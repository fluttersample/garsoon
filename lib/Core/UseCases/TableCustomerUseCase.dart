


import 'package:dartz/dartz.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'package:waiter/Core/Helper/Failure.dart';
import 'package:waiter/Core/Interfaces/Repositories/WaiterRepository.dart';
import 'package:waiter/Core/Interfaces/UseCases/IUseCase.dart';
import 'package:waiter/Core/Interfaces/UseCasesExport.dart';



class TableCustomerUseCase extends ITableCustomerUseCase
{

  final WaiterRepository waiterRepository;
  TableCustomerUseCase({required this.waiterRepository});

  @override
  Future<Either<Failure, List<TablesModel>>> handler({NoParams? params}) async{
    return await waiterRepository.tableCustomer()!;

  }




}