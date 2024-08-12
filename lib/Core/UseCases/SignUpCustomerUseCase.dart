


import 'package:dartz/dartz.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'package:waiter/Core/Helper/Failure.dart';
import 'package:waiter/Core/Interfaces/Repositories/WaiterRepository.dart';
import 'package:waiter/Core/Interfaces/UseCasesExport.dart';


class SignUpCustomerUseCase extends ISignUpCustomerUseCase
{

  final WaiterRepository waiterRepository;
  SignUpCustomerUseCase({required this.waiterRepository});

  @override
  Future<Either<Failure, LoginResponseDto>> handler({LoginCustomerRequestModel? params})async {
    return await waiterRepository.signUpCustomer(loginRequestModel: params!)!;
  }



}