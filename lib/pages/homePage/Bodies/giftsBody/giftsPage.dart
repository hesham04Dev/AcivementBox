import "package:achivement_box/db/sql.dart";
import "package:achivement_box/models/gift.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../../../../models/Coins.dart";
import "../../../../models/PrimaryContainer.dart";
import "../../../../models/levelBar.dart";
import "../../../../rootProvider/giftProvider.dart";

class GiftsBody extends StatelessWidget {
  const GiftsBody({super.key});

  @override
  Widget build(BuildContext context) {
    bool listView = isListView();
    var gifts = context.watch<GiftProvider>().Gifts;

    final List<Widget>? mostUsed;
    int maxOfMostUsed = 3;
    // ((MediaQuery.sizeOf(context).width - 18) / TileWithCounter.width)
    //     .floor();
    context.read<GiftProvider>().MaxOfMostUsed = maxOfMostUsed;
    var mostUsedGifts = context.watch<GiftProvider>().MostUsedGifts ?? [""];
    if (mostUsedGifts.length > 0 || listView) {
      mostUsed = [
        const Text("most used"),
        PrimaryContainer(
          opacity: 0.1,
          height: 170,
          paddingHorizontal: 10,
          child: ListView(
              //clipBehavior: Clip.antiAliasWithSaveLayer,
              scrollDirection: Axis.horizontal,
              children: List.generate(mostUsedGifts.length,
                  (index) => Gift.giftBuilder(context, mostUsedGifts[index]))),
        ),
      ];
    } else
      mostUsed = [];

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LevelBar(
                canChange: false,
              ),
              CoinsBar(),
            ],
          ),
        ),
        if (listView) const SizedBox() else ...mostUsed,
        const Text("all items"),
        Expanded(
          child: PrimaryContainer(
            opacity: 0.1,
            child: listView
                ? ListView.builder(
                    itemBuilder: (BuildContext context, int index) =>
                        Gift.giftBuilder(context, gifts[index]),
                    itemCount: gifts.length,
                  )
                : GridView.builder(
                    itemBuilder: (context, index) =>
                        Gift.giftBuilder(context, gifts[index]),
                    itemCount: gifts.length,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 130,
                            mainAxisExtent: 140,
                            childAspectRatio: 0.5,
                            crossAxisSpacing: 8)),
          ),
        ),
      ],
    );
  }
}
