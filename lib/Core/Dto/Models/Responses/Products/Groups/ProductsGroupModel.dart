
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ProductsGroupModel.g.dart';

@JsonSerializable()

class ProductsGroupModel {
  final String? GroupId;
  final String? GroupName;
  final String? Picture;
  @JsonKey(fromJson: _convertCount,toJson: _convertCountToJson )
  RxInt? Count;
  ProductsGroupModel({this.GroupId, this.GroupName, this.Picture,this.Count});

  factory ProductsGroupModel.fromJson(Map<String, dynamic> json) => _$ProductsGroupModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsGroupModelToJson(this);


  static _convertCount(dynamic value) {
    if (value == null) {
      return 0.obs;
    }
    return 0.obs;
  }

  static _convertCountToJson(dynamic value) {
    if (value == null) {
      return null;
    }
    return 0;
  }
}



