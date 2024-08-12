


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'ProductsModel.g.dart';

@JsonSerializable()
class ProductsModel extends Equatable{

  List<String>? Pictures;

  @JsonKey(fromJson: _convertCount,toJson: _convertCountToJson)
  RxInt? Count;
  @JsonKey(fromJson: _convertRxBool,toJson: _convertRxBoolToJson)
  RxBool? IsAddToCart;
  @JsonKey(fromJson: _convertRxBool,toJson: _convertRxBoolToJson)
  RxBool? ShowAddDescription;
  int? LimitCount;
  int? MyOffPrice;
  int? OffPrice;
  int? Price;
  String? SchemaId;
  String? ProductChoiceName;
  String? GroupId;
  String? ProductUnitNameString;
  String? ProductId;
  String? ProductChoiceId;
  String? ProductContain;
  String? Picture;
  String? ProductName;
  String? Description;
  String? CustomerDescription;
  int? Quantity;
  int? SelectedQuantity;
  int? ProductChoiceCount;
  String? ShopId;
  String? ShopName;
  String? Redirect;
  String? ExpireDate;
  String? SupplyTime;
  String? Id;
  String? Name;
  String? Badge;
  List<VMProductChoice>? ProductChoices;
  TextEditingController textEditingController = TextEditingController();

  ProductsModel({
    this.LimitCount,
    this.MyOffPrice,
    this.OffPrice,
    this.GroupId,
    this.ProductContain,
    this.ProductChoiceCount,
    this.Price,
    this.SchemaId,
    this.Badge,
    this.ProductChoiceId,
    this.ProductChoiceName,
    this.ProductId,
    this.Picture,
    this.ProductName,
    this.Quantity,
    this.ShopId,
    this.SelectedQuantity,
    this.ShopName,
    this.SupplyTime,
    this.CustomerDescription,
    this.ProductUnitNameString,
    this.IsAddToCart,
    this.Redirect,
    this.Count,
    this.Pictures,
    this.ExpireDate,
    this.Id,
    this.Name,
    this.ShowAddDescription,
    this.ProductChoices,
    this.Description,
  }){
    if(Description != null){
      textEditingController.text = CustomerDescription??'';
    }
  }

  factory ProductsModel.fromJson(Map<String, dynamic> json) =>
      _$ProductsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsModelToJson(this);

  static _convertRxBool(dynamic value) {
    if (value == null) {
      return false.obs;
    }
    return false.obs;
  }



  static _convertCount(dynamic value) {
    if (value == null) {
      return 0.obs;
    }
    final vs = value as int;
    return vs.obs;
  }

  static _convertCountToJson(dynamic value) {
    if (value == null) {
      return 0;
    }
    return 0;
  }
  static _convertRxBoolToJson(dynamic value) {
    if (value == null) {
      return false;
    }
    return false;
  }
  @override
  List<Object?> get props => [
    LimitCount,
    MyOffPrice,
    OffPrice,
    Price,
    Pictures,
    SchemaId,
    ProductChoiceName,
    ProductId,
    Picture,
    ProductName,
    Quantity,
    ShopId,
    ShopName,
    SupplyTime,
    ProductUnitNameString,
    IsAddToCart,
    Redirect,
    Count,
    ExpireDate,
    Id,
    Name,
    ProductChoiceId,
    ProductChoiceCount,
    ProductContain,
    GroupId,
    Description,
    ProductChoices,
    ShowAddDescription,

  ];

}

@JsonSerializable()
//ignore: must_be_immutable
class VMProductChoice extends Equatable {
  List<VMProductOption>? Options;
  List<String>? Pictures;
  int? FastPost;
  int? FinalPrice;
  int? SelectedQuantity;
  bool? HasWarranty;
  String? Id;
  String? Name;
  int? LimitCount;
  int? MyOffPrice;
  int? OffPrice;
  int? OffPercent;
  int? Price;
  int? PreparationDay;
  String? PreparationTime;
  String? SchemaId;
  String? ProductChoiceName;
  String? ProductUnitNameString;
  String? ProductId;
  String? Picture;
  String? ProductName;
  String? ProductContain;
  int? Quantity;
  String? ShopId;
  String? ShopName;
  bool? SpecialOffer;
  String? SpecialOfferFromFa;
  String? SpecialOfferToFa;
  int? WeightType;
  int? FirstQuantity;
  int? LockQuantity;
  String? Redirect;
  String? ExpireDate;
  String? SupplyTime;
  String? ProductChoiceId;
  bool? IsNew;
  bool? IsEdited;
  String? Description;
  String? Badge;


