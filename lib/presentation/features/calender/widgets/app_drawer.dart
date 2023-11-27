import 'package:calender/presentation/features/calender/calender_controller.dart';
import 'package:calender/utils/contants/sizes.dart';
import 'package:calender/utils/contants/text_constants.dart';
import 'package:calender/utils/contants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppDrawer extends GetView<CalenderController> {
  const AppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Drawer(
      width: screenWidth * 0.70,
      child: SafeArea(
        child: Padding(
          padding: kAppDefaultHorizontalPadding,
          child: Column(
            children: [
              kHeight20,
              const Row(
                children: [
                  Icon(Icons.menu),
                  kWidth16,
                  Text(
                    myAppName,
                    style: kTextStyle16Bold,
                  ),
                ],
              ),
              kHeight12,
              drawerListTile(
                icon: Icons.calendar_month_rounded,
                onTap: () => controller.changeView(CalendarView.month),
                title: "Month",
              ),
              drawerListTile(
                icon: Icons.date_range_rounded,
                onTap: () => controller.changeView(CalendarView.week),
                title: "Week",
              ),
              drawerListTile(
                icon: Icons.today_rounded,
                onTap: () => controller.changeView(CalendarView.day),
                title: "Day",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget drawerListTile({
    required IconData icon,
    required String title,
    required Function()? onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon),
      title: Text(
        title,
        style: kTextStyle16Medium,
      ),
      onTap: onTap,
    );
  }
}
