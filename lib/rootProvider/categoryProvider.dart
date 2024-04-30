import 'package:flutter/material.dart';

import '../../../db.dart';

class CategoryProvider with ChangeNotifier {
  CategoryProvider() {
    _Category = getCategories();
  }
  newCategory() {
    _Category = getCategories();
    notifyListeners();
  }

  var _Category;
  get Category => _Category;
}
