import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'TokenModel.g.dart';

@JsonSerializable()
class VMToken extends Equatable {

  @JsonKey(name: 'access_token') final  String? AccessToken;
  @JsonKey(name: 'refresh_token') final String? RefreshToken;
  @JsonKey(name: 'token_type') final String? TokenType;
  @JsonKey(name: 'expires_in') final int? ExpiresIn;
  @JsonKey(name: 'expires_on') final int? ExpiresOn;
 final bool? isCustomer;
 final String? phoneNumber;

  const VMToken({this.AccessToken, this.RefreshToken, this.TokenType = 'Bearer', this.ExpiresIn, this.ExpiresOn,
  this.isCustomer = false,
  this.phoneNumber});

  factory VMToken.fromJson(Map<String, dynamic> json) => _$VMTokenFromJson(json);

  Map<String, dynamic> toJson() => _$VMTokenToJson(this);

  VMToken copyWith({String? AccessToken, String? RefreshToken, String? TokenType ,
  int? ExpiresIn , int? ExpiresOn}) => VMToken(
    AccessToken: AccessToken ?? this.AccessToken,
    RefreshToken: RefreshToken ?? this.RefreshToken,
    TokenType: TokenType ?? this.TokenType,
    ExpiresIn: ExpiresIn ?? this.ExpiresIn,
    ExpiresOn: ExpiresOn ?? this.ExpiresOn
  );

  @override
  List<Object?> get props => [
    AccessToken,
    RefreshToken,
    TokenType,
    ExpiresIn,
    ExpiresOn,
    isCustomer,
    phoneNumber,
  ];
}
