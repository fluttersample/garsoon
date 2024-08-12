import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:waiter/Core/Dto/Enums/StorageServiceTables.dart';
import 'package:waiter/Core/Dto/Models/Responses/Token/TokenModel.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'package:waiter/Core/Helper/BaseBrain.dart';
import 'package:waiter/Core/Helper/Globals/GlobalFunc.dart';
import 'package:waiter/Core/Helper/Services/BaseDio.dart';
import 'package:waiter/Core/Helper/Storage/StorageHelper.dart';
import 'package:waiter/Core/Interfaces/UseCases/IChangePasswordUseCase.dart';
import 'package:waiter/Core/Interfaces/UseCases/IConfirmUseCase.dart';
import 'package:waiter/Core/Interfaces/UseCases/IForgetPasswordUseCase.dart';
import 'package:waiter/Core/Interfaces/UseCases/ILoginUseCase.dart';
import 'package:waiter/Infrastructure/Navigation/CustomRoot.dart';
import 'package:waiter/Infrastructure/Navigation/Routes.dart';
import 'package:waiter/Presentation/Widgets/LoadingWidget.dart';
import 'package:waiter/Presentation/Widgets/ToastNotification/ShowMessage.dart';

class LoginController extends GetxController {
  final ILoginUseCase _loginUseCase;
  final IForgetPasswordUseCase _forgetPasswordUseCase;
  final IConfirmUseCase _confirmUseCase;
  final IChangePasswordUseCase _changePasswordUseCase;

  LoginController({required ILoginUseCase iLoginUseCase, required IForgetPasswordUseCase forgetPasswordUseCase,
    required IConfirmUseCase confirmUseCase,
    required IChangePasswordUseCase changePasswordUseCase,

  })
      : _changePasswordUseCase = changePasswordUseCase,
        _forgetPasswordUseCase = forgetPasswordUseCase,
        _confirmUseCase = confirmUseCase,
        _loginUseCase = iLoginUseCase;
  final formKey = GlobalKey<FormState>();


  /// bool
  bool isDialogLoading = false;
  bool isLoading = false;
  bool showForgetUserName = true;
  bool showForgetSms = false;
  bool showForgetPassword = false;
  bool canLogin = false;


  /// models
  final codeConfirm = CodeConfirmModel().obs;


  /// keys
  final forgetFormKey =  GlobalKey<FormState>();


  /// controllers
  final forgetUserNameController = TextEditingController();
  final smsController = TextEditingController();
  final forgetPasswordController = TextEditingController();
  final forgetConfirmPasswordController = TextEditingController();
  final userNameController = TextEditingController(text: kDebugMode ? '09302212189' : null);
  final passwordController = TextEditingController(text:  kDebugMode ? '1234569' : null);


