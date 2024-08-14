import 'package:achivement_box/db/sql.dart';
import 'package:achivement_box/models/imageIcon.dart';
import 'package:achivement_box/rootProvider/ThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../output/generated/colors.dart';

class ColorDialog extends StatelessWidget {
  ColorDialog({super.key});
  int chosenColorId = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 155,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
              itemBuilder: (context, index) => IconButton(
                    onPressed: () {
                      setAccentColor(index);
                      context
                          .read<ThemeProvider>()
                          .accentColorChanged(colors[index]);

                      Navigator.pop(context);
                    },
                    icon: IconImage(
                      iconName: "circle.png",
                      color: colors[index],
                    ),
                  ),
              itemCount: colors.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 50,
                  mainAxisExtent: 50,
                  childAspectRatio: 1,
                  crossAxisSpacing: 4)),
        ),
      ),
    );
    ;
  }
}
