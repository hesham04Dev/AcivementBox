import 'dart:io';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:restart_app/restart_app.dart';

import '../db/db.dart';

Future<void> backup() async {
  String pathToDownloadsDir;
  if (Platform.isAndroid) {
    pathToDownloadsDir = "/storage/emulated/0/Download";
  } else {
    final downloadsDir = await getDownloadsDirectory();
    pathToDownloadsDir = downloadsDir!.path;
  }
  String date = DateFormat('yyyy_MM_dd_kk_mm').format(DateTime.now());
  Directory folder = Directory("$pathToDownloadsDir/achievement_box/");
  bool isFolderExists = await folder.exists();
  if (!isFolderExists) {
    folder.create();
  }
  String backupPath =
      "$pathToDownloadsDir/achievement_box/hcody_ab_backup$date.db";
  File file = File(backupPath);
  if (await file.exists()) {
    await file.delete();
  }
  //Database? backup = sqlite3.open(backupPath);
  //db.backup(backup, nPage: -1);
  //backup.dispose();
  File originalFile =
      File("${(await getApplicationSupportDirectory()).path}/hcody_ab.db");

  originalFile
      .copy("$pathToDownloadsDir/achievement_box/hcody_ab_backup$date.db");
}

Future<void> restore(String path) async {
  final supportDir = await getApplicationSupportDirectory();
  File sourceFile = File(path);
  await sourceFile.copy('${supportDir.path}/restored.db');
  if (Platform.isAndroid) {
    db.db.dispose();
    await Restart.restartApp();
    await Restart.restartApp();
  }
  //we need to restart the app to restore the db;
}
