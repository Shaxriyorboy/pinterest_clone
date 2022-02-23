import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pinterest_app/animation/fade_animation.dart';
import 'package:pinterest_app/pages/global_page.dart';
class SpleshPage extends StatefulWidget {
  const SpleshPage({Key? key}) : super(key: key);

  @override
  _SpleshPageState createState() => _SpleshPageState();
}

class _SpleshPageState extends State<SpleshPage> {

  void _openGlobalPage(){
    Timer(Duration(seconds: 5), (){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
        return GlobalPage();
      }));
    });
  }

  @override
  void initState() {
    _openGlobalPage();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FadeAnimation(2,Center(
        child: Image(image: AssetImage("assets/images/img_1.png"),height: 70,width: MediaQuery.of(context).size.width*0.7,),
      ),),
    );
  }
}
