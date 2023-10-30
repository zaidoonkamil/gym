import 'package:flutter/material.dart';
import 'package:untitled1/features/tapbar/tapbar.dart';

import '../../core/widgets/navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      navigateAndFinish(context, const TapBar());
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/images/Untitled_logo_4_free-file (4).jpg',
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height*0.4,
            ),
          ),
        ],
      ),
    );
  }
}
