import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pal_mail_app/constants/keys.dart';
import 'package:pal_mail_app/constants/widget.dart';
import 'package:pal_mail_app/models/mails_model.dart';
import 'package:pal_mail_app/providers/details_mail_provider.dart';
import 'package:pal_mail_app/screens/details_mail_screen.dart';
import 'package:pal_mail_app/widgets/navigate_widget.dart';
import 'package:provider/provider.dart';

Widget mailsWidget({
  required Mail mails,
  required BuildContext context,
}) =>
    GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        margin: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30.r)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 18.w,
                  height: 18.h,
                  decoration: BoxDecoration(
                      color:
                          Color(int.parse(mails.status?.color ?? '0xff000000')),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.r),
                      )),
                ),
                SizedBox(
                  width: 12.w,
                ),
                Text(
                  mails.sender!.category!.name!,
                  style: TextStyle(
                    fontSize: 18.sp,
                  ),
                ),
                const Spacer(),
                Text(
                  "Today, 11:00 AM",
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                InkWell(
                  onTap: () {
                    final detailsMailProvider =
                        Provider.of<DetailsMailProvider>(context,
                            listen: false);
                    detailsMailProvider.setStatusMailsID(mails.status!.id!);
                    detailsMailProvider.setAttachmentList(mails.attachments);
                    detailsMailProvider.setActivityList(mails.activities);
                    navigatePush(
                        context: context,
                        nextScreen: DetailsMailScreen(mail: mails));
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
            smallSpacer,
            Text(
              mails.subject!,
              style: TextStyle(
                fontSize: 18.sp,
              ),
            ),
            Text(mails.description ?? '',
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.blueAccent,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis),
            smallSpacer,
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (var element in mails.attachments!)
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Image.network(
                          '${Keys.baseUrlStorage}/${element.image!}',
                          height: 46.h,
                          width: 46.w,
                          fit: BoxFit.fill),
                    ),
                ],
              ),
            ),
            smallSpacer,
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (var element in mails.tags!)
                    Text(
                      "#$element",
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.blueAccent,
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );

Color colorsStatusMails(int id) {
  if (id == 1) {
    return Colors.red;
  } else if (id == 2) {
    return Colors.yellow;
  } else if (id == 3) {
    return Colors.blueAccent;
  } else {
    return Colors.green;
  }
}
// wqe