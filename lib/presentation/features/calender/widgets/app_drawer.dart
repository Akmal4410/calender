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
      width: screenWidth * 0.90,
      child: SafeArea(
        child: Padding(
          padding: kAppDefaultHorizontalPadding,
          child: ListView(
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
              const Divider(),
              Obx(
                () => Column(
                  children: List.generate(
                    controller.calenders.value.length,
                    (index) {
                      final keys = controller.calenders.value.keys.toList();
                      final key = keys[index];
                      return ExpansionTile(
                        title: Text(key),
                        children: List.generate(
                          controller.calenders.value[key]!.length,
                          (index) {
                            final calendar =
                                controller.calenders.value[key]![index];
                            return CheckboxListTile(
                              title: Text(calendar.name ?? ""),
                              value: controller.selectedValues.value
                                  .contains(calendar.name),
                              onChanged: (value) =>
                                  controller.addOrRemoveFromCalendars(
                                      value, calendar.name ?? ""),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
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
