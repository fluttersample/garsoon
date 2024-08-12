


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/Core/Helper/AppTypography.dart';
import 'package:waiter/Core/Helper/BaseBrain.dart';
import 'package:waiter/Infrastructure/Navigation/CustomRoot.dart';
import 'package:waiter/Infrastructure/Navigation/Routes.dart';
import 'package:waiter/Presentation/Login/Controller/Login.Controller.dart';
import 'package:waiter/Presentation/Widgets/DeveloperButton.dart';
import 'package:waiter/Presentation/Widgets/ToastNotification/ShowMessage.dart';

class LoginScreen extends GetView<LoginController>{
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: const DeveloperButton(),
      body: GetBuilder(
        init: controller,
        builder:(_) =>  IgnorePointer(
          ignoring: controller.isLoading,
          child: SingleChildScrollView(
            child: Container(
              height: Get.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bg_login.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Form(
                key: controller.formKey,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 80),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        height: 190,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              margin:
                              const EdgeInsets.symmetric(horizontal: 20),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: TextField(
                                  key: const Key("userNameTextField"),
                                  controller:
                                  controller.userNameController,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  textAlignVertical: TextAlignVertical.center,
                                  maxLength: 11,
                                  style: AppTypography.s16
                                      .copyWith(
                                      color: const Color(0xff747474)),
                                  decoration: InputDecoration(
                                    hintText: 'نام کاربری',
                                    hintStyle: AppTypography.s16
                                        .copyWith(
                                        color: const Color(0xff747474)),
                                    border: InputBorder.none,
                                    fillColor: const Color(0xffF9F9F9),
                                    counterText: '',
                                    filled: true,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 1,
                              width: double.infinity,
                              color: const Color(0xff707070),
                            ),
                            Container(
                              margin:
                              const EdgeInsets.symmetric(horizontal: 20),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: TextField(
                                  key: const Key("passwordTextField"),
                                  controller: controller.passwordController,
                                  textAlign: TextAlign.center,
                                  textAlignVertical: TextAlignVertical.center,
                                  style: AppTypography.s16
                                      .copyWith(
                                      color: const Color(0xff747474)),
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: 'رمز عبور',
                                    hintStyle:  AppTypography.s16
                                        .copyWith(
                                        color: const Color(0xff747474)),
                                    border: InputBorder.none,
                                    fillColor: const Color(0xffF9F9F9),
                                    filled: true,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: (){
                          controller.apiLogin();
                        },
                        child: Container(
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                              color: const Color(0xff398FFF),
                              borderRadius: BorderRadius.circular(15)),
                          child: !controller.isLoading?  Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/ic_exit_app.png',
                                width: 25,
                                height: 25,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'ورود',
                                style: AppTypography.s20
                                    .copyWith(color: Colors.white,
                                    fontFamily: FontsName.fontBold),
                              ),

                            ],
                          ) :  Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(
                                  backgroundColor:Color(0xff398FFF),
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 10,),
                              Text("در حال ورود ...",
                                style: AppTypography.s15
                                    .copyWith(color: Colors.white),)

                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 70,),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: (){
                                controller.openForgetPasswordDialog();
                              },
                              child: Container(
                                  margin: const EdgeInsets.only(left: 50),
                                  decoration: BoxDecoration(
                                      color: const Color(0xffC4C4C4),
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 2,horizontal: 8),
                                    child: Text("رمز عبور خود را فراموش کرده ام",
                                        style: AppTypography.s16),
                                  )),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),

    );
  }



}