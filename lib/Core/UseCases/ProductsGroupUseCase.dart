
import 'package:dartz/dartz.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'package:waiter/Core/Helper/Failure.dart';
import 'package:waiter/Core/Interfaces/Repositories/WaiterRepository.dart';
import 'package:waiter/Core/Interfaces/UseCases/IUseCase.dart';
import 'package:waiter/Core/Interfaces/UseCasesExport.dart';


class ProductsGroupUseCase extends IProductsGroupUseCase
{

  final WaiterRepository waiterRepository;
  ProductsGroupUseCase({required this.waiterRepository});

  @override
  Future<Either<Failure, List<ProductsGroupModel>>> handler({NoParams? params})async {
    return await waiterRepository.productsGroup()!;

  }

}