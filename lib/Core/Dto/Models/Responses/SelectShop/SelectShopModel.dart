import 'package:json_annotation/json_annotation.dart';

part 'SelectShopModel.g.dart';

@JsonSerializable()

class SelectShopModel {
  String? ShopId;
  String? ShopName;
  int? IsType;

  SelectShopModel({this.ShopId, this.ShopName, this.IsType});

  factory SelectShopModel.fromJson(Map<String, dynamic> json) => _$SelectShopModelFromJson(json);

  Map<String, dynamic> toJson() => _$SelectShopModelToJson(this);
}

@JsonSerializable()
class VMShopInfo {
  String? Address;
  String? AddressDetail;
  String? AgentName;
  String? AgentLastName;
  String? AgentPhone;
  String? BankAccountOwnerLastName;
  String? BankAccountOwnerName;
  String? BankCardNumber;
  String? BankCardOwner;
  String? BankName;
  int? BuildingFloor;
  String? BuildingName;
  int? BuildingUnit;
  bool? CanChangeDocuments;
  int? DelayTime;
  int? MinDelayTime;
  double? FreeDeliveryPrice;
  double? Latitude;
  double? Longitude;
  String? ManagerLastName;
  String? ManagerName;
  String? ManagerNationalCode;
  String? ManagerPhone;
  int? MaxOrder;
  int? MinOrder;
  String? Plaque;
  int? ProductVariety;
  String? IBAN;
  int? ShopAreaAsMeter;
  String? ShopPhone;
  String? ShopRepresentativeLastName;
  String? ShopRepresentativeName;
  String? ShopRepresentativePhoneNumber;
  String? TabletInfo;
  String? TabletSimCardNumber;
  int? YearsOfActivity;

  VMShopInfo(
      {this.Address,
      this.AddressDetail,
      this.AgentName,
      this.AgentLastName,
      this.AgentPhone,
      this.BankAccountOwnerLastName,
      this.BankAccountOwnerName,
      this.BankCardNumber,
      this.BankCardOwner,
      this.BankName,
      this.BuildingFloor,
      this.BuildingName,
      this.BuildingUnit,
      this.CanChangeDocuments,
      this.DelayTime,
      this.MinDelayTime,
      this.FreeDeliveryPrice,
      this.Latitude,
      this.Longitude,
      this.ManagerLastName,
      this.ManagerName,
      this.ManagerNationalCode,
      this.ManagerPhone,
      this.MaxOrder,
      this.MinOrder,
      this.Plaque,
      this.ProductVariety,
      this.IBAN,
      this.ShopAreaAsMeter,
      this.ShopPhone,
      this.ShopRepresentativeLastName,
      this.ShopRepresentativeName,
      this.ShopRepresentativePhoneNumber,
      this.TabletInfo,
      this.TabletSimCardNumber,
      this.YearsOfActivity});

  factory VMShopInfo.fromJson(Map<String, dynamic> json) => _$VMShopInfoFromJson(json);

  Map<String, dynamic> toJson() => _$VMShopInfoToJson(this);
}

