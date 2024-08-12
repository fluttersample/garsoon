


import 'package:dartz/dartz.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'package:waiter/Core/Helper/Failure.dart';
import 'package:waiter/Core/Interfaces/Repositories/WaiterRepository.dart';
import 'package:waiter/Core/Interfaces/UseCases/ILoginUseCase.dart';


class LoginUseCase extends ILoginUseCase
{

  final WaiterRepository waiterRepository;
  LoginUseCase({required this.waiterRepository});

  @override
  Future<Either<Failure, VMToken>> handler({LoginRequestModel? params}) async{
    return  await waiterRepository.login(loginRequestModel: params!)!;

  }

}