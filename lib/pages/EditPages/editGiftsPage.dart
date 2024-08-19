import 'package:achivement_box/pages/AddNewPages/newGift.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../db/db.dart';
import '../../models/PrimaryContainer.dart';
import '../../models/gift.dart';
import '../../models/imageIcon.dart';
import '../../output/generated/icon_names.dart';
import '../../rootProvider/giftProvider.dart';
import '../AddNewPages/widget/icon.dart';

class EditGiftsPage extends NewGiftPage {
  final Gift gift;
  EditGiftsPage({required this.gift});

  @override
  State<NewGiftPage> createState() => _EditGiftPageState(gift: gift);
}

class _EditGiftPageState extends NewGiftPageState {
  _EditGiftPageState({required this.gift});

  final Gift gift;

  @override
  void initState() {
    super.initState();

    super.name.text = gift.name;

    super.coins.text = "${gift.price}";

    super.selectIcon = SelectIcon(
      selectedIconName: iconNames[gift.iconId],
    );
    selectIcon.selectedIconId = gift.iconId;
  }

  @override
  Widget build(BuildContext context) {
    widget.actions = [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
            onPressed: () {
              db.sql.gifts.archive(id: gift.id);
              context.read<GiftProvider>().giftUpdated();
              Navigator.pop(context);
            },
            icon: IconImage(iconName: "box-archive.png")),
      )
    ];
    children = [
      PrimaryContainer(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {
                if (gift.totalTimes > 0) {
                  gift.undo();
                }
                setState(() {});
              },
              child: const Text("-")),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(gift.totalTimes.toString()),
          ),
          TextButton(
              onPressed: () {
                gift.clicked();
                setState(() {});
              },
              child: const Text("+"))
        ],
      ))
    ];
    return super.build(context);
  }

  @override
  void save(BuildContext context) {
    if (super.formKey.currentState!.validate()) {
      Gift h = Gift(
        id: gift.id,
        name: super.name.text,
        price: int.parse(super.coins.text),
        iconId: selectIcon.selectedIconId ?? NewGiftPage.giftIconId,
        totalTimes: gift.totalTimes,
        context: context,
      );
      db.sql.gifts.update(h);
      context.read<GiftProvider>().giftUpdated();
      Navigator.pop(context);
    }
  }
}
