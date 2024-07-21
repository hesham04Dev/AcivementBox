import 'package:achivement_box/models/AutoDirectionTextFormField.dart';
import 'package:achivement_box/pages/AddNewPages/widget/NumericField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../db/sql.dart';
import '../../rootProvider/giftProvider.dart';
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
  void save(BuildContext context) {
    if (formKey.currentState!.validate()) {
      newGift(
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
        title: const Text("new gift"),
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
                        errMessage: "errMessage",
                        hintText: "name"),
                    NumericField(
                      hintText: "Coins",
                      controller: coins,
                      maxValue: 9999999,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      onPressed: () {
                        save(context);
                      },
                      child: const Text("save"),
                      //color: Theme.of(context).primaryColor.withOpacity(0.5),
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
