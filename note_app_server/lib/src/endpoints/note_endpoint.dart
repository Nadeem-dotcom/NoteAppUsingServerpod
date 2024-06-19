import 'package:note_app_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class NoteEndPoint extends Endpoint {
  Future<List<Note>> getAllNotes(Session session) async {
    return await Note.db.find(session);
  }

  Future<void> addNote(Session session, Note note) async {
    await Note.db.insertRow(session, note);
  }

  Future<void> deleteNote(Session session, Note note) async {
    await Note.db.deleteRow(session, note);
  }
}
