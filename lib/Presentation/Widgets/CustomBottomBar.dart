

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/Core/Helper/ColorHelper.dart';


class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({super.key, required this.child, this.height});
  final Widget child;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: height ?? 70,
      width: Get.width,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration:  BoxDecoration(
          color:  context.theme.appColors.cart,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 5.0,
            ),
          ]
      ),
      child: child,
    );
  }



}
