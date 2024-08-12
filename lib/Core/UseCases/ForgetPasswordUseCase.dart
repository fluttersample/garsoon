


import 'package:dartz/dartz.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'package:waiter/Core/Helper/Failure.dart';
import 'package:waiter/Core/Interfaces/Repositories/WaiterRepository.dart';
import 'package:waiter/Core/Interfaces/UseCasesExport.dart';



class ForgetPasswordUseCase extends IForgetPasswordUseCase
{

  final WaiterRepository waiterRepository;
  ForgetPasswordUseCase({required this.waiterRepository});

  @override
  Future<Either<Failure, VMAPIBase>> handler({LoginRequestModel? params}) async{
    return await waiterRepository.forgetPassword(loginRequestModel: params!)!;

  }

}