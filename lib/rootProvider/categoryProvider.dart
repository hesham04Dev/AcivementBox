import 'package:flutter/material.dart';

import '../db/db.dart';

class CategoryProvider with ChangeNotifier {
  CategoryProvider() {
    _Category = db.sql.categories.get();
  }
  newCategory() {
    _Category = db.sql.categories.get();
    notifyListeners();
  }

  categoryUpdated() {
    _Category = db.sql.categories.get();
    notifyListeners();
  }

  var _Category;
  get Category => _Category;
}
