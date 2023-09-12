import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/widget.dart';

class CategoriesBottomSheet{

  final BuildContext context;

  CategoriesBottomSheet({required this.context});

  void showCategoriesBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.grey[100],
      isScrollControlled: true,
      useSafeArea: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15.r), topLeft: Radius.circular(15.r))),
      context: context,
      builder: (BuildContext context) {
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
                    style: TextStyle(
                        fontSize: 19.sp, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Done',
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              smallSpacer,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30.r))),
                  child: ListView.separated(
                      itemBuilder: (context, index)=> const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Text('fdsfsdf',style: TextStyle(
                              fontSize: 22,
                            ),),
                            Spacer(),
                            Icon(Icons.check,color: Colors.blue,),
                          ],
                        ),
                      ),
                      separatorBuilder: (context, index)=> Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey[300],
                      ),
                      itemCount: 4)
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}