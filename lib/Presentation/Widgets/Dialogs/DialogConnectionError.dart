import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/Core/Helper/AppTypography.dart';
import 'package:waiter/Core/Helper/ColorHelper.dart';
import 'package:waiter/Infrastructure/Navigation/CustomRoot.dart';

class DialogConnectionError extends StatelessWidget {
  final VoidCallback onTap;
  final String? massage;
  final Function? onClose;

  const DialogConnectionError(
      {super.key, required this.onTap, this.massage, this.onClose});

  showConnectionErrorDialog() async {
    await showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (context) => DialogConnectionError(
              onTap: onTap,
              massage: massage,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.only(bottom: 0),
      buttonPadding: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      actions: [
        _alertDialogActions,
      ],
      content: _alertDialogContent,
    );
  }

  Widget get _alertDialogActions => Column(
        children: [
          Divider(
            color: Color(0xffF1F1F1),
            height: 1,
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 48,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _tryAgainButton,
                _closeButton,
              ],
            ),
          ),
        ],
      );

  Widget get _alertDialogContent => SizedBox(
        width: 320,
        height: 160,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //Constants.smallVerticalSize,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              child: Image.asset(
                massage == null
                    ? 'assets/images/img_connection_error.png'
                    : 'assets/images/img_error.png',
              ),
            ),

            Text(massage == null ? 'خطا در اتصال' : massage!,
                maxLines: 1,
                style: AppTypography.s17.copyWith(
                  fontFamily: FontsName.fontMed,
                )),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      );

  Widget get _tryAgainButton => Expanded(
        flex: 1,
        child: TextButton(
          onPressed: () => onTap.call(),
          child: Text('تلاش مجدد',
              style: AppTypography.s14.copyWith(
                fontFamily: FontsName.fontMed,
              )),
        ),
      );

  Widget get _closeButton => Expanded(
        flex: 1,
        child: TextButton(
            onPressed: () {
              CustomRoot.back(closeOverlays: true);
              onClose?.call();
            },
            child: Text('بستن',
                style: AppTypography.s14.copyWith(
                  fontFamily: FontsName.fontBold,
                ))),
      );
}
