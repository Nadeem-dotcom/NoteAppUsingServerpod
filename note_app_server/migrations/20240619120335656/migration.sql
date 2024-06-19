BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "note" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL
);


--
-- MIGRATION VERSION FOR note_app
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('note_app', '20240619120335656', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240619120335656', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
