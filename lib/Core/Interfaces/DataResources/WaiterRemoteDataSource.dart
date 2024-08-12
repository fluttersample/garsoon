



import 'package:waiter/Core/Dto/Models/Requests/LoginCustomerRequestModel.dart';
import 'package:waiter/Core/Dto/Models/Responses/LoginCustomer/LoginResponseDto.dart';
import 'package:waiter/Core/Dto/Models/Responses/LoginCustomer/RegisterPhoneNumberDtoUseCase.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';

abstract class WaiterRemoteDataSource {

  Future<dynamic> getCartSlim();



  Future<VMToken> login({required LoginRequestModel loginRequestModel});

  Future<LoginResponseDto> loginCustomer(
      {required LoginCustomerRequestModel loginCustomerRequestModel});


  Future<RegisterPhoneNumberDtoUseCase> registerCustomer(
      {required LoginCustomerRequestModel loginCustomerRequestModel});

  Future<LoginResponseDto> signUpCustomer(
      {required LoginCustomerRequestModel loginCustomerRequestModel});

  Future<VMAPIBase> forgetPassword({required LoginRequestModel loginRequestModel});


  Future<CodeConfirmModel> confirm({required LoginRequestModel loginRequestModel});

  Future<VMToken> changePassword({required LoginRequestModel loginRequestModel});

  Future<List<OrdersModel>> getOrders({required OrdersRequestModel ordersRequestModel});

  Future<List<SelectShopModel>> getShops();

  Future<List<TablesModel>> tableCustomer();

  Future<List<ProductsModel>> getProducts();

  Future<List<ProductsGroupModel>> productsGroup();
  Future<ProductsModel> singleProduct({required SingleProductRequestModel singleProductRequestModel});

  Future<VMAPIBase> insertOrder({required InsertOrderRequestModel insertOrderRequestModel});

  Future<VMOrderInfo> getOrderInfo({required GetOrderInfoRequestModel getOrderInfoRequestModel});

  Future<VMAPIBase> editOrder({required InsertOrderRequestModel insertOrderRequestModel});

  Future<VMAPIBase> cancelOrder({required InsertOrderRequestModel insertOrderRequestModel});

  Future<VMOrderInfo> getOrderInfoCustomer({required GetOrderInfoRequestModel getOrderInfoRequestModel});

  Future<CheckPaymentModel> checkPayment({required CheckPaymentRequestModel checkPaymentRequestModel});


}