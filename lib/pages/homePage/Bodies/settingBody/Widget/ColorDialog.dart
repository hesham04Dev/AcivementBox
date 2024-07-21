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
              itemBuilder: (context, index) => SizedBox(
                    width: 35,
                    height: 35,
                    child: TextButton(
                      onPressed: () {
                        setAccentColor(index);
                        context
                            .read<ThemeProvider>()
                            .accentColorChanged(colors[index]);

                        Navigator.pop(context);
                      },
                      child: IconImage(
                        iconName: "droplet.png",
                        size: 25,
                        color: colors[index],
                      ),
                    ),
                  ),
              itemCount: colors.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 75 / 2 + 10,
                  mainAxisExtent: 75 / 2 + 10,
                  childAspectRatio: 1,
                  crossAxisSpacing: 4)),
        ),
      ),
    );
    ;
  }
}