  /// methods
  openForgetPasswordDialog() async {
    var data = await Get.defaultDialog(
      title: "فراموشی رمز عبور",
      content: GetBuilder(
        init: this,
        builder: (_) {
          return Form(
            key: forgetFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: showForgetUserName,
                  child: Column(
                    children: [
                      const Text(
                        "نام کاربری خود را وارد نمائید",
                        style: TextStyle(fontSize: 12.0),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        validator: (value) {
                          // Conditions
                          var checkValue = value == null || value.isEmpty;
                          var checkLength = !checkValue && value.length > 11;

                          if (checkValue) {
                            return "نام کاربری را وارد نمائید";
                          }
                          else if (checkLength) {
                            return "نام کاربری 11 رقمی می‌باشد.";
                          }
                          return null;
                        },
                        controller: forgetUserNameController,
                        textAlignVertical: TextAlignVertical.center,
                        textAlign: TextAlign.center,
                        maxLength: 11,
                        decoration: InputDecoration(
                          labelText: 'نام کاربری',
                          alignLabelWithHint: true,
                          border:  OutlineInputBorder(
                            borderSide:  const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: showForgetSms,
                  child: Column(
                    children: [
                      const Text(
                        "کد پیامک شده را وارد نمائید",
                        style: TextStyle(fontSize: 12.0),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        validator: (value) {
                          // Conditions
                          var checkValue = value == null || value.isEmpty;
                          var checkLength = !checkValue && value.length != 6;

                          if (checkValue) {
                            return "کد پیامک شده را وارد نمائید";
                          } else if (checkLength) {
                            return "کد پیامکی ۶ رقمی می‌باشد.";
                          }
                          return null;
                        },
                        controller: smsController,
                        textAlignVertical: TextAlignVertical.center,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        maxLength: 6,
                        decoration: InputDecoration(
                          labelText: 'کد پیامک شده',
                          alignLabelWithHint: true,
                          border:  OutlineInputBorder(
                            borderSide:  const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: showForgetPassword,
                  child: Column(
                    children: [
                      const Text(
                        "رمز عبور جدید را وارد نمائید",
                        style: TextStyle(fontSize: 12.0),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        validator: (value) {
                          // Conditions
                          var checkValue = value == null || value.isEmpty;

                          if (checkValue) {
                            return "رمز عبور جدید را وارد نمائید";
                          }
                          return null;
                        },
                        controller: forgetPasswordController,
                        textAlignVertical: TextAlignVertical.center,
                        textAlign: TextAlign.center,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'رمز عبور جدید',
                          alignLabelWithHint: true,
                          border:  OutlineInputBorder(
                            borderSide:  const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      const Text(
                        "مجددا رمز عبور جدید را وارد نمائید",
                        style: TextStyle(fontSize: 12.0),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        validator: (value) {
                          // Conditions
                          var checkValue = value == null || value.isEmpty;
                          var checkValid = !checkValue && value != forgetPasswordController.text;

                          if (checkValue) {
                            return "رمز عبور جدید را مجددا وارد نمائید";
                          } else if (checkValid) {
                            return "گذرواژه‌ها با یکدیگر همخوانی ندارند";
                          }
                          return null;
                        },
                        controller: forgetConfirmPasswordController,
                        textAlignVertical: TextAlignVertical.center,
                        textAlign: TextAlign.center,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'تکرار رمز عبور',
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      actions: [
        GetBuilder(
          init: this,
          builder: (_) {
            return SizedBox(
              width: 250,
              height: 50.0,
              child: Stack(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Material(
                          child: InkWell(
                            onTap: () {
                              if (forgetFormKey.currentState!.validate()) {
                                onForgetFormSaved();
                              } else {
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12.0),
                              child: Center(
                                child: Text(showForgetPassword ? "تایید" : "ادامه"),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 36.0,
                        child: const VerticalDivider(
                          width: 1.0,
                        ),
                      ),
                      Expanded(
                        child: Material(
                          child: InkWell(
                            onTap: () {
                              showForgetUserName = true;
                              showForgetSms = false;
                              showForgetPassword = false;
                              forgetUserNameController.text = "";
                              smsController.text = "";
                              forgetPasswordController.text = "";
                              forgetConfirmPasswordController.text = "";
                              CustomRoot.back(closeOverlays: true);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12.0),
                              child: const Center(
                                child: Text("بستن"),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  isDialogLoading
                      ? const LoadingWidget()
                      : Container()
                ],
              ),
            );
          },
        )
      ],
      barrierDismissible: showForgetSms || showForgetPassword ? false : true,
      onWillPop: () {
        showForgetUserName = true;
        showForgetSms = false;
        showForgetPassword = false;
        smsController.text = "";
        forgetPasswordController.text = "";
        forgetConfirmPasswordController.text = "";
        CustomRoot.back();

        return Future.delayed(const Duration(milliseconds: 500)).then((value) {
          return true;
        });
      },
    );

  }

  updateLoading({required bool isLoading}) {
    this.isLoading = isLoading;
    update();
  }
  goToHome() {
    GlobalFunc.closeKeyboard();
    Future.delayed(const Duration(milliseconds: 200),(){
    CustomRoot.offAllNamed(Routes.Home);
    });
  }


  void onForgetFormSaved() {
    final FormState form = forgetFormKey.currentState!;
    form.save();

    if (showForgetUserName) {
      startApiForgetPassword();
    }

    if (showForgetSms) {
      startApiConfirm();
    }

    if (showForgetPassword) {
      startApiChangePassword();
    }
  }

  updateDialogLoading({required bool isDialogLoading}) {
    this.isDialogLoading = isDialogLoading;
    update();
  }



  /// apis
 void startApiForgetPassword() async {
    updateDialogLoading(isDialogLoading: true);

    await _forgetPasswordUseCase.handler(params: LoginRequestModel(userName: forgetUserNameController.text)).then((value) {
      value.fold((l) {

      }, (result) {
        if (result.Code == 200) {
          showForgetUserName = false;
          showForgetSms = true;
          showForgetPassword = false;
          update();
        }

      });
      updateDialogLoading(isDialogLoading: false);
    }).catchError((e){
      updateDialogLoading(isDialogLoading: false);

    });

  }


  void startApiConfirm() async {
    updateDialogLoading(isDialogLoading: true);
    await _confirmUseCase.handler(params: LoginRequestModel(
        userName: forgetUserNameController.text, code: smsController.text
    )).then((value) {
      value.fold((l) {

      }, (result) {
        codeConfirm.value = result;
        showForgetUserName = false;
        showForgetSms = false;
        showForgetPassword = true;
        update();
      });
      updateDialogLoading(isDialogLoading: false);

    }).catchError((e){
      updateDialogLoading(isDialogLoading: false);
    });

  }


  void startApiChangePassword() async {
    updateDialogLoading(isDialogLoading: true);
    await _changePasswordUseCase.handler(params: LoginRequestModel(
        userName: forgetUserNameController.text,
        password: forgetPasswordController.text,
        resetPasswordToken: codeConfirm.value.ResetPasswordToken
    )).then((value) {
      value.fold((l) {

      }, (result) async{
        showForgetUserName = true;
        showForgetSms = false;
        showForgetPassword = false;
        smsController.text = "";
        forgetPasswordController.text = "";
        forgetUserNameController.text = "";
        forgetConfirmPasswordController.text = "";
        await GlobalFunc.updateVmToken(account: result);

        goToHome();
      });
      updateDialogLoading(isDialogLoading: false);

    }).catchError((e){
      updateDialogLoading(isDialogLoading: false);
    });

  }


  void apiLogin() async {
    var userName = NumberUtility.changeDigit(userNameController.text, NumStrLanguage.English);
    updateLoading(isLoading: true);
    await _loginUseCase
        .handler(
        params: LoginRequestModel(
            userName: userName,
            password: passwordController.text,
            role: 'waiter'))
        .then((value) {
      value.fold((l) {

      }, (account) async{
        if((account.AccessToken ?? "").isEmpty && (account.RefreshToken ?? "").isEmpty){
          ShowMessage().getSnackBar(message: "خطا در دریافت اطلاعات کاربری", type: MessageType.ERROR);
          return;
        }
        await GlobalFunc.updateVmToken(account: account);
        goToHome();
      });
      updateLoading(isLoading: false);

    }).catchError((e) {
      updateLoading(isLoading: false);

    });
  }




}
