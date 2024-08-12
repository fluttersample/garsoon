


import 'package:dartz/dartz.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'package:waiter/Core/Helper/Failure.dart';
import 'package:waiter/Core/Interfaces/Repositories/WaiterRepository.dart';
import 'package:waiter/Core/Interfaces/UseCasesExport.dart';



class ConfirmUseCase extends IConfirmUseCase
{

  final WaiterRepository waiterRepository;
  ConfirmUseCase({required this.waiterRepository});

  @override
  Future<Either<Failure, CodeConfirmModel>> handler({LoginRequestModel? params})async {
    return  await waiterRepository.confirm(loginRequestModel: params!)!;

  }

}