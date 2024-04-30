import "package:achivement_box/models/gift.dart";
import "package:achivement_box/pages/homePage/provider/giftProvider.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../../../../models/Coins.dart";
import "../../../../models/PrimaryContainer.dart";
import "../../../../models/imageIcon.dart";
import "../../../../models/levelBar.dart";

class GiftsBody extends StatelessWidget {
  const GiftsBody() : super();

  @override
  Widget build(BuildContext context) {
    var gifts = context.watch<GiftProvider>().Gifts;
    var mostUsedGifts = context.watch<GiftProvider>().MostUsedGifts ?? [""];
    //TODO for the most used

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
        const Text("most used"),
        PrimaryContainer(
          opacity: 0.1,
          height: 150,
          child: ListView.builder(
              itemBuilder: (context, index) => Gift(
                  totalTimes: gifts[index]['NoOfUsed'],
                  context: context,
                  icon: IconImage(path: "assets/icons/gift.png", size: 50),
                  id: gifts[index]['Id'],
                  name: gifts[index]['Name'],
                  price: gifts[index]['Price']),
              itemCount: mostUsedGifts.length,
              scrollDirection: Axis.horizontal),
        ),
        //TODO if null dont show any
        const Text("all items"),
        Expanded(
          child: PrimaryContainer(
            opacity: 0.1,
            child: GridView.builder(
                itemBuilder: (context, index) => Gift(
                    context: context,
                    totalTimes: gifts[index]['NoOfUsed'],
                    icon: IconImage(path: "assets/icons/gift.png", size: 50),
                    id: gifts[index]['Id'],
                    name: gifts[index]['Name'],
                    price: gifts[index]['Price']),
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
/*TODO
* hide most used when nothing is used
*
* */
