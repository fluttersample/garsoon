import 'package:json_annotation/json_annotation.dart';

part 'api_model.g.dart';

@JsonSerializable()
class VMAPIBase {
  VMMessage? Message;
  int? Code;
  int? StatusCode;
  String? SingleData;

  VMAPIBase({this.Message, this.Code,this.StatusCode,this.SingleData});

  factory VMAPIBase.fromJson(Map<String, dynamic> json) => _$VMAPIBaseFromJson(json);

  Map<String, dynamic> toJson() => _$VMAPIBaseToJson(this);
}

@JsonSerializable()
class VMMessage {
  String? Text;
  int? Type;

  VMMessage({this.Text, this.Type});

  factory VMMessage.fromJson(Map<String, dynamic> json) => _$VMMessageFromJson(json);

  Map<String, dynamic> toJson() => _$VMMessageToJson(this);
}

@JsonSerializable()
class VMAPICore<T> {
  VMMessage? Message;
  int? Code;
  @JsonKey(ignore: true)
  T? Data;

  VMAPICore({this.Message, this.Code, this.Data});

  factory VMAPICore.fromJson(Map<String, dynamic> json) => _$VMAPICoreFromJson(json);

  Map<String, dynamic> toJson() => _$VMAPICoreToJson(this);
}
