


import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/Core/Helper/AppTypography.dart';
import 'package:waiter/Core/Helper/BaseBrain.dart';
import 'package:waiter/Core/Helper/ColorHelper.dart';
import 'package:waiter/Infrastructure/Navigation/Routes.dart';
import 'package:waiter/Presentation/Login/Controller/Login.Controller.dart';
import 'package:waiter/Presentation/Widgets/AppBars/CustomAppBar.dart';
import 'package:waiter/Presentation/Widgets/DeveloperButton.dart';
import 'package:waiter/Presentation/Widgets/ToastNotification/ShowMessage.dart';

import 'Controller/LoginCustomer.Controller.dart';

class LoginCustomerScreen extends GetView<LoginCustomerController>{
  const LoginCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (_) {
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: DeveloperButton(),
        body: IgnorePointer(
          ignoring: controller.isLoading,
          child: SingleChildScrollView(
            child: Container(
              height: Get.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bg_login_customer.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Form(
                key: controller.formKey,
                child: Container(
                  margin:  EdgeInsets.only(bottom: controller.showCodeConfirm.value ? 60 : 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      _buildPhoneNumber(),

                      const SizedBox(height: 20,),

                      _buildCodeConfirm(),
                      _buildButtonGuest()

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

      );
    },);
  }




  _buildPhoneNumber(){
    return Column(children: [
      Container(
        height: 45,
        margin:
        const EdgeInsets.symmetric(horizontal: 50),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: TextField(
            key: const Key("userNameTextField"),
            controller:
            controller.userNameController,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            textAlignVertical: TextAlignVertical.center,
            maxLength: 11,
            style: AppTypography.s16
                .copyWith(
                color:  ColorHelper.black),
            decoration: InputDecoration(
              hintText: 'شماره تماس',
              contentPadding: const EdgeInsets.only(bottom: 12),
              counterText: "",
              hintStyle: AppTypography.s16
                  .copyWith(
                  color: const Color(0xff747474)),
              border: InputBorder.none,
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.red)
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.grey)
              ),
              focusedBorder:  OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.grey)
              ),
              fillColor: const Color(0xffF9F9F9),
              filled: true,
            ),
          ),
        ),
      ),

      const SizedBox(height: 20,),
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
              Text(
                'درخواست کد',
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
              Text("لطفا صبر کنید ...",
                style: AppTypography.s15
                    .copyWith(color: Colors.white),)

            ],
          ),
        ),
      ),


    ],);
  }

  _buildCodeConfirm(){
    return  Visibility(
      visible: controller.showCodeConfirm.value,
      child: FadeInUp(
        from: 20,
        child: Column(
          children: [
            Container(
              height: 45,
              margin: const EdgeInsets.symmetric(horizontal: 50),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: TextField(
                  key: const Key("userNameTextField"),
                  controller:
                  controller.smsController,
                  onChanged: (value) {
                    if(value.length == 6){
                      controller.apiRegisterPhoneNumber();
                    }
                  },
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  style: AppTypography.s16
                      .copyWith(
                      color: ColorHelper.black),
                  decoration: InputDecoration(
                    hintText: 'کد تاییدیه',
                    contentPadding: const EdgeInsets.only(bottom: 12),
                    counterText: "",
                    hintStyle: AppTypography.s16
                        .copyWith(
                        color: const Color(0xff747474)),
                    border: InputBorder.none,
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.red)
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.grey)
                    ),
                    focusedBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.grey)
                    ),
                    fillColor: const Color(0xffF9F9F9),
                    filled: true,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30,),
            InkWell(
              onTap: (){
                controller.apiRegisterPhoneNumber();
              },
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                    color: const Color(0xff398FFF),
                    borderRadius: BorderRadius.circular(15)),
                child: !controller.isLoadingCodeConfirm?  Row(
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
          ],
        ),
      ),
    );
  }

  Widget _buildButtonGuest() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(left: 14),
        height: 80,
        width: 80,
        child: FloatingActionButton(onPressed: () {
          controller.goToHomeFromGuest();
        },
          elevation: 1,
          backgroundColor: ColorHelper.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50),
          side: const BorderSide(width: 1)),
          child: Text('کاربر مهمان',
          style: AppTypography.s14.copyWith(
            fontFamily: FontsName.fontMed,
            color: ColorHelper.black
          ),),
        ),
      ),
    );
  }





}