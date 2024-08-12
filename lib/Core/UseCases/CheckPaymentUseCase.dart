


import 'package:dartz/dartz.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'package:waiter/Core/Helper/Failure.dart';
import 'package:waiter/Core/Interfaces/Repositories/WaiterRepository.dart';
import 'package:waiter/Core/Interfaces/UseCasesExport.dart';



class CheckPaymentUseCase extends ICheckPaymentUseCase
{

  final WaiterRepository waiterRepository;
  CheckPaymentUseCase({required this.waiterRepository});

  @override
  Future<Either<Failure, CheckPaymentModel>> handler({CheckPaymentRequestModel? params})async {
    return await waiterRepository.checkPayment(checkPaymentRequestModel: params!)!;
  }



}