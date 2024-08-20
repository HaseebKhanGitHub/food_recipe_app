

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';

import 'package:food_recipe_app/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<SplashScreen> {

  @override
  void initState() {

    super.initState();
    Timer(Duration(seconds: 3), (){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home() ));
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image.asset('assets/images/food_logo.png'),
              ),

              Text('Food Recipe App',style: TextStyle(fontSize: 24,fontWeight: FontWeight.w800),),
              SizedBox(height: 12),
              Text('Developed By Haseeb Khan',style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w700),),
              SizedBox(height: 25),
          SpinKitPouringHourGlass(
            color: Colors.white,
            size: 50.0,
          ),

            ],

          ),
      ),


      backgroundColor:
      Colors.purple.shade300,
          // Colors.teal.shade400

      );

  }
}
