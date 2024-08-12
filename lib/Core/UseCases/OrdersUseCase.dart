


import 'package:dartz/dartz.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'package:waiter/Core/Helper/Failure.dart';
import 'package:waiter/Core/Interfaces/Repositories/WaiterRepository.dart';
import 'package:waiter/Core/Interfaces/UseCases/ILoginUseCase.dart';
import 'package:waiter/Core/Interfaces/UseCases/IOrdersUseCase.dart';


class OrdersUseCase extends IOrdersUseCase
{

  final WaiterRepository waiterRepository;
  OrdersUseCase({required this.waiterRepository});

  @override
  Future<Either<Failure, List<OrdersModel>>> handler({OrdersRequestModel? params}) async{
    return await  waiterRepository.getOrders(ordersRequestModel:  params!)!;

  }

}