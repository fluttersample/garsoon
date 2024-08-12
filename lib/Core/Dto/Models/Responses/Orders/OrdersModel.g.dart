// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OrdersModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrdersModel _$OrdersModelFromJson(Map<String, dynamic> json) => OrdersModel(
      ApprovedShopDateTime: json['ApprovedShopDateTime'] == null
          ? null
          : DateTime.parse(json['ApprovedShopDateTime'] as String),
      ArrivalDeliverDateTime: json['ArrivalDeliverDateTime'] == null
          ? null
          : DateTime.parse(json['ArrivalDeliverDateTime'] as String),
      CityName: json['CityName'] as String?,
      CreateDateTime: json['CreateDateTime'] == null
          ? null
          : DateTime.parse(json['CreateDateTime'] as String),
      CustomerDistanceInfo: json['CustomerDistanceInfo'] as String?,
      Count: json['Count'] as int?,
      IsPaid: json['IsPaid'] as bool?,
      CustomerFirstName: json['CustomerFirstName'] as String?,
      CustomerLastName: json['CustomerLastName'] as String?,
      DeliverManToArriveDate: json['DeliverManToArriveDate'] == null
          ? null
          : DateTime.parse(json['DeliverManToArriveDate'] as String),
      DeliverManToArriveTime: json['DeliverManToArriveTime'] as String?,
      Description: json['Description'] as String?,
      OrderId: json['OrderId'] as String?,
      StateDetails: json['StateDetails'] as String?,
      TotalCount: json['TotalCount'] as int?,
      TableCode: json['TableCode'] as String?,
      Status: json['Status'] as int?,
      CreatedAt: json['CreatedAt'] as String?,
      TotalAmount: json['TotalAmount'] as int?,
      IsStatus: json['IsStatus'] as int?,
      RequestedDate: json['RequestedDate'] == null
          ? null
          : DateTime.parse(json['RequestedDate'] as String),
      CustomerInfo: json['CustomerInfo'] as String?,
      RequestedDateFa: json['RequestedDateFa'] as String?,
      RequestedTime: json['RequestedTime'] as String?,
      TrackingCode: json['TrackingCode'] as String?,
      IsHomeFood: json['IsHomeFood'] as bool?,
      IsNow: json['IsNow'] as bool?,
      DeliveryServiceStatus: json['DeliveryServiceStatus'] as String?,
      DeliveryService: json['DeliveryService'] == null
          ? null
          : DeliveryServiceOfOrderModel.fromJson(
              json['DeliveryService'] as Map<String, dynamic>),
      DeliverManMoney: json['DeliverManMoney'] as int?,
    );

Map<String, dynamic> _$OrdersModelToJson(OrdersModel instance) =>
    <String, dynamic>{
      'ApprovedShopDateTime': instance.ApprovedShopDateTime?.toIso8601String(),
      'ArrivalDeliverDateTime':
          instance.ArrivalDeliverDateTime?.toIso8601String(),
      'CityName': instance.CityName,
      'CreateDateTime': instance.CreateDateTime?.toIso8601String(),
      'Count': instance.Count,
      'CustomerFirstName': instance.CustomerFirstName,
      'CustomerLastName': instance.CustomerLastName,
      'DeliverManToArriveDate':
          instance.DeliverManToArriveDate?.toIso8601String(),
      'DeliverManToArriveTime': instance.DeliverManToArriveTime,
      'Description': instance.Description,
      'CustomerInfo': instance.CustomerInfo,
      'OrderId': instance.OrderId,
      'StateDetails': instance.StateDetails,
      'TableCode': instance.TableCode,
      'CreatedAt': instance.CreatedAt,
      'IsPaid': instance.IsPaid,
      'CustomerDistanceInfo': instance.CustomerDistanceInfo,
      'Status': instance.Status,
      'TotalAmount': instance.TotalAmount,
      'TotalCount': instance.TotalCount,
      'IsStatus': instance.IsStatus,
      'RequestedDate': instance.RequestedDate?.toIso8601String(),
      'RequestedDateFa': instance.RequestedDateFa,
      'RequestedTime': instance.RequestedTime,
      'DeliveryServiceStatus': instance.DeliveryServiceStatus,
      'TrackingCode': instance.TrackingCode,
      'IsHomeFood': instance.IsHomeFood,
      'IsNow': instance.IsNow,
      'DeliveryService': instance.DeliveryService,
      'DeliverManMoney': instance.DeliverManMoney,
    };

VMProductDesignOrderSend _$VMProductDesignOrderSendFromJson(
        Map<String, dynamic> json) =>
    VMProductDesignOrderSend(
      Quantity: json['Quantity'] as int?,
      ProductChoiceId: json['ProductChoiceId'] as String?,
    );

Map<String, dynamic> _$VMProductDesignOrderSendToJson(
        VMProductDesignOrderSend instance) =>
    <String, dynamic>{
      'Quantity': instance.Quantity,
      'ProductChoiceId': instance.ProductChoiceId,
    };

VMHiveOrder _$VMHiveOrderFromJson(Map<String, dynamic> json) => VMHiveOrder(
      Orders: (json['Orders'] as List<dynamic>?)
          ?.map((e) => OrdersModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      OrderType: json['OrderType'] as String?,
    );

Map<String, dynamic> _$VMHiveOrderToJson(VMHiveOrder instance) =>
    <String, dynamic>{
      'Orders': instance.Orders,
      'OrderType': instance.OrderType,
    };

DeliveryServiceOfOrderModel _$DeliveryServiceOfOrderModelFromJson(
        Map<String, dynamic> json) =>
    DeliveryServiceOfOrderModel(
      Title: json['Title'] as String?,
      DeliveryTypeId: json['DeliveryTypeId'] as String?,
      DeliveryType: json['DeliveryType'] as int?,
    );

Map<String, dynamic> _$DeliveryServiceOfOrderModelToJson(
        DeliveryServiceOfOrderModel instance) =>
    <String, dynamic>{
      'Title': instance.Title,
      'DeliveryTypeId': instance.DeliveryTypeId,
      'DeliveryType': instance.DeliveryType,
    };
