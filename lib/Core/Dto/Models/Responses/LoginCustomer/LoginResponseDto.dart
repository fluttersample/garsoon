
import 'package:equatable/equatable.dart';

class LoginResponseDto extends Equatable {
  final String? stateLogin;

  const LoginResponseDto({this.stateLogin,});

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) {
    return LoginResponseDto(
        stateLogin: json['StateLogin']);
  }




  @override
  List<Object?> get props => [];
}
