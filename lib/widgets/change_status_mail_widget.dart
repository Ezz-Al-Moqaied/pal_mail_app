import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pal_mail_app/constants/widget.dart';
import 'package:pal_mail_app/providers/details_mail_provider.dart';
import 'package:pal_mail_app/providers/home_provider.dart';
import 'package:pal_mail_app/services/localizations_extention.dart';

import 'package:pal_mail_app/widgets/navigate_widget.dart';
import 'package:provider/provider.dart';

class ChangeStatusMailWidget extends StatefulWidget {
  ChangeStatusMailWidget({Key? key}) : super(key: key);

  @override
  State<ChangeStatusMailWidget> createState() => _ChangeStatusMailWidgetState();
}

class _ChangeStatusMailWidgetState extends State<ChangeStatusMailWidget> {
  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    final detailsMailProvider = Provider.of<DetailsMailProvider>(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () async {
                      navigatePop(context: context);
                    },
                    child: Text(
                      context.localizations!.cancel,
                      style: TextStyle(
                        fontSize: 18.sp,
                      ),
                    )),
                Text(
                  "Status Mail",
                  style: TextStyle(fontSize: 18.sp),
                ),
                TextButton(
                    onPressed: () {
                      detailsMailProvider.setScreenChange(true);
                      navigatePop(context: context);
                    },
                    child: Text(
                      context.localizations!.done,
                      style: TextStyle(fontSize: 18.sp),
                    )),
              ],
            ),
            mediumSpacer,
            Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20.r)),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: homeProvider.statusMails.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        detailsMailProvider.setStatusMailsID(
                            homeProvider.statusMails[index].id!);
                      },
                      leading: Container(
                        height: 32.h,
                        width: 32.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.r)),
                          color: Color(int.parse(
                              homeProvider.statusMails[index].color!)),
                        ),
                      ),
                      trailing: homeProvider.statusMails[index].id ==
                              detailsMailProvider.statusMailsID
                          ? const Icon(Icons.check)
                          : const SizedBox(
                              width: 1,
                              height: 1,
                            ),
                      title: Text(homeProvider.statusMails[index].name ==
                              "Inbox"
                          ? context.localizations!.inbox
                          : homeProvider.statusMails[index].name == "Pending"
                              ? context.localizations!.pending
                              : homeProvider.statusMails[index].name ==
                                      'In Progress'
                                  ? context.localizations!.inprogress
                                  : homeProvider.statusMails[index].name ==
                                          "Completed"
                                      ? context.localizations!.completed
                                      : ''),
                    );
                  },
                )),
            mediumSpacer,
          ],
        ),
      ),
    );
  }
}
