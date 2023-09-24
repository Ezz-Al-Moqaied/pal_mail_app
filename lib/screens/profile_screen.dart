import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  TextEditingController editNameController = TextEditingController();
  File? pickedFile;
  bool isUpload = false;
  String? name;
  String? pathFile;
  bool isEdit = false;
  late Future<UserModel> user;

  @override
  void initState() {
    user = UserController().getLocalUser();
    user.then((userData) => {
          editNameController.text = userData.user.name!,
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 40.0, bottom: 80),
        child: SizedBox(
          height: 50,
          width: 300,
          child: FloatingActionButton(
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: Colors.white, width: 2, style: BorderStyle.solid)),
            onPressed: () async {
              setState(() {
                isUpload = true;
              });
              if (pickedFile != null) {
                await uploadProfilePic(
                        pickedFile!, name ?? editNameController.text)
                    .then((value) async {
                  final newImage = await getNewProfilePic();
                  updateSharedPreferences(
                          name ?? editNameController.text, newImage!)
                      .then((value) {
                    setState(() {
                      isUpload = false;
                      user = UserController().getLocalUser();

                      showAlert(context,
                          message: "the inforamtion update",
                          color: Colors.blue.withOpacity(0.75),
                          width: 150);
                    });
                  });

                  if (mounted) {
                    setState(() {
                      isEdit = false;
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
                updateName(name ?? editNameController.text).then((value) {
                  updateNameSharedPreferences(name ?? editNameController.text)
                      .then((value) {
                    setState(() {
                      isUpload = false;
                      showAlert(context,
                          message: "User Updated",
                          color: Colors.blue.withOpacity(0.75),
                          width: 150);
                    });

                    if (mounted) {
                      setState(() {
                        isEdit = false;
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
                                pathFile = pickedFile!.path;
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
                  return const Center(
                    child: SpinKitPulse(
                      duration: Duration(milliseconds: 1000),
                      color: Colors.grey,
                      size: 40,
                    ),
                  );
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
                                leading: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 40,
                                ),
                                title: const Text(
                                  'Name:',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                subtitle: isEdit
                                    ? TextField(
                                        controller: editNameController,
                                        onChanged: (value) {
                                          setState(() {
                                            name = value;
                                          });
                                        },
                                        enabled: isEdit,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.only(bottom: 20),
                                          hintText:
                                              name ?? snapshot.data!.user.name,
                                          hintStyle: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                      )
                                    : Text(
                                        editNameController.text,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                              ),
                            ),
                            IconButton(
                              padding:
                                  const EdgeInsets.only(right: 45, bottom: 0),
                              onPressed: () {
                                setState(() {
                                  isEdit = !isEdit;
                                });
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                        ListTile(
                          leading: const Icon(
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
                          leading: const Icon(
                            Icons.alternate_email,
                            size: 40,
                            color: Colors.white,
                          ),
                          title: Text(
                            'Email Verified: ${snapshot.data!.user.emailVerifiedAt} ',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.book_outlined,
                            size: 36,
                            color: Colors.white,
                          ),
                          title: Text(
                            'Role: ${snapshot.data!.user.role?.name}',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ]),
                    );
                  }
                  return const Center(
                    child: SpinKitPulse(
                      duration: Duration(milliseconds: 1000),
                      color: Colors.grey,
                      size: 40,
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
