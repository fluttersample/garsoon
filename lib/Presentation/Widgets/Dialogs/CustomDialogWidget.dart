


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/Core/Helper/AppTypography.dart';
import 'package:waiter/Core/Helper/ColorHelper.dart';


class CustomDialogWidget extends StatelessWidget {
  const CustomDialogWidget({super.key, this.width, this.height, this.child, this.title, this.btnOkOnTap,
    this.btnCancelOnTap,
    this.textOk,
    this.textCancel,
  this.messageDialog});
  final double? width;
  final double? height;
  final Widget? child;
  final String? title;
  final String? messageDialog;
  final String? textOk;
  final String? textCancel;
  final Function? btnOkOnTap;
  final Function? btnCancelOnTap;


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title != null ? Text(title!,textAlign: TextAlign.center,) : null,
      titlePadding: const EdgeInsets.only(top: 20,right: 20,left: 10),
      // actionsPadding: EdgeInsets.zero,
      titleTextStyle: AppTypography.s18.copyWith(
        color: context.theme.appColors.text,
        fontFamily: FontsName.fontBold
      ),
      content:  SizedBox(
        height: height ?? 315 ,
        width: width ?? 260,
        child: child ??
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32, vertical: 20),
                  child: Image.asset(
                    'assets/images/img_error.png',
                    height: 100.0,
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Text(
                    messageDialog??'',
                    style: AppTypography.s17.copyWith(
                      fontFamily: FontsName.fontMed,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
      ),
      actions: [
        btnOkOnTap != null? _alertDialogActions : const SizedBox.shrink()
      ],

    );
  }

  Widget get _alertDialogActions => Column(
    children: [
      // const CustomDivider(
      //   color: Colors.blue,
      //   height: 1,
      // ),
      SizedBox(
        height: 48.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _actionButton,
            // const VerticalDivider(
            //   color: Colors.blue,
            // ),
            _closeButton,
          ],
        ),
      ),
    ],
  );


  Widget get _actionButton => Expanded(
    flex: 1,
    child: TextButton(
      onPressed: () {
        if (btnOkOnTap != null) {
          btnOkOnTap!();
        }
      },
      child: Text(
          textOk ??'بله',
        style: AppTypography.s14.copyWith(
          fontFamily: FontsName.fontBold
        )
      ),
    ),
  );

  Widget get _closeButton => Expanded(
    flex: 1,
    child: TextButton(
      onPressed: () {
        Get.back(closeOverlays: true);
        if (btnCancelOnTap != null) {
          btnCancelOnTap!();
        }
      },
      child: Text(
       textCancel ?? 'خیر',
        style: AppTypography.s14.copyWith(
            fontFamily: FontsName.fontBold,

        )
      ),
    ),
  );
}
