import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:localization_lite/translate.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../fn/restoreDB.dart';
import '../../../../../models/imageIcon.dart';
import 'MyListTile.dart';

class RestoreTile extends StatelessWidget {
  const RestoreTile({super.key});

  Future<bool> _requestStoragePermission() async {
    if (Platform.isAndroid) {
      final deviceInfo = await DeviceInfoPlugin().androidInfo;
      if (deviceInfo.version.sdkInt < 32) {
        final status = await Permission.storage.request();
        return status.isGranted;
      }
    }
    return true; // Not needed on iOS or Android SDK >= 33
  }

  void _showIncorrectFileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor:  Colors.red.withValues(alpha: 0.2),
        content: Text(
          tr("incorrectFile"),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Future<String?> _pickBackupFile(BuildContext context) async {
    try {
      final downloadsDir = await getDownloadsDirectory();
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['db'],
        initialDirectory: downloadsDir?.path,
      );
      return result?.files.single.path;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr("filePickerError"))),
      );
      return null;
    }
  }

  Future<void> _promptBackupBeforeRestore(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(
          tr("doYouWantToBackupBeforeRestore"),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(tr('restoreOnly')),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(tr('backupAndRestore')),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await backup();
    }
  }

  Future<void> _handleRestore(BuildContext context) async {
    final hasPermission = await _requestStoragePermission();
    if (!hasPermission) return;

    await _promptBackupBeforeRestore(context);

    final filePath = await _pickBackupFile(context);
    if (filePath != null) {
      if (filePath.endsWith('.db')) {
        restore(filePath);
      } else {
        _showIncorrectFileDialog(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyListTile(
      title: tr('restore'),
      trailing: IconImage(iconName: "time-back.png"),
      onTap: () => _handleRestore(context),
    );
  }
}
