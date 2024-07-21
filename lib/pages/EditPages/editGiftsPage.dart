import 'package:achivement_box/pages/AddNewPages/newGift.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../db/sql.dart';
import '../../models/gift.dart';
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
  final gift;
  @override
  Widget build(BuildContext context) {
    widget.actions = [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
            onPressed: () {
              deleteGift(id: gift.id);
              context.read<GiftProvider>().giftUpdated();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.delete)),
      )
    ];
    return super.build(context);
  }

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
      updateGift(h);
      context.read<GiftProvider>().giftUpdated();
      Navigator.pop(context);
    }
  }
}
