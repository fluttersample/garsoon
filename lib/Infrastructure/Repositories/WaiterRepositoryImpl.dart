import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'package:waiter/Core/Helper/Failure.dart';
import 'package:waiter/Core/Interfaces/DataResources/WaiterRemoteDataSource.dart';
import 'package:waiter/Core/Interfaces/Repositories/WaiterRepository.dart';


class WaiterRepositoryImpl implements WaiterRepository {
  final WaiterRemoteDataSource waiterRepositoryImpl;

  WaiterRepositoryImpl({required this.waiterRepositoryImpl});






  @override
  Future<Either<Failure, List<ProductsModel>>>? getCartSlim() {
  }

  @override
  Future<Either<Failure, VMToken>> login({required LoginRequestModel loginRequestModel}) async{
    try {
      final result = await waiterRepositoryImpl.login(loginRequestModel: loginRequestModel);
      return Right(result);
    } catch (e) {
      return  Left(ServerFailure(error:  e is DioException? e : null));
    }
  }

  @override
  Future<Either<Failure, VMAPIBase>>? forgetPassword({required LoginRequestModel loginRequestModel})async {
    try {
      final result = await waiterRepositoryImpl.forgetPassword(loginRequestModel: loginRequestModel);
      return Right(result);
    } catch (e) {
      return  Left(ServerFailure(error:  e is DioException? e : null));
    }
  }

  @override
  Future<Either<Failure, CodeConfirmModel>>? confirm({required LoginRequestModel loginRequestModel})async {
    try {
      final result = await waiterRepositoryImpl.confirm(loginRequestModel: loginRequestModel);
      return Right(result);
    } catch (e) {
      return  Left(ServerFailure(error:  e is DioException? e : null));
    }
  }

  @override
  Future<Either<Failure, VMToken>>? changePassword({required LoginRequestModel loginRequestModel}) async{
    try {
      final result = await waiterRepositoryImpl.changePassword(loginRequestModel: loginRequestModel);
      return Right(result);
    } catch (e) {
      return  Left(ServerFailure(error:  e is DioException? e : null));
    }
  }

  @override
  Future<Either<Failure, List<OrdersModel>>>? getOrders({required OrdersRequestModel ordersRequestModel}) async{
    try {
      final result = await waiterRepositoryImpl.getOrders(ordersRequestModel:  ordersRequestModel);
      return Right(result);
    } catch (e) {
      return  Left(ServerFailure(error:  e is DioException? e : null));
    }
  }

  @override
  Future<Either<Failure, List<SelectShopModel>>>? getShops() async{
    try {
      final result = await waiterRepositoryImpl.getShops();
      return Right(result);
    } catch (e) {
      return  Left(ServerFailure(error:  e is DioException? e : null));
    }
  }

  @override
  Future<Either<Failure, List<TablesModel>>>? tableCustomer()async {
    try {
      final result = await waiterRepositoryImpl.tableCustomer();
      return Right(result);
    } catch (e) {
      return  Left(ServerFailure(error:  e is DioException? e : null));
    }
  }

  @override
  Future<Either<Failure, List<ProductsModel>>>? getProducts() async{
    try {
      final result = await waiterRepositoryImpl.getProducts();
      return Right(result);
    } catch (e) {
      return  Left(ServerFailure(error:  e is DioException? e : null));
    }
  }

  @override
  Future<Either<Failure, List<ProductsGroupModel>>>? productsGroup() async{
    try {
      final result = await waiterRepositoryImpl.productsGroup();
      return Right(result);
    } catch (e) {
      return  Left(ServerFailure(error:  e is DioException? e : null));
    }
  }

  @override
  Future<Either<Failure, ProductsModel>>? singleProduct({required SingleProductRequestModel singleProductRequestModel})async {
    try {
      final result = await waiterRepositoryImpl.singleProduct(singleProductRequestModel: singleProductRequestModel);
      return Right(result);
    } catch (e) {
      return  Left(ServerFailure(error:  e is DioException? e : null));
    }
  }

  @override
  Future<Either<Failure, LoginResponseDto>>? loginCustomer({required LoginCustomerRequestModel loginRequestModel})async {
    try {
      final result = await waiterRepositoryImpl.loginCustomer(loginCustomerRequestModel: loginRequestModel);
      return Right(result);
    } catch (e) {
      return  Left(ServerFailure(error:  e is DioException? e : null));
    }
  }

  @override
  Future<Either<Failure, RegisterPhoneNumberDtoUseCase>>? registerPhoneNumber({required LoginCustomerRequestModel loginRequestModel}) async{
    try {
      final result = await waiterRepositoryImpl.registerCustomer(loginCustomerRequestModel: loginRequestModel);
      return Right(result);
    } catch (e) {
      return  Left(ServerFailure(error:  e is DioException? e : null));
    }
  }

  @override
  Future<Either<Failure, LoginResponseDto>>? signUpCustomer({required LoginCustomerRequestModel loginRequestModel})async {
    try {
      final result = await waiterRepositoryImpl.signUpCustomer(loginCustomerRequestModel: loginRequestModel);
      return Right(result);
    } catch (e) {
      return  Left(ServerFailure(error:  e is DioException? e : null));
    }
  }

  @override
  Future<Either<Failure, VMAPIBase>>? insertOrder({required InsertOrderRequestModel insertOrderRequestModel})async {
    try {
      final result = await waiterRepositoryImpl.insertOrder(insertOrderRequestModel: insertOrderRequestModel);
      return Right(result);
    } catch (e) {
      return  Left(ServerFailure(error:  e is DioException? e : null));
    }
  }

  @override
  Future<Either<Failure, VMOrderInfo>>? getOrderInfo({required GetOrderInfoRequestModel getOrderInfoRequestModel})async {
    try {
      final result = await waiterRepositoryImpl.getOrderInfo(getOrderInfoRequestModel: getOrderInfoRequestModel);
      return Right(result);
    } catch (e) {
      return  Left(ServerFailure(error:  e is DioException? e : null));
    }
  }

  @override
  Future<Either<Failure, VMAPIBase>>? editOrder({required InsertOrderRequestModel insertOrderRequestModel})async {
    try {
      final result = await waiterRepositoryImpl.editOrder(insertOrderRequestModel: insertOrderRequestModel);
      return Right(result);
    } catch (e) {
      return  Left(ServerFailure(error:  e is DioException? e : null));
    }
  }

  @override
  Future<Either<Failure, VMAPIBase>>? cancelOrder({required InsertOrderRequestModel insertOrderRequestModel})async {
    try {
      final result = await waiterRepositoryImpl.cancelOrder(insertOrderRequestModel: insertOrderRequestModel);
      return Right(result);
    } catch (e) {
      return  Left(ServerFailure(error:  e is DioException? e : null));
    }
  }

  @override
  Future<Either<Failure, VMOrderInfo>>? getOrderInfoCustomer({required GetOrderInfoRequestModel getOrderInfoRequestModel})async {
    try {
      final result = await waiterRepositoryImpl.getOrderInfoCustomer(getOrderInfoRequestModel: getOrderInfoRequestModel);
      return Right(result);
    } catch (e) {
      return  Left(ServerFailure(error:  e is DioException? e : null));
    }
  }

  @override
  Future<Either<Failure, CheckPaymentModel>>? checkPayment({required CheckPaymentRequestModel checkPaymentRequestModel})async {
    try {
      final result = await waiterRepositoryImpl.checkPayment(checkPaymentRequestModel: checkPaymentRequestModel);
      return Right(result);
    } catch (e) {
      return  Left(ServerFailure(error:  e is DioException? e : null));
    }
  }


}
