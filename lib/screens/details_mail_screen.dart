import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pal_mail_app/constants/colors.dart';
import 'package:pal_mail_app/constants/keys.dart';
import 'package:pal_mail_app/models/mails_model.dart';
import 'package:pal_mail_app/providers/details_mail_provider.dart';
import 'package:pal_mail_app/services/localizations_extention.dart';
import 'package:pal_mail_app/services/shared_preferences.dart';
import 'package:pal_mail_app/widgets/change_status_mail_widget.dart';
import 'package:pal_mail_app/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class DetailsMailScreen extends StatefulWidget {
  Mail mail;

  DetailsMailScreen({Key? key, required this.mail}) : super(key: key);

  @override
  State<DetailsMailScreen> createState() => _DetailsMailScreenState();
}

class _DetailsMailScreenState extends State<DetailsMailScreen> {
  dynamic file;

  @override
  Widget build(BuildContext context) {
    final detailsMailProvider = Provider.of<DetailsMailProvider>(context);

    TextEditingController controller = TextEditingController();
    TextEditingController controllerActivity = TextEditingController();
    controller.text = widget.mail.decision ?? '';
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(context.localizations!.home),
        titleTextStyle: TextStyle(
            color: inboxtextColor,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold),
        iconTheme: IconThemeData(color: inboxtextColor, size: 30.sp),
        actions: [
          detailsMailProvider.isScreenChange
              ? IconButton(
                  onPressed: () {
                    detailsMailProvider.updateMail(widget.mail.id!, {
                      'decision': controller.text,
                      'status_id': detailsMailProvider.statusMailsID.toString(),
                    });
                  },
                  icon: const Icon(Icons.save))
              : IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_horiz_outlined)),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 16.h,
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30.r))),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.person_outline,
                          size: 35.sp,
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.mail.sender!.name!,
                              style: TextStyle(
                                fontSize: 16.sp,
                              ),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Text(
                              widget.mail.sender!.category!.name!,
                              style: TextStyle(
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.mail.archiveDate!,
                              style: TextStyle(
                                fontSize: 16.sp,
                              ),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Text(
                              '${context.localizations!.archivenumber} : ${widget.mail.archiveNumber!}',
                              style: TextStyle(
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                          title: Text(
                            widget.mail.subject!,
                            style:
                                TextStyle(fontSize: 20.sp, color: colorBlack),
                          ),
                          children: [
                            Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  widget.mail.description ?? '',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                  ),
                                )),
                            SizedBox(
                              height: 8.h,
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30.r))),
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Row(
                  children: [
                    for (var element in widget.mail.tags!)
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          '#${element.name!}',
                          style: const TextStyle(color: Colors.blue),
                        ),
                      )
                  ],
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30.r)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.screen_lock_rotation),
                    SizedBox(
                      width: 12.w,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30.r)),
                        color: Color(
                          int.parse(widget.mail.status!.color!),
                        ),
                      ),
                      child: Text(widget.mail.status!.name!),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.grey[100],
                            isScrollControlled: true,
                            useSafeArea: true,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    topLeft: Radius.circular(15))),
                            context: context,
                            builder: (context) {
                              return ChangeStatusMailWidget();
                            },
                          );
                        },
                        icon: const Icon(Icons.arrow_forward_ios))
                  ],
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30.r)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.localizations!.decision,
                      style: TextStyle(
                        fontSize: 20.sp,
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    textFormFieldWidget(
                      controller: controller,
                      type: TextInputType.text,
                      maxLines: 2,
                      outlinedBorder: true,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30.r)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.localizations!.addimage,
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Column(
                      children: [
                        for (var element in detailsMailProvider.attachments!)
                          Container(
                            margin: const EdgeInsets.all(5),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    detailsMailProvider
                                        .deleteItemAttachments(element);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30.r)),
                                        color: Colors.redAccent),
                                    child: const Icon(
                                      Icons.horizontal_rule,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Image.network(
                                    '${Keys.baseUrlStorage}/${element.image!}',
                                    height: 46.h,
                                    width: 46.w,
                                    fit: BoxFit.fill),
                                SizedBox(
                                  width: 12.w,
                                ),
                                Expanded(
                                    child: Text(element.title!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis)),
                                IconButton(
                                    onPressed: () {
                                      imagePicker(detailsMailProvider);
                                    },
                                    icon: const Icon(Icons.dehaze_sharp))
                              ],
                            ),
                          )
                      ],
                    )
                  ],
                ),
              ),
              Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                    title: Text(
                      context.localizations!.activity,
                      style: TextStyle(fontSize: 20.sp, color: colorBlack),
                    ),
                    children: [
                      for (var element in detailsMailProvider.activity!)
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 12.h, horizontal: 8.w),
                          margin: EdgeInsets.symmetric(vertical: 4.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.r)),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        '${Keys.baseUrlStorage}/${element.user!.image ?? ''}'),
                                    radius: 15.r,
                                  ),
                                  SizedBox(
                                    width: 12.w,
                                  ),
                                  Text(
                                    element.user!.name!,
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  Text(element.user!.createdAt ?? ''),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(element.body!),
                                ],
                              )
                            ],
                          ),
                        ),
                      SizedBox(
                        height: 8.h,
                      ),
                    ]),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
                margin: EdgeInsets.symmetric(vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30.r)),
                ),
                child: textFormFieldWidget(
                  controller: controllerActivity,
                  type: TextInputType.text,
                  hintText: "Add new Activity … ",
                  prefixIcon: Icons.person,
                  suffixIcon: IconButton(
                      onPressed: () {
                        detailsMailProvider.addActivity(Activity(
                          mailId: widget.mail.id.toString(),
                          updatedAt: DateTime.now().toString(),
                          createdAt: DateTime.now().toString(),
                          body: controllerActivity.text,
                          user: User(
                            id: SharedPreferencesHelper.user.user.id,
                            updatedAt:
                                SharedPreferencesHelper.user.user.updatedAt,
                            createdAt:
                                SharedPreferencesHelper.user.user.createdAt,
                            image: SharedPreferencesHelper.user.user.image,
                            name: SharedPreferencesHelper.user.user.name,
                            email: SharedPreferencesHelper.user.user.email,
                            emailVerifiedAt: SharedPreferencesHelper
                                .user.user.emailVerifiedAt,
                            roleId: SharedPreferencesHelper.user.user.roleId,
                          ),
                        ));
                      },
                      icon: const Icon(Icons.near_me_rounded)),
                  outlinedBorder: true,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void imagePicker(DetailsMailProvider detailsMailProvider) async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      file = File(image.path).uri;

      detailsMailProvider.addAttachments(Attachment(
          id: widget.mail.id,
          mailId: widget.mail.id.toString(),
          title: image.name,
          image: "images/lFyOobM7XHqV8ZCRZTuP7cN4ZJD09Dq8X4KoNTD9.jpg",
          createdAt: DateTime.now().toString(),
          updatedAt: DateTime.now().toString()));
    }
  }
}
