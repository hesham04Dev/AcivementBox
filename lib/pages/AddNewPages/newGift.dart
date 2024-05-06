import 'package:achivement_box/models/AutoDirectionTextFormField.dart';
import 'package:achivement_box/pages/AddNewPages/widget/NumericField.dart';
import 'package:achivement_box/rootProvider/iconProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../db/sql.dart';
import '../../rootProvider/giftProvider.dart';
import 'widget/icon.dart';

class NewGiftPage extends StatelessWidget {
  const NewGiftPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController name = TextEditingController();
    final TextEditingController coins = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("new gift"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SelectIcon(),
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
                        if (_formKey.currentState!.validate()) {
                          newGift(
                            name: name.text,
                            price: int.parse(coins.text),
                            iconId: context.read<IconProvider>().IconId,
                          );
                          context.read<GiftProvider>().newGift();
                          Navigator.pop(context);
                        }
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
}
//TODO max gift is nine million 99
