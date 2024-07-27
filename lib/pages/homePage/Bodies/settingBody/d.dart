/*import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({
    super.key,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

const fonts = ["Jozoor", "Amiri"];
const ar_fonts = ["جذور", "اميري"];

class _SettingsPageState extends State<SettingsPage> {
  var deviceInfo;
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      deviceInfo = DeviceInfoPlugin().androidInfo;
    }
    final double half = (MediaQuery.sizeOf(context).width / 2) - 25;

    return Scaffold(
      appBar: AppBar(
        title: Text("locale[TranslationsKeys.settings]!"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(30)),
                      width: half,
                      child: TextButton(
                          onPressed: () async {
                            if (Platform.isAndroid) {
                              final _deviceInfo = await deviceInfo;
                              if (_deviceInfo.version.sdkInt < 32) {
                                var allowStorage =
                                    await Permission.storage.request();
                                if (allowStorage.isGranted) {
                                  requiredData.db.localBackup(true);
                                  showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Text(locale[
                                            TranslationsKeys.backupMsg]!),
                                      ),
                                    ),
                                  );
                                }
                              }
                              var allowStorage =
                                  await Permission.storage.request();
                              requiredData.db.localBackup(true);
                            }
                            //var allowStorage = await Permission.storage.request();
                            requiredData.db.localBackup(false);

                            showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child:
                                      Text(locale[TranslationsKeys.backupMsg]!),
                                ),
                              ),
                            );
                            // Navigator.pop(context);
                          },
                          child: Text(locale[TranslationsKeys.backup]!)),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(30)),
                      width: half,
                      child: TextButton(
                          onPressed: () async {
                            //var allowStorage = await Permission.storage.request();
                            var downloadsDir = await getDownloadsDirectory();
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles(
                              initialDirectory: downloadsDir!.path,
                            );
                            if (result != null) {
                              if (result.files.single.path!
                                  .endsWith(".hcody")) {
                                if (Platform.isAndroid) {
                                  final _deviceInfo = await deviceInfo;
                                  if (_deviceInfo.version.sdkInt < 32) {
                                    var allowStorage =
                                        await Permission.storage.request();
                                    if (allowStorage.isGranted) {
                                      requiredData.db.copyDbToSupportDir(
                                          result.files.single.path);

                                      showDialog(
                                          context: context,
                                          builder: (context) =>
                                              RestartAppDialog());
                                    }
                                  } else {
                                    requiredData.db.copyDbToSupportDir(
                                        result.files.single.path);

                                    showDialog(
                                      context: context,
                                      builder: (context) => RestartAppDialog(),
                                    );
                                  }
                                } else {
                                  requiredData.db.copyDbToSupportDir(
                                      result.files.single.path);

                                  showDialog(
                                    context: context,
                                    builder: (context) => RestartAppDialog(),
                                  );
                                }
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                    backgroundColor:
                                        Colors.red.withOpacity(0.2),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(
                                        "locale[TranslationsKeys.wrongFile]!",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                );
                              }
                            }
                          },
                          child: Text(
                            "locale[TranslationsKeys.restore]!",
                          )),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}*/
