import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
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
        builder: (context) => const Dialog(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Text("the database copied to Downloads/achievement_box"),
          ),
        ),
      );
    }

    return MyListTile(
      title: 'Backup',
      trailing: IconImage(
        iconName: "arrow-up-from-arc.png",
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
