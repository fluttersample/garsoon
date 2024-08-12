// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CodeConfirmModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CodeConfirmModel _$CodeConfirmModelFromJson(Map<String, dynamic> json) =>
    CodeConfirmModel(
      UserName: json['UserName'] as String?,
      ResetPasswordToken: json['ResetPasswordToken'] as String?,
    );

Map<String, dynamic> _$CodeConfirmModelToJson(CodeConfirmModel instance) =>
    <String, dynamic>{
      'UserName': instance.UserName,
      'ResetPasswordToken': instance.ResetPasswordToken,
    };
