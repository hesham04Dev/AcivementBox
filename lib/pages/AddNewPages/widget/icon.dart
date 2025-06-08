
import 'package:flutter/material.dart';

import '../../../models/imageIcon.dart';
import '../../../models/PrimaryContainer.dart';
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
    //IconsDialog iconsDialog = const IconsDialog();
    //selectedIconId = iconsDialog.selectedIconId;

    return Hero(
      tag: "add",
      child: PrimaryContainer(
          margin: 0,
          padding: 0,
          width: 50,
          height: 50,
          child: IconButton(
              onPressed: () async {
                widget.selectedIconId = await showIconPicker(context);
                widget.selectedIconName = widget.selectedIconId == null
                    ? "plus.png"
                    : iconNames[widget.selectedIconId!];
                setState(() {});
              },
              icon: IconImage(
                opacity: 1.0,
                iconName: widget.selectedIconName,
              ))),
    );
  }
}
