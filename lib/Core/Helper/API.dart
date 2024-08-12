


abstract class API {

  static const String LOGIN = '/Identity/V2/Shop/Login';
  static const String FORGET_PASSWORD = '/Identity/v2/Shop/ForgetPassword';
  static const String CONFIRM = '/Identity/V2/Shop/Confirm';
  static const String CHANGE_PASSWORD = '/Identity/V2/Shop/ChangePassword';
  static const String ORDERS = '/food/waiter/order/GetOrders';
  static const String GetShops = '/Shop/v1/Shop/MyShops';
  static const String Tables = '/food/waiter/table/GetAll';
  static const String ProductList = '/food/waiter/product/GetProducts';
  static const String ProductsGroup = '/food/waiter/product/GetProductGroups';
  static const String SingleProduct = "/shop/customer/product/v2/Get";
  /// Orders
  static const String InsertOrder = "/food/waiter/order/InsertOrder";
  static const String GetOrderInfo = "/shop/v1/shop/order";
  static const String EditOrder = "/food/waiter/order/EditOrder";
  static const String CancelOrder = "/food/waiter/order/CancelOrder";
  static const String GetOrderInfoCustomer = "/food/waiter/order/GetOrderInfo";
  static const String VerificationPayment = "/food/waiter/order/VerificationPayment";



  /// customer
  static const String LoginCustomer = '/Identity/customer/login';
  static const String RegisterPhoneNumberCustomer = '/Identity/customer/Confirm';
  static const String SignUpCustomer = '/Identity/customer/signup';


  // static const String baseDomainLocal = "http://192.168.10.176:1000";
  static const String baseDomainLocal = "https://api.alfast.ir";
  static const String baseDomainNewLocal = "https://api1.alfast.ir";
  // static const String baseDomainNewLocal = "http://192.168.10.176:666";
  static const String baseUrlIran = "https://api.3soot.ir";
  static const String baseUrlIranNew = "https://api1.3soot.ir";
}

String packageName = 'waiter';