  VMProductChoice({
    this.Options,
    this.FastPost,
    this.FinalPrice,
    this.Badge,
    this.HasWarranty,
    this.LimitCount,
    this.MyOffPrice,
    this.OffPrice,
    this.Pictures,
    this.Price,
    this.PreparationDay,
    this.PreparationTime,
    this.SchemaId,
    this.ProductChoiceName,
    this.ProductId,
    this.Picture,
    this.ProductName,
    this.ProductContain,
    this.Quantity,
    this.ShopId,
    this.ShopName,
    this.SpecialOffer,
    this.SpecialOfferFromFa,
    this.SpecialOfferToFa,
    this.WeightType,
    this.FirstQuantity,
    this.LockQuantity,
    this.SupplyTime,
    this.ProductUnitNameString,
    this.Redirect,
    this.ExpireDate,
    this.Id,
    this.Name,
    this.IsNew,
    this.IsEdited,
    this.ProductChoiceId,
    this.Description,
    this.SelectedQuantity,
    this.OffPercent
  });


  num get productPrice {
    return Price! - OffPrice!;
  }

  factory VMProductChoice.fromJson(Map<String, dynamic> json) => _$VMProductChoiceFromJson(json);

  Map<String, dynamic> toJson() => _$VMProductChoiceToJson(this);

  @override
  List<Object?> get props => [
    Options,
    FastPost,
    Id,
    FinalPrice,
    HasWarranty,
    LimitCount,
    MyOffPrice,
    OffPrice,
    Price,
    PreparationDay,
    PreparationTime,
    SchemaId,
    ProductChoiceName,
    ProductId,
    SelectedQuantity,
    Picture,
    ProductName,
    ProductContain,
    Quantity,
    ShopId,
    ShopName,
    SpecialOffer,
    SpecialOfferFromFa,
    SpecialOfferToFa,
    WeightType,
    FirstQuantity,
    LockQuantity,
    SupplyTime,
    ExpireDate,
    Name,
    IsNew,
    ProductChoiceId,
    IsEdited,
    Description,
  ];

}



@JsonSerializable()
//ignore: must_be_immutable
class VMProductOption extends Equatable {
  String? SpecificationTypeID;
  String? Name;
  String? Type;
  String? ProductChoiceID;
  List<VMProductOptionValue?>? Items;
  VMProductOptionValue? Item;

  VMProductOption({this.SpecificationTypeID, this.Name, this.Type, this.ProductChoiceID, this.Items}) {
    Items ??= List<VMProductOptionValue?>.empty(growable: true);
  }

  factory VMProductOption.fromJson(Map<String, dynamic> json) => _$VMProductOptionFromJson(json);

  Map<String, dynamic> toJson() => _$VMProductOptionToJson(this);

  @override
  List<Object?> get props => [SpecificationTypeID, Name, Type, ProductChoiceID, Items, Item];
}

@JsonSerializable()
//ignore: must_be_immutable
class VMProductOptionValue extends Equatable {
  String? SpecificationTypeItemID;
  String? Hex;
  String? OptionItemId;
  String? Value;

  @JsonKey(defaultValue: false)
  bool? selected;

  @JsonKey(defaultValue: true)
  bool? enabled;

  VMProductOptionValue({this.SpecificationTypeItemID, this.Hex, this.OptionItemId, this.Value, this.selected});

  factory VMProductOptionValue.fromJson(Map<String, dynamic> json) => _$VMProductOptionValueFromJson(json);

  Map<String, dynamic> toJson() => _$VMProductOptionValueToJson(this);

  @override
  List<Object?> get props => [SpecificationTypeItemID, Hex, Value, selected];
}
