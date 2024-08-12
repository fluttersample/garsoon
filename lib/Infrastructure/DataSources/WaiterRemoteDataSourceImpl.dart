
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'package:waiter/Core/Helper/API.dart';
import 'package:waiter/Core/Helper/BaseBrain.dart';
import 'package:waiter/Core/Interfaces/DataResources/WaiterRemoteDataSource.dart';

class WaiterRemoteDataSourceImpl implements WaiterRemoteDataSource {
  @override
  Future getCartSlim() {
    throw UnimplementedError();
  }

  @override
  Future<VMToken> login({required LoginRequestModel loginRequestModel}) async{
    var result = await BaseBrain.dio.post('${BaseBrain.baseDomain}${API.LOGIN}',
    data: loginRequestModel.toJson()
    ).then((response) {
      final vmAccount = VMToken.fromJson(response.data['Data']);
      return vmAccount;
    });

    return result;
  }

  @override
  Future<VMAPIBase> forgetPassword({required LoginRequestModel loginRequestModel})async {
    var result = await BaseBrain.dio.post('${BaseBrain.baseDomain}${API.FORGET_PASSWORD}',
        data: {'UserName' : loginRequestModel.userName}
    ).then((response) {
      final vmBase = VMAPIBase.fromJson(response.data);
      return vmBase;
    });

    return result;
  }

  @override
  Future<CodeConfirmModel> confirm({required LoginRequestModel loginRequestModel})async {
    var result = await BaseBrain.dio.post('${BaseBrain.baseDomain}${API.CONFIRM}',
        data: {"UserName": loginRequestModel.userName, "Code": loginRequestModel.code}
    ).then((response) {
      final vmConfirm = CodeConfirmModel.fromJson(response.data['Data']);
      return vmConfirm;
    });

    return result;
  }

  @override
  Future<VMToken> changePassword({required LoginRequestModel loginRequestModel}) async{
    var result = await BaseBrain.dio.post('${BaseBrain.baseDomain}${API.CHANGE_PASSWORD}',
        data: {"UserName": loginRequestModel.userName, "Password": loginRequestModel.password, "ResetPasswordToken":
        loginRequestModel.resetPasswordToken}
    ).then((response) {
      final vmConfirm = VMToken.fromJson(response.data['Data']);
      return vmConfirm;
    });

    return result;
  }
  @override
  Future<List<SelectShopModel>> getShops() async{
    var result = await BaseBrain.dio.get('${BaseBrain.baseDomain}${API.GetShops}',
    ).then((response) {
      List<SelectShopModel> myList = [];
      for (var element in (response.data['Data'] as List<dynamic>)) {
        myList.add(SelectShopModel.fromJson(element));
      }
      return myList;
    });

    return result;
  }

  @override
  Future<List<OrdersModel>> getOrders({required OrdersRequestModel ordersRequestModel})async {
    var result = await BaseBrain.dio.get('${BaseBrain.baseDomainNew}${API.ORDERS}',
        queryParameters:  ordersRequestModel.toJson(),
    ).then((response) {
      List<OrdersModel> myList = [];

      for (var element in (response.data['Content']['Orders'] as List<dynamic>)) {
        myList.add(OrdersModel.fromJson(element));
      }
      return myList;
    });

    return result;
  }

  @override
  Future<List<TablesModel>> tableCustomer() async{
    var result = await BaseBrain.dio.get('${BaseBrain.baseDomainNew}${API.Tables}',
    ).then((response) {
      List<TablesModel> myList = [];

      for (var element in (response.data['Content']['Tables'] as List<dynamic>)) {
        myList.add(TablesModel.fromJson(element));
      }
      return myList;
    });

    return result;
  }

  @override
  Future<List<ProductsModel>> getProducts()async {
    var result = await BaseBrain.dio.get('${BaseBrain.baseDomainNew}${API.ProductList}',
    ).then((response) {
      List<ProductsModel> myList = [];

      for (var element in (response.data['Content']['Orders'] as List<dynamic>)) {
        myList.add(ProductsModel.fromJson(element));
      }
      return myList;
    });

    return result;
  }

  @override
  Future<List<ProductsGroupModel>> productsGroup() async{
    var result = await BaseBrain.dio.get('${BaseBrain.baseDomainNew}${API.ProductsGroup}',
    ).then((response) {
      List<ProductsGroupModel> myList = [];

      for (var element in (response.data['Content']['Orders'] as List<dynamic>)) {
        myList.add(ProductsGroupModel.fromJson(element));
      }
      return myList;
    });

    return result;
  }

