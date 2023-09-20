import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../providers/home_provider.dart';

class TagsWidget extends StatelessWidget {
  List<String> tag;

  TagsWidget({
    super.key,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tag.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 3,
          crossAxisCount: 3,
          mainAxisSpacing: 4.h,
          crossAxisSpacing: 4.w),
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(4),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
              color: Colors.blue
            ),
            child: Text("#${tag[index]}" , style: TextStyle(
              color: tagTextColor ,
              fontSize: 16.sp ,
            ),));
      },
    );
  }
}

/*
Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: tagButtonColor,
            borderRadius: BorderRadius.all(Radius.circular(30.r)),
          ),
          child: TextButton(
            child: Text(
              tag[index].name!,
              style: TextStyle(color: Colors.black, fontSize: 16.sp),
            ),
            onPressed: () {

            },

          ),
        )
 */