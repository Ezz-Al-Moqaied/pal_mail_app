import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pal_mail_app/constants/widget.dart';
import 'package:pal_mail_app/providers/home_provider.dart';
import 'package:pal_mail_app/providers/search_provider.dart';
import 'package:pal_mail_app/widgets/navigate_widget.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatefulWidget {
  FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    final searchProvider = Provider.of<SearchProvider>(context);
    return TweenAnimationBuilder(
      builder: (BuildContext context, double? value, Widget? child) {
        return Container(
          height: value,
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
                          await searchProvider.setCategoryID(0);
                          await searchProvider.setStatusMailsID(0);
                          navigatePop(context: context);
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            fontSize: 18.sp,
                          ),
                        )),
                    Text(
                      "Filters",
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    TextButton(
                        onPressed: () {
                          navigatePop(context: context);
                        },
                        child: Text(
                          "Done",
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
                      itemCount: homeProvider.category.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            searchProvider.setCategoryID(
                                homeProvider.category[index].id!);
                          },
                          trailing: homeProvider.category[index].id ==
                                  searchProvider.categoryID
                              ? const Icon(Icons.check)
                              : const SizedBox(
                                  width: 1,
                                  height: 1,
                                ),
                          title: Text(homeProvider.category[index].name!),
                        );
                      },
                    )),
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
                            searchProvider.setStatusMailsID(
                                homeProvider.statusMails[index].id!);
                          },
                          leading: Container(
                            height: 32.h,
                            width: 32.w,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.r)),
                              color: Color(int.parse(
                                  homeProvider.statusMails[index].color!)),
                            ),
                          ),
                          trailing: homeProvider.statusMails[index].id ==
                                  searchProvider.statusMailsID
                              ? const Icon(Icons.check)
                              : const SizedBox(
                                  width: 1,
                                  height: 1,
                                ),
                          title: Text(homeProvider.statusMails[index].name!),
                        );
                      },
                    )),
                mediumSpacer,
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30.r)),
                      color: Colors.white),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.date_range_outlined,
                        color: Colors.redAccent,
                      ),
                      SizedBox(
                        width: 9.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Date",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 4.w,
                          ),
                          Row(
                            children: [
                              Text(
                                "Form: ",
                                style: TextStyle(fontSize: 14.sp),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                "July 5, 2022",
                                style: TextStyle(
                                    fontSize: 14.sp, color: Colors.blueAccent),
                              ),
                              SizedBox(
                                width: 25.w,
                              ),
                              Text(
                                "To: ",
                                style: TextStyle(fontSize: 14.sp),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                "July 5, 2022",
                                style: TextStyle(
                                    fontSize: 14.sp, color: Colors.blueAccent),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                mediumSpacer,
              ],
            ),
          ),
        );
      },
      duration: const Duration(milliseconds: 500),
      curve: Curves.linear,
      tween: Tween<double>(
          begin: MediaQuery.of(context).size.height - 500.h,
          end: MediaQuery.of(context).size.height - 50),
    );
  }
}
