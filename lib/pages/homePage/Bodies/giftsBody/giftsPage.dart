import "package:achivement_box/models/gift.dart";
import "package:flutter/material.dart";

import "../../../../models/Coins.dart";
import "../../../../models/PrimaryContainer.dart";
import "../../../../models/imageIcon.dart";
import "../../../../models/levelBar.dart";

class GiftsBody extends StatelessWidget {
  const GiftsBody() : super();

  @override
  Widget build(BuildContext context) {
    Gift h1 = new Gift(
      context: context,
      icon: IconImage(
        path: "assets/icons/gift.png",
        size: 50,
      ),
      name: " some long text pla pla",
      price: 10,
    );
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LevelBar(
                canChange: false,
              ),
              const CoinsBar(),
            ],
          ),
        ),
        const Text("recent"),
        PrimaryContainer(
          opacity: 0.1,
          height: 150,
          child: ListView.builder(
              itemBuilder: (context, index) => h1,
              itemCount: 10, //max is 10
              scrollDirection: Axis.horizontal),
        ),
        //TODO if null dont show any
        const Text("all items"),
        Expanded(
          child: PrimaryContainer(
            opacity: 0.1,
            child: GridView.builder(
                itemBuilder: (context, index) => h1,
                itemCount: 30,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 121,
                    mainAxisExtent: 130,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 8)),
          ),
        ),
      ],
    );
  }
}
