import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pal_mail_app/constants/colors.dart';
import 'package:pal_mail_app/widgets/text_field_widget.dart';

import '../constants/widget.dart';

class CustomModalBottomSheet {
  final BuildContext context;
  TextEditingController senderController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController decisionController = TextEditingController();

  DateTime _dateTime = DateTime.now();
  String? mo;

  Widget basicContainer(double height, Widget widget) {
    return Container(
        padding: EdgeInsets.all(5),
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: widget);
  }

  Widget lineContainer() {
    return Container(
      height: 1,
      width: 400,
      color: Colors.grey[200],
    );
  }

  CustomModalBottomSheet({required this.context});

  void show() {
    showModalBottomSheet(
      backgroundColor: Colors.grey[100],
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15))),
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height-50,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancle',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Text(
                      'New inbox',
                      style: TextStyle(
                          fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Done',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                smallSpacer,
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    //part number one
                      basicContainer(
                          180.h,
                          Column(
                            children: [
                              textFormFieldWidget(
                                colors: Colors.white,
                                hintText: 'name',
                                prefixIcon: Icons.account_circle,
                                suffixIcon: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.circle_outlined,
                                      color: Colors.blue,
                                    )),
                                controller: senderController,
                                type: TextInputType.text,
                                validate: (p0) => '',
                              ),
                              lineContainer(),
                              textFormFieldWidget(
                                colors: Colors.white,
                                hintText: 'Mobile',
                                prefixIcon:
                                Icons.phone_android_outlined,
                                controller: mobileController,
                                type: TextInputType.text,
                                validate: (p0) => '',
                              ),
                              lineContainer(),
                              InkWell(
                                onTap: () {},
                                child: const Padding(
                                  padding: EdgeInsets.only(
                                      right: 11.0,
                                      left: 11.0,
                                      top: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Categories',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        'Other',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: textFieldHintColor,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.grey,
                                        size: 15,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )),
                      smallSpacer,
                     //part number two
                      basicContainer(
                        143.h,
                        Column(
                          children: [
                            textFormFieldWidget(
                              colors: Colors.white,
                              hintText: 'Title of Mail',
                              controller: titleController,
                              type: TextInputType.text,
                              validate: (p0) => '',
                            ),
                            lineContainer(),
                            textFormFieldWidget(
                              colors: Colors.white,
                              hintText: 'Describtion',
                              controller: titleController,
                              type: TextInputType.text,
                              validate: (p0) => '',
                            )
                          ],
                        ),
                      ),
                      smallSpacer,
                    //part number three
                      basicContainer(
                          140.h,
                          Column(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: (){
                                    showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2025),
                                    ).then((value) {
                                      _dateTime = value!;
                                    }).catchError((error){
                                      print(error.toString());
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.date_range,
                                        color: Colors.red,
                                        size: 25,
                                      ),
                                      SizedBox(
                                        width: 11.w,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Date',
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4.h,
                                          ),
                                           Text(_dateTime.toString(),
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.grey,
                                        size: 20,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              lineContainer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.archive_outlined,
                                      color: textFieldHintColor,
                                      size: 25,
                                    ),
                                    SizedBox(
                                      width: 11.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Archive Number',
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        const Text(
                                          'like: 10/2/2023',
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                      smallSpacer,
                     //part number four
                      basicContainer(
                          55.h,
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                const Text(
                                  '#',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: border,
                                  ),
                                ),
                                SizedBox(
                                  width: 14.w,
                                ),
                                const Text(
                                  'Tags',
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                                Spacer(),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey,
                                  size: 20,
                                )
                              ],
                            ),
                          )),
                      smallSpacer,
                      //part number five
                      basicContainer(60.h, Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Icon(Icons.local_offer_outlined),
                            SizedBox(
                              width: 14.w,
                            ),
                            Container(
                              width: 70.w,
                              height: 50.h,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius:
                                  BorderRadius.circular(15)),
                              child: Center(
                                child: Text(
                                  'inbox',
                                  style: TextStyle(
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                              size: 20,
                            )
                          ],
                        ),
                      )),
                      smallSpacer,
                      //part number sex
                      basicContainer(120.h, Padding(
                          padding: const EdgeInsets.only(left: 12.0, top: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Decision',style: TextStyle(fontSize: 18),),
                              textFormFieldWidget(
                                colors: Colors.white,
                                hintText: 'Add Decision..',
                                controller: decisionController,
                                type: TextInputType.text,
                                validate: (p0) => '',
                              )
                            ],
                          ),
                        ),),
                      smallSpacer,
                      //part number seven
                      basicContainer(55, Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: InkWell(
                          onTap: (){},
                          child: Row(
                            children: [
                              Icon(Icons.image,color: tagTextColor,),
                              SizedBox(
                                width: 14.w,
                              ),
                              const Text(
                                'Add image',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: splashColorDegree1,
                                ),
                              ),
                              Spacer(),
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey,
                                size: 20,
                              )
                            ],
                          ),
                        ),
                      )),
                      smallSpacer,
                      const Text('Activity',style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),),
                      smallSpacer,
                      basicContainer(55,Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: InkWell(
                          onTap: (){},
                          child: const Row(
                            children: [
                              Text(
                                'Add new Activity ..',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: splashColorDegree1,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.send,
                                color: Colors.grey,
                                size: 20,
                              )
                            ],
                          ),
                        ),
                      ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
