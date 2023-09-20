import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pal_mail_app/providers/tags_provider.dart';
import 'package:pal_mail_app/widgets/flutterToastWidget.dart';
import 'package:pal_mail_app/widgets/navigate_widget.dart';
import 'package:pal_mail_app/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../constants/widget.dart';

class TagsBottomSheet {
  TextEditingController tagsController = TextEditingController();

  void showTagsSheet(context) async {
    final tagsProvider2 = Provider.of<TagsProvider>(context, listen: false);
    await tagsProvider2.getTagsProv();
    await tagsProvider2.isSelected();

    showModalBottomSheet(
      backgroundColor: Colors.grey[100],
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15), topLeft: Radius.circular(15))),
      context: context,
      builder: (BuildContext context) {
        return Consumer<TagsProvider>(
          builder: (context, tagsProvider, child) {
            return SizedBox(
              height: MediaQuery.of(context).size.height - 50,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          tagsProvider.clearData();
                          tagsProvider.tagsId.clear();
                          tagsProvider.selected.clear();
                          tagsController.clear();
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Cancle',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const Text(
                        'Tags',
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {
                          tagsProvider.clearData();
                          navigatePop(context: context);
                        },
                        child: const Text(
                          'Done',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  smallSpacer,
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        children: [
                          Container(
                              padding: const EdgeInsets.all(5),
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              child: tagsProvider.tagsName.isEmpty
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : GridView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: tagsProvider.tagsName.isEmpty
                                          ? 0
                                          : tagsProvider.tagsName.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              childAspectRatio: 3,
                                              crossAxisCount: 3,
                                              mainAxisSpacing: 4.h,
                                              crossAxisSpacing: 4.w),
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () async {
                                            tagsProvider.isSelectedState(index);
                                            print(tagsProvider.tagsId);
                                          },
                                          child: Container(
                                              padding: const EdgeInsets.all(4),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.r),
                                                  color: tagsProvider
                                                          .selected[index]
                                                      ? tagButtonColorSelected
                                                      : tagButtonColornotSelected),
                                              child: Text(
                                                "#${tagsProvider.tagsName.elementAt(index)}",
                                                style: TextStyle(
                                                  color: tagsProvider
                                                          .selected[index]
                                                      ? Colors.white
                                                      : tagTextColor,
                                                  fontSize: 16.sp,
                                                ),
                                              )),
                                        );
                                      },
                                    )),
                          const SizedBox(
                            height: 22,
                          ),
                          textFormFieldWidget(
                            suffixIcon: IconButton(
                                splashColor: Colors.transparent,
                                onPressed: () async {
                                  if (tagsController.text.isNotEmpty) {
                                    await tagsProvider.createTags(
                                        name: tagsController.text);
                                    await tagsProvider.isSelected();
                                    tagsController.clear();
                                  } else {
                                    flutterToastWidget(
                                        msg: 'You Must Enter Tag Name',
                                        colors: Colors.red);
                                  }
                                },
                                icon: const Icon(Icons.send)),
                            radius: 50.r,
                            colors: colorWhite,
                            hintText: 'add New tags..',
                            maxLines: 1,
                            label: const Text("Tags"),
                            outlinedBorder: true,
                            controller: tagsController,
                            type: TextInputType.text,
                            validate: (p0) => '',
                          )
                        ],
                      )),
                ],
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      tagsController.clear();
      tagsProvider2.clearData();
    });
  }
}
