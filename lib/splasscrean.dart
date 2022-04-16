import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class Splasscreen extends StatefulWidget {
  const Splasscreen({Key? key}) : super(key: key);

  @override
  _SplasscreenState createState() => _SplasscreenState();
}

class _SplasscreenState extends State<Splasscreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3),
      ()=>Navigator.pushReplacement(context,
                      MaterialPageRoute(builder:
                              (context) =>
                              const MyApp()
                              )
                    )
      );
  }
  @override
  Widget build(BuildContext context) {
    // return Container(
    // color: Colors.black,
    // child:Image.asset("assets/imagenes/logo.png")
    // );
    return Container(
      width: double.infinity,
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ZoomIn(
            child: Container(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Image.asset('assets/imagenes/logo.png')),
            duration: const Duration(seconds: 1),
          ),
          ZoomIn(
            child:Container(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Image.asset('assets/imagenes/logoletra.png')
              ),
            duration: const Duration(seconds: 1),
          ),
          
        ],
      ),
    );
  }
}