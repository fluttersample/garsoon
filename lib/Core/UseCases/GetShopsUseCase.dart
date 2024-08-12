


import 'package:dartz/dartz.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'package:waiter/Core/Helper/Failure.dart';
import 'package:waiter/Core/Interfaces/Repositories/WaiterRepository.dart';
import 'package:waiter/Core/Interfaces/UseCases/IGetShopsUseCase.dart';
import 'package:waiter/Core/Interfaces/UseCases/ILoginUseCase.dart';
import 'package:waiter/Core/Interfaces/UseCases/IOrdersUseCase.dart';
import 'package:waiter/Core/Interfaces/UseCases/IUseCase.dart';


class GetShopsUseCase extends IGetShopsUseCase
{

  final WaiterRepository waiterRepository;
  GetShopsUseCase({required this.waiterRepository});

  @override
  Future<Either<Failure, List<SelectShopModel>>> handler({NoParams? params}) async{
    return await waiterRepository.getShops()!;
  }



}