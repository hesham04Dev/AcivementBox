import "package:achivement_box/models/gift.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../../../../models/Coins.dart";
import "../../../../models/PrimaryContainer.dart";
import "../../../../models/levelBar.dart";
import "../../../../rootProvider/giftProvider.dart";

class GiftsBody extends StatelessWidget {
  const GiftsBody({super.key});
  Gift gift(Map<String, dynamic> gift, BuildContext context) {
    return Gift(
        totalTimes: gift['NoOfUsed'],
        context: context,
        iconId: gift['IconId'],
        id: gift['Id'],
        name: gift['Name'],
        price: gift['Price']);
  }

  @override
  Widget build(BuildContext context) {
    var gifts = context.watch<GiftProvider>().Gifts;
    var mostUsedGifts = context.watch<GiftProvider>().MostUsedGifts ?? [""];
    //TODO for the most used

    final List<Widget>? mostUsed;

    if (mostUsedGifts.length > 0) {
      mostUsed = [
        const Text("most used"),
        PrimaryContainer(
          key: UniqueKey(),
          opacity: 0.1,
          height: 150,
          paddingHorizontal: 10,
          child: ListView(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              scrollDirection: Axis.horizontal,
              children: List.generate(mostUsedGifts.length,
                  (index) => gift(mostUsedGifts[index], context))),
        ),
      ];
    } else
      mostUsed = [];

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
        ...mostUsed,
        const Text("all items"),
        Expanded(
          child: PrimaryContainer(
            padding: 0,
            paddingHorizontal: 8,
            opacity: 0.1,
            child: GridView.builder(
                itemBuilder: (context, index) => gift(gifts[index], context),
                itemCount: gifts.length,
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
