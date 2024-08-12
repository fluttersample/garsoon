// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VMUser _$VMUserFromJson(Map<String, dynamic> json) => VMUser(
      UserFirstName: json['UserFirstName'] as String?,
      UserLastName: json['UserLastName'] as String?,
      Birthdate: json['Birthdate'] as String?,
      IsGender: json['IsGender'] as bool?,
      PhoneNumber: json['PhoneNumber'] as String?,
      UserId: json['UserId'] as String?,
      ShopId: json['ShopId'] as String?,
      Iban: json['Iban'] as String?,
      Services: json['Services'] == null
          ? null
          : ServicesUserInfoModel.fromJson(
              json['Services'] as Map<String, dynamic>),
      ServicesIcons: (json['ServicesIcons'] as List<dynamic>?)
          ?.map((e) =>
              ServicesIconsUserInfoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      ShopName: json['ShopName'] as String?,
    );

Map<String, dynamic> _$VMUserToJson(VMUser instance) => <String, dynamic>{
      'UserFirstName': instance.UserFirstName,
      'UserLastName': instance.UserLastName,
      'Birthdate': instance.Birthdate,
      'IsGender': instance.IsGender,
      'PhoneNumber': instance.PhoneNumber,
      'UserId': instance.UserId,
      'ShopName': instance.ShopName,
      'ShopId': instance.ShopId,
      'Services': instance.Services,
      'ServicesIcons': instance.ServicesIcons,
      'Iban': instance.Iban,
    };

ServicesUserInfoModel _$ServicesUserInfoModelFromJson(
        Map<String, dynamic> json) =>
    ServicesUserInfoModel(
      HyperIsActive: json['HyperIsActive'] as bool?,
      ShopIsActive: json['ShopIsActive'] as bool?,
      RestaurantIsActive: json['RestaurantIsActive'] as bool?,
    );

Map<String, dynamic> _$ServicesUserInfoModelToJson(
        ServicesUserInfoModel instance) =>
    <String, dynamic>{
      'HyperIsActive': instance.HyperIsActive,
      'ShopIsActive': instance.ShopIsActive,
      'RestaurantIsActive': instance.RestaurantIsActive,
    };

ServicesIconsUserInfoModel _$ServicesIconsUserInfoModelFromJson(
        Map<String, dynamic> json) =>
    ServicesIconsUserInfoModel(
      IsType: json['IsType'] as int?,
      Picture: json['Picture'] as String?,
    );

Map<String, dynamic> _$ServicesIconsUserInfoModelToJson(
        ServicesIconsUserInfoModel instance) =>
    <String, dynamic>{
      'IsType': instance.IsType,
      'Picture': instance.Picture,
    };
