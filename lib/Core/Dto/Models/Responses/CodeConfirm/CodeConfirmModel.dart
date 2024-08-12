import 'package:json_annotation/json_annotation.dart';

part 'CodeConfirmModel.g.dart';


@JsonSerializable()
class CodeConfirmModel {
  String? UserName;
  String? ResetPasswordToken;

  CodeConfirmModel({this.UserName, this.ResetPasswordToken});

  factory CodeConfirmModel.fromJson(Map<String, dynamic> json) => _$CodeConfirmModelFromJson(json);

  Map<String, dynamic> toJson() => _$CodeConfirmModelToJson(this);
}
