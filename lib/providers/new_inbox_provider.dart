import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pal_mail_app/controller/new_inbox_controller.dart';
import 'package:pal_mail_app/controller/sender_model.dart';
import 'package:pal_mail_app/models/category_model.dart' as cat;

class NewInboxProvider extends ChangeNotifier {
  final NewInboxHelper _helper = NewInboxHelper.instance;
  ExpansionTileController expansionTile = ExpansionTileController();

  double angle = 0;
  //
  int _mailId = 0;
  int get mailId => _mailId;
  // Sender
  List<Datum> _senders = [];
  List<Datum> get senders => _senders;
  String senderName = "";
  String senderCategID = "";
  String senderCategName = "";
  String senderMobile = "";
  int idSender = 0;
  // Category
  List<cat.Category> _categories = [];
  List<cat.Category> _filters = [];
  List<cat.Category> get filters => _filters;
  List<cat.Category> get categories => _categories;
  String searchController = "";
  // Date Picker
  DateTime? _dateTime = DateTime.now();
  DateTime? get dateTime => _dateTime;
  // Activityies
  List<String> _activities = [];
  List<String> _activitiesDate = [];
  List<Map<String, dynamic>> _activitiesMap = [];
  List<String> get activities => _activities;
  List<Map<String, dynamic>> get activitiesMap => _activitiesMap;
  List<String> get activitiesDate => _activitiesDate;
  // Attachment
  Set<File> _files = {};
  Set<File> get files => _files;
  Future<void> addMailProv(
      {required String subject,
      String? description,
      required String senderId,
      required String archiveNumber,
      required String archiveDate,
      String? decision,
      required String statusId,
      String? finalDescision,
      List? tags,
      List? activities}) async {
    try {
      await _helper.addMail({
        'subject': subject,
        'description': description,
        'sender_id': senderId,
        'archive_number': archiveNumber,
        'archive_date': archiveDate,
        'decision': decision,
        'status_id': statusId,
        'final_decision': finalDescision,
        'tags': json.encode(tags),
        'activities': json.encode(activities),
      }).then((value) {
        _mailId = value!.id!;
      });
    } catch (e) {
      print('-------------------------');
      print(e.toString());
    }
  }

// sender Functions
  Future<void> createSendersProvider(
      {required String name,
      required String mobile,
      required String address,
      required String categoryId}) async {
    try {
      await _helper.createSender({
        'name': name,
        'mobile': mobile,
        'address': address,
        'category_id': categoryId
      }).then((value) {
        idSender = value!.id;
      });
    } catch (e) {
      print('-------------------------');
      print(e.toString());
    }
  }

  // void getSenderId() async {
  //   _categories.forEach((element) {
  //     element.senders!.forEach((element) {
  //       _senderid.add(element.id!);
  //     });
  //   });
  //   notifyListeners();
  // }

  Future<void> getCategoryAndSenders() async {
    try {
      await _helper.getCategory().then((value) {
        for (var element in value.categories!) {
          _categories.add(element);
        }
      });
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getSenders() async {
    try {
      await _helper.getSenders().then((value) {
        for (var element in value.senders.data) {
          _senders.add(element);
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void Filters() {
    _filters = categories.where((element) {
      return element.senders!.any((element2) {
        return element2.name!.contains(searchController);
      });
    }).toList();
  }

  Future<void> getData() async {
    await getCategoryAndSenders();
    // Filters();
    notifyListeners();
  }

  void UpdateData() {
    notifyListeners();
  }

  void clearSenderSearch() {
    senderName = searchController;
    idSender = 0;
    senderMobile = '';
    senderCategID = '';
    senderCategName = '';
    notifyListeners();
  }
// Activity

  void removeActiviy(int index) {
    _activities.removeAt(index);
    _activitiesDate.removeAt(index);
    _activitiesMap.removeAt(index);
    notifyListeners();
  }

  // Date Picker
  void updateDate(DateTime time) {
    _dateTime = time;
    notifyListeners();
  }

  // Clear Var
  void removeData() async {
    _categories.clear();
    _filters.clear();
    searchController = '';
    _senders.clear();

    _activities.clear();
    _activitiesMap.clear();
    _activitiesDate.clear();
    angle = 0;
    notifyListeners();
  }

  void clearSender() async {
    idSender = 0;
    senderMobile = '';
    senderName = '';
    senderCategID = '';
    senderCategName = '';
    notifyListeners();
  }

// Image Upload Attachment
  Future<void> uploadImage(context) async {
    File? file;

    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      file = File(picked.path);
      print(file.path);
      _files.add(file);
      print(files);
      notifyListeners();
      // Create a storage reference from our app
    } else {
      print(":eroor");
    }
  }

  Future<void> uploadImageToApi(File file, mailId) async {
    await _helper.uploadImageHttp(file, mailId);
  }

  void removeImage(int index) {
    _files.remove(_files.elementAt(index));
    notifyListeners();
  }

  // Expansigsdfsdafsd
  changeIconState(bool value) {
    print('ads');
    if (value) {
      angle = 90 * (math.pi / 180);
      print(angle);
    } else {
      angle = 0;
      print(angle);
    }
    notifyListeners();
  }
}
