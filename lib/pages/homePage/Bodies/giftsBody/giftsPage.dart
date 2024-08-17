import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../../../../db/sql.dart";
import "../../../../models/PrimaryContainer.dart";
import "../../../../models/gift.dart";
import "../../../../models/my_grid_view.dart";
import "../../../../models/topBar.dart";
import "../../../../rootProvider/giftProvider.dart";

class GiftsBody extends StatelessWidget {
  const GiftsBody({super.key});

  @override
  Widget build(BuildContext context) {
    bool listView = isListView();
    var gifts = context.watch<GiftProvider>().Gifts;

    final List<Widget>? mostUsed;
    int maxOfMostUsed = 3;
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
    } else {
      mostUsed = [];
    }

    return Column(
      children: [
        const TopBar(
          canLevelChange: false,
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
                : MyGridView(
                    itemBuilder: (context, index) =>
                        Gift.giftBuilder(context, gifts[index]),
                    itemCount: gifts.length,
                  ),
          ),
        ),
      ],
    );
  }
}
