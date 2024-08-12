


import 'package:dartz/dartz.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'package:waiter/Core/Helper/Failure.dart';
import 'package:waiter/Core/Interfaces/Repositories/WaiterRepository.dart';
import 'package:waiter/Core/Interfaces/UseCasesExport.dart';


class GetOrderInfoUseCase extends IGetOrderInfoUseCase
{

  final WaiterRepository waiterRepository;
  GetOrderInfoUseCase({required this.waiterRepository});

  @override
  Future<Either<Failure, VMOrderInfo>> handler({GetOrderInfoRequestModel? params}) async{
    return await waiterRepository.getOrderInfo(getOrderInfoRequestModel: params!)!;
  }


}