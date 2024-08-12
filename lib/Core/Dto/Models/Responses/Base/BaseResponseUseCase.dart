

class BaseResponseUseCase {
  int? statusCode;
  String? message;

  BaseResponseUseCase({this.statusCode, this.message});

  BaseResponseUseCase.fromJson(Map<String, dynamic> json) {
    statusCode = json['StatusCode'];
    message = json['Message'];
  }
}