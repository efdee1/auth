import 'package:flutter/material.dart';
import 'package:system_login/models/animation.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
// import 'package:lit_firebase_auth/system_login/models/animation';
import 'package:system_login/models/colors.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key key}) : super(key: key);
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this,duration: Duration(seconds:7 ));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: CustomPaint(
            painter: BackgroundPainter(animation:_controller.view,),
            ),
          ),
          Center(
            child: RaisedButton(onPressed: (){
              _controller.forward(from: 0);
            },
              child: Text ('Change'),
            ),
          )
        ],
      ),
    );
  }
}
