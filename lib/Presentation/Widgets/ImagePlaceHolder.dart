import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/Core/Helper/ColorHelper.dart';

class ImagePlaceHolder extends StatelessWidget {
  const ImagePlaceHolder({super.key, this.height,  required this.isError,this.borderRadius});

  final double? height;
  final bool isError;
  final double? borderRadius ;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          decoration: BoxDecoration(
            color: context.theme.appColors.cart,
              borderRadius: BorderRadius.circular(borderRadius ?? 15),
              border: isError ?  Border.all(
                width: 0.8,
                color: Colors.white
              ): null,

            image:  const DecorationImage(
              image: AssetImage('assets/images/logo_placeholder.png'),

    )

          ),));
  }
}
