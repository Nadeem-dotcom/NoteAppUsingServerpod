import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:note_app_client/note_app_client.dart';
import 'package:note_app_flutter/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController textController = TextEditingController();
  late Future<List<Note>> _notesFuture;

  @override
  void initState() {
    super.initState();
    _notesFuture = getNotes();
  }

  Future<List<Note>> getNotes() async {
    log("getNotes");
    final response = await client.noteEndPoint.getAllNotes();
    log(response.toString());
    return response;
  }

  Future<void> addNote() async {
    await client.noteEndPoint.addNote(Note(
      name: textController.text,
    ));
    textController.clear();
    setState(() {
      _notesFuture = getNotes();
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Server Pod Notes"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addNoteDialog();
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<Note>>(
        future: _notesFuture,
        builder: (context, snapshot) {
          log(snapshot.toString());
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Text(
                      "${index + 1}.",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    title: Text(snapshot.data![index].name),
                  );
                },
              );
            } else {
              return const Center(
                child: Text("No data"),
              );
            }
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong"),
            );
          } else {
            return const Center(
              child: Text("Something went wrong"),
            );
          }
        },
      ),
    );
  }

  addNoteDialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(hintText: "Enter note"),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              addNote();
            },
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }
}
