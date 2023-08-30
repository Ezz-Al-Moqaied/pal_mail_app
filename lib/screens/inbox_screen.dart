import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pal_mail_app/constants/colors.dart';
import 'package:pal_mail_app/constants/widget.dart';
import 'package:pal_mail_app/widgets/bottom_sheet_widget.dart';
import 'package:pal_mail_app/widgets/text_field_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Widget basicContainer(double height,Widget widget){
    return Container(
      padding: EdgeInsets.all(5),
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30))
      ),
      child: widget
    );
  }
  Widget lineContainer(){
    return Container(
      height: 1,
      width: 400,
      color: Colors.grey[200],
    );
  }

  TextEditingController senderController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController DecisionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#F7F4FF'),
      body: SafeArea(
        child: ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                backgroundColor: Colors.grey[100],
                isScrollControlled: true,
                useSafeArea: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15)
                  )
                ),
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    child:  SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                 onPressed: (){
                                   Navigator.pop(context);
                                 },
                                 child: Text('Cancle',
                                   style: TextStyle(
                                   fontSize: 18,

                                 ),),
                             ),
                              Text('New inbox',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold
                                ),),
                              TextButton(
                                onPressed: (){},
                                child: Text('Done',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),),
                              ),
                            ],
                          ),
                          smallSpacer,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Column(
                              children: [
                                //part number one
                                basicContainer(
                                 180,Column(
                                      children: [
                                        textFormFieldWidget(
                                            hintText: 'name',
                                            prefixIcon: Icons.account_circle,
                                            suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.circle_outlined,color: Colors.blue,)),
                                            controller: senderController,
                                            type: TextInputType.text,
                                            validate:(p0) => '',
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.circular(30)),
                                        lineContainer(),
                                        textFormFieldWidget(
                                            hintText: 'Mobile',
                                            prefixIcon: Icons.phone_android_outlined,
                                            controller: mobileController,
                                            type: TextInputType.text,
                                            validate:(p0) => '',
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.circular(30)),
                                        lineContainer(),
                                        InkWell(
                                          onTap: (){},
                                          child: Padding(
                                            padding: const EdgeInsets.only(right: 11.0,left: 11.0,top: 10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text('Categories',style: TextStyle(
                                                  fontSize: 16,

                                                ),),
                                                Spacer(),
                                                Text('Other',style: TextStyle(
                                                  fontSize: 16,
                                                  color: textFieldHintColor,
                                                ),),
                                                Icon(Icons.arrow_forward_ios,color: Colors.grey,size: 15,)
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
                                smallSpacer,
                                //part number two
                                basicContainer( 138, Column(
                                    children: [
                                      textFormFieldWidget(
                                        hintText: 'Title of Mail',
                                          numfontSize: 20,
                                          controller: titleController,
                                          type: TextInputType.text,
                                          validate: (p0) => '',
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.circular(30)),
                                      lineContainer(),
                                      textFormFieldWidget(
                                          hintText: 'Describtion',
                                          controller: titleController,
                                          type: TextInputType.text,
                                          validate: (p0) => '',
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.circular(30))
                                    ],
                                  ),),
                                smallSpacer,
                                //part number three
                                basicContainer(140, Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Icon(Icons.date_range,color: Colors.red,size: 25,),
                                          SizedBox(width: 11,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Date',style: TextStyle(
                                                fontSize: 15,
                                              ),),
                                              SizedBox(height: 4,),
                                              Text('2 mar 10/2/2023',style: TextStyle(
                                                fontSize: 12,
                                              ),),
                                            ],
                                          ),
                                          Spacer(),
                                          Icon(Icons.arrow_forward_ios,color: Colors.grey,size: 20,)
                                        ],
                                      ),
                                    ),
                                    lineContainer(),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Icon(Icons.archive_outlined,color: textFieldHintColor,size: 25,),
                                          SizedBox(width: 11,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Archive Number',style: TextStyle(
                                                fontSize: 15,
                                              ),),
                                              SizedBox(height: 8,),
                                              Text('like: 10/2/2023',style: TextStyle(
                                                fontSize: 12,
                                              ),),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                                smallSpacer,
                                //part number four
                                basicContainer(55, Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      Text('#',style: TextStyle(
                                        fontSize: 18,
                                        color: border,
                                      ),),
                                      SizedBox(width: 14,),
                                      Text('Tags',style: TextStyle(
                                        fontSize: 17,
                                      ),),
                                      Spacer(),
                                      Icon(Icons.arrow_forward_ios,color: Colors.grey,size: 20,)
                                    ],
                                  ),
                                )),
                                smallSpacer,
                                basicContainer(60, Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.arrow_forward),
                                      SizedBox(width: 14,),
                                      Container(
                                        width: 70,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(15)
                                        ),
                                        child: Center(
                                          child: Text('inbox',style: TextStyle(
                                            color: Colors.white
                                          ),),
                                        ),
                                      ),
                                      Spacer(),
                                      Icon(Icons.arrow_forward_ios,color: Colors.grey,size: 20,)
                                    ],
                                  ),
                                )),
                                smallSpacer,
                                basicContainer( 138, Column(
                                  children: [
                                    lineContainer(),
                                    textFormFieldWidget(
                                        hintText: 'Describtion',
                                        controller: DecisionController,
                                        type: TextInputType.text,
                                        validate: (p0) => '',
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(30))
                                  ],
                                ),),
                                smallSpacer,
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: Text('pressed')),
      ),
    );
  }
}