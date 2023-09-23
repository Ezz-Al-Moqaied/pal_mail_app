import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pal_mail_app/providers/category_provider.dart';
import 'package:pal_mail_app/widgets/navigate_widget.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/widget.dart';

class CategoriesBottomSheet {
  CategoriesBottomSheet();

  void showCategoriesBottomSheet(context) async {
    final categProvider = Provider.of<CategoryProvider>(context, listen: false);
    Future<void> getData() async {
      await categProvider.getCategories();
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
        return TweenAnimationBuilder(
          curve: Curves.linear,
          builder: (BuildContext context, double? value, Widget? child) {
            return SizedBox(
              height: value,
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
                        style: TextStyle(
                            fontSize: 19.sp, fontWeight: FontWeight.bold),
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
                  Consumer<CategoryProvider>(
                    builder: (context, value, child) {
                      getData();
                      return value.catName.isEmpty
                          ? Shimmer(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFFEBEBF4),
                                  Color(0xFFF4F4F4),
                                  Color(0xFFEBEBF4),
                                ],
                                stops: [
                                  0.1,
                                  0.3,
                                  0.4,
                                ],
                                begin: Alignment(-1.0, -0.3),
                                end: Alignment(1.0, 0.3),
                                tileMode: TileMode.clamp,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0.w.h),
                                child: Container(
                                    padding: EdgeInsets.all(8.0.w.h),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30.r))),
                                    child: ListView.separated(
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {},
                                            child: Padding(
                                              padding: EdgeInsets.all(10.0.w.h),
                                              child: InkWell(
                                                onTap: () {},
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      '',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 22.sp,
                                                      ),
                                                    ),
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
                                              color: Colors.grey[900],
                                            ),
                                        itemCount: 4)),
                              ))
                          : Padding(
                              padding: EdgeInsets.all(8.0.w.h),
                              child: Container(
                                  padding: EdgeInsets.all(8.0.w.h),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.r))),
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
                                                  Text(
                                                    value.catName
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
                                      itemCount: value.catName.length)),
                            );
                    },
                  ),
                ],
              ),
            );
          },
          duration: const Duration(milliseconds: 500),
          tween: Tween<double>(
              begin: MediaQuery.of(context).size.height - 500.h,
              end: MediaQuery.of(context).size.height - 50),
        );
      },
    ).whenComplete(() {});
  }
}
