import 'package:flutter/material.dart';
import 'package:pal_mail_app/controller/tags_controller.dart';

import '../models/tage_model.dart';

class TagsProvider extends ChangeNotifier {
  final TagsHelper _helper = TagsHelper.instance;
  List<bool> _selected = [];
  Set<Tag> _tags = {};
  Set<String> _tagsName = {};
  List<int> _tagsIdSelected = [];
  Set<Tag> get tags => _tags;
  List<int> get tagsId => _tagsIdSelected;
  Set<String> get tagsName => _tagsName;
  List<bool> get selected => _selected;
  Future<void> createTags({required String name}) async {
    await _helper.createTags({'name': name});
    _tagsName.add(name);
    notifyListeners();
  }

  Future<void> getTagsProv() async {
    await _helper.getTags().then((value) {
      for (var element in value.tags!) {
        _tags.add(element);
        _tagsName.add(element.name!);
      }
    });
    notifyListeners();
  }

  Future<void> isSelected() async {
    for (var i = 0; i < tagsName.length; i++) {
      _selected.add(false);
    }
  }

  void isSelectedState(int index) {
    _selected[index] = !_selected[index];
    notifyListeners();

    if (_selected[index]) {
      _tagsIdSelected.add(tags.elementAt(index).id!);
    } else {
      _tagsIdSelected.remove(tags.elementAt(index).id);
    }
  }

  void clearData() {
    tags.clear();

    tagsName.clear();
    notifyListeners();
  }

  void clearTags() {
    selected.clear();
    tagsId.clear();
    notifyListeners();
  }
}
