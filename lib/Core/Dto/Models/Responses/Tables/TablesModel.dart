
import 'dart:io';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'TablesModel.g.dart';

@JsonSerializable()

class TablesModel extends Equatable{
  final String? TableId;
  final String? TableCode;


  TablesModel({this.TableId, this.TableCode});

  factory TablesModel.fromJson(Map<String, dynamic> json) => _$TablesModelFromJson(json);

  Map<String, dynamic> toJson() => _$TablesModelToJson(this);

  @override
  List<Object?> get props => [
    TableId,
    TableCode,

  ];
}



