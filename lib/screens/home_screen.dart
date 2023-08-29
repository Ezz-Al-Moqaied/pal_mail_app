import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pal_mail_app/widgets/text_field_widget.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:HexColor('#F7F4FF'),
      drawer: Drawer(
          child:ListView.builder(itemBuilder: (context, index)=> ListTile())
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.menu,size: 30,),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                        ),
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage('assets/images/pic.png'),
                        ),
                      ],
                    )
                  )
                ],
              ),
              SizedBox(height: 12,),
              textFormFieldWidget(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                  controller: searchController,
                  prefixIcon: Icons.search,
                  hintText: 'search',
                  type: TextInputType.text,
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                  validate: (p0) => 'error',)
            ],
          ),
        ),
      ),
    );
  }
}
