import 'package:achivement_box/models/AutoDirectionTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../db.dart';
import 'homePage/provider/giftProvider.dart';

class NewGiftPage extends StatelessWidget {
  const NewGiftPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController name = TextEditingController();
    final TextEditingController coins = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("new gift"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
                child: Column(
              children: [
                Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Theme.of(context).primaryColor.withOpacity(0.1)),
                    child: const Icon(Icons.add)),
                const SizedBox(
                  height: 10,
                ),
                AutoDirectionTextFormField(
                    controller: name,
                    errMessage: "errMessage",
                    hintText: "name"),
                Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: Theme.of(context).primaryColor.withOpacity(0.2)),
                  child: TextFormField(
                    controller: coins,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter a number";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "Coins", border: InputBorder.none),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    if (name.text.isNotEmpty && coins.text.isNotEmpty)
                      newGift(
                        name: name.text,
                        price: int.parse(coins.text),
                        iconId: 1,
                      );
                    context.read<GiftProvider>().newGift();
                    Navigator.pop(context);
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
