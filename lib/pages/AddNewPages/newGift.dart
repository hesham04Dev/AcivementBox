
import 'package:flutter/material.dart';
import 'package:localization_lite/translate.dart';
import 'package:provider/provider.dart';

import '../../db/db.dart';
import '../../models/AutoDirectionTextFormField.dart';
import '../../rootProvider/giftProvider.dart';
import '../../pages/AddNewPages/widget/NumericField.dart';
import 'widget/icon.dart';

class NewGiftPage extends StatefulWidget {
  NewGiftPage({super.key});
  static const int giftIconId = 40;
  List<Widget>? actions;
  @override
  State<NewGiftPage> createState() => NewGiftPageState();
}

class NewGiftPageState extends State<NewGiftPage> {
  final TextEditingController name = TextEditingController();
  final TextEditingController coins = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late SelectIcon selectIcon;
  List<Widget>? children;
  void save(BuildContext context) {
    if (formKey.currentState!.validate()) {
      db.sql.gifts.add(
        name: name.text,
        price: int.parse(coins.text),
        iconId: selectIcon.selectedIconId ?? NewGiftPage.giftIconId,
      );
      context.read<GiftProvider>().newGift();
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    selectIcon = SelectIcon();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr("newGift")),
        actions: widget.actions,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
                key: formKey,
                child: Column(
                  children: [
                    selectIcon,
                    const SizedBox(
                      height: 10,
                    ),
                    AutoDirectionTextFormField(
                        controller: name,
                        errMessage: tr("errMessage"),
                        hintText: tr("name")),
                    NumericField(
                      hintText: tr("coins"),
                      controller: coins,
                      maxValue: 9999999,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ...?children,
                    TextButton(
                      onPressed: () {
                        save(context);
                      },
                      child: Text(tr("save")),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    coins.dispose();
    name.dispose();
    super.dispose();
  }
}
