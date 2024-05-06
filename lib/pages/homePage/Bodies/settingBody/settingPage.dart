import 'package:achivement_box/models/imageIcon.dart';
import 'package:achivement_box/models/mySwitchTile.dart';
import 'package:achivement_box/pages/homePage/Bodies/settingBody/Widget/ColorDialog.dart';
import 'package:achivement_box/pages/homePage/Bodies/settingBody/Widget/MyListTile.dart';
import 'package:flutter/material.dart';

import '../../../../db/sql.dart';
import '../../../../fn/forDbNotification.dart';

class SettingBody extends StatelessWidget {
  const SettingBody({super.key});

  @override
  Widget build(BuildContext context) {
    final Widget darkModeTile = MySwitchTile(
      title: "darkMode",
      value: getDarkMode() == 1 ? true : false,
      onChange: (bool value) {
        value ? setDarkMode(1) : setDarkMode(0);
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
          MyListTile(
            title: 'Notification',
            subtitle: "notify me at ${formatToGet(getNotificationTime())}",
            trailing: IconImage(
              iconName: "watch.png",
            ),
            onTap: () async {
              TimeOfDay? x = await showTimePicker(
                  context: context, initialTime: TimeOfDay.now());
              if (x != null) {
                setNotificationTime(formatToSet(x.hour, x.minute));
              }
            },
          ),
          MyListTile(
            title: 'Backup',
            trailing: IconImage(
              iconName: "arrow-up-from-arc.png",
            ),
            onTap: () {},
          ),
          MyListTile(
            title: 'Restore',
            trailing: IconImage(
              iconName: "arrow-up-to-arc.png",
            ),
            onTap: () {},
          ),
          MyListTile(
            title: 'Archive',
            trailing: IconImage(
              iconName: "box-archive.png",
            ),
            onTap: () {},
          ),
          MyListTile(
            title: 'View on Github',
            trailing: IconImage(
              iconName: "github-alt.png",
            ),
            onTap: () {},
          ),
          MyListTile(
            title: 'Version: 0.5.0',
            onTap: () {},
          ),
          Text(
              "this verison is beta version only dark mode and accent colors works")
        ],
      ),
    );
  }
}
