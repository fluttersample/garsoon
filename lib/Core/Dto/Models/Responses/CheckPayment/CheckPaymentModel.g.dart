// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CheckPaymentModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckPaymentModel _$CheckPaymentModelFromJson(Map<String, dynamic> json) =>
    CheckPaymentModel(
      Content: json['Content'] == null
          ? null
          : ContentOfCheckPaymentModel.fromJson(
              json['Content'] as Map<String, dynamic>),
      StatusCode: json['StatusCode'] as int?,
      Message: json['Message'] == null
          ? null
          : VMMessage.fromJson(json['Message'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CheckPaymentModelToJson(CheckPaymentModel instance) =>
    <String, dynamic>{
      'Content': instance.Content,
      'StatusCode': instance.StatusCode,
      'Message': instance.Message,
    };

ContentOfCheckPaymentModel _$ContentOfCheckPaymentModelFromJson(
        Map<String, dynamic> json) =>
    ContentOfCheckPaymentModel(
      PaymentUrl: json['PaymentUrl'] as String?,
      Money: json['Money'] as int?,
    );

Map<String, dynamic> _$ContentOfCheckPaymentModelToJson(
        ContentOfCheckPaymentModel instance) =>
    <String, dynamic>{
      'PaymentUrl': instance.PaymentUrl,
      'Money': instance.Money,
    };
