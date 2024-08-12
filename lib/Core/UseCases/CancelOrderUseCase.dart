


import 'package:dartz/dartz.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'package:waiter/Core/Helper/Failure.dart';
import 'package:waiter/Core/Interfaces/Repositories/WaiterRepository.dart';
import 'package:waiter/Core/Interfaces/UseCasesExport.dart';


class CancelOrderUseCase extends ICancelOrderUseCase
{

  final WaiterRepository waiterRepository;
  CancelOrderUseCase({required this.waiterRepository});

  @override
  Future<Either<Failure, VMAPIBase>> handler({InsertOrderRequestModel? params}) async {
    return await waiterRepository.cancelOrder(insertOrderRequestModel: params!)!;

  }




}