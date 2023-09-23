
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../models/sender_model.dart';

class SendersScreen extends StatefulWidget {
  const SendersScreen({super.key});

  @override
  State<SendersScreen> createState() => _SendersScreenState();
}

class _SendersScreenState extends State<SendersScreen> {
  TextEditingController searchTextField = TextEditingController();
  late Future<Senders> senders;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  dynamic sendersData;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: const Column(
          children: [],
        ));
  }

// searchSenders(Senders sendersData, String searchTerm) {
//   result.clear();
//   for (int i = 0; i < sendersData.data.length; i++) {
//     final sender = sendersData.data[i];
//     final senderName = sender.name;
//     final senderMobile = sender.mobile;

//     if (senderMobile.contains(searchTerm) ||
//         senderName.contains(searchTerm)) {
//       result.addAll([senderName, senderMobile]);
//     }
//   }
// }
}

