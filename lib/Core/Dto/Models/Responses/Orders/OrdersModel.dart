import 'package:json_annotation/json_annotation.dart';

part 'OrdersModel.g.dart';

@JsonSerializable()
class OrdersModel {
  DateTime? ApprovedShopDateTime;
  DateTime? ArrivalDeliverDateTime;
  String? CityName;
  DateTime? CreateDateTime;
  int? Count;
  String? CustomerFirstName;
  String? CustomerLastName;
  DateTime? DeliverManToArriveDate;
  String? DeliverManToArriveTime;
  String? Description;
  String? CustomerInfo;
  String? OrderId;
  String? StateDetails;
  String? TableCode;
  String? CreatedAt;
  String? CustomerDistanceInfo;
  int? Status;
  int? TotalAmount;
  int? TotalCount;
  int? IsStatus;
  DateTime? RequestedDate;
  String? RequestedDateFa;
  String? RequestedTime;
  String? DeliveryServiceStatus;
  String? TrackingCode;
  bool? IsHomeFood;
  bool? IsNow;
  bool? IsPaid;
  DeliveryServiceOfOrderModel? DeliveryService;
  int? DeliverManMoney;


  OrdersModel({
    this.ApprovedShopDateTime,
    this.ArrivalDeliverDateTime,
    this.CityName,
    this.CreateDateTime,
    this.CustomerDistanceInfo,
    this.Count,
    this.CustomerFirstName,
    this.CustomerLastName,
    this.DeliverManToArriveDate,
    this.DeliverManToArriveTime,
    this.Description,
    this.OrderId,
    this.StateDetails,
    this.TotalCount,
    this.TableCode,
    this.Status,
    this.CreatedAt,
    this.TotalAmount,
    this.IsStatus,
    this.RequestedDate,
    this.CustomerInfo,
    this.RequestedDateFa,
    this.RequestedTime,
    this.TrackingCode,
    this.IsHomeFood,
    this.IsNow,
    this.DeliveryServiceStatus,
    this.DeliveryService,
    this.DeliverManMoney,
    this.IsPaid,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) => _$OrdersModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrdersModelToJson(this);
}

@JsonSerializable()
class VMProductDesignOrderSend {
  int? Quantity;
  String? ProductChoiceId;

  VMProductDesignOrderSend({this.Quantity, this.ProductChoiceId});

  factory VMProductDesignOrderSend.fromJson(Map<String, dynamic> json) => _$VMProductDesignOrderSendFromJson(json);

  Map<String, dynamic> toJson() => _$VMProductDesignOrderSendToJson(this);
}

@JsonSerializable()
class VMHiveOrder {
  List<OrdersModel>? Orders;
  String? OrderType;

  VMHiveOrder({this.Orders, this.OrderType});

  factory VMHiveOrder.fromJson(Map<String, dynamic> json) => _$VMHiveOrderFromJson(json);

  Map<String, dynamic> toJson() => _$VMHiveOrderToJson(this);
}


@JsonSerializable()
class DeliveryServiceOfOrderModel {
  String? Title;
  String? DeliveryTypeId;
  int? DeliveryType;

  DeliveryServiceOfOrderModel({this.Title, this.DeliveryTypeId,this.DeliveryType});

  factory DeliveryServiceOfOrderModel.fromJson(Map<String, dynamic> json) => _$DeliveryServiceOfOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryServiceOfOrderModelToJson(this);
}

enum OrderStatusStringType {
  STATUS_NEW, //0 مشتری سفارش داده
  STATUS_WAITING_FOR_ONLINE_PAYMENT, //1 در انتظار پرداخت آنلاین
  STATUS_CONFIRMED_BY_SHOP, //53 تایید شده توسط فروشگاه
  STATUS_SEEN_BY_SHOP, //52 مشاهده شده توسط فروشگاه
  STATUS_EDITED, //-54 ویرایش شده توسط فروشگاه
  STATUS_DELIVERMAN_QUEUE, //22 صف پیک
  STATUS_ON_WAY, //21 در مسیر
  STATUS_ORDER_DEDUCTION_BY_DELIVERMAN, //-21 کسر در سفارش توسط پیک
  STATUS_DELIVERED_TO_CUSTOMER, //9 مشتری تحویل گرفت
  STATUS_CUSTOMER_COMMENTED, //10 مشتری رای و نظر داد
  STATUS_LOCKED, //23 قفل شده
  STATUS_DELIVERMAN_ARRIVED_TO_SHOP, //25 پیک به فروشگاه رسید
  STATUS_DELIVERED_TO_DELIVERMAN, //24 تحویل شده به پیک
  STATUS_CANCELED_BY_CUSTOMER, //-1 لغو توسط مشتری
  STATUS_CANCELED_BY_SYSTEM, //-2 لغو توسط سیستم
  STATUS_CANCELED_BY_SUPPORT, //-41 لغو شده توسط پشتیبانی
  STATUS_CANCELED_BY_SUPPORT_, //-42 لغو شده توسط پشتیبانی
  STATUS_CANCELED_BY_SHOP, // -53 لغو شده توسط فروشگاه
  STATUS_CANCELED_BY_SHOP_AFTER_CONFIRMATION, //-55 لغو شده توسط فروشگاه، بعد از تایید
  STATUS_CANCELED_BY_DELIVERMAN, //-22 لغو شده توسط پیک
}
