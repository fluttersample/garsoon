


import 'package:dartz/dartz.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'package:waiter/Core/Helper/Failure.dart';
import 'package:waiter/Core/Interfaces/Repositories/WaiterRepository.dart';
import 'package:waiter/Core/Interfaces/UseCasesExport.dart';


class LoginCustomerUseCase extends ILoginCustomerUseCase
{

  final WaiterRepository waiterRepository;
  LoginCustomerUseCase({required this.waiterRepository});

  @override
  Future<Either<Failure, LoginResponseDto>> handler({LoginCustomerRequestModel? params})async {
    return await waiterRepository.loginCustomer(loginRequestModel: params!)!;
  }



}