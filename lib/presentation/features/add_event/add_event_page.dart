import 'package:calender/presentation/features/add_event/add_event_controller.dart';
import 'package:calender/presentation/widgets/app_container.dart';
import 'package:calender/presentation/widgets/app_text_field.dart';
import 'package:calender/utils/contants/app_colors.dart';
import 'package:calender/utils/contants/sizes.dart';
import 'package:calender/utils/contants/text_constants.dart';
import 'package:calender/utils/contants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEventPage extends GetView<AddEventController> {
  const AddEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          addEvent,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: Padding(
                padding: kAppDefaultPadding,
                child: Form(
                  key: controller.formKey,
                  autovalidateMode: controller.autovalidateMode.value,
                  child: Column(
                    children: [
                      const AppTextField(
                        hint: "Event",
                        maxLines: 2,
                      ),
                      kHeight12,
                      const AppTextField(
                        hint: "Description",
                        maxLines: 5,
                      ),
                      kHeight12,
                      Column(
                        children: [
                          AppContainer(
                            onTap: () =>
                                controller.showStartTimePicker(context),
                            data: "Start Time : ${controller.showStartTime()}",
                          ),
                          kHeight12,
                          AppContainer(
                            onTap: () => controller.showEndTimePicker(context),
                            data: "End Time : ${controller.showEndTime()}",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            _bottomSection(),
            kHeight12,
          ],
        ),
      ),
    );
  }

  Row _bottomSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text(
            "Cancel",
            style: kTextStyle18Bold.copyWith(color: AppColors.kGreen),
          ),
        ),
        TextButton(
          onPressed: () => controller.addEvent(),
          child: Text(
            "Save",
            style: kTextStyle18Bold.copyWith(color: AppColors.kGreen),
          ),
        ),
      ],
    );
  }
}
