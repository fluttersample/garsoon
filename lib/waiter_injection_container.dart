import 'package:get_it/get_it.dart';
import 'package:waiter/Core/Interfaces/DataResources/WaiterRemoteDataSource.dart';
import 'package:waiter/Core/Interfaces/Storage/StorageService.dart';
import 'package:waiter/Core/Interfaces/UseCasesExport.dart';
import 'package:waiter/Infrastructure/DataSources/WaiterRemoteDataSourceImpl.dart';
import 'package:waiter/Infrastructure/Repositories/WaiterRepositoryImpl.dart';
import 'Core/Helper/Storage/DatabaseHelper.dart';
import 'Core/Interfaces/Repositories/WaiterRepository.dart';


final sl = GetIt.instance;

Future<void> initSl () async {



  // Data Resources
  sl.registerLazySingleton<WaiterRemoteDataSource>(() => WaiterRemoteDataSourceImpl());

  //Repositories
  sl.registerLazySingleton<WaiterRepository>(() => WaiterRepositoryImpl(waiterRepositoryImpl: sl()));


  /// hive
  sl.registerLazySingleton<StorageService>(() => DatabaseHelper());



  // Use Cases
  /// Login
    sl.registerLazySingleton<ILoginUseCase>(() => LoginUseCase(waiterRepository: sl()));
    sl.registerLazySingleton<IForgetPasswordUseCase>(() => ForgetPasswordUseCase(waiterRepository: sl()));
    sl.registerLazySingleton<IConfirmUseCase>(() => ConfirmUseCase(waiterRepository: sl()));
    sl.registerLazySingleton<IChangePasswordUseCase>(() => ChangePasswordUseCase(waiterRepository: sl()));
    sl.registerLazySingleton<IOrdersUseCase>(() => OrdersUseCase(waiterRepository: sl()));
    sl.registerLazySingleton<IGetShopsUseCase>(() => GetShopsUseCase(waiterRepository: sl()));
    sl.registerLazySingleton<ITableCustomerUseCase>(() => TableCustomerUseCase(waiterRepository: sl()));
    sl.registerLazySingleton<IGetProductsUseCase>(() => GetProductsUseCase(waiterRepository: sl()));
    sl.registerLazySingleton<IProductsGroupUseCase>(() => ProductsGroupUseCase(waiterRepository: sl()));
    sl.registerLazySingleton<ISingleProductUseCase>(() => SingleProductUseCase(waiterRepository: sl()));
    /// orders
    sl.registerLazySingleton<IInsertOrderUseCase>(() => InsertOrderUseCase(waiterRepository: sl()));
    sl.registerLazySingleton<IGetOrderInfoUseCase>(() => GetOrderInfoUseCase(waiterRepository: sl()));
    sl.registerLazySingleton<IEditOrderUseCase>(() => EditOrderUseCase(waiterRepository: sl()));
    sl.registerLazySingleton<ICancelOrderUseCase>(() => CancelOrderUseCase(waiterRepository: sl()));
    sl.registerLazySingleton<IGetOrderInfoCustomerUseCase>(() => GetOrderInfoCustomerUseCase(waiterRepository: sl()));
    sl.registerLazySingleton<ICheckPaymentUseCase>(() => CheckPaymentUseCase(waiterRepository: sl()));


    /// customer
    sl.registerLazySingleton<ILoginCustomerUseCase>(() => LoginCustomerUseCase(waiterRepository: sl()));
    sl.registerLazySingleton<IRegisterPhoneNumberUseCase>(() => RegisterPhoneNumberUseCase(waiterRepository: sl()));
    sl.registerLazySingleton<ISignUpCustomerUseCase>(() => SignUpCustomerUseCase(waiterRepository: sl()));







  ///Global

  // Get.lazyPut<IRemoveNotifyMeUseCase>(() => RemoveNotifyMeUseCase(repository: sl()));
}