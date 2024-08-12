


import 'package:dartz/dartz.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'package:waiter/Core/Helper/Failure.dart';
import 'package:waiter/Core/Interfaces/Repositories/WaiterRepository.dart';
import 'package:waiter/Core/Interfaces/UseCasesExport.dart';



class ChangePasswordUseCase extends IChangePasswordUseCase
{

  final WaiterRepository waiterRepository;
  ChangePasswordUseCase({required this.waiterRepository});

  @override
  Future<Either<Failure, VMToken>> handler({LoginRequestModel? params}) async{
    return await waiterRepository.changePassword(loginRequestModel: params!)!;

  }

}