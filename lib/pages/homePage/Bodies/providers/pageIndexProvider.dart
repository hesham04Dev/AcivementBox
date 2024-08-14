import 'package:flutter/material.dart';

class PageIndexProvider with ChangeNotifier {
  static const homepageIndex = 1;

  int _pageIndex = homepageIndex;
  PageController bodiesController = PageController(initialPage: homepageIndex);

  void pageIndexChanged(index) {
    _pageIndex = index.round();
    notifyListeners();
  }

  set pageIndex(value) => _pageIndex = value;
  get pageIndex => _pageIndex;
}
