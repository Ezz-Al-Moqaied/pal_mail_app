import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pal_mail_app/constants/colors.dart';
import 'package:pal_mail_app/constants/widget.dart';
import 'package:pal_mail_app/providers/home_provider.dart';
import 'package:pal_mail_app/providers/search_provider.dart';
import 'package:pal_mail_app/screens/filter_screen.dart';
import 'package:pal_mail_app/widgets/mails_widget.dart';
import 'package:pal_mail_app/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);
    final homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Column(
            children: [
              largeSpacer,
              Row(
                children: [
                  Expanded(
                    flex: 9,
                    child: textFormFieldWidget(
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter the password';
                        }
                        return null;
                      },
                      type: TextInputType.text,
                      suffixIcon: IconButton(
                          onPressed: () async {
                            await searchProvider.getAllMails(
                                controller.text, homeProvider);
                          },
                          icon: const Icon(Icons.search_outlined)),
                      prefixIcon: Icons.clear,
                      controller: controller,
                      hintText: 'search',
                      outlinedBorder: true,
                    ),
                  ),
                  Expanded(
                      child: IconButton(
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
                          return FilterScreen();
                        },
                      );
                    },
                    icon: const Icon(Icons.filter_list_alt),
                  ))
                ],
              ),
              searchProvider.countCategoryMails(2) != 0
                  ? Row(
                      children: [
                        Text(
                          "Official Organization",
                          style: TextStyle(
                              fontSize: 20.sp,
                              color: colorBlack.withOpacity(0.5)),
                        ),
                        const Spacer(),
                        Text('${searchProvider.countCategoryMails(2)} Found',
                            style: TextStyle(
                                fontSize: 20.sp,
                                color: colorBlack.withOpacity(0.5))),
                      ],
                    )
                  : Container(),
              searchProvider.countCategoryMails(2) != 0
                  ? ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        for (var element in searchProvider.mail)
                          if (element.sender!.category!.id == 2)
                            mailsWidget(mails: element, context: context),
                      ],
                    )
                  : Container(),
              searchProvider.countCategoryMails(3) != 0
                  ? Row(
                      children: [
                        Text(
                          "NGOs",
                          style: TextStyle(
                              fontSize: 20.sp,
                              color: colorBlack.withOpacity(0.5)),
                        ),
                        const Spacer(),
                        Text('${searchProvider.countCategoryMails(3)} Found',
                            style: TextStyle(
                                fontSize: 20.sp,
                                color: colorBlack.withOpacity(0.5))),
                      ],
                    )
                  : Container(),
              searchProvider.countCategoryMails(3) != 0
                  ? ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        for (var element in searchProvider.mail)
                          if (element.sender!.category!.id == 3)
                            mailsWidget(mails: element, context: context),
                      ],
                    )
                  : Container(),
              searchProvider.countCategoryMails(1) != 0
                  ? Row(
                      children: [
                        Text(
                          "Others",
                          style: TextStyle(
                              fontSize: 20.sp,
                              color: colorBlack.withOpacity(0.5)),
                        ),
                        const Spacer(),
                        Text('${searchProvider.countCategoryMails(1)} Found',
                            style: TextStyle(
                                fontSize: 20.sp,
                                color: colorBlack.withOpacity(0.5))),
                      ],
                    )
                  : Container(),
              searchProvider.countCategoryMails(1) != 0
                  ? ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        for (var element in searchProvider.mail)
                          if (element.sender!.category!.id != 2)
                            mailsWidget(mails: element, context: context),
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
