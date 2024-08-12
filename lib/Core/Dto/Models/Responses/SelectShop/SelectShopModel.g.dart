// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SelectShopModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SelectShopModel _$SelectShopModelFromJson(Map<String, dynamic> json) =>
    SelectShopModel(
      ShopId: json['ShopId'] as String?,
      ShopName: json['ShopName'] as String?,
      IsType: json['IsType'] as int?,
    );

Map<String, dynamic> _$SelectShopModelToJson(SelectShopModel instance) =>
    <String, dynamic>{
      'ShopId': instance.ShopId,
      'ShopName': instance.ShopName,
      'IsType': instance.IsType,
    };

VMShopInfo _$VMShopInfoFromJson(Map<String, dynamic> json) => VMShopInfo(
      Address: json['Address'] as String?,
      AddressDetail: json['AddressDetail'] as String?,
      AgentName: json['AgentName'] as String?,
      AgentLastName: json['AgentLastName'] as String?,
      AgentPhone: json['AgentPhone'] as String?,
      BankAccountOwnerLastName: json['BankAccountOwnerLastName'] as String?,
      BankAccountOwnerName: json['BankAccountOwnerName'] as String?,
      BankCardNumber: json['BankCardNumber'] as String?,
      BankCardOwner: json['BankCardOwner'] as String?,
      BankName: json['BankName'] as String?,
      BuildingFloor: json['BuildingFloor'] as int?,
      BuildingName: json['BuildingName'] as String?,
      BuildingUnit: json['BuildingUnit'] as int?,
      CanChangeDocuments: json['CanChangeDocuments'] as bool?,
      DelayTime: json['DelayTime'] as int?,
      MinDelayTime: json['MinDelayTime'] as int?,
      FreeDeliveryPrice: (json['FreeDeliveryPrice'] as num?)?.toDouble(),
      Latitude: (json['Latitude'] as num?)?.toDouble(),
      Longitude: (json['Longitude'] as num?)?.toDouble(),
      ManagerLastName: json['ManagerLastName'] as String?,
      ManagerName: json['ManagerName'] as String?,
      ManagerNationalCode: json['ManagerNationalCode'] as String?,
      ManagerPhone: json['ManagerPhone'] as String?,
      MaxOrder: json['MaxOrder'] as int?,
      MinOrder: json['MinOrder'] as int?,
      Plaque: json['Plaque'] as String?,
      ProductVariety: json['ProductVariety'] as int?,
      IBAN: json['IBAN'] as String?,
      ShopAreaAsMeter: json['ShopAreaAsMeter'] as int?,
      ShopPhone: json['ShopPhone'] as String?,
      ShopRepresentativeLastName: json['ShopRepresentativeLastName'] as String?,
      ShopRepresentativeName: json['ShopRepresentativeName'] as String?,
      ShopRepresentativePhoneNumber:
          json['ShopRepresentativePhoneNumber'] as String?,
      TabletInfo: json['TabletInfo'] as String?,
      TabletSimCardNumber: json['TabletSimCardNumber'] as String?,
      YearsOfActivity: json['YearsOfActivity'] as int?,
    );

Map<String, dynamic> _$VMShopInfoToJson(VMShopInfo instance) =>
    <String, dynamic>{
      'Address': instance.Address,
      'AddressDetail': instance.AddressDetail,
      'AgentName': instance.AgentName,
      'AgentLastName': instance.AgentLastName,
      'AgentPhone': instance.AgentPhone,
      'BankAccountOwnerLastName': instance.BankAccountOwnerLastName,
      'BankAccountOwnerName': instance.BankAccountOwnerName,
      'BankCardNumber': instance.BankCardNumber,
      'BankCardOwner': instance.BankCardOwner,
      'BankName': instance.BankName,
      'BuildingFloor': instance.BuildingFloor,
      'BuildingName': instance.BuildingName,
      'BuildingUnit': instance.BuildingUnit,
      'CanChangeDocuments': instance.CanChangeDocuments,
      'DelayTime': instance.DelayTime,
      'MinDelayTime': instance.MinDelayTime,
      'FreeDeliveryPrice': instance.FreeDeliveryPrice,
      'Latitude': instance.Latitude,
      'Longitude': instance.Longitude,
      'ManagerLastName': instance.ManagerLastName,
      'ManagerName': instance.ManagerName,
      'ManagerNationalCode': instance.ManagerNationalCode,
      'ManagerPhone': instance.ManagerPhone,
      'MaxOrder': instance.MaxOrder,
      'MinOrder': instance.MinOrder,
      'Plaque': instance.Plaque,
      'ProductVariety': instance.ProductVariety,
      'IBAN': instance.IBAN,
      'ShopAreaAsMeter': instance.ShopAreaAsMeter,
      'ShopPhone': instance.ShopPhone,
      'ShopRepresentativeLastName': instance.ShopRepresentativeLastName,
      'ShopRepresentativeName': instance.ShopRepresentativeName,
      'ShopRepresentativePhoneNumber': instance.ShopRepresentativePhoneNumber,
      'TabletInfo': instance.TabletInfo,
      'TabletSimCardNumber': instance.TabletSimCardNumber,
      'YearsOfActivity': instance.YearsOfActivity,
    };
