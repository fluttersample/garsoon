import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:waiter/Core/Dto/Enums/OrderStepType.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';

part 'OrderInfoModel.g.dart';

@JsonSerializable()
class VMOrderInfo {
  bool? CanChangePaymentType;
  String? OrderId;
  String? TrackingCode;
  String? IsStatusString;
  String? IsPaymentTypeString;
  bool? CanCancel;
  bool? CanEdit;
  bool? IsPaid;
  bool? HasPhoneNumber;
  String? CalculateTimeFromServer;
  String? EstimateDateTime;
  String? RequestedDateTime;
  VMMoneyCalculation? MoneyCalculation;
  String? OrderStatus;
  int? ServiceType;
  int? Status;
  List<ProductsModel>? Products;
  List<VMCheckOrderList>? Records;
  CheckChangedOrderModel? CheckChangedOrder;
  String? ShopId;
  String? OrderCustomerDescription;
  String? ShopName;
  String? Logo;
  DeliveryServiceInfoOfOrderInfo? DeliveryServiceInfo;


  OrderStepType get StatusType {
    switch (OrderStatus) {
      case "IN_PROGRESS":
        return OrderStepType.PREPARING;
      case "ON_THE_WAY":
        return OrderStepType.DELIVERY;
      case "DELIVERED":
        return OrderStepType.DELIVERED;
      default:
        return OrderStepType.NONE;
    }
  }

  VMOrderInfo(
      {this.CanChangePaymentType,
      this.OrderId,
      this.TrackingCode,
      this.IsStatusString,
      this.IsPaymentTypeString,
      this.CanCancel,
      this.CanEdit,
      this.CalculateTimeFromServer,
      this.DeliveryServiceInfo,
      this.EstimateDateTime,
      this.RequestedDateTime,
      this.MoneyCalculation,
      this.OrderStatus,
      this.ServiceType,
      this.Products,
      this.IsPaid,
      this.ShopName,
      this.Logo,
      this.Records,
      this.Status,
      this.HasPhoneNumber,
      this.CheckChangedOrder,
        this.OrderCustomerDescription,
      this.ShopId});

  factory VMOrderInfo.fromJson(Map<String, dynamic> json) =>
      _$VMOrderInfoFromJson(json);

  Map<String, dynamic> toJson() => _$VMOrderInfoToJson(this);
}

@JsonSerializable()
class VMMoneyCalculation {
  int? TotalAmount;
  int? DeliverManMoney;
  int? YourBenefit;
  int? MustBePay;

  VMMoneyCalculation(
      {this.TotalAmount,
      this.DeliverManMoney,
      this.YourBenefit,
      this.MustBePay});

  factory VMMoneyCalculation.fromJson(Map<String, dynamic> json) =>
      _$VMMoneyCalculationFromJson(json);

  Map<String, dynamic> toJson() => _$VMMoneyCalculationToJson(this);
}

@JsonSerializable()
class DeliveryServiceInfoOfOrderInfo {
  ShopAddressOfDeliveryService? ShopAddress;
  String? ShopPhone;
  String? ShopName;
  String? Logo;
  DeliveryServiceInfoOfOrderInfo(
      {this.ShopPhone,
        this.ShopAddress,
        this.Logo,
        this.ShopName,
      });

  factory DeliveryServiceInfoOfOrderInfo.fromJson(Map<String, dynamic> json) =>
      _$DeliveryServiceInfoOfOrderInfoFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryServiceInfoOfOrderInfoToJson(this);
}
@JsonSerializable()
class ShopAddressOfDeliveryService {
  String? Address;
  double? Latitude;
  double? Longitude;
  ShopAddressOfDeliveryService(
      {
    this.Address,this.Latitude,this.Longitude,
      });

  factory ShopAddressOfDeliveryService.fromJson(Map<String, dynamic> json) =>
      _$ShopAddressOfDeliveryServiceFromJson(json);

  Map<String, dynamic> toJson() => _$ShopAddressOfDeliveryServiceToJson(this);
}




@JsonSerializable()
class CheckChangedOrderModel {
  String? Message;
  bool? IsChanged;
  bool? IsProductChanged;
  bool? TimeChanged;

  CheckChangedOrderModel({this.Message, this.IsChanged, this.IsProductChanged});

  factory CheckChangedOrderModel.fromJson(Map<String, dynamic> json) =>
      _$CheckChangedOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$CheckChangedOrderModelToJson(this);
}


@JsonSerializable()
class VMCheckOrderList extends Equatable {
  final int? FinalTotalPrice;
  final int? MaxPrice;
  final int? MinPrice;
  final int? OffPrice;
  final String? ShopId;
  final String? ShopName;
  final String? Logo;
  final List<ProductsModel>? ShopProducts;
  final  int? TotalAmount;
  final int? DeliverManMoney;
  final String? Message;
  final bool? Break;
  final bool? TimeChanged;
  final  String? Description;
  final  String? CustomerScore;


  const VMCheckOrderList(
      {this.FinalTotalPrice,
        this.MaxPrice,
        this.MinPrice,
        this.OffPrice,
        this.ShopId,
        this.Logo,
        this.ShopName,
        this.ShopProducts,
        this.TotalAmount,
        this.DeliverManMoney,
        this.Message,
        this.Break,
        this.TimeChanged,
        this.CustomerScore,
        this.Description});



  factory VMCheckOrderList.fromJson(Map<String, dynamic> json) =>
      _$VMCheckOrderListFromJson(json);

  Map<String, dynamic> toJson() => _$VMCheckOrderListToJson(this);

  @override
  List<Object?> get props => [];
}



class MoneyCalculateModel extends Equatable{

  final int? priceProducts ;
  final int? yourBenefit ;

  const MoneyCalculateModel({ this.priceProducts,  this.yourBenefit, });



  int get calMustBePay {
    return (priceProducts??0) - (yourBenefit??0);
  }

  @override
  List<Object?> get props => [
    priceProducts,
    yourBenefit,
  ];

}