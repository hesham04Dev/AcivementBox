import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import "package:localization_lite/translate.dart";

import 'package:permission_handler/permission_handler.dart';

import '../../../../../fn/restoreDB.dart';
import '../../../../../models/imageIcon.dart';
import 'MyListTile.dart';

class BackupTile extends StatelessWidget {
  const BackupTile({super.key});

  @override
  Widget build(BuildContext context) {
    void showBackupDialog() {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(tr("theDatabaseCopiedTo_Downloads/achievement_box")),
          ),
        ),
      );
    }

    return MyListTile(
      title: tr('backup'),
      trailing: IconImage(
        iconName: "copy.png",
      ),
      onTap: () async {
        if (Platform.isAndroid) {
          final deviceInfo = await DeviceInfoPlugin().androidInfo;
          if (deviceInfo.version.sdkInt < 32) {
            var allowStorage = await Permission.storage.request();
            if (allowStorage.isGranted) {
              await backup();
              showBackupDialog();
            }
          }
        }
        await backup();
        showBackupDialog();
      },
    );
  }
}
