import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pal_mail_app/providers/status_provider.dart';

import 'package:pal_mail_app/widgets/navigate_widget.dart';
import 'package:provider/provider.dart';

import '../../constants/widget.dart';

class StatusBottomSheet {
  StatusBottomSheet();

  void showStatusBottomSheet(context) async {
    final categProvider = Provider.of<StatusProvider>(context, listen: false);
    Future<void> getData() async {
      await categProvider.getStatus();
    }

    showModalBottomSheet(
      backgroundColor: Colors.grey[100],
      isScrollControlled: true,
      useSafeArea: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15.r), topLeft: Radius.circular(15.r))),
      context: context,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height - 50,
          child: Column(
            children: [
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
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                  Text(
                    'New inbox',
                    style:
                        TextStyle(fontSize: 19.sp, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      navigatePop(context: context);
                    },
                    child: Text(
                      'Done',
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              smallSpacer,
              Consumer<StatusProvider>(
                builder: (context, value, child) {
                  getData();
                  return value.statusName.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : Padding(
                          padding: EdgeInsets.all(8.0.w.h),
                          child: Container(
                              padding: EdgeInsets.all(8.0.w.h),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.r))),
                              child: ListView.separated(
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {},
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0.w.h),
                                        child: InkWell(
                                          onTap: () {
                                            value.isSelected(index);
                                            print(categProvider.selected);
                                          },
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 40.w,
                                                height: 40.h,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.r),
                                                    color: Color(int.parse(value
                                                        .statusColors[index]))),
                                              ),
                                              SizedBox(
                                                width: 12.w,
                                              ),
                                              Text(
                                                value.statusName
                                                    .elementAt(index),
                                                style: TextStyle(
                                                  fontSize: 22.sp,
                                                ),
                                              ),
                                              const Spacer(),
                                              value.selected[index]
                                                  ? const Icon(
                                                      Icons.check,
                                                      color: Colors.blue,
                                                    )
                                                  : const SizedBox(),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      Container(
                                        height: 1.h,
                                        width: double.infinity,
                                        color: Colors.grey[300],
                                      ),
                                  itemCount: value.statusName.length)),
                        );
                },
              ),
            ],
          ),
        );
      },
    ).whenComplete(() {});
  }
}
