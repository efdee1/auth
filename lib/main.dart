import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:system_login/service/auth_service.dart';
import 'package:system_login/service/loginview.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mufasa Auth',
      home: AuthScreen(),
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      backgroundColor: Colors.amber,
      image: Image.asset('assets/launch_image.png'),
      loaderColor: Colors.white,
      photoSize: 100,
      navigateAfterSeconds: LoginScreen(),
    );
  }
}



