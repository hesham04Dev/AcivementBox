import 'package:achivement_box/models/imageIcon.dart';
import 'package:achivement_box/models/mySwitchTile.dart';
import 'package:achivement_box/pages/homePage/Bodies/settingBody/Widget/ColorDialog.dart';
import 'package:achivement_box/pages/homePage/Bodies/settingBody/Widget/MyListTile.dart';
import 'package:achivement_box/pages/homePage/Bodies/settingBody/Widget/backup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../db/sql.dart';
import '../../../../rootProvider/ThemeProvider.dart';
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
      title: "darkMode",
      value: getDarkMode(),
      onChange: (bool value) {
        value ? setDarkMode(1) : setDarkMode(0);
        context.read<ThemeProvider>().toggleMode();
      },
    );
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        children: [
          darkModeTile,
          MyListTile(
            title: 'Accent Color',
            trailing: IconImage(
              iconName: "droplet.png",
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
            title: 'View on Github',
            trailing: IconImage(
              iconName: "github-alt.png",
            ),
            onTap: () async {
              await Clipboard.setData(const ClipboardData(
                  text: "https://github.com/hesham04Dev/AcivementBox"));
            },
          ),
          MyListTile(
            title: 'Version: 0.7.5',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
