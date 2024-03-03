import 'package:achivement_box/models/MyBottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView(
          children: [
            Text("Hello Hesham"),
            SwitchListTile(
              title: Text("dark mode"),
              value: false,
              onChanged: (value) {},
            ),
            SwitchListTile(
                title: Text("dynamic color"),
                value: false,
                onChanged: (value) {}),
            SizedBox(
              height: 10,
            ),
            Text("Notifications"),
            TextButton(
                onPressed: () {
                  //TODO show time picker
                },
                child: Text(true ? "remined me at 8:00pm" : "add reminder")),
            SizedBox(height: 10),
            Text("Local Backup"),
            Row(
              children: [
                Expanded(
                    child: TextButton(onPressed: () {}, child: Text("Backup"))),
                Expanded(
                    child:
                        TextButton(onPressed: () {}, child: Text("Restore"))),
              ],
            ),
            IconButton(
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
            Text("version: 1.0.0 ")
            // add ester egg in this when click 7 times tell the user something
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }
}
