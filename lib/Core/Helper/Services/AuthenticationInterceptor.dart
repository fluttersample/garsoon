import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'package:waiter/Core/Helper/API.dart';
import 'package:waiter/Core/Helper/BaseBrain.dart';
import 'package:waiter/Core/Helper/Extensions.dart';
import 'package:waiter/Core/Helper/Globals/GlobalFunc.dart';
import 'package:waiter/Core/Helper/Storage/LocalData.dart';
import 'package:waiter/Infrastructure/Navigation/CustomRoot.dart';
import 'package:waiter/Infrastructure/Navigation/Routes.dart';
import 'package:waiter/Presentation/Widgets/Dialogs/DialogConnectionError.dart';
import 'package:waiter/Presentation/Widgets/ToastNotification/ShowMessage.dart';
import 'dart:developer' as l;

class AuthenticationInterceptor extends QueuedInterceptorsWrapper {
  final Dio _mainDio;
  late Dio _dio;

  AuthenticationInterceptor(this._mainDio) {
    BaseOptions options = BaseOptions(
      baseUrl: BaseBrain.baseDomain,
      connectTimeout: const Duration(milliseconds: 10000),
      receiveTimeout: const Duration(milliseconds: 10000),
      headers: {
        "type": "Flutter",
      },
    );
    _dio = Dio(options);

    _dio.interceptors.add(
        QueuedInterceptorsWrapper(onRequest: (RequestOptions options,
            RequestInterceptorHandler handler,) {
          handler.next(options);
        }));
    _dio.interceptors.add(LogInterceptor(
        responseBody: true, logPrint: (object) {
          l.log(object.toString());
    }, requestBody: true));
  }


  @override
  Future onRequest(RequestOptions options,
      RequestInterceptorHandler handler) async {
    // if(BaseBrain.isExpireToken){
    //   return handler.reject(
    //     DioException(requestOptions: options),
    //     true,
    //   );
    // }
    options.headers.addIf(!BaseBrain.token.AccessToken.isNullOrEmpty, 'Authorization',
        '${BaseBrain.token.TokenType} ${BaseBrain.token.AccessToken}');
    if(kIsWeb){
      final shopId = LocalData.getSelectedShop.ShopId;
      options.headers.addIf(shopId != null, 'ShopId', shopId);
    }else {
      options.headers.addIf(BaseBrain.selectedShop?.ShopId != null, 'ShopId',
          BaseBrain.selectedShop?.ShopId ?? '');
    }




    return handler.next(options);
  }

  @override
  Future onResponse(Response response,
      ResponseInterceptorHandler handler,) async {
    if (response.statusCode == 200) {
      _checkStatusCodeAndShowMessage(response);
    }

    return handler.next(response);
  }


  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {

    print('ERROR ${err.response?.statusCode}');
    if(err.response?.statusCode == 500){
      ShowMessage().showToastWithoutCnt(
          message: 'خطایی رخ داده است !', status: 410);
    }
    if(err.type == DioExceptionType.connectionError){
      if(!err.requestOptions.path.contains(API.InsertOrder)){
      DialogConnectionError(onTap: () async{
        CustomRoot.back(closeOverlays: true);
        try {
        handler.resolve(await _mainDio.fetch(err.requestOptions));
        }catch (e){
          print("$e");
        }
      },).showConnectionErrorDialog();
      }
    }

    if (err.response?.statusCode! == 401) {

      if ((BaseBrain.token.AccessToken ?? "").isNotEmpty) {
        RequestOptions options = err.requestOptions;

        // final authHeader = options.headers['Authorization'].toString();
        // final accessToken = "${BaseBrain.token.TokenType} ${BaseBrain.token
        //     .AccessToken}";
        // if (accessToken.toLowerCase() != authHeader.toLowerCase()) {
        //   return handler.resolve(await _mainDio.fetch(options));
        // }
        // BaseBrain.isExpireToken = true;
        var resultToken = await refreshToken();
        // BaseBrain.isExpireToken = false;

        options.headers["Authorization"] = "${BaseBrain.token.TokenType} ${BaseBrain.token.AccessToken}";
        if (resultToken == 1) {
          // final dioAgain = Dio(BaseOptions(
          //   baseUrl: BaseBrain.baseDomain,
          //   connectTimeout: const Duration(milliseconds: 10000),
          //   receiveTimeout: const Duration(milliseconds: 10000),
          //   headers: {
          //     "content-type": "application/json",
          //   }
          // ));
          //
          // dioAgain.interceptors.add(this);
          // dioAgain.interceptors.add(LogInterceptor(
          //     responseBody: true, logPrint: (object) {
          //   l.log(object.toString());
          // }, requestBody: true));

          return handler.resolve(await _mainDio.fetch(options));
        } else if (resultToken == 0) {
          logout();
        }
      } else {
        logout();
      }
    }

    return handler.next(err);
  }



  _checkStatusCodeAndShowMessage(Response? response){
      final model = VMAPIBase.fromJson(response?.data);
      if (model.Message?.Text != null && model.Message!.Text!.isNotEmpty) {
        ShowMessage().showToastWithoutCnt(
            message: model.Message?.Text ?? '', status: model.Code ?? 200);
      }
  }



  logout() async {
    _mainDio.options.headers["authorization"] = "";
    if(BaseBrain.isCustomer) {
      GlobalFunc.logout(root: Routes.LoginCustomer);
    }else {
      GlobalFunc.logout();

    }
  }


  _getRefreshToken() {
    // Conditions
    var checkToken =
    (BaseBrain.token.AccessToken != null &&
        BaseBrain.token.RefreshToken != null &&
        BaseBrain.token.RefreshToken!.isNotEmpty);

    return checkToken ? BaseBrain.token.RefreshToken : "";
  }

  Future<int> refreshToken() async {
    return await _dio
        .post("${BaseBrain.baseDomain}/Identity/V2/Shop/RefreshToken",
        options: Options(headers: {"refreshtoken": _getRefreshToken()})).then((
        value) async {
      if (value.data != null) {
        var jsonData = value.data;
        if (jsonData['Code'] == 401 || jsonData['Code'] == 410) {
          return 0;
        }
        VMToken vmToken = VMToken.fromJson(jsonData['Data']);
        BaseBrain.token = vmToken;
        // await BaseBrain.storageService.deleteByProperty(
        //     StorageServiceTables.TABLE_TOKEN).then((value) async {
        //   await BaseBrain.storageService.insert(data: vmToken.toJson(),
        //       storageServiceTables: StorageServiceTables.TABLE_TOKEN);
        // });
        //
        LocalData.setToken(vmToken);
        GlobalFunc.initialDio();
        return 1;
      } else {
        return 15;
      }
    }).catchError((error) {
      if (error is DioException) {
        if (error.type == DioExceptionType.receiveTimeout) {
          return 4;
        }
        if (error.response?.statusCode == 401) {
          return 0;
        }
      }
      return 2;
    });
  }

}
