import 'package:calender/presentation/features/splash/splash_controller.dart';
import 'package:calender/utils/contants/assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadCalendars();
    });
    return Scaffold(
      body: Center(
        child: Image.asset(
          AppAssets.kAppIcon,
          height: 100,
          width: 100,
        ),
      ),
    );
  }
}
