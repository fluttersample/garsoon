// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TokenModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VMToken _$VMTokenFromJson(Map<String, dynamic> json) => VMToken(
      AccessToken: json['access_token'] as String?,
      RefreshToken: json['refresh_token'] as String?,
      TokenType: json['token_type'] as String? ?? 'Bearer',
      ExpiresIn: json['expires_in'] as int?,
      ExpiresOn: json['expires_on'] as int?,
      isCustomer: json['isCustomer'] as bool? ?? false,
      phoneNumber: json['phoneNumber'] as String?,
    );

Map<String, dynamic> _$VMTokenToJson(VMToken instance) => <String, dynamic>{
      'access_token': instance.AccessToken,
      'refresh_token': instance.RefreshToken,
      'token_type': instance.TokenType,
      'expires_in': instance.ExpiresIn,
      'expires_on': instance.ExpiresOn,
      'isCustomer': instance.isCustomer,
      'phoneNumber': instance.phoneNumber,
    };
