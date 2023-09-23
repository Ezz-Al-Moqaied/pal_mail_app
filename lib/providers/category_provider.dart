import 'package:flutter/material.dart';

import '../controller/new_inbox_controller.dart';
import '../models/tage_model.dart';

class CategoryProvider extends ChangeNotifier {
  final NewInboxHelper _helper = NewInboxHelper.instance;
  List<bool> _selected = [];

  Set<String> _catName = {};
  List<int> _categoryId = [];
  int _selectedCategoryId = 0;
  String _selectedCategoryname = '';

  List<int> get categoryId => _categoryId;
  String get selectedCategoryname => _selectedCategoryname;
  int get selectedCategoryId => _selectedCategoryId;
  Set<String> get catName => _catName;
  List<bool> get selected => _selected;

  Future<void> getCategories() async {
    await _helper.getCategory().then((value) {
      value.categories!.forEach((element) {
        _catName.add(element.name!);
        _selected.add(false);
        categoryId.add(element.id!);
      });
    });
    notifyListeners();
  }

  void isSelected(index) async {
    _selected.length = catName.length;
    for (var i = 0; i < _selected.length; i++) {
      if (i == index) {
        _selected[index] = !_selected[index];
        _selectedCategoryId = categoryId[index];
        _selectedCategoryname = catName.elementAt(index);
        print(_selectedCategoryId);
      } else {
        _selected[i] = false;
      }
    }

    notifyListeners();
  }
}
