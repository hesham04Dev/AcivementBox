import 'package:achivement_box/models/imageIcon.dart';
import 'package:achivement_box/rootProvider/iconProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'iconsDialog.dart';

class SelectIcon extends StatelessWidget {
  SelectIcon({super.key});
  int selectedIconId = 0;
  @override
  Widget build(BuildContext context) {
    IconsDialog iconsDialog = IconsDialog();
    selectedIconId = iconsDialog.chosenImageId;
    return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Theme.of(context).primaryColor.withOpacity(0.1)),
        child: IconButton(
            onPressed: () {
              showDialog(context: context, builder: (context) => iconsDialog);
            },
            icon: IconImage(
              iconName: context.watch<IconProvider>().IconName,
            )));
  }
}
