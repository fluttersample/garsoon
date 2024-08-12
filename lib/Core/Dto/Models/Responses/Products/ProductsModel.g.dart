// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProductsModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductsModel _$ProductsModelFromJson(Map<String, dynamic> json) =>
    ProductsModel(
      LimitCount: json['LimitCount'] as int?,
      MyOffPrice: json['MyOffPrice'] as int?,
      OffPrice: json['OffPrice'] as int?,
      GroupId: json['GroupId'] as String?,
      ProductContain: json['ProductContain'] as String?,
      CustomerDescription: json['CustomerDescription'] as String?,
      ProductChoiceCount: json['ProductChoiceCount'] as int?,
      Price: json['Price'] as int?,
      SchemaId: json['SchemaId'] as String?,
      Badge: json['Badge'] as String?,
      ProductChoiceId: json['ProductChoiceId'] as String?,
      ProductChoiceName: json['ProductChoiceName'] as String?,
      ProductId: json['ProductId'] as String?,
      Picture: json['Picture'] as String?,
      ProductName: json['ProductName'] as String?,
      Quantity: json['Quantity'] as int?,
      ShopId: json['ShopId'] as String?,
      SelectedQuantity: json['SelectedQuantity'] as int?,
      ShopName: json['ShopName'] as String?,
      SupplyTime: json['SupplyTime'] as String?,
      ProductUnitNameString: json['ProductUnitNameString'] as String?,
      IsAddToCart: ProductsModel._convertRxBool(json['IsAddToCart']),
      Redirect: json['Redirect'] as String?,
      Count: ProductsModel._convertCount(json['Count']),
      Pictures: (json['Pictures'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      ExpireDate: json['ExpireDate'] as String?,
      Id: json['Id'] as String?,
      Name: json['Name'] as String?,
      ShowAddDescription:
          ProductsModel._convertRxBool(json['ShowAddDescription']),
      ProductChoices: (json['ProductChoices'] as List<dynamic>?)
          ?.map((e) => VMProductChoice.fromJson(e as Map<String, dynamic>))
          .toList(),
      Description: json['Description'] as String?,
    );

Map<String, dynamic> _$ProductsModelToJson(ProductsModel instance) =>
    <String, dynamic>{
      'Pictures': instance.Pictures,
      'Count': ProductsModel._convertCountToJson(instance.Count),
      'IsAddToCart': ProductsModel._convertRxBoolToJson(instance.IsAddToCart),
      'ShowAddDescription':
          ProductsModel._convertRxBoolToJson(instance.ShowAddDescription),
      'LimitCount': instance.LimitCount,
      'MyOffPrice': instance.MyOffPrice,
      'OffPrice': instance.OffPrice,
      'Price': instance.Price,
      'CustomerDescription': instance.CustomerDescription,
      'SchemaId': instance.SchemaId,
      'ProductChoiceName': instance.ProductChoiceName,
      'GroupId': instance.GroupId,
      'ProductUnitNameString': instance.ProductUnitNameString,
      'ProductId': instance.ProductId,
      'ProductChoiceId': instance.ProductChoiceId,
      'ProductContain': instance.ProductContain,
      'Picture': instance.Picture,
      'ProductName': instance.ProductName,
      'Description': instance.Description,
      'Quantity': instance.Quantity,
      'SelectedQuantity': instance.SelectedQuantity,
      'ProductChoiceCount': instance.ProductChoiceCount,
      'ShopId': instance.ShopId,
      'ShopName': instance.ShopName,
      'Redirect': instance.Redirect,
      'ExpireDate': instance.ExpireDate,
      'SupplyTime': instance.SupplyTime,
      'Id': instance.Id,
      'Name': instance.Name,
      'Badge': instance.Badge,
      'ProductChoices': instance.ProductChoices,
    };

VMProductChoice _$VMProductChoiceFromJson(Map<String, dynamic> json) =>
    VMProductChoice(
      Options: (json['Options'] as List<dynamic>?)
          ?.map((e) => VMProductOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      FastPost: json['FastPost'] as int?,
      FinalPrice: json['FinalPrice'] as int?,
      Badge: json['Badge'] as String?,
      HasWarranty: json['HasWarranty'] as bool?,
      LimitCount: json['LimitCount'] as int?,
      MyOffPrice: json['MyOffPrice'] as int?,
      OffPrice: json['OffPrice'] as int?,
      Pictures: (json['Pictures'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      Price: json['Price'] as int?,
      PreparationDay: json['PreparationDay'] as int?,
      PreparationTime: json['PreparationTime'] as String?,
      SchemaId: json['SchemaId'] as String?,
      ProductChoiceName: json['ProductChoiceName'] as String?,
      ProductId: json['ProductId'] as String?,
      Picture: json['Picture'] as String?,
      ProductName: json['ProductName'] as String?,
      ProductContain: json['ProductContain'] as String?,
      Quantity: json['Quantity'] as int?,
      ShopId: json['ShopId'] as String?,
      ShopName: json['ShopName'] as String?,
      SpecialOffer: json['SpecialOffer'] as bool?,
      SpecialOfferFromFa: json['SpecialOfferFromFa'] as String?,
      SpecialOfferToFa: json['SpecialOfferToFa'] as String?,
      WeightType: json['WeightType'] as int?,
      FirstQuantity: json['FirstQuantity'] as int?,
      LockQuantity: json['LockQuantity'] as int?,
      SupplyTime: json['SupplyTime'] as String?,
      ProductUnitNameString: json['ProductUnitNameString'] as String?,
      Redirect: json['Redirect'] as String?,
      ExpireDate: json['ExpireDate'] as String?,
      Id: json['Id'] as String?,
      Name: json['Name'] as String?,
      IsNew: json['IsNew'] as bool?,
      IsEdited: json['IsEdited'] as bool?,
      ProductChoiceId: json['ProductChoiceId'] as String?,
      Description: json['Description'] as String?,
      SelectedQuantity: json['SelectedQuantity'] as int?,
      OffPercent: json['OffPercent'] as int?,
    );

Map<String, dynamic> _$VMProductChoiceToJson(VMProductChoice instance) =>
    <String, dynamic>{
      'Options': instance.Options,
      'Pictures': instance.Pictures,
      'FastPost': instance.FastPost,
      'FinalPrice': instance.FinalPrice,
      'SelectedQuantity': instance.SelectedQuantity,
      'HasWarranty': instance.HasWarranty,
      'Id': instance.Id,
      'Name': instance.Name,
      'LimitCount': instance.LimitCount,
      'MyOffPrice': instance.MyOffPrice,
      'OffPrice': instance.OffPrice,
      'OffPercent': instance.OffPercent,
      'Price': instance.Price,
      'PreparationDay': instance.PreparationDay,
      'PreparationTime': instance.PreparationTime,
      'SchemaId': instance.SchemaId,
      'ProductChoiceName': instance.ProductChoiceName,
      'ProductUnitNameString': instance.ProductUnitNameString,
      'ProductId': instance.ProductId,
      'Picture': instance.Picture,
      'ProductName': instance.ProductName,
      'ProductContain': instance.ProductContain,
      'Quantity': instance.Quantity,
      'ShopId': instance.ShopId,
      'ShopName': instance.ShopName,
      'SpecialOffer': instance.SpecialOffer,
      'SpecialOfferFromFa': instance.SpecialOfferFromFa,
      'SpecialOfferToFa': instance.SpecialOfferToFa,
      'WeightType': instance.WeightType,
      'FirstQuantity': instance.FirstQuantity,
      'LockQuantity': instance.LockQuantity,
      'Redirect': instance.Redirect,
      'ExpireDate': instance.ExpireDate,
      'SupplyTime': instance.SupplyTime,
      'ProductChoiceId': instance.ProductChoiceId,
      'IsNew': instance.IsNew,
      'IsEdited': instance.IsEdited,
      'Description': instance.Description,
      'Badge': instance.Badge,
    };

VMProductOption _$VMProductOptionFromJson(Map<String, dynamic> json) =>
    VMProductOption(
      SpecificationTypeID: json['SpecificationTypeID'] as String?,
      Name: json['Name'] as String?,
      Type: json['Type'] as String?,
      ProductChoiceID: json['ProductChoiceID'] as String?,
      Items: (json['Items'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : VMProductOptionValue.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..Item = json['Item'] == null
        ? null
        : VMProductOptionValue.fromJson(json['Item'] as Map<String, dynamic>);

Map<String, dynamic> _$VMProductOptionToJson(VMProductOption instance) =>
    <String, dynamic>{
      'SpecificationTypeID': instance.SpecificationTypeID,
      'Name': instance.Name,
      'Type': instance.Type,
      'ProductChoiceID': instance.ProductChoiceID,
      'Items': instance.Items,
      'Item': instance.Item,
    };

VMProductOptionValue _$VMProductOptionValueFromJson(
        Map<String, dynamic> json) =>
    VMProductOptionValue(
      SpecificationTypeItemID: json['SpecificationTypeItemID'] as String?,
      Hex: json['Hex'] as String?,
      OptionItemId: json['OptionItemId'] as String?,
      Value: json['Value'] as String?,
      selected: json['selected'] as bool? ?? false,
    )..enabled = json['enabled'] as bool? ?? true;

Map<String, dynamic> _$VMProductOptionValueToJson(
        VMProductOptionValue instance) =>
    <String, dynamic>{
      'SpecificationTypeItemID': instance.SpecificationTypeItemID,
      'Hex': instance.Hex,
      'OptionItemId': instance.OptionItemId,
      'Value': instance.Value,
      'selected': instance.selected,
      'enabled': instance.enabled,
    };
