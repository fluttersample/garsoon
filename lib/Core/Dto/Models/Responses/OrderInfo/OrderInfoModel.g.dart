// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OrderInfoModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VMOrderInfo _$VMOrderInfoFromJson(Map<String, dynamic> json) => VMOrderInfo(
      CanChangePaymentType: json['CanChangePaymentType'] as bool?,
      OrderId: json['OrderId'] as String?,
      TrackingCode: json['TrackingCode'] as String?,
      IsStatusString: json['IsStatusString'] as String?,
      IsPaymentTypeString: json['IsPaymentTypeString'] as String?,
      CanCancel: json['CanCancel'] as bool?,
      IsPaid: json['IsPaid'] as bool?,
      HasPhoneNumber: json['HasPhoneNumber'] as bool?,
      CanEdit: json['CanEdit'] as bool?,
      CalculateTimeFromServer: json['CalculateTimeFromServer'] as String?,
      DeliveryServiceInfo: json['DeliveryServiceInfo'] == null
          ? null
          : DeliveryServiceInfoOfOrderInfo.fromJson(
              json['DeliveryServiceInfo'] as Map<String, dynamic>),
      EstimateDateTime: json['EstimateDateTime'] as String?,
      RequestedDateTime: json['RequestedDateTime'] as String?,
      MoneyCalculation: json['MoneyCalculation'] == null
          ? null
          : VMMoneyCalculation.fromJson(
              json['MoneyCalculation'] as Map<String, dynamic>),
      OrderStatus: json['OrderStatus'] as String?,
      ServiceType: json['ServiceType'] as int?,
      Status: json['Status'] as int?,
      Products: (json['Products'] as List<dynamic>?)
          ?.map((e) => ProductsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      ShopName: json['ShopName'] as String?,
      Logo: json['Logo'] as String?,
      Records: (json['Records'] as List<dynamic>?)
          ?.map((e) => VMCheckOrderList.fromJson(e as Map<String, dynamic>))
          .toList(),
      CheckChangedOrder: json['CheckChangedOrder'] == null
          ? null
          : CheckChangedOrderModel.fromJson(
              json['CheckChangedOrder'] as Map<String, dynamic>),
      OrderCustomerDescription: json['OrderCustomerDescription'] as String?,
      ShopId: json['ShopId'] as String?,
    );

Map<String, dynamic> _$VMOrderInfoToJson(VMOrderInfo instance) =>
    <String, dynamic>{
      'CanChangePaymentType': instance.CanChangePaymentType,
      'OrderId': instance.OrderId,
      'TrackingCode': instance.TrackingCode,
      'IsStatusString': instance.IsStatusString,
      'IsPaymentTypeString': instance.IsPaymentTypeString,
      'CanCancel': instance.CanCancel,
      'IsPaid': instance.IsPaid,
      'HasPhoneNumber': instance.CanCancel,
      'CanEdit': instance.CanEdit,
      'CalculateTimeFromServer': instance.CalculateTimeFromServer,
      'EstimateDateTime': instance.EstimateDateTime,
      'RequestedDateTime': instance.RequestedDateTime,
      'MoneyCalculation': instance.MoneyCalculation,
      'OrderStatus': instance.OrderStatus,
      'ServiceType': instance.ServiceType,
      'Products': instance.Products,
      'Records': instance.Records,
      'Status': instance.Status,
      'CheckChangedOrder': instance.CheckChangedOrder,
      'ShopId': instance.ShopId,
      'OrderCustomerDescription': instance.OrderCustomerDescription,
      'ShopName': instance.ShopName,
      'Logo': instance.Logo,
      'DeliveryServiceInfo': instance.DeliveryServiceInfo,
    };

VMMoneyCalculation _$VMMoneyCalculationFromJson(Map<String, dynamic> json) =>
    VMMoneyCalculation(
      TotalAmount: json['TotalAmount'] as int?,
      DeliverManMoney: json['DeliverManMoney'] as int?,
      YourBenefit: json['YourBenefit'] as int?,
      MustBePay: json['MustBePay'] as int?,
    );

