import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../controller/profile_controller.dart';
import '../controller/user_controller.dart';
import '../models/user_model.dart';
import '../providers/user_provider.dart';
import '../widgets/alert_widget.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfilePage> {
  File? pickedFile;
  String? filePath;
  bool isEdit = false;
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
      floatingActionButton: pickedFile != null || isEdit
          ? FloatingActionButton(
        onPressed: () async {
        },
        backgroundColor: Colors.blue,
        child: isUploading
            ? const Center(
          child: SizedBox(
            width: 25,
            height: 25,
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        )
            : const Icon(Icons.check),
      )
          : null,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              width: deviceWidth,
              height: deviceHeight * 0.4,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(170)),
              ),
            ),
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
                  Container(
                    width: 200,
                    margin: const EdgeInsets.only(top: 115, left: 10),
                    child: Stack(
                      children: [
                        RichText(
                          text: const TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'P',
                                style: TextStyle(
                                  fontSize: 110,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Positioned(
                          left: 40, // Adjust the left offset as needed
                          top: 72, // Adjust the top offset as needed
                          child: Text(
                            'rofile',
                            style: TextStyle(
                                letterSpacing: 3,
                                color: Colors.white,
                                fontSize: 35,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                    ),
                  )
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
                    // print('the snapshot image : ${snapshot.data!.user.image}');
                    // path = snapshot.data!.user.image!;
                    return Center(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Stack(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 190, left: 180),
                                  child: CircleAvatar(
                                    radius: 100,
                                    backgroundColor: Colors.blueGrey.shade300,
                                    child: Stack(
                                      children: [
                                        Shimmer.fromColors(
                                            baseColor: Colors.grey.shade300,
                                            highlightColor:
                                            Colors.grey.shade100,
                                            child: Container(
                                              // margin: EdgeInsets.only(top: 3),
                                              height: 195,
                                              width: 195,
                                              decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle),
                                            )),
                                        CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          radius: 98,
                                          backgroundImage: pickedFile == null
                                              ? NetworkImage(
                                            'https://palmail.gsgtt.tech/storage/${snapshot.data!.user.image}',
                                          )
                                              : FileImage(
                                            File(pickedFile!.path),
                                          ) as ImageProvider<Object>,
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
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
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(25)),
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
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
                                leading: const CircleAvatar(
                                  radius: 30,
                                  child: Icon(Icons.person),
                                ),
                                title: const Text(
                                  'Name:',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 134, 134, 134),
                                      fontSize: 16),
                                ),
                                subtitle: isEdit
                                    ? TextField(
                                  controller: nameTextFieldCont,
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
                                      color: Colors.grey,
                                      fontSize: 20,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                )
                                    : Text(
                                  nameTextFieldCont.text,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
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
                              icon: Icon(
                                Icons.edit,
                                color: Colors.blue,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                        ListTile(
                          leading: const CircleAvatar(
                            radius: 30,
                            child: Icon(Icons.email),
                          ),
                          title: Text(
                            'Email:',
                            style: const TextStyle(
                                color: Color.fromARGB(255, 134, 134, 134)),
                          ),
                          subtitle: Text(
                            snapshot.data!.user.email!,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        ListTile(
                          leading: const CircleAvatar(
                            radius: 30,
                            child: Icon(
                              Icons.account_box,
                            ),
                          ),
                          title: const Text(
                            'Role:',
                            style: TextStyle(
                                color: Color.fromARGB(255, 134, 134, 134)),
                          ),
                          subtitle: Text(
                            snapshot.data!.user.role!.name!,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
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