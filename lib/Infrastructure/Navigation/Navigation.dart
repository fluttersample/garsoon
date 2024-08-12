import 'package:get/get.dart';
import 'package:waiter/Infrastructure/Middlewares/Auth.Middleware.dart';
import 'package:waiter/Infrastructure/Navigation/Controllers/CheckOrderBinding.dart';
import 'package:waiter/Infrastructure/Navigation/Controllers/Home.Binding.dart';
import 'package:waiter/Infrastructure/Navigation/Controllers/LoginCustomer.Binding.dart';
import 'package:waiter/Infrastructure/Navigation/Controllers/Orders.Binding.dart';
import 'package:waiter/Infrastructure/Navigation/Controllers/Payment.Binding.dart';
import 'package:waiter/Infrastructure/Navigation/Controllers/PreviewChangeOrder.Binding.dart';
import 'package:waiter/Infrastructure/Navigation/Controllers/SearchProduct.Binding.dart';
import 'package:waiter/Infrastructure/Navigation/Controllers/SingleProduct.Binding.dart';
import 'package:waiter/Infrastructure/Navigation/Controllers/StatusUploadServer.Binding.dart';
import 'package:waiter/Infrastructure/Navigation/Controllers/TableCustomer.Binding.dart';
import 'package:waiter/Presentation/ChangeProductOrder/ChangeProductOrder.Screen.dart';
import 'package:waiter/Presentation/CheckOrder/CheckOrder.Screen.dart';
import 'package:waiter/Presentation/DeveloperTools/DeveloperTools.Screen.dart';
import 'package:waiter/Presentation/Home/Home.Screen.dart';
import 'package:waiter/Presentation/Login/Login.Screen.dart';
import 'package:waiter/Presentation/LoginCustomer/LoginCustomer.Screen.dart';
import 'package:waiter/Presentation/Orders/Orders.Screen.dart';
import 'package:waiter/Presentation/Payment/Payment.Screen.dart';
import 'package:waiter/Presentation/PreviewChangeOrder/PreviewChangeOrder.Screen.dart';
import 'package:waiter/Presentation/ProductList/ProductList.Screen.dart';
import 'package:waiter/Presentation/ReceiptBasket/ReceiptBasket.Screen.dart';
import 'package:waiter/Presentation/SearchProduct/SearchProduct.Screen.dart';
import 'package:waiter/Presentation/SingleProduct/SingleProduct.Screen.dart';
import 'package:waiter/Presentation/Splash/Splash.Screen.dart';
import 'package:waiter/Presentation/StatusUploadServer/StatusUploadServer.Screen.dart';
import 'package:waiter/Presentation/TableCustomer/TableCustomer.Screen.dart';
import 'Controllers/ChangeProductOrder.Binding.dart';
import 'Controllers/Controllers_Bindings.dart';
import 'Controllers/Login.Binding.dart';
import 'Controllers/ProductList.Binding.dart';
import 'Controllers/Receipt.Binding.dart';
import 'Controllers/Splash.Binding.dart';
import 'Routes.dart';

class Nav {
  Nav._();

  static List<GetPage> allNav = [

    GetPage(
      name: Routes.Splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
       middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.Login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
       middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.Home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
       middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: Routes.TableCustomer,
      page: () => const TableCustomerScreen(),
      binding: TableCustomerBinding(),
       middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.StatusUploadServer,
      page: () => const StatusUploadServerScreen(),
      binding: StatusUploadServerBinding(),
       middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.ProductList,
      page: () => const ProductListScreen(),
      binding: ProductListBinding(),
       middlewares: [AuthMiddleware()],
    ),


    GetPage(
      name: Routes.Orders,
      page: () => const OrdersScreen(),
      binding: OrdersBinding(),
       middlewares: [AuthMiddleware()],
    ),


    GetPage(
      name: Routes.SearchProduct,
      page: () => const SearchProductScreen(),
      binding: SearchProductBinding(),
       middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: Routes.SingleProduct,
      page: () => const SingleProductScreen(),
      binding: SingleProductBinding(),
       middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: Routes.CheckOrder,
      page: () => const CheckOrderScreen(),
      binding: CheckOrderBinding(),
      transition:  Transition.leftToRight,
       middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: Routes.Receipt,
      page: () => const ReceiptBasketScreen(),
      binding: ReceiptBinding(),
       middlewares: [AuthMiddleware()],
    ),


    GetPage(
      name: Routes.LoginCustomer,
      page: () => const LoginCustomerScreen(),
      binding: LoginCustomerBinding(),
       middlewares: [AuthMiddleware()],
    ),


    GetPage(
      name: Routes.PreviewChangeOrder,
      page: () => const PreviewChangeOrderScreen(),
      binding: PreviewChangeOrderBinding(),
       middlewares: [AuthMiddleware()],
    ),


   GetPage(
      name: Routes.ChangeProductOrder,
      page: () => const ChangeProductOrderScreen(),
      binding: ChangeProductOrderBinding(),
     transition:  Transition.downToUp,
       middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: Routes.Payment,
      page: () => const PaymentScreen(),
      binding: PaymentBinding(),
      transition:  Transition.downToUp,
       middlewares: [AuthMiddleware()],
    ),





    GetPage(
      name: Routes.DEVELOPER_TOOLS,
      page: () => DeveloperToolsScreen(),
      binding: DeveloperToolsBinding(),
       // middlewares: [AuthMiddleware()],
    ),

  ];
}
