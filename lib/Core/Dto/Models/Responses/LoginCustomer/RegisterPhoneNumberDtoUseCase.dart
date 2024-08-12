
import 'package:equatable/equatable.dart';


class RegisterPhoneNumberDtoUseCase extends Equatable {
  final Content? content;
  final int statusCode;

  const RegisterPhoneNumberDtoUseCase(
      {this.content, required this.statusCode,});

  factory RegisterPhoneNumberDtoUseCase.fromJson(Map<String, dynamic> json) {
    if (json['Content'] == null) {
      return RegisterPhoneNumberDtoUseCase(
          statusCode: json['StatusCode']);
    } else {
      if (json['Message'] != null) {
        return RegisterPhoneNumberDtoUseCase(
            content: Content.fromJson(json['Content']),
            statusCode: json['StatusCode']);
      } else {
        return RegisterPhoneNumberDtoUseCase(
            content: Content.fromJson(json['Content']),
            statusCode: json['StatusCode']);
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (content != null) {
      data['Content'] = content!.toJson();
    }
    data['StatusCode'] = statusCode;
    return data;
  }

  @override
  List<Object?> get props => [];
}

class Content {
  final Token token;

  Content({required this.token});

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(token: Token.fromJson(json['Token']));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Token'] = token.toJson();
      return data;
  }
}

class Token {
  final String accessToken;
  final int expiresIn;
  final int expiresOn;
  final String refreshToken;
  final String tokenType;

  Token(
      {required this.accessToken,
      required this.expiresIn,
      required this.expiresOn,
      required this.refreshToken,
      required this.tokenType});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
        refreshToken: json['RefreshToken'],
        accessToken: json['AccessToken'],
        expiresIn: json['ExpiresIn'],
        expiresOn: json['ExpiresOn'],
        tokenType: json['TokenType']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AccessToken'] = accessToken;
    data['ExpiresIn'] = expiresIn;
    data['ExpiresOn'] = expiresOn;
    data['RefreshToken'] = refreshToken;
    data['TokenType'] = tokenType;
    return data;
  }
}
