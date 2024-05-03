import 'package:achivement_box/models/imageIcon.dart';
import 'package:achivement_box/models/mySwitchTile.dart';
import 'package:achivement_box/pages/homePage/Bodies/settingBody/Widget/accentColorTile.dart';
import 'package:flutter/material.dart';

class SettingBody extends StatelessWidget {
  const SettingBody({super.key});

  @override
  Widget build(BuildContext context) {
    final Widget darkModeTile = MySwitchTile(title: "darkMode");
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
            onTap: () {},
          ),
          MyListTile(
            title: 'Notification',
            subtitle: "notify me at 8:00pm",
            trailing: IconImage(
              iconName: "watch.png",
            ),
            onTap: () {},
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
            title: 'Version: 1.0.0',
            onTap: () {},
          ),

          //Text("Notifications"),
          /*TextButton(
              onPressed: () {
                //TODO show time picker
              },
              child: Text(true ? "remined me at 8:00pm" : "add reminder")),*/

          //Text("Local Backup"),
          /*Row(
            children: [
              Expanded(
                  child: TextButton(onPressed: () {}, child: Text("Backup"))),
              Expanded(
                  child: TextButton(onPressed: () {}, child: Text("Restore"))),
            ],
          ),*/
          /*IconButton(
              onPressed: () {},
              icon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.archive_rounded),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Archive")
                ],
              )),
          IconButton(
              onPressed: () {},
              icon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(FontAwesomeIcons.github),
                  SizedBox(
                    width: 5,
                  ),
                  Text("view on github")
                ],
              )),
          Text("version: 1.0.0 ")*/
          // add ester egg in this when click 7 times tell the user something
        ],
      ),
    );
  }
}
