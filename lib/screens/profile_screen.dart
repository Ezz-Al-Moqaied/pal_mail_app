
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/profile_controller.dart';
import '../controller/user_controller.dart';
import '../models/user_model.dart';
import '../providers/user_provider.dart';
import '../widgets/alert_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? pickedFile;
  String? filePath;
  bool isEditable = false;
  TextEditingController nameTextFieldCont = TextEditingController();
  late Future<UserModel> user;
  bool isUploading = false;
  String? name;

  @override
  void initState() {
    user = UserController().getLocalUser();
    user.then((userData) => {
          nameTextFieldCont.text = userData.user.name!,
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButton:  Padding(
        padding: const EdgeInsets.only(right: 40.0,bottom: 80),
        child: SizedBox(
          height: 50,
          width: 300,
          child: FloatingActionButton(
            shape: RoundedRectangleBorder(side: BorderSide(color: Colors.white,width: 2,style: BorderStyle.solid)),
                  onPressed: () async {
                    setState(() {
                      isUploading = true;
                    });
                    if (pickedFile != null) {
                      await uploadProfilePic(
                              pickedFile!, name ?? nameTextFieldCont.text)
                          .then((value) async {
                        final newImage = await getNewProfilePic();
                        updateSharedPreferences(
                                name ?? nameTextFieldCont.text, newImage!)
                            .then((value) {
                          setState(() {
                            isUploading = false;
                            user = UserController().getLocalUser();

                            showAlert(context,
                                message: "User Updated",
                                color: Colors.blue.withOpacity(0.75),
                                width: 150);
                          });
                        });
                        if (mounted) {
                          setState(() {
                            isEditable = false;
                          });
                        }
                        if (mounted) {
                          setState(() {
                            pickedFile = null;
                          });
                        }
                        Provider.of<UserProvider>(context, listen: false)
                            .getUserData();
                      }).catchError((err) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(err.toString()),
                          backgroundColor: Colors.red,
                        ));
                      });
                    } else {
                      updateName(name ?? nameTextFieldCont.text).then((value) {
                        updateNameSharedPreferences(name ?? nameTextFieldCont.text)
                            .then((value) {
                          setState(() {
                            isUploading = false;
                            showAlert(context,
                                message: "User Updated",
                                color: Colors.blue.withOpacity(0.75),
                                width: 150);
                          });

                          if (mounted) {
                            setState(() {
                              isEditable = false;
                            });
                          }
                          if (mounted) {
                            setState(() {
                              pickedFile = null;
                            });
                          }
                          Provider.of<UserProvider>(context, listen: false)
                              .getUserData();
                        });
                      }).catchError((err) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(err.toString()),
                          backgroundColor: Colors.red,
                        ));
                      });
                    }
                  },
                  backgroundColor: Colors.blue,
                  child: Text('Edit profile'),
                ),
        ),
      ),
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 38),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            FutureBuilder(
                future: user,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  if (snapshot.hasData) {
                    return Center(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: 100, left: 30),
                              child: CircleAvatar(
                                radius: 100,
                                backgroundColor: Colors.blueGrey.shade300,
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 98,
                                  backgroundImage: pickedFile == null
                                      ? NetworkImage(
                                          '${snapshot.data!.user.image}',
                                        )
                                      : FileImage(
                                          File(pickedFile!.path),
                                        ) as ImageProvider<Object>,
                                ),
                              )),
                          GestureDetector(
                            onTap: () async {
                              pickedFile = await pickImageFile();

                              if (pickedFile != null) {
                                filePath = pickedFile!.path;
                              }
                              setState(() {});
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(end: 15.0),
                              child: Container(
                                width: 45,
                                height: 45,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25)),
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox();
                }),
            FutureBuilder(
                future: user,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  if (snapshot.hasData) {
                    return Container(
                      margin: const EdgeInsets.only(top: 400, left: 30),
                      child: Column(children: [
                        Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                leading: Icon(
                                  Icons.account_circle,
                                  size: 40,
                                  color: Colors.white,
                                ),
                                title: Text(
                                  'Name: ${nameTextFieldCont.text}',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                          ],
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.email,
                            size: 40,
                            color: Colors.white,
                          ),
                          title: Text(
                            'Email: ${snapshot.data!.user.email} ',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.book_outlined,
                            size: 40,
                            color: Colors.white,
                          ),
                          title: Text(
                            'Role: ${snapshot.data!.user.role?.name}',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ]),
                    );
                  }
                  return Column();
                })
          ],
        ),
      ),
    );
  }
}
