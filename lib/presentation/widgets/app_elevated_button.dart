import 'package:calender/utils/contants/app_colors.dart';
import 'package:calender/utils/contants/sizes.dart';
import 'package:calender/utils/contants/text_style.dart';
import 'package:calender/utils/utils.dart';
import 'package:flutter/material.dart';

class AppElevetedButton extends StatelessWidget {
  const AppElevetedButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.isBusy,
  });

  final void Function() onPressed;
  final String label;
  final bool? isBusy;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isBusy ?? false,
      child: GestureDetector(
        onTap: () => dismissKeyboard(context),
        behavior: HitTestBehavior.translucent,
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ).copyWith(
              overlayColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.transparent;
                  }
                  return null;
                },
              ),
            ),
            child: Padding(
              padding: kAppPaddingVertical15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: kTextStyle16Medium.copyWith(color: AppColors.kWhite),
                  ),
                  Visibility(
                    visible: isBusy ?? false,
                    child: const Row(
                      children: [
                        kWidth20,
                        SizedBox(
                          width: 12,
                          height: 12,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
