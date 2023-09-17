import 'package:flutter/material.dart';
import 'package:pal_mail_app/controller/status_controller.dart';

import '../controller/new_inbox_controller.dart';

class StatusProvider extends ChangeNotifier {
  final StatusHelper _helper = StatusHelper.instance;
  List<bool> _selected = [];

  Set<String> _statusName = {};
  List<int> _statusId = [];
  List<String> _statusColors = [];
  int? _selectedstatusId;
  String _selectedstatusname = '';
  String _selectedstatuscolor = '';

  List<int> get statusId => _statusId;
  List<String> get statusColors => _statusColors;
  String get selectedstatusname => _selectedstatusname;
  String get selectedstatuscolor => _selectedstatuscolor;
  int? get selectedstatusId => _selectedstatusId;
  Set<String> get statusName => _statusName;
  List<bool> get selected => _selected;

  Future<void> getStatus() async {
    await _helper.getStatus().then((value) {
      value.statuses!.forEach((element) {
        _statusName.add(element.name!);
        _statusColors.add(element.color!);
        _selected.add(false);
        _statusId.add(element.id!);
      });
    });
    notifyListeners();
  }

  void isSelected(index) async {
    _selected.length = _statusName.length;
    for (var i = 0; i < _selected.length; i++) {
      if (i == index) {
        _selected[index] = !_selected[index];
        _selectedstatusId = _statusId[index];
        _selectedstatusname = _statusName.elementAt(index);
        _selectedstatuscolor = _statusColors.elementAt(index);
        print(_selectedstatusId);
      } else {
        _selected[i] = false;
      }
    }

    notifyListeners();
  }
}
