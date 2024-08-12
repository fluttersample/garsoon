



import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnimFadeWidget extends StatelessWidget {
  const AnimFadeWidget({super.key,
    required this.condition,
    required this.widget1,
    required this.widget2});

  final RxBool condition ;
  final Widget widget1;
  final Widget widget2;
  @override
  Widget build(BuildContext context) {
    return  Obx(
          () {
        return AnimatedSwitcher(duration: const Duration(milliseconds: 200),
            layoutBuilder:  (Widget? currentChild, List<Widget> previousChildren) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  currentChild!,
                ],
              );
            },
            transitionBuilder: (child , value){
              return FadeTransition(
                opacity: value,
                          // position:  child.key == const Key('first')? Tween<Offset>(
                          //     begin: const Offset(0.0,0.0),end: const Offset(0.0,0.0)
                          // ).animate(value) : Tween(
                          //   begin: const Offset(0.0,0.0),end: const Offset(0.0,0.0),
                          // ).animate(value),

                  child: child);
            },
            child: condition.value ? SizedBox(
              key: const Key('second'),
              child: widget2,
            ) : SizedBox(
              key: const Key('first'),
              child: widget1,
            ));
      },

    );
  }
}
