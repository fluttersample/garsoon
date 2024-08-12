


import 'package:dartz/dartz.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'package:waiter/Core/Helper/Failure.dart';
import 'package:waiter/Core/Interfaces/Repositories/WaiterRepository.dart';
import 'package:waiter/Core/Interfaces/UseCasesExport.dart';


class RegisterPhoneNumberUseCase extends IRegisterPhoneNumberUseCase
{

  final WaiterRepository waiterRepository;
  RegisterPhoneNumberUseCase({required this.waiterRepository});

  @override
  Future<Either<Failure, RegisterPhoneNumberDtoUseCase>> handler({LoginCustomerRequestModel? params})async {
    return await waiterRepository.registerPhoneNumber(loginRequestModel: params!)!;

  }





}