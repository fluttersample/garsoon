import 'package:flutter/material.dart';
import 'package:waiter/Core/Helper/AppTypography.dart';
import 'package:waiter/Core/Helper/ColorHelper.dart';


class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      this.color,
      this.colorText,
      this.backGroundColor,
      this.text,
      this.width,
      this.height,
      this.child,
      this.textStyle,
      this.isOutLineButton = false,
      required this.onTap});

  final Color? color;
  final Color? colorText;
  final Color? backGroundColor;
  final String? text;
  final double? width;
  final double? height;
  final Widget? child;
  final bool? isOutLineButton;
  final TextStyle? textStyle;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    // return ElevatedButton(
    //   onPressed: onTap,
    //   style: ElevatedButton.styleFrom(
    //       backgroundColor: ColorHelper.yellow,
    //       fixedSize: Size(width ?? 108, height ?? 48),
    //       foregroundColor: Colors.black,
    //       textStyle: AppTypography.s20.copyWith(
    //         fontFamily: FontsName.fontBold,
    //       ),
    //       shape:
    //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
    //   child: Center(child: Text(text ?? '',)
    //   ),
    // );
    if(isOutLineButton == true){
      return _outLineButton;
    }

    return _elevationButton;
  }


  Widget get _outLineButton {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: backGroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        visualDensity: const VisualDensity(vertical: 0,horizontal: -4),
          side: BorderSide(color: color ?? ColorHelper.black),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
      ),
        onPressed: onTap,
        child: Text(text ?? '',
            style:
           textStyle ?? AppTypography.s16.copyWith(fontFamily: FontsName.fontMed,
                color: colorText ?? Colors.black)));
  }


  Widget get _elevationButton{
    return  InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        width: width ?? 108,
        height: height ?? 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color ?? ColorHelper.yellow,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              child??SizedBox.shrink(),

              Text(text ?? '',
                  style:
                  textStyle ?? AppTypography.s20.copyWith(fontFamily: FontsName.fontBold,
                      color: colorText ?? Colors.black)),
            ],
          ),
        ),
      ),
    );
  }
}