Map<String, dynamic> _$VMMoneyCalculationToJson(VMMoneyCalculation instance) =>
    <String, dynamic>{
      'TotalAmount': instance.TotalAmount,
      'DeliverManMoney': instance.DeliverManMoney,
      'YourBenefit': instance.YourBenefit,
      'MustBePay': instance.MustBePay,
    };

DeliveryServiceInfoOfOrderInfo _$DeliveryServiceInfoOfOrderInfoFromJson(
        Map<String, dynamic> json) =>
    DeliveryServiceInfoOfOrderInfo(
      ShopPhone: json['ShopPhone'] as String?,
      ShopAddress: json['ShopAddress'] == null
          ? null
          : ShopAddressOfDeliveryService.fromJson(
              json['ShopAddress'] as Map<String, dynamic>),
      Logo: json['Logo'] as String?,
      ShopName: json['ShopName'] as String?,
    );

Map<String, dynamic> _$DeliveryServiceInfoOfOrderInfoToJson(
        DeliveryServiceInfoOfOrderInfo instance) =>
    <String, dynamic>{
      'ShopAddress': instance.ShopAddress,
      'ShopPhone': instance.ShopPhone,
      'ShopName': instance.ShopName,
      'Logo': instance.Logo,
    };

ShopAddressOfDeliveryService _$ShopAddressOfDeliveryServiceFromJson(
        Map<String, dynamic> json) =>
    ShopAddressOfDeliveryService(
      Address: json['Address'] as String?,
      Latitude: (json['Latitude'] as num?)?.toDouble(),
      Longitude: (json['Longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ShopAddressOfDeliveryServiceToJson(
        ShopAddressOfDeliveryService instance) =>
    <String, dynamic>{
      'Address': instance.Address,
      'Latitude': instance.Latitude,
      'Longitude': instance.Longitude,
    };

CheckChangedOrderModel _$CheckChangedOrderModelFromJson(
        Map<String, dynamic> json) =>
    CheckChangedOrderModel(
      Message: json['Message'] as String?,
      IsChanged: json['IsChanged'] as bool?,
      IsProductChanged: json['IsProductChanged'] as bool?,
    )..TimeChanged = json['TimeChanged'] as bool?;

Map<String, dynamic> _$CheckChangedOrderModelToJson(
        CheckChangedOrderModel instance) =>
    <String, dynamic>{
      'Message': instance.Message,
      'IsChanged': instance.IsChanged,
      'IsProductChanged': instance.IsProductChanged,
      'TimeChanged': instance.TimeChanged,
    };

VMCheckOrderList _$VMCheckOrderListFromJson(Map<String, dynamic> json) =>
    VMCheckOrderList(
      FinalTotalPrice: json['FinalTotalPrice'] as int?,
      MaxPrice: json['MaxPrice'] as int?,
      MinPrice: json['MinPrice'] as int?,
      OffPrice: json['OffPrice'] as int?,
      ShopId: json['ShopId'] as String?,
      Logo: json['Logo'] as String?,
      ShopName: json['ShopName'] as String?,
      ShopProducts: (json['ShopProducts'] as List<dynamic>?)
          ?.map((e) => ProductsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      TotalAmount: json['TotalAmount'] as int?,
      DeliverManMoney: json['DeliverManMoney'] as int?,
      Message: json['Message'] as String?,
      Break: json['Break'] as bool?,
      TimeChanged: json['TimeChanged'] as bool?,
      CustomerScore: json['CustomerScore'] as String?,
      Description: json['Description'] as String?,
    );

Map<String, dynamic> _$VMCheckOrderListToJson(VMCheckOrderList instance) =>
    <String, dynamic>{
      'FinalTotalPrice': instance.FinalTotalPrice,
      'MaxPrice': instance.MaxPrice,
      'MinPrice': instance.MinPrice,
      'OffPrice': instance.OffPrice,
      'ShopId': instance.ShopId,
      'ShopName': instance.ShopName,
      'Logo': instance.Logo,
      'ShopProducts': instance.ShopProducts,
      'TotalAmount': instance.TotalAmount,
      'DeliverManMoney': instance.DeliverManMoney,
      'Message': instance.Message,
      'Break': instance.Break,
      'TimeChanged': instance.TimeChanged,
      'Description': instance.Description,
      'CustomerScore': instance.CustomerScore,
    };
