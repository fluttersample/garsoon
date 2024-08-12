import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:waiter/Core/Dto/Enums/StorageKey.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'package:waiter/Core/Helper/Globals/GlobalFunc.dart';
import 'package:waiter/Core/Helper/Storage/LocalData.dart';
import 'package:waiter/Core/Helper/Storage/StorageHelper.dart';
import 'package:waiter/Core/Interfaces/UseCases/ILoginCustomerUseCase.dart';
import 'package:waiter/Core/Interfaces/UseCases/IRegisterPhoneNumberUseCase.dart';
import 'package:waiter/Core/Interfaces/UseCases/ISignUpCustomerUseCase.dart';
import 'package:waiter/Infrastructure/Navigation/CustomRoot.dart';
import 'package:waiter/Infrastructure/Navigation/Routes.dart';

class LoginCustomerController extends GetxController {
  final ILoginCustomerUseCase _iLoginCustomerUseCase;
  final IRegisterPhoneNumberUseCase _iRegisterPhoneNumberUseCase;
  final ISignUpCustomerUseCase _iSignUpCustomerUseCase;

  LoginCustomerController({required ILoginCustomerUseCase iLoginCustomerUseCase,
  required IRegisterPhoneNumberUseCase iRegisterPhoneNumberUseCase,
    required ISignUpCustomerUseCase iSignUpCustomerUseCase
  })
      :
        _iRegisterPhoneNumberUseCase = iRegisterPhoneNumberUseCase,
        _iSignUpCustomerUseCase = iSignUpCustomerUseCase,
        _iLoginCustomerUseCase = iLoginCustomerUseCase;
  final formKey = GlobalKey<FormState>();


  /// bool
  final showCodeConfirm = false.obs;
  bool isLoading = false;
  bool isLoadingCodeConfirm = false;

  /// models
  final codeConfirm = CodeConfirmModel().obs;


  /// keys
  final forgetFormKey =  GlobalKey<FormState>();


  /// controllers
  final userNameController = TextEditingController(text: kDebugMode ? '09396080591' : null);
  final smsController = TextEditingController();




  /// methods

  updateLoading({required bool isLoading}) {
    this.isLoading = isLoading;
    update();
  }
  updateLoadingConfirm({required bool isLoading}) {
    isLoadingCodeConfirm = isLoading;
    update();
  }
  goToHome() {
    GlobalFunc.closeKeyboard();
    Future.delayed(const Duration(milliseconds: 200),(){
    CustomRoot.offAllNamed(Routes.ProductList);
    });
  }


  void goToHomeFromGuest()async{
    const token = VMToken(isCustomer: true, phoneNumber: 'Guest');
    await GlobalFunc.updateVmToken(account: token,fromGust: true);
    goToHome();
}


  /// apis

  void apiLogin() async {
    var userName = NumberUtility.changeDigit(userNameController.text, NumStrLanguage.English);
    updateLoading(isLoading: true);
    await _iLoginCustomerUseCase
        .handler(
        params: LoginCustomerRequestModel(phoneNumber: userName,))
        .then((value) {
      value.fold((l) {
      }, (account) {
        if(account.stateLogin?.contains('NotFound')??false){
          apiSignUp();
        }else {
          showCodeConfirm.value = true;
          updateLoading(isLoading: false);
        }

      });


    }).catchError((e) {
      updateLoading(isLoading: false);

    });
  }

  void apiSignUp() async {
    var userName = NumberUtility.changeDigit(userNameController.text, NumStrLanguage.English);
    await _iSignUpCustomerUseCase
        .handler(
        params: LoginCustomerRequestModel(phoneNumber: userName,))
        .then((value) {
      value.fold((l) {
      }, (account) {
        showCodeConfirm.value = true;
      });
      updateLoading(isLoading: false);

    }).catchError((e) {
      updateLoading(isLoading: false);

    });
  }

  void apiRegisterPhoneNumber() async {
    var phoneNumber = NumberUtility.changeDigit(userNameController.text, NumStrLanguage.English);
    var sms = NumberUtility.changeDigit(smsController.text, NumStrLanguage.English);
    updateLoadingConfirm(isLoading: true);
    await _iRegisterPhoneNumberUseCase
        .handler(
        params: LoginCustomerRequestModel(phoneNumber: phoneNumber,code: sms ))
        .then((value) {
      value.fold((l) {

      }, (account) async{
        if(account.content?.token.accessToken != null){
          final data = account.content?.token;
        final token = VMToken(
          AccessToken: data?.accessToken,
          TokenType:  data?.tokenType,
          isCustomer: true,
          RefreshToken: data?.refreshToken,
          phoneNumber: phoneNumber,
          ExpiresIn: data?.expiresIn,
          ExpiresOn: data?.expiresOn
        );
        await GlobalFunc.updateVmToken(account: token);
        goToHome();
        }
      });


      updateLoadingConfirm(isLoading: false);

    }).catchError((e) {
      updateLoadingConfirm(isLoading: false);

    });
  }




}
