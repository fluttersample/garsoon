
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/Infrastructure/Navigation/CustomRoot.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: SizedBox(
          height: 30,
          width: 30,
          child: InkResponse(radius: 15,
            onTap: () {
              CustomRoot.back();
            },
            child: const Icon(
              Icons.arrow_forward_rounded,
              size: 28,
              textDirection: TextDirection.ltr,
            ),
          ),
        ),
      ),
    );;
  }
}