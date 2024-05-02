import 'package:achivement_box/models/imageIcon.dart';
import 'package:achivement_box/output/generated/icon_names.dart';
import 'package:achivement_box/rootProvider/iconProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IconsDialog extends StatelessWidget {
  IconsDialog({super.key});
  //TODO take default icon from the page if it tasks or gifts
  int chosenImageId = 0;
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
                        context.read<IconProvider>().IconUpdated(index);
                        Navigator.pop(context);
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
    ;
  }
}
