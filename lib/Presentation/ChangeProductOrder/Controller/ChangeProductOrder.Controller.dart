import 'package:get/get.dart';
import 'package:waiter/Core/Dto/Enums/StorageKey.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'package:waiter/Core/Helper/ArgName.dart';
import 'package:waiter/Core/Helper/Globals/GlobalFunc.dart';
import 'package:waiter/Core/Helper/Storage/LocalData.dart';
import 'package:waiter/Core/Helper/WaiterBasket.dart';
import 'package:waiter/Core/Interfaces/UseCasesExport.dart';

class ChangeProductOrderController extends GetxController {
  // late final String orderId ;




  final IGetProductsUseCase _iGetProductsUseCase;
  final IProductsGroupUseCase _iProductsGroupUseCase;

  ChangeProductOrderController(
      {required IGetProductsUseCase iGetProductsUseCase,
      required IProductsGroupUseCase iProductsGroupUseCase})
      : _iProductsGroupUseCase = iProductsGroupUseCase,
        _iGetProductsUseCase = iGetProductsUseCase;


  late List<ProductsModel> tempListProduct = [];
   String trackingCode ='';

  @override
  void onInit() {
    super.onInit();
    GlobalFunc.checkArgument<List<ProductsModel>>(
        argName: ArgName.tempListProductOrder,
        result: (value) {
          tempListProduct = value;
        });
    GlobalFunc.checkArgument<String>(
        argName: ArgName.trackingCode,
        result: (value) {
          trackingCode = value;
        });
  }

  @override
  void onReady() {
    super.onReady();
    _initCheckDataAndCallApi();
  }

  /// variables
  // booleans
  bool isLoading = true;

  // strings
  String productSchemaId = '';

  // obx
  final showIconSuffix = false.obs;
  final currentSlider = 0.obs;

  // models

  List<ProductsModel> constListProducts = [];
  final listProducts = <ProductsModel>[].obs;

  List<ProductsGroupModel> listGroups = [];
  final selectedGroup = ProductsGroupModel().obs;

  // obx
  final showGroupPanel = false.obs;
  final isLoadingGroup = true.obs;

  /// Methods \\\
  Future<void> _initCheckDataAndCallApi() async {
    LocalData.checkTimeCallApi();
    if (!LocalData.checkDataInLocal(StorageKey.productList)) {
      startApiGetProducts();
    } else {
      listProducts.value = LocalData.getProductList;
      constListProducts = LocalData.getProductList;
      isLoading = false;
      checkCallBak();
      update();
    }
    if (!LocalData.checkDataInLocal(StorageKey.productGroupList)) {
      startApiGroups();
    } else {
      listGroups = LocalData.getProductGroupList;
      isLoadingGroup.value = false;
    }
  }

  void checkCallBak() {
    for (var element in listProducts) {
      if (element.SchemaId != null) {
        if (existInList(element) == true) {
          element.IsAddToCart?.value = true;
          element.Count?.value = getInCart(element)!.Count!.value ;
        } else {
          element.IsAddToCart?.value = false;
          element.Count?.value = 0;
        }
      }
    }
  }

  bool existInList(ProductsModel? productChoice) {
    for (var item in tempListProduct) {
      if (item.SchemaId!.toLowerCase() ==
          productChoice!.SchemaId!.toLowerCase()) {
        return true;
      }
    }
    return false;
  }

  ProductsModel? getInCart(ProductsModel? productChoice) {
    for (var item in tempListProduct) {
      if (item.SchemaId!.toLowerCase() ==
          productChoice!.SchemaId!.toLowerCase()) {
        return item;
      }
    }
    return null;
  }


  /// Apis ///

  void startApiGetProducts() async {
    await _iGetProductsUseCase.handler().then((value) {
      isLoading = false;
      value.fold((l) {}, (result) async{
        listProducts.value = result;
        constListProducts = result;

       await LocalData.setProduct(listProducts);
       await LocalData.setDateTimeCallApi();

      });
    }).catchError((e) {
      isLoading = false;
    });
    WaiterBasket.checkCallBak(listProducts);

    update();
  }

  void startApiGroups() async {
    await _iProductsGroupUseCase.handler().then((value) {
      isLoadingGroup.value = false;
      value.fold((l) {}, (result) {
        listGroups = result;
        LocalData.setProductGroups(listGroups);
      });
    }).catchError((e) {
      isLoadingGroup.value = false;
    });
  }

  void selectCategory({required ProductsGroupModel item}) {
    print("Group Id ${item.GroupId}");
    if (selectedGroup.value.GroupId == item.GroupId) {
      selectedGroup.value = ProductsGroupModel();
      listProducts.value = constListProducts;
      checkCallBak();
      return;
    }
    selectedGroup.value = item;
    final result = constListProducts
        .where((element) =>
            element.GroupId?.toLowerCase() == item.GroupId?.toLowerCase())
        .toList();
    listProducts.value = result;
    checkCallBak();

  }
}
