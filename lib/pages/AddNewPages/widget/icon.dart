import 'package:achivement_box/models/imageIcon.dart';
import 'package:flutter/material.dart';

import '../../../output/generated/icon_names.dart';
import 'iconsDialog.dart';

class SelectIcon extends StatefulWidget {
  SelectIcon({super.key, this.selectedIconName = "plus.png"});
  String selectedIconName;
  int? selectedIconId;

  @override
  State<SelectIcon> createState() => _SelectIconState();
}

class _SelectIconState extends State<SelectIcon> {
  @override
  Widget build(BuildContext context) {
    IconsDialog iconsDialog = IconsDialog();
    //selectedIconId = iconsDialog.selectedIconId;

    return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Theme.of(context).primaryColor.withOpacity(0.1)),
        child: IconButton(
            onPressed: () async {
              widget.selectedIconId = await showIconPicker(context);
              widget.selectedIconName = widget.selectedIconId == null
                  ? "plus.png"
                  : iconNames[widget.selectedIconId!];
              setState(() {});
            },
            icon: IconImage(
              iconName: widget.selectedIconName,
            )));
  }
}
