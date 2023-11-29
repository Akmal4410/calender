import 'package:calender/presentation/features/calender/calender_binding.dart';
import 'package:calender/presentation/features/calender/calender_page.dart';
import 'package:calender/presentation/features/splash/splash_binding.dart';
import 'package:calender/presentation/features/splash/splash_page.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String kSplash = '/splash_page';
  static const String kCalender = '/calender_page';

  static List<GetPage> getPages() => [
        GetPage(
          name: kSplash,
          page: SplashPage.new,
          binding: SplashBinding(),
        ),
        GetPage(
          name: kCalender,
          page: CalenderPage.new,
          binding: CalenderBinding(),
        ),
      ];
}
