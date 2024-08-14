import 'package:achivement_box/models/imageIcon.dart';
import 'package:achivement_box/output/generated/icon_names.dart';
import 'package:flutter/material.dart';

class IconsDialog extends StatelessWidget {
  const IconsDialog({super.key});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GridView.builder(
              itemBuilder: (context, index) => SizedBox(
                    width: 50,
                    height: 50,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context, index);
                      },
                      child: IconImage(
                        iconName: iconNames[index],
                        size: 30,
                      ),
                    ),
                  ),
              itemCount: iconNames.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 75,
                  mainAxisExtent: 75,
                  childAspectRatio: 1,
                  crossAxisSpacing: 4))),
    );
  }
}

Future<int?> showIconPicker(BuildContext context) {
  var dialog = const IconsDialog();
  return showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      });
}
