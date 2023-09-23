import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileScreen extends StatefulWidget {
   UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {

  pickImage(ImageSource source)async{
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);

    if(file != null){
      return await file.readAsBytes();
    }
  }
  Uint8List? _image;

  void selectImage()async{
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }
  @override
  Widget build(BuildContext context) {
    String tPhoneNo = '0567155819';
    String tPassword = '';

    TextEditingController controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back)),
        title: Text('Update profile', style: TextStyle(fontSize: 18)),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            children: [
              // -- IMAGE with ICON
              Stack(
                children: [
                  _image !=null ?
                  CircleAvatar(
                    radius: 64,
                    backgroundImage: MemoryImage(_image!),
                  ):const CircleAvatar(
                    radius: 64,
                    backgroundImage: AssetImage('assets/images/1.jpeg'),
                  ),
                  //     :SizedBox(
                  //   width: 120,
                  //   height: 120,
                  //   child: ClipRRect(
                  //       borderRadius: BorderRadius.circular(100),
                  //       child: const Image(image: AssetImage('assets/images/1.jpeg'),fit: BoxFit.cover,)),
                  // ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.blue),
                      child: IconButton(onPressed: (){
                        selectImage();
                      }, icon: const Icon(Icons.edit, color: Colors.black, size: 20),)
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),

              // -- Form Fields
              Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                        label: Text('mohammed shawwa'), prefixIcon: Icon(Icons.account_box)),
                  ),
                  SizedBox(height: 10.h),
                  TextFormField(
                    decoration: const InputDecoration(
                        label: Text('mohammedelshawwa944@gmail.com'), prefixIcon: Icon(Icons.email)),
                  ),
                  TextFormField(
                    decoration:  InputDecoration(
                        label: Text(tPhoneNo), prefixIcon: Icon(Icons.phone)),
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      label:  Text(tPassword),
                      prefixIcon: const Icon(Icons.fingerprint),
                      suffixIcon:
                      IconButton(icon: const Icon(Icons.remove_red_eye), onPressed: () {}),
                    ),
                  ),
                  SizedBox(height: 20.h),


                  // -- Form Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateProfileScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          side: BorderSide.none,
                          shape: const StadiumBorder()),
                      child: const Text('Edit Profile', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // -- Created Date and Delete Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text.rich(
                        TextSpan(
                          text: 'tJoined',
                          style: TextStyle(fontSize: 15),
                          children: [
                            TextSpan(
                                text: ' october 2023',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}