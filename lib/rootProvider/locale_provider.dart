import 'dart:io';

import 'package:achievement_box/models/my_toast.dart';
import 'package:flutter/material.dart';
import 'package:localization_lite/translate.dart';
import 'package:restart_app/restart_app.dart';

import '../db/db.dart';


class LocaleProvider with ChangeNotifier {
  LocaleProvider() {
    _languageId = db.sql.settings.getLanguageId();
    print("lang id is $_languageId");
    
  }
  
  languageChanged(int langId,BuildContext context) async {
    _languageId = langId;
    db.sql.settings.setLanguageId(langId);

if(Platform.isAndroid || Platform.isIOS){
  Restart.restartApp(
		notificationTitle: 'Restarting App',
		notificationBody: 'Please tap here to open the app again.',
	);
}else{
   MyToast(
    title: Text("need To restart app"),).show(context);
   
}
    
    // await Translate.setLang(Translate.supportedLangs[langId]);
    // notifyListeners();
  }

  late int _languageId;
  int get LanguageId => _languageId;
  String get Language => Translate.supportedLangs[_languageId];
  
}
