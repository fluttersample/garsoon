import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/Core/Helper/BaseBrain.dart';
import 'package:waiter/Core/Helper/Extensions.dart';
import 'package:waiter/Infrastructure/Navigation/Routes.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    return redirectUser(route);
  }

  RouteSettings? redirectUser(String? route){
    if(route!= null){
      final uri = Uri.parse(route);
      debugPrint("ROUTE REDIRECT ${uri.path}");
      final pathRoute = uri.path;
      if(!BaseBrain.token.AccessToken.isNullOrEmpty){
        if(BaseBrain.isCustomer){
          if(pathRoute == (Routes.LoginCustomer) || pathRoute == (Routes.ProductList) ||
              pathRoute == (Routes.SingleProduct) || pathRoute == (Routes.CheckOrder) ||
              pathRoute == (Routes.SearchProduct) ||
              pathRoute == (Routes.Receipt) || pathRoute == (Routes.Payment) ){
            return null;
          }else {
            return const RouteSettings(name: Routes.LoginCustomer);
          }
        }
      }
      return null;
    }
    return null;
  }

  @override
  GetPage? onPageCalled(GetPage? page) {
    print('AuthMiddleware onPageCalled => ${page?.name}');

    return page;
  }

  @override
  GetPageBuilder onPageBuildStart(GetPageBuilder? page) {
    return page!;
  }

  @override
  Widget onPageBuilt(Widget page) {
    return page;
  }

  @override
  void onPageDispose() {
  }
}
