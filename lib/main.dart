import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutterwebapp_reload_detector/flutterwebapp_reload_detector.dart';
import 'package:get/get.dart';
import 'package:waiter/Core/Dto/Enums/StorageKey.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'package:waiter/Core/Helper/BaseBrain.dart';
import 'package:waiter/Core/Helper/ColorHelper.dart';
import 'package:waiter/Core/Helper/Globals/GlobalFunc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:waiter/Core/Helper/Storage/StorageHelper.dart';
import 'package:waiter/Core/Helper/ThemeHelper.dart';
import 'Core/Helper/API.dart';
import 'Core/Helper/AppTypography.dart';
import 'Core/Helper/Storage/LocalData.dart';
import 'Infrastructure/Navigation/Navigation.dart';
import 'Infrastructure/Navigation/Routes.dart';
import 'Presentation/Widgets/CustomScrollBehavior.dart';
import 'waiter_injection_container.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'dart:developer' as l;
import 'package:uni_links/uni_links.dart';
import 'package:url_strategy/url_strategy.dart';
bool _initialUriIsHandled = false;

void main() async {
  await _beforeRunApp();
  runApp(const MyApp());
}

Future<void> _beforeRunApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Future.wait([
    initSl(),
    GlobalFunc().appInfo(),
    StorageHelper.initStorage(),
  ]);

  if (!kIsWeb && GetPlatform.isAndroid) {
    AndroidDeviceInfo info = sl();
    if (info.version.sdkInt < 27) {
      HttpOverrides.global = MyHttpOverrides();
    }
  }
  GlobalFunc.initialDio();
  _initUniLinks();

  // if(!kIsWeb){
  //   Directory directory = await path_provider.getApplicationDocumentsDirectory();
  // Hive.init(directory.path);
  // }
  // Hive.registerAdapter(VMDatabaseAdapter());
  //   await Hive.openBox<VMDatabase>(DatabaseHelper.dbBoxName);
  //
  // BaseBrain.storageService = sl<StorageService>();

   setLocalData();
}

  void setLocalData(){
    BaseBrain.token = LocalData.getToken;
    BaseBrain.getShops = LocalData.getShopList;
    StorageHelper.removeStorage(storageKey: StorageKey.queueList);
    var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    if(isDarkMode){
      BaseBrain.isDarkTheme.value = true;
    }else {
      BaseBrain.isDarkTheme.value = false;
    }


    if(kDebugMode){
      // read Data From Local
       if(LocalData.checkDataInLocal(StorageKey.baseUrl)){
         if(LocalData.getBaseUrl.contains('alfast')){
          GlobalFunc.changeBaseUrl(1);
         }else {
           GlobalFunc.changeBaseUrl(0);
         }
      } // default
       else {
         GlobalFunc.changeBaseUrl(1);
       }
    }else {
      GlobalFunc.changeBaseUrl(0);
    }

    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarColor: Colors,
    //   statusBarIconBrightness:
    // ));

  }

void _initUniLinks() async {

  if(!_initialUriIsHandled){
    _initialUriIsHandled = true;
  try{
    final initialURI = await getInitialUri();
    if (initialURI != null) {
      debugPrint("Initial URI received $initialURI");
      String urlNavigation = '';
      if (initialURI.query.isNotEmpty) {
        urlNavigation = initialURI.query;

        debugPrint('URL NAVIGATION $urlNavigation');
        print("ShopId ${initialURI.queryParameters['ShopId']}");
        print("TableId ${initialURI.queryParameters['TableId']}");
        print("TableCode ${initialURI.queryParameters['TableCode']}");
        if(urlNavigation.contains('TableId') && urlNavigation.contains('ShopId')){
          final shopId =initialURI.queryParameters['ShopId'];
          final tableId =initialURI.queryParameters['TableId'];
          final tableCode =initialURI.queryParameters['TableCode'];
          final selectShop = SelectShopModel(ShopId: shopId);
          final selectTable = TablesModel(
              TableId: tableId,
              TableCode: tableCode
          );
          LocalData.setSelectedShop(selectShop);
          LocalData.setSelectedTable(selectTable);
        }

      }

    }

  }catch(e){
    print('platfrom exception unilink ${e}');
  }
  }

}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    l.log('TOKEN USER ${BaseBrain.token.TokenType} ${BaseBrain.token.AccessToken}');
    // final x =LocalData.checkDataInLocal(StorageKey.productList);
    print("ISCUSTOMER !!!!! ${BaseBrain.isCustomer}");
    return GetMaterialApp(
      scrollBehavior: CustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: 'گارسون',
      onInit: () {

      },
      builder: (context, widget) => ResponsiveBreakpoints.builder(
        child: Stack(
          alignment: Alignment.center,
          children: [
            ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 450, maxWidth: 600),
                child: SafeArea(child: widget!)),
          ],
        ),
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate
      ],
      supportedLocales: const [Locale("fa", "IR")],
      locale: const Locale("fa", "IR"),
      fallbackLocale: const Locale("fa", "IR"),
      theme: ThemeHelper.themeLight,
      darkTheme: ThemeHelper.themeDark,
      getPages: Nav.allNav,
      // routerDelegate: AppRouterDelegate(),
      // customTransition: myCS(),
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      initialRoute: Routes.Splash,
    );
  }
}
// class myCS extends CustomTransition {
//   @override
//   Widget buildTransition(
//       BuildContext context,
//       Curve? curve,
//       Alignment? alignment,
//       Animation<double> animation,
//       Animation<double> secondaryAnimation,
//       Widget child) {
//    return FadeTransition(opacity: animation,child: child,);
//   }
// }
// class AppRouterDelegate extends GetDelegate {
//   @override
//   Widget build(BuildContext context) {
//     return Navigator(
//       key: Get.key,
//       onPopPage: (route, result) => route.didPop(result),
//       pages: currentConfiguration != null
//           ? [currentConfiguration!.currentPage!]
//           : [GetNavConfig.fromRoute(Routes.SPLASH)!.currentPage!],
//     );
//   }
// }

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
