import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localization_lite/translate.dart';
import 'package:provider/provider.dart';

import '../../../../db/db.dart';
import '../../../../rootProvider/ThemeProvider.dart';
import '../../../logPage/log_page.dart';
import '../../../../models/imageIcon.dart';
import '../../../../models/mySwitchTile.dart';
import '../../../../pages/ArchivePage/archivePage.dart';
import '../../../../pages/homePage/Bodies/settingBody/Widget/ColorDialog.dart';
import '../../../../pages/homePage/Bodies/settingBody/Widget/MyListTile.dart';
import '../../../../pages/homePage/Bodies/settingBody/Widget/backup.dart';
import '../../../../rootProvider/settings_controller.dart';

import 'Widget/restore_tile.dart';

class SettingBody extends StatefulWidget {
  const SettingBody({super.key});

  @override
  State<SettingBody> createState() => _SettingBodyState();
}

class _SettingBodyState extends State<SettingBody> {
  @override
  Widget build(BuildContext context) {
    Widget darkModeTile = MySwitchTile(
      title: tr("darkMode"),
      value: db.sql.settings.getDarkMode(),
      onChange: (bool value) {
        value ? db.sql.settings.setDarkMode(1) : db.sql.settings.setDarkMode(0);
        context.read<ThemeProvider>().toggleMode();
      },
    );
    Widget listViewTile = MySwitchTile(
      title: tr("listView"),
      value: db.sql.settings.isListView(),
      onChange: (bool value) {
        db.sql.settings.setIsListView(value);
        context.read<ThemeProvider>().toggleMode();
      },
    );
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        children: [
          listViewTile,
          darkModeTile,
          MyListTile(
            title: tr('accentColor'),
            trailing: IconImage(
              iconName: "circle.png",
            ),
            onTap: () {
              showDialog(context: context, builder: (context) => ColorDialog());
            },
          ),
          BackupTile(),
          /*not constant*/
          RestoreTile(),
          /*not constant*/
          MyListTile(
            title: tr('viewOnGithub'),
            trailing: IconImage(
              iconName: "github-alt.png",
            ),
            onTap: () async {
              await Clipboard.setData(const ClipboardData(
                  text: "https://github.com/hesham04Dev/AcivementBox"));
            },
          ),
          MyListTile(
              title: tr("logPage"),
              trailing: IconImage(
                iconName: "rectangle-history.png",
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LogPage()));
              }),
          MyListTile(
              title: tr("archivePage"),
              trailing: IconImage(
                iconName: "box-archive.png",
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ArchivePage()));
              }),
          MyListTile(
            title: '${tr("version")}: ${SettingsController.appVersion}',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
