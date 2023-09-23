import 'package:flutter/material.dart';
import 'package:pal_mail_app/services/helper/api_response.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../providers/user_1_provider.dart';
import '../providers/user_provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: splashColorDegree3,
      appBar: AppBar(
        backgroundColor: splashColorDegree3,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "User Management",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () async {
            await Provider.of<UserProvider>(context, listen: false)
                .getUserData();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.blueAccent,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: Consumer<AllUserProvider>(
          builder: (_, allUserProvider, __) {
            if (allUserProvider.allUserdata.status == Status.LOADING) {
              return ListView.builder(
                itemCount: allUserProvider.allUserdata.data?.users?.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Center();
                },
              );
            }
            if (allUserProvider.allUserdata.status == Status.COMPLETED) {
              return ListView.builder(
                  itemCount: allUserProvider.allUserdata.data?.users?.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ListTile();
                  });
            }

            return const Text(" No Data ");
          },
        ),
      ),
    );
  }
}