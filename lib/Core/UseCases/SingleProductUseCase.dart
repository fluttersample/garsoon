


import 'package:dartz/dartz.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'package:waiter/Core/Helper/Failure.dart';
import 'package:waiter/Core/Interfaces/Repositories/WaiterRepository.dart';
import 'package:waiter/Core/Interfaces/UseCasesExport.dart';


class SingleProductUseCase extends ISingleProductUseCase
{

  final WaiterRepository waiterRepository;
  SingleProductUseCase({required this.waiterRepository});

  @override
  Future<Either<Failure, ProductsModel>> handler({SingleProductRequestModel? params})async {
    return await waiterRepository.singleProduct(singleProductRequestModel: params!)!;

  }

}