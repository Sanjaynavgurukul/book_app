import 'package:book_app/helper/navigate_helper.dart';
import 'package:book_app/screens/landing/landing.dart';
import 'package:book_app/theme/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      navigateToLandingScreen();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
       child: Lottie.asset('assets/animation_json/logo.json',repeat: false),
      ),
    );
  }

  void navigateToLandingScreen(){
    Future.delayed(const Duration(seconds: 3),((){
      NavigationHelper().normalNavigatePushReplacement(context: context, screen: const Landing());
    }));
  }
}
