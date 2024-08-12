


import 'package:dartz/dartz.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'package:waiter/Core/Helper/Failure.dart';
import 'package:waiter/Core/Interfaces/Repositories/WaiterRepository.dart';
import 'package:waiter/Core/Interfaces/UseCasesExport.dart';


class EditOrderUseCase extends IEditOrderUseCase
{

  final WaiterRepository waiterRepository;
  EditOrderUseCase({required this.waiterRepository});

  @override
  Future<Either<Failure, VMAPIBase>> handler({InsertOrderRequestModel? params}) async {
    return await waiterRepository.editOrder(insertOrderRequestModel: params!)!;

  }




}