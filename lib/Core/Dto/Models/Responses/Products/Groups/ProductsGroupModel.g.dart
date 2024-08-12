// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProductsGroupModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductsGroupModel _$ProductsGroupModelFromJson(Map<String, dynamic> json) =>
    ProductsGroupModel(
      GroupId: json['GroupId'] as String?,
      GroupName: json['GroupName'] as String?,
      Picture: json['Picture'] as String?,
      Count: ProductsGroupModel._convertCount(json['Count']),
    );

Map<String, dynamic> _$ProductsGroupModelToJson(ProductsGroupModel instance) =>
    <String, dynamic>{
      'GroupId': instance.GroupId,
      'GroupName': instance.GroupName,
      'Picture': instance.Picture,
      'Count': ProductsGroupModel._convertCountToJson(instance.Count),
    };
