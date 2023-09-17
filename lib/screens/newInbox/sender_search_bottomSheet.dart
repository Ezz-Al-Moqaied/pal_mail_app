import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pal_mail_app/constants/widget.dart';
import 'package:pal_mail_app/providers/new_inbox_provider.dart';
import 'package:pal_mail_app/widgets/navigate_widget.dart';
import 'package:pal_mail_app/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';

class SenderSearchWidget extends ChangeNotifier {
  SenderSearchWidget();
  void showSearchBar(BuildContext context) async {
    Provider.of<NewInboxProvider>(context, listen: false).getData();
    TextEditingController searchController = TextEditingController();
    showModalBottomSheet(
      enableDrag: false,
      backgroundColor: const Color(0xffF7F6FF),
      isScrollControlled: true,
      useSafeArea: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15.r), topLeft: Radius.circular(15.r))),
      context: context,
      builder: (BuildContext context) {
        return Consumer<NewInboxProvider>(
          builder: (context, newInboxProv, _) {
            return Container(
              height: MediaQuery.of(context).size.height - 50,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {
                            newInboxProv.removeData();

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
                          'Sender',
                          style: TextStyle(
                              fontSize: 19.sp, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () async {},
                          child: Text(
                            'Done',
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  smallSpacer,
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: textFormFieldWidget(
                          radius: 60,
                          onSaved: (p0) {},
                          hintText: "Enter sender name",
                          prefixIcon: Icons.search,
                          suffixIcon: IconButton(
                              splashColor: Colors.transparent,
                              onPressed: () {
                                searchController.text = '';
                              },
                              icon: const Icon(Icons.cancel)),
                          colors: const Color(0xffE6E6E6),
                          outlinedBorder: true,
                          controller: searchController,
                          onChange: (value) {
                            newInboxProv.searchController =
                                searchController.text;
                            newInboxProv.notifyListeners();
                            newInboxProv.Filters();
                            print(searchController.text);
                          },
                          onSubmit: () {},
                          type: TextInputType.text),
                    ),
                  ),
                  smallSpacer,
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: const Divider(
                          thickness: 1, color: Color(0xffC0BFC2))),
                  smallSpacer,
                  searchController.text == ''
                      ? const SizedBox()
                      : InkWell(
                          onTap: () {
                            newInboxProv.senderName =
                                newInboxProv.searchController;
                            newInboxProv.idSender = 0;
                            newInboxProv.senderMobile = '';
                            newInboxProv.senderCategID = '';
                            newInboxProv.senderCategName = '';
                            newInboxProv.notifyListeners();
                            navigatePop(context: context);
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              alignment: Alignment.topLeft,
                              child: Text("\"${searchController.text}\"")),
                        ),
                  smallSpacer,
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: const Divider(
                          thickness: 1, color: Color(0xffC0BFC2))),
                  smallSpacer,
                  Expanded(
                    flex: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 24.h),
                      alignment: Alignment.topLeft,
                      child: newInboxProv.categories.isEmpty
                          ? const Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              // ignore: unrelated_type_equality_checks
                              itemCount: searchController.text.isEmpty
                                  ? newInboxProv.categories.length
                                  : newInboxProv.filters.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: searchController.text == ''
                                          ? Text(
                                              newInboxProv
                                                  .categories[index].name!,
                                              style: const TextStyle(
                                                  color: Color(0xffC0BFC2)),
                                            )
                                          : Text(
                                              newInboxProv.filters[index].name!,
                                              style: const TextStyle(
                                                  color: Color(0xffC0BFC2)),
                                            ),
                                    ),
                                    const Divider(
                                      thickness: 1,
                                      color: Color(0xffC0BFC2),
                                    ),
                                    ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: searchController.text == ''
                                          ? newInboxProv
                                              .categories[index].senders!.length
                                          : newInboxProv.filters[index].senders!
                                              .where((element) => element.name!
                                                  .contains(
                                                      searchController.text))
                                              .toList()
                                              .length,
                                      itemBuilder: (context, index2) {
                                        return InkWell(
                                          onTap: () {
                                            newInboxProv
                                                .senderName = (searchController
                                                        .text ==
                                                    ''
                                                ? newInboxProv.categories[index]
                                                    .senders![index2].name
                                                : newInboxProv
                                                    .filters[index].senders!
                                                    .where((element) =>
                                                        element.name!.contains(
                                                            searchController
                                                                .text))
                                                    .toList()[index2]
                                                    .name)!;
                                            newInboxProv
                                                .senderMobile = (searchController
                                                        .text ==
                                                    ''
                                                ? newInboxProv.categories[index]
                                                    .senders![index2].mobile
                                                : newInboxProv
                                                    .filters[index].senders!
                                                    .where((element) =>
                                                        element.name!.contains(
                                                            searchController
                                                                .text))
                                                    .toList()[index2]
                                                    .mobile)!;
                                            newInboxProv
                                                .idSender = (searchController
                                                        .text ==
                                                    ''
                                                ? newInboxProv.categories[index]
                                                    .senders![index2].id
                                                : newInboxProv
                                                    .filters[index].senders!
                                                    .where((element) =>
                                                        element.name!.contains(
                                                            searchController
                                                                .text))
                                                    .toList()[index2]
                                                    .id)!;

                                            newInboxProv
                                                .senderCategID = searchController
                                                        .text ==
                                                    ''
                                                ? newInboxProv.categories[index]
                                                    .senders![index2].categoryId
                                                    .toString()
                                                : newInboxProv
                                                    .filters[index].senders!
                                                    .where((element) =>
                                                        element.name!.contains(
                                                            searchController
                                                                .text))
                                                    .toList()[index2]
                                                    .categoryId
                                                    .toString();
                                            newInboxProv.senderCategName =
                                                searchController.text == ''
                                                    ? newInboxProv
                                                        .categories[index].name!
                                                    : newInboxProv
                                                        .filters[index].name!;
                                            print(newInboxProv.senderName);
                                            print(newInboxProv.senderMobile);
                                            print(newInboxProv.idSender);
                                            print(newInboxProv.senderCategName);
                                            print(newInboxProv.senderCategID);
                                            navigatePop(context: context);
                                          },
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.account_circle,
                                                    color: Color(0xff7C7C7C),
                                                  ),
                                                  const SizedBox(
                                                    width: 12,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      searchController.text ==
                                                              ''
                                                          ? Text(newInboxProv
                                                              .categories[index]
                                                              .senders![index2]
                                                              .name!)
                                                          : Text(newInboxProv
                                                              .filters[index]
                                                              .senders!
                                                              .where((element) =>
                                                                  element.name!
                                                                      .contains(
                                                                          searchController
                                                                              .text))
                                                              .toList()[index2]
                                                              .name!),
                                                      const SizedBox(
                                                        width: 4,
                                                      ),
                                                      searchController.text ==
                                                              ''
                                                          ? Text(newInboxProv
                                                              .categories[index]
                                                              .senders![index2]
                                                              .mobile!)
                                                          : Text(newInboxProv
                                                              .filters[index]
                                                              .senders!
                                                              .where((element) =>
                                                                  element.name!
                                                                      .contains(
                                                                          searchController
                                                                              .text))
                                                              .toList()[index2]
                                                              .mobile!),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const Divider(
                                                thickness: 1,
                                                color: Color(0xffC0BFC2),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    mediumSpacer
                                  ],
                                );
                              }),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      Provider.of<NewInboxProvider>(context, listen: false).removeData();
    });
  }
}
