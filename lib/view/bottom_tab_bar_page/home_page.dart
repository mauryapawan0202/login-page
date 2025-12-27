import 'package:flutter/material.dart';

import '../../app_icon_changer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Column(
        spacing: 25,
        children: [
          Row(children: [],),
          InkWell(
            onTap: () async {
              await AppIconChanger.change("IconOne");
            },
            child: Container(
              color: Colors.red,
              height: 100,
              width: 100,
              child: Image.asset("assets/images/ic_icon_one.png"),
            ),
          ),
          // SizedBox(height: 5,),
          InkWell(
            onTap: () async {
              await AppIconChanger.change("IconTwo");
            },
            child: Container(
              color: Colors.red,
              height: 100,
              width: 100,
              child: Image.asset("assets/images/ic_icon_two.png"),
            ),
          ),
          // SizedBox(height: 5,),
          InkWell(
            onTap: () async {
              await AppIconChanger.change("IconThree");
            },
            child: Container(
              color: Colors.red,
              height: 100,
              width: 100,
              child: Image.asset("assets/images/ic_icon_three.png"),
            ),
          ),
          // SizedBox(height: 5,),
          InkWell(
            onTap: () async {
              await AppIconChanger.change("IconFour");
            },
            child: Container(
              color: Colors.red,
              height: 100,
              width: 100,
              child: Image.asset("assets/images/ic_icon_four.png"),
            ),
          ),
        ],
      ),
    );
  }
}
