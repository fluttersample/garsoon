

import 'package:dartz/dartz.dart';
import 'package:waiter/Core/Dto/Models/Requests/LoginCustomerRequestModel.dart';
import 'package:waiter/Core/Dto/Models/Responses/LoginCustomer/LoginResponseDto.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'package:waiter/Core/Helper/Failure.dart';

abstract class WaiterRepository {


  Future<Either<Failure, List<ProductsModel>>>? getCartSlim();

  Future<Either<Failure, VMToken>>? login({required LoginRequestModel loginRequestModel});

  Future<Either<Failure, LoginResponseDto>>? loginCustomer({required LoginCustomerRequestModel loginRequestModel});

  Future<Either<Failure, LoginResponseDto>>? signUpCustomer({required LoginCustomerRequestModel loginRequestModel});

  Future<Either<Failure, RegisterPhoneNumberDtoUseCase>>? registerPhoneNumber({required LoginCustomerRequestModel loginRequestModel});

  Future<Either<Failure, VMAPIBase>>? forgetPassword({required LoginRequestModel loginRequestModel});

  Future<Either<Failure, CodeConfirmModel>>? confirm({required LoginRequestModel loginRequestModel});

  Future<Either<Failure, VMToken>>? changePassword({required LoginRequestModel loginRequestModel});

  Future<Either<Failure, List<OrdersModel>>>? getOrders({required OrdersRequestModel ordersRequestModel});

  Future<Either<Failure, List<SelectShopModel>>>? getShops();


  Future<Either<Failure, List<TablesModel>>>? tableCustomer();
  Future<Either<Failure, List<ProductsModel>>>? getProducts();

  Future<Either<Failure, List<ProductsGroupModel>>>? productsGroup();

  Future<Either<Failure, ProductsModel>>? singleProduct({required SingleProductRequestModel singleProductRequestModel});

  Future<Either<Failure, VMAPIBase>>? insertOrder({required InsertOrderRequestModel insertOrderRequestModel});

  Future<Either<Failure, VMOrderInfo>>? getOrderInfo({required GetOrderInfoRequestModel getOrderInfoRequestModel});

  Future<Either<Failure, VMAPIBase>>? editOrder({required InsertOrderRequestModel insertOrderRequestModel});

  Future<Either<Failure, VMAPIBase>>? cancelOrder({required InsertOrderRequestModel insertOrderRequestModel});

  Future<Either<Failure, VMOrderInfo>>? getOrderInfoCustomer({required GetOrderInfoRequestModel getOrderInfoRequestModel});

  Future<Either<Failure, CheckPaymentModel>>? checkPayment({required CheckPaymentRequestModel checkPaymentRequestModel});
}