  @override
  Future<ProductsModel> singleProduct({required SingleProductRequestModel singleProductRequestModel}) async{
    var result = await BaseBrain.dio.get('${BaseBrain.baseDomainNew}${API.SingleProduct}',
      queryParameters: singleProductRequestModel.toJson()
    ).then((response) {
      final result = ProductsModel.fromJson((response.data['Content']));
      return result;
    });

    return result;
  }

  @override
  Future<LoginResponseDto> loginCustomer({required LoginCustomerRequestModel loginCustomerRequestModel}) async{
    var result = await BaseBrain.dio.post('${BaseBrain.baseDomainNew}${API.LoginCustomer}',
        data: loginCustomerRequestModel.toJson()
    ).then((response) {
      final result = LoginResponseDto.fromJson((response.data['Content']));
      return result;
    });

    return result;
  }

  @override
  Future<RegisterPhoneNumberDtoUseCase> registerCustomer({required LoginCustomerRequestModel loginCustomerRequestModel})async {
    var result = await BaseBrain.dio.post('${BaseBrain.baseDomainNew}${API.RegisterPhoneNumberCustomer}',
      data: loginCustomerRequestModel.toJson()
    ).then((response) {
      final result = RegisterPhoneNumberDtoUseCase.fromJson((response.data));
      return result;
    });

    return result;
  }

  @override
  Future<LoginResponseDto> signUpCustomer({required LoginCustomerRequestModel loginCustomerRequestModel})async {
    var result = await BaseBrain.dio.post('${BaseBrain.baseDomainNew}${API.SignUpCustomer}',
        data: loginCustomerRequestModel.toJson()
    ).then((response) {
      const result = LoginResponseDto();
      return result;
    });
    return result;
  }

  @override
  Future<VMAPIBase> insertOrder({required InsertOrderRequestModel insertOrderRequestModel})async {
    var result = await BaseBrain.dio.post('${BaseBrain.baseDomainNew}${API.InsertOrder}',
        data: insertOrderRequestModel.toJson()
    ).then((response) {
      final result = VMAPIBase(SingleData: response.data['Content']['TrackingCode']);
      return result;
    });
    return result;
  }

  @override
  Future<VMOrderInfo> getOrderInfo({required GetOrderInfoRequestModel getOrderInfoRequestModel}) async{
    var result = await BaseBrain.dio.get('${BaseBrain.baseDomain}${API.GetOrderInfo}',
        queryParameters: getOrderInfoRequestModel.toJson()
    ).then((response) {
      final result = VMOrderInfo.fromJson((response.data['Data']));
      return result;
    });
    return result;
  }

  @override
  Future<VMAPIBase> editOrder({required InsertOrderRequestModel insertOrderRequestModel})async {
    var result = await BaseBrain.dio.post('${BaseBrain.baseDomainNew}${API.EditOrder}',
        queryParameters: {'OrderId' : insertOrderRequestModel.OrderId},
      data: insertOrderRequestModel.toJson()
    ).then((response) {
      final result = VMAPIBase.fromJson(response.data);
      return result;
    });
    return result;
  }

  @override
  Future<VMAPIBase> cancelOrder({required InsertOrderRequestModel insertOrderRequestModel}) async{
    var result = await BaseBrain.dio.post('${BaseBrain.baseDomainNew}${API.CancelOrder}',
        data: {'OrderId' : insertOrderRequestModel.OrderId},
    ).then((response) {
      final result = VMAPIBase.fromJson(response.data);
      return result;
    });
    return result;
  }

  @override
  Future<VMOrderInfo> getOrderInfoCustomer({required GetOrderInfoRequestModel getOrderInfoRequestModel})async {
    var result = await BaseBrain.dio.get('${BaseBrain.baseDomainNew}${API.GetOrderInfoCustomer}',
      queryParameters: {'OrderId' : getOrderInfoRequestModel.OrderId},
    ).then((response) {
      final result = VMOrderInfo.fromJson(response.data['Content']);
      return result;
    });
    return result;
  }

  @override
  Future<CheckPaymentModel> checkPayment({required CheckPaymentRequestModel checkPaymentRequestModel}) async{
    var result = await BaseBrain.dio.post('${BaseBrain.baseDomainNew}${API.VerificationPayment}',
      // queryParameters: checkPaymentRequestModel.toJson(),
      data: {'orderId' : checkPaymentRequestModel.orderId},
      // queryParameters: {'orderId' : checkPaymentRequestModel.orderId},
    ).then((response) {
      final result = CheckPaymentModel.fromJson(response.data);
      return result;
    });
    return result;
  }




}




