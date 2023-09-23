import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pal_mail_app/constants/colors.dart';
import 'package:pal_mail_app/models/mails_model.dart';
import 'package:pal_mail_app/providers/search_provider.dart';
import 'package:pal_mail_app/widgets/mails_widget.dart';

class ExpansionTileWidget extends StatelessWidget {
  List<Mail> mails;
  SearchProvider searchProvider;

  ExpansionTileWidget(
      {Key? key, required this.mails, required this.searchProvider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        children: [

        ],
      ),
    );
  }
}
