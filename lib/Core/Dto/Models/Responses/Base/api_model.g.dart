// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VMAPIBase _$VMAPIBaseFromJson(Map<String, dynamic> json) => VMAPIBase(
      Message: json['Message'] == null
          ? null
          : VMMessage.fromJson(json['Message'] as Map<String, dynamic>),
      Code: json['Code'] as int?,
      StatusCode: json['StatusCode'] as int?,
      SingleData: json['SingleData'] as String?,
    );

Map<String, dynamic> _$VMAPIBaseToJson(VMAPIBase instance) => <String, dynamic>{
      'Message': instance.Message,
      'Code': instance.Code,
      'StatusCode': instance.StatusCode,
      'SingleData': instance.SingleData,
    };

VMMessage _$VMMessageFromJson(Map<String, dynamic> json) => VMMessage(
      Text: json['Text'] as String?,
      Type: json['Type'] as int?,
    );

Map<String, dynamic> _$VMMessageToJson(VMMessage instance) => <String, dynamic>{
      'Text': instance.Text,
      'Type': instance.Type,
    };

VMAPICore<T> _$VMAPICoreFromJson<T>(Map<String, dynamic> json) => VMAPICore<T>(
      Message: json['Message'] == null
          ? null
          : VMMessage.fromJson(json['Message'] as Map<String, dynamic>),
      Code: json['Code'] as int?,
    );

Map<String, dynamic> _$VMAPICoreToJson<T>(VMAPICore<T> instance) =>
    <String, dynamic>{
      'Message': instance.Message,
      'Code': instance.Code,
    };
