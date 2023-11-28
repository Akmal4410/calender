import 'package:calender/utils/contants/app_colors.dart';
import 'package:calender/utils/contants/text_style.dart';
import 'package:flutter/material.dart';

class AppContainer extends StatelessWidget {
  const AppContainer({
    super.key,
    required this.data,
    this.onTap,
  });

  final String data;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.kWhite,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.kBlack45),
        ),
        child: Center(
          child: Text(
            data,
            style: kTextStyle14Medium,
          ),
        ),
      ),
    );
  }
}
