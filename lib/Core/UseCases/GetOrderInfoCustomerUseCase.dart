


import 'package:dartz/dartz.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'package:waiter/Core/Helper/Failure.dart';
import 'package:waiter/Core/Interfaces/Repositories/WaiterRepository.dart';
import 'package:waiter/Core/Interfaces/UseCasesExport.dart';


class GetOrderInfoCustomerUseCase extends IGetOrderInfoCustomerUseCase
{

  final WaiterRepository waiterRepository;
  GetOrderInfoCustomerUseCase({required this.waiterRepository});

  @override
  Future<Either<Failure, VMOrderInfo>> handler({GetOrderInfoRequestModel? params}) async{
    return await waiterRepository.getOrderInfoCustomer(getOrderInfoRequestModel: params!)!;
  }


}