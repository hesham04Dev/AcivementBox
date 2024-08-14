import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../fn/restoreDB.dart';
import '../../../../../models/imageIcon.dart';
import 'MyListTile.dart';

class RestoreTile extends StatelessWidget {
  const RestoreTile({super.key});

  @override
  Widget build(BuildContext context) {
    void incorrectFile() {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          backgroundColor: Colors.red.withOpacity(0.2),
          child: const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "incorrect file",
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    void backupBeforeRestoreDialog() {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "do you want to backup before restore",
                  textAlign: TextAlign.center,
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel')),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          backup();
                        },
                        child: const Text('Backup')),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }

    return MyListTile(
      title: 'Restore',
      trailing: IconImage(
        iconName: "time-back.png",
      ),
      onTap: () async {
        //var allowStorage = await Permission.storage.request();
        var downloadsDir = await getDownloadsDirectory();

        FilePickerResult? result = await FilePicker.platform.pickFiles(
          initialDirectory: downloadsDir!.path,
        );
        if (result != null) {
          if (result.files.single.path!.endsWith(".db")) {
            if (Platform.isAndroid) {
              final deviceInfo = await DeviceInfoPlugin().androidInfo;
              if (deviceInfo.version.sdkInt < 32) {
                var allowStorage = await Permission.storage.request();
                if (allowStorage.isGranted) {
                  backupBeforeRestoreDialog();
                  restore(result.files.single.path!);
                }
              } else {
                backupBeforeRestoreDialog();
                restore(result.files.single.path!);
              }
            } else {
              backupBeforeRestoreDialog();
              restore(result.files.single.path!);
            }
          } else {
            incorrectFile();
          }
        }
      },
    );
  }
}
