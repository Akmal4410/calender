import 'package:calender/domain/use_cases/get_my_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddEventController extends GetxController {
  final GetMyCalendar _getMyCalendar;

  AddEventController(this._getMyCalendar);

  final eventNameController = TextEditingController();
  final eventDescriptionController = TextEditingController();
  final eventDurationController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  Rx<AutovalidateMode> autovalidateMode = Rx(AutovalidateMode.always);

  Rx<DateTime?> startTime = Rx(null);
  Rx<DateTime?> endTime = Rx(null);

  void showStartTimePicker(BuildContext context) {
    DatePicker.showTime12hPicker(
      context,
      onChanged: (date) {
        startTime(date);
        if (endTime.value != null) {
          if (endTime.value!.isBefore(startTime.value!)) {
            endTime(startTime.value!.add(const Duration(minutes: 5)));
          }
        }
      },
      onConfirm: (date) {
        startTime(date);
        if (endTime.value != null &&
            endTime.value!.isBefore(startTime.value!)) {
          endTime(startTime.value!.add(const Duration(minutes: 5)));
        }
      },
      currentTime: DateTime.now(),
      locale: LocaleType.en,
    );
  }

  void showEndTimePicker(BuildContext context) {
    DatePicker.showTime12hPicker(
      context,
      onChanged: (date) {
        endTime(date);
        if (startTime.value != null &&
            startTime.value!.isAfter(endTime.value!)) {
          startTime(endTime.value!.subtract(const Duration(minutes: 5)));
        }
      },
      onConfirm: (date) {
        endTime(date);
        if (startTime.value != null &&
            startTime.value!.isAfter(endTime.value!)) {
          startTime(endTime.value!.subtract(const Duration(minutes: 5)));
        }
      },
      currentTime: startTime.value ?? DateTime.now(),
      locale: LocaleType.en,
    );
  }

  String showStartTime() {
    if (startTime.value == null) {
      return DateFormat('hh:mm a').format(DateTime.now());
    }
    return DateFormat('hh:mm a').format(startTime.value!);
  }

  String showEndTime() {
    if (endTime.value == null) {
      return DateFormat('hh:mm a')
          .format(DateTime.now().add(const Duration(hours: 1)));
    }
    return DateFormat('hh:mm a').format(endTime.value!);
  }

  Future<void> addEvent() async {
    autovalidateMode = Rx(AutovalidateMode.onUserInteraction);
    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }

    // _getMyCalendar.addToCalendar(calenderEvent, selectedCalendarId);
  }
}
