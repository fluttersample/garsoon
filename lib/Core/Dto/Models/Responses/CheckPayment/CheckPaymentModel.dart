
import 'package:json_annotation/json_annotation.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';

part 'CheckPaymentModel.g.dart';

@JsonSerializable()
class CheckPaymentModel {

  final ContentOfCheckPaymentModel? Content;
  final int? StatusCode;
  final VMMessage? Message;

  CheckPaymentModel({ this.Content,  this.StatusCode,  this.Message});

  factory CheckPaymentModel.fromJson(Map<String, dynamic> json) => _$CheckPaymentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CheckPaymentModelToJson(this);
}





@JsonSerializable()
class ContentOfCheckPaymentModel {

  final String? PaymentUrl;
  final int? Money;

  ContentOfCheckPaymentModel({ this.PaymentUrl,  this.Money});

  factory ContentOfCheckPaymentModel.fromJson(Map<String, dynamic> json) => _$ContentOfCheckPaymentModelFromJson(json);

  Map<String, dynamic> toJson() => _$ContentOfCheckPaymentModelToJson(this);


}