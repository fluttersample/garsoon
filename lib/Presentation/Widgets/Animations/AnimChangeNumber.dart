

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/Core/Helper/AppTypography.dart';


class AnimChangeNumber extends StatelessWidget {
  const AnimChangeNumber({super.key, required this.count});
  final RxInt count;
  @override
  Widget build(BuildContext context) {
    return  Obx(
      () =>  AnimatedSwitcher(
        duration: const Duration(milliseconds: 100),
        transitionBuilder: (Widget child,  animation) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: animation,
              child: child,
            ),
          );
        },
        child: Text(
          count.value.toString(),
          key: ValueKey<int>(count.value),
          style:  AppTypography.s17.copyWith(
              fontFamily: FontsName.fontReg
          ),
        ),
      ),
    );
  }
}
