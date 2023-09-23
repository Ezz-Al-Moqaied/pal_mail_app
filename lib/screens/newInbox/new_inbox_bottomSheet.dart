import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pal_mail_app/constants/colors.dart';
import 'package:pal_mail_app/providers/category_provider.dart';
import 'package:pal_mail_app/providers/home_provider.dart';
import 'package:pal_mail_app/providers/status_provider.dart';
import 'package:pal_mail_app/providers/tags_provider.dart';
import 'package:pal_mail_app/screens/home_screen.dart';
import 'package:pal_mail_app/screens/newInbox/category_bottomSheet.dart';
import 'package:pal_mail_app/screens/newInbox/status_bottomSheet.dart';
import 'package:pal_mail_app/services/shared_preferences.dart';
import 'package:pal_mail_app/screens/newInbox/sender_search_bottomSheet.dart';
import 'tags_bottomSheet_widget.dart';

import 'package:pal_mail_app/providers/new_inbox_provider.dart';
import 'package:pal_mail_app/widgets/flutterToastWidget.dart';
import 'package:pal_mail_app/widgets/navigate_widget.dart';

import 'package:pal_mail_app/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';

import '../../constants/widget.dart';

class CustomModalBottomSheet {
  final BuildContext context;
  final tags = TagsBottomSheet();
  TextEditingController senderController = TextEditingController();
  TextEditingController archiveController = TextEditingController();
  ExpansionTileController expanController = ExpansionTileController();
  TextEditingController activityController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController decisionController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController tagsController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Widget basicContainer(double height, Widget widget) {
    return Container(
        padding: EdgeInsets.all(5.w.h),
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30.r))),
        child: widget);
  }

  CustomModalBottomSheet({required this.context});

  void show() async {
    final newInboxProv = Provider.of<NewInboxProvider>(context, listen: false);
    final cat = Provider.of<CategoryProvider>(context, listen: false);
    final statusProvider = Provider.of<StatusProvider>(context, listen: false);

    final tagsProvider = Provider.of<TagsProvider>(context, listen: false);
    final home = Provider.of<HomeProvider>(context, listen: false);
    Future<void> createSender() async {
      await newInboxProv.createSendersProvider(
          name: senderController.text,
          address: '',
          mobile: mobileController.text,
          categoryId: cat.selectedCategoryId.toString());
    }

    Future<void> addMail() async {
      if (titleController.text.isNotEmpty &&
          senderController.text.isNotEmpty &&
          mobileController.text.isNotEmpty &&
          archiveController.text.isNotEmpty &&
          statusProvider.statusId.isNotEmpty) {

        if (newInboxProv.idSender == 0) {
          await createSender();
        }
        await newInboxProv
            .addMailProv(
          decision: decisionController.text,
          description: descriptionController.text,
          subject: titleController.text,
          senderId: newInboxProv.idSender.toString(),
          archiveNumber: archiveController.text,
          archiveDate:
              "${newInboxProv.dateTime!.year}-${newInboxProv.dateTime!.month}-${newInboxProv.dateTime!.day}",
          statusId: statusProvider.selectedstatusId.toString(),
          finalDescision: decisionController.text,
          activities: newInboxProv.activitiesMap.isEmpty
              ? []
              : newInboxProv.activitiesMap,
          tags: tagsProvider.tagsId,
        )
            .then((value) async {
          print(newInboxProv.files);
          newInboxProv.files.forEach((element) async {
            await newInboxProv.uploadImageToApi(element, newInboxProv.mailId);
          });
          home.cleanDate();
          await home.getAllMails();
          newInboxProv.removeData();
          tagsProvider.clearData();
          tagsProvider.clearTags();
          newInboxProv.clearSender();
          newInboxProv.clearSender();
          tagsProvider.tagsId.clear();
          tagsProvider.selected.clear();
          newInboxProv.activities.clear();
          newInboxProv.activitiesDate.clear();
          newInboxProv.activitiesMap.clear();
          newInboxProv.files.clear();

          navigatePush(context: context, nextScreen: HomeScreen());
        });
      } else {
        if (senderController.text.isEmpty) {
          flutterToastWidget(msg: 'Mail must have a Sender 😄');
        } else if (mobileController.text.isEmpty) {
          flutterToastWidget(msg: 'Sender must Have mobile number 😄');
        } else if (titleController.text.isEmpty) {
          flutterToastWidget(msg: 'Mail must have a Title 😄');
        } else if (archiveController.text.isEmpty) {
          flutterToastWidget(msg: 'Mail must have a Archive 😄');
        } else if (statusProvider.statusId.isEmpty) {
          flutterToastWidget(msg: 'Mail must have a Status 😄');
        }
      }
    }

    showModalBottomSheet(
      backgroundColor: const Color(0xffF7F6FF),
      isScrollControlled: true,
      useSafeArea: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15.r), topLeft: Radius.circular(15.r))),
      context: context,
      builder: (BuildContext context) {
        return TweenAnimationBuilder(
          builder: (BuildContext context, double? value, Widget? child) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              height: value,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () async {
                            newInboxProv.removeData();
                            tagsProvider.clearData();
                            tagsProvider.clearTags();
                            newInboxProv.clearSender();
                            newInboxProv.clearSender();
                            tagsProvider.tagsId.clear();
                            tagsProvider.selected.clear();
                            newInboxProv.activities.clear();
                            newInboxProv.activitiesDate.clear();
                            newInboxProv.activitiesMap.clear();
                            newInboxProv.files.clear();
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Cancle',
                            style: TextStyle(
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                        Text(
                          'New inbox',
                          style: TextStyle(
                              fontSize: 19.sp, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () async {
                            await addMail();

                            // ignore: use_build_context_synchronously
                          },
                          child: Text(
                            'Done',
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    smallSpacer,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //part number one
                          basicContainer(
                              183.h,
                              Column(
                                children: [
                                  Expanded(
                                    child: Consumer<NewInboxProvider>(
                                      builder: (context, prov, child) {
                                        if (prov.senderName != '') {
                                          senderController.text =
                                              prov.senderName;
                                        }
                                        return textFormFieldWidget(
                                          readOnly:
                                              prov.idSender == 0 ? false : true,
                                          validate: (value) {
                                            senderController.text = value!;
                                            return null;
                                          },
                                          colors: Colors.white,
                                          hintText: 'name',
                                          suffixIcon: IconButton(
                                              splashColor: Colors.transparent,
                                              onPressed: () {
                                                SenderSearchWidget()
                                                    .showSearchBar(context);
                                              },
                                              icon: const Icon(
                                                Icons.info_outline,
                                                color: Colors.blue,
                                              )),
                                          controller: senderController,
                                          type: TextInputType.text,
                                        );
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: Consumer<NewInboxProvider>(
                                      builder: (context, prov, child) {
                                        if (prov.idSender != 0) {
                                          mobileController.text =
                                              prov.senderMobile;
                                        }
                                        return textFormFieldWidget(
                                          validate: (p0) {

                                          },
                                          readOnly: prov.senderMobile.isEmpty
                                              ? false
                                              : true,
                                          colors: Colors.white,
                                          hintText: 'Mobile',
                                          controller: mobileController,
                                          type: TextInputType.text,
                                        );
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {},
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            right: 15.0.w,
                                            left: 15.0.w,
                                            top: 10.h),
                                        child: Consumer2<NewInboxProvider,
                                            CategoryProvider>(
                                          builder:
                                              (context, prov, catProv, child) {
                                            return InkWell(
                                              onTap: () {
                                                CategoriesBottomSheet()
                                                    .showCategoriesBottomSheet(
                                                        context);
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Categories',
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    prov.senderCategID == ''
                                                        ? catProv
                                                            .selectedCategoryname
                                                        : prov.senderCategName,
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                      color: textFieldHintColor,
                                                    ),
                                                  ),
                                                  prov.senderMobile.isEmpty
                                                      ? Icon(
                                                          Icons
                                                              .arrow_forward_ios,
                                                          color: Colors.grey,
                                                          size: 15.sp,
                                                        )
                                                      : const SizedBox()
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                          smallSpacer,
                          //part number two
                          basicContainer(
                            145.h,
                            Column(
                              children: [
                                Expanded(
                                  child: Form(
                                    key: formKey,
                                    child: textFormFieldWidget(
                                      validate: (p0) {

                                      },
                                      colors: Colors.white,
                                      hintText: 'Title of Mail',
                                      controller: titleController,
                                      type: TextInputType.text,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: textFormFieldWidget(
                                    validate: (value) {
                                      descriptionController.text = value!;
                                      return null;
                                    },
                                    colors: Colors.white,
                                    hintText: 'Describtion',
                                    controller: descriptionController,
                                    type: TextInputType.text,
                                  ),
                                )
                              ],
                            ),
                          ),
                          smallSpacer,
                          //part number three
                          basicContainer(
                              180.h,
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Consumer<NewInboxProvider>(
                                      builder: (context, prov, child) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15.w),
                                          child: InkWell(
                                            onTap: () {
                                              showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(2000),
                                                currentDate: prov.dateTime,
                                                lastDate: DateTime(2025),
                                              ).then((value) {
                                                prov.updateDate(value!);
                                              }).catchError((error) {
                                                print(error.toString());
                                              });
                                              ;
                                            },
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.date_range,
                                                  color: Colors.red,
                                                  size: 25.sp,
                                                ),
                                                SizedBox(
                                                  width: 11.w,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        'Date',
                                                        style: TextStyle(
                                                          fontSize: 15.sp,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 4.h,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        prov.dateTime
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: 12.sp,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const Spacer(),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Colors.grey,
                                                  size: 20.sp,
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Expanded(
                                      child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15.w, vertical: 4),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Icon(
                                              Icons.archive_outlined,
                                              size: 25.sp,
                                            )),
                                        Expanded(
                                          flex: 10,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "Archive Number",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16.sp),
                                                ),
                                              ),
                                              Expanded(
                                                child: textFormFieldWidget(
                                                  validate: (p0) {

                                                  },
                                                    colors: colorWhite,
                                                    hintText: 'like: 10/2/2023',
                                                    controller:
                                                        archiveController,
                                                    type: TextInputType.text),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                                ],
                              )),
                          smallSpacer,
                          //part number four
                          basicContainer(
                              65.h,
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                child: InkWell(
                                  onTap: () async {
                                    // ignore: use_build_context_synchronously
                                    tags.showTagsSheet(context);
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        '#',
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          color: border,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 14.w,
                                      ),
                                      Text(
                                        'Tags',
                                        style: TextStyle(
                                          fontSize: 17.sp,
                                        ),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.grey,
                                        size: 20.sp,
                                      )
                                    ],
                                  ),
                                ),
                              )),
                          smallSpacer,
                          //part number five
                          basicContainer(
                              60.h,
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                child: Consumer<StatusProvider>(
                                  builder: (context, value, child) {
                                    return InkWell(
                                      onTap: () {
                                        StatusBottomSheet()
                                            .showStatusBottomSheet(context);
                                      },
                                      child: Row(
                                        children: [
                                          const Icon(
                                              Icons.local_offer_outlined),
                                          SizedBox(
                                            width: 14.w,
                                          ),
                                          Container(
                                            width: 70.w,
                                            height: 50.h,
                                            decoration: BoxDecoration(
                                                color: value.selectedstatuscolor
                                                        .isEmpty
                                                    ? null
                                                    : Color(int.parse(value
                                                        .selectedstatuscolor)),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        15.r)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Center(
                                                child: Text(
                                                  value.selectedstatusname
                                                          .isEmpty
                                                      ? 'Choose Status'
                                                      : value
                                                          .selectedstatusname,
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: value
                                                              .selectedstatusname
                                                              .isEmpty
                                                          ? null
                                                          : Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Spacer(),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.grey,
                                            size: 20.sp,
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              )),
                          smallSpacer,
                          //part number sex
                          basicContainer(
                            120.h,
                            Padding(
                              padding: EdgeInsets.only(left: 15.0.w, top: 12.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Decision',
                                      style: TextStyle(fontSize: 18.sp),
                                    ),
                                  ),
                                  Expanded(
                                    child: textFormFieldWidget(
                                      colors: Colors.white,
                                      hintText: 'Add Decision..',
                                      controller: decisionController,
                                      type: TextInputType.text,
                                      validate: (p0) => '',
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          smallSpacer,
                          //part number seven
                          Consumer<NewInboxProvider>(
                            builder: (context, prov, child) {
                              return Container(
                                decoration: BoxDecoration(
                                    color: colorWhite,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(30.r))),
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.image,
                                            color: tagTextColor,
                                          ),
                                          SizedBox(
                                            width: 14.w,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              await prov.uploadImage(context);
                                            },
                                            child: Text(
                                              'Add image',
                                              style: TextStyle(
                                                fontSize: 17.sp,
                                                color: splashColorDegree1,
                                              ),
                                            ),
                                          ),
                                          const Spacer(),
                                        ],
                                      ),
                                    ),
                                    prov.files.isEmpty
                                        ? const SizedBox()
                                        : ListView.separated(
                                            padding:
                                                EdgeInsets.only(bottom: 8.h),
                                            shrinkWrap: true,
                                            itemCount: prov.files.length,
                                            itemBuilder: (context, index) {
                                              return prov.files
                                                      .elementAt(index)
                                                      .path
                                                      .isEmpty
                                                  ? const SizedBox()
                                                  : Row(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            prov.removeImage(
                                                                index);
                                                            print(prov.files);
                                                          },
                                                          child: Icon(
                                                            Icons.delete,
                                                            size: 25.sp,
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 12,
                                                        ),
                                                        Container(
                                                          width: 40,
                                                          height: 40,
                                                          decoration:
                                                              BoxDecoration(
                                                                  image:
                                                                      DecorationImage(
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          image:
                                                                              FileImage(
                                                                            prov.files.elementAt(index),
                                                                          )),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15.r)),
                                                        )
                                                      ],
                                                    );
                                            },
                                            separatorBuilder:
                                                (BuildContext context,
                                                    int index) {
                                              return smallSpacer;
                                            },
                                          )
                                  ],
                                ),
                              );
                            },
                          ),
                          smallSpacer,
                          Consumer<NewInboxProvider>(
                            builder: (context, prov, child) {
                              return ExpansionTile(
                                onExpansionChanged: (value) {
                                  prov.changeIconState(value);
                                },
                                controller: prov.expansionTile,
                                tilePadding:
                                    EdgeInsets.symmetric(horizontal: 15.w),
                                // controller: expanController,
                                trailing: Container(
                                  width: 50.w,
                                  height: 50.h,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      prov.activities.isEmpty
                                          ? const SizedBox()
                                          : Text(
                                              "${prov.activities.length}",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey[400]),
                                            ),
                                      TweenAnimationBuilder(
                                        builder: (BuildContext context,
                                            double? value, Widget? child) {
                                          return Transform.rotate(
                                            angle: value!,
                                            origin: Offset.zero,
                                            alignment: Alignment.center,
                                            child: Icon(
                                              Icons.arrow_forward_ios,
                                              color: Colors.grey,
                                              size: 20.sp,
                                            ),
                                          );
                                        },
                                        duration:
                                            const Duration(milliseconds: 200),
                                        tween: Tween<double>(
                                            begin: 0, end: prov.angle),
                                      )
                                    ],
                                  ),
                                ),
                                title: Text(
                                  'Activity',
                                  style: TextStyle(
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                children: [
                                  Consumer<NewInboxProvider>(
                                      builder: (context, prov, child) {
                                    return ListView.separated(
                                      reverse: true,
                                      physics: const BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: prov.activities.length,
                                      itemBuilder: (context, index) {
                                        return prov.activities
                                                .elementAt(index)
                                                .isEmpty
                                            ? const SizedBox()
                                            : basicContainer(
                                                80.h,
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 15.w,
                                                      vertical: 4),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30)),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Icon(
                                                        Icons.circle,
                                                        size: 20.sp,
                                                        color: Colors.blue,
                                                      ),
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            SharedPreferencesHelper
                                                                .user
                                                                .user!
                                                                .name!,
                                                          ),
                                                          Text(
                                                            prov.activities[
                                                                index],
                                                            style: TextStyle(
                                                                fontSize: 12.sp,
                                                                color: border),
                                                          ),
                                                        ],
                                                      ),
                                                      const Spacer(),
                                                      Row(
                                                        children: [
                                                          Text(
                                                              prov.activitiesDate[
                                                                  index]),
                                                          IconButton(
                                                              onPressed: () {
                                                                prov.removeActiviy(
                                                                    index);
                                                                print(prov
                                                                    .activitiesMap);
                                                              },
                                                              icon: Icon(
                                                                Icons.delete,
                                                                color:
                                                                    Colors.red,
                                                                size: 25.sp,
                                                              ))
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ));
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return smallSpacer;
                                      },
                                    );
                                  })
                                ],
                              );
                            },
                          ),
                          smallSpacer,

                          SizedBox(
                            height: 100.h,
                            child: Consumer<NewInboxProvider>(
                              builder: (context, prov, child) {
                                return textFormFieldWidget(
                                  validate: (p0) {

                                  },
                                    suffixIcon: IconButton(
                                        splashColor: Colors.transparent,
                                        onPressed: () async {
                                          if (activityController
                                              .text.isNotEmpty) {
                                            prov.activities
                                                .add(activityController.text);
                                            prov.activitiesDate.add(
                                                "${DateTime.now().day}-${DateTime.timestamp().month}-${DateTime.timestamp().year}");
                                            prov.activitiesMap.add({
                                              "body": activityController.text,
                                              'user_id': SharedPreferencesHelper
                                                  .user.user!.id
                                            });
                                            activityController.clear();
                                            prov.UpdateData();
                                            print(prov.activitiesMap);
                                          } else {
                                            flutterToastWidget(
                                                msg: "Activity must be filled",
                                                colors: Colors.red);
                                          }
                                        },
                                        icon: Transform.rotate(
                                            angle: -45,
                                            child: const Icon(
                                                Icons.send_rounded))),
                                    colors: const Color(0xffEEEEF6),
                                    controller: activityController,
                                    type: TextInputType.text);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          duration: const Duration(seconds: 1),
          curve: Curves.bounceOut,
          tween: Tween<double>(
              begin: 0, end: MediaQuery.of(context).size.height - 50),
        );
      },
    ).whenComplete(() {});
  }
}
