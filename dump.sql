PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE "artists" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "song_id" integer, "artistname" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "comments" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "content" varchar, "mood" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "moods" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "song_id" integer, "moodname" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "playlists" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "mood_id" integer, "user_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "song_id" integer, "name" varchar);
CREATE TABLE "populars" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "song_id" integer, "count" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "raters" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer, "song_id" integer, "count" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "search" integer, "mood_id" integer, "play" integer);
CREATE TABLE "reccommenders" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer, "happy" integer, "sad" integer, "angry" integer, "fear" integer, "surprise" integer, "mood_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "email" varchar DEFAULT '' NOT NULL, "encrypted_password" varchar DEFAULT '' NOT NULL, "reset_password_token" varchar, "reset_password_sent_at" datetime, "remember_created_at" datetime, "sign_in_count" integer DEFAULT 0 NOT NULL, "current_sign_in_at" datetime, "last_sign_in_at" datetime, "current_sign_in_ip" varchar, "last_sign_in_ip" varchar, "created_at" datetime, "updated_at" datetime, "name" varchar, "confirmation_token" varchar, "confirmed_at" datetime, "confirmation_sent_at" datetime, "unconfirmed_email" varchar, "role" integer);
INSERT INTO "users" VALUES(1,'user@example.com','$2a$10$uNL1Xo8QzBi28qJ58duFzebvHfuRuCengOqr2pZgUBbCCL6h.qgQe',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,'2015-03-21 18:22:38.235083','2015-03-21 18:22:38.409903',NULL,NULL,'2015-03-21 18:22:38.232614',NULL,NULL,1);
CREATE TABLE "schema_migrations" ("version" varchar NOT NULL);
INSERT INTO "schema_migrations" VALUES('20150321180711');
INSERT INTO "schema_migrations" VALUES('20150106160034');
INSERT INTO "schema_migrations" VALUES('20150111082255');
INSERT INTO "schema_migrations" VALUES('20150218134310');
INSERT INTO "schema_migrations" VALUES('20150213190238');
INSERT INTO "schema_migrations" VALUES('20150112104519');
INSERT INTO "schema_migrations" VALUES('20150305124409');
INSERT INTO "schema_migrations" VALUES('20150221120752');
INSERT INTO "schema_migrations" VALUES('20150112070650');
INSERT INTO "schema_migrations" VALUES('20150221125615');
INSERT INTO "schema_migrations" VALUES('20150112105000');
INSERT INTO "schema_migrations" VALUES('20150220033049');
INSERT INTO "schema_migrations" VALUES('20150106160042');
INSERT INTO "schema_migrations" VALUES('20150221122404');
INSERT INTO "schema_migrations" VALUES('20150226143635');
INSERT INTO "schema_migrations" VALUES('20150221121341');
INSERT INTO "schema_migrations" VALUES('20150221121837');
INSERT INTO "schema_migrations" VALUES('20150112065920');
INSERT INTO "schema_migrations" VALUES('20150111082243');
INSERT INTO "schema_migrations" VALUES('20150106160036');
INSERT INTO "schema_migrations" VALUES('20150319120141');
INSERT INTO "schema_migrations" VALUES('20150106160038');
INSERT INTO "schema_migrations" VALUES('20150221123554');
INSERT INTO "schema_migrations" VALUES('20150218134514');
DELETE FROM sqlite_sequence;
INSERT INTO "sqlite_sequence" VALUES('users',1);
CREATE INDEX "index_artists_on_song_id" ON "artists" ("song_id");
CREATE INDEX "index_moods_on_song_id" ON "moods" ("song_id");
CREATE INDEX "index_playlists_on_mood_id" ON "playlists" ("mood_id");
CREATE INDEX "index_playlists_on_song_id" ON "playlists" ("song_id");
CREATE INDEX "index_playlists_on_user_id" ON "playlists" ("user_id");
CREATE INDEX "index_populars_on_song_id" ON "populars" ("song_id");
CREATE INDEX "index_raters_on_mood_id" ON "raters" ("mood_id");
CREATE INDEX "index_raters_on_song_id" ON "raters" ("song_id");
CREATE INDEX "index_raters_on_user_id" ON "raters" ("user_id");
CREATE INDEX "index_reccommenders_on_mood_id" ON "reccommenders" ("mood_id");
CREATE UNIQUE INDEX "index_users_on_email" ON "users" ("email");
CREATE UNIQUE INDEX "index_users_on_reset_password_token" ON "users" ("reset_password_token");
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
COMMIT;
