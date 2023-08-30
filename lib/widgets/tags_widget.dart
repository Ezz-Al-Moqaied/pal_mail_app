import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';

class TagsWidget extends StatelessWidget {
  const TagsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100.h,
        decoration: BoxDecoration(
            color: colorWhite, borderRadius: BorderRadius.circular(30.r)),
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          scrollDirection: Axis.vertical,
          itemCount: 4,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 3,
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                print("Test");
              },
              child: Container(
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                    color: tagButtonColor,
                    borderRadius:
                        BorderRadiusDirectional.all(Radius.circular(30.r))),
                child: Text(
                  "#Urhent",
                  style: TextStyle(color: tagTextColor, fontSize: 14.sp),
                ),
              ),
            );
          },
        ));
  }
}
