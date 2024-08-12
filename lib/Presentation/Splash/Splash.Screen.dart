import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/Core/Helper/AppTypography.dart';
import 'package:waiter/Presentation/Widgets/LoadingWidget.dart';


import 'Controller/Splash.Controller.dart';
import 'Widgets/LogoWidget.dart';
class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (_) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(),
              // Padding(
              //   padding: const EdgeInsets.all(70),
              //   child: Center(
              //     child: Image.asset(
              //       'assets/images/3soot_logo.png',
              //     ),
              //   ),
              // ),
              LogoWidget(),
              _buildStatusInternet(),
            ],
          ),
        );
      },
    );
  }


  _buildStatusInternet(){
   return  Obx(
      () {
        if(controller.internetStatus.value == InternetStatus.Disconnect){
          return InkWell(
            onTap: () async {
              controller.internetStatus.value = InternetStatus.Loading;
              await controller.checkInternet();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.sync,
                  color: Color(0xff999999),
                  size: 24,
                ),
                 const SizedBox(height: 15,),
                 Text(
                  'ارتباط برقرار نشد',
                  style: AppTypography.s14.copyWith(
                    color: const Color(0xff999999)

                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          );
        }

        return const LoadingWidget();
      },
    );

  }

}
