
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/Core/Helper/ColorHelper.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key,this.width,this.height, this.color});
  final double? height;
  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: height ?? 2,
          decoration: BoxDecoration(
          color: color ?? context.theme.appColors.divider,
            borderRadius: BorderRadius.circular(10)
          ),
          width: width ?? Get.width,
        ),
      ],
    );
  }
}
