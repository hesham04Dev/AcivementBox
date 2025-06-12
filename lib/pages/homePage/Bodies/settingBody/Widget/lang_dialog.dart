
import '/rootProvider/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:localization_lite/translate.dart';
import 'package:provider/provider.dart';

import '../../../../../db/db.dart';


class LangDialog extends StatelessWidget {
  const LangDialog({super.key});
  // int langId = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 155,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              itemBuilder: (context, index) => TextButton(
                    onPressed: () async{
                     await context
                          .read<LocaleProvider>()
                          .languageChanged(index,context);
                      Navigator.pop(context);
                    },
                    child: Text(
                      Translate.supportedLangs[index],
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
              itemCount: Translate.supportedLangs.length,
             ),
        ),
      ),
    );
    ;
  }
}
