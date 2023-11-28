import 'package:calender/utils/contants/app_colors.dart';
import 'package:calender/utils/contants/text_constants.dart';
import 'package:calender/utils/init_services.dart';
import 'package:calender/utils/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  return runApp(
    const MyCalendarApp(),
  );
}

class MyCalendarApp extends StatelessWidget {
  const MyCalendarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: AppColors.myTheme,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: AppColors.kBlack),
          color: AppColors.kWhite,
        ),
        scaffoldBackgroundColor: AppColors.kWhite,
      ),
      initialRoute: AppRoutes.kSplash,
      getPages: AppRoutes.getPages(),
      title: myAppName,
    );
  }
}
