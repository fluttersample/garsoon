

class LoginRequestModel {


  final String? userName;
  final String? password;
  final String? role;
  final String? code;
  final String? resetPasswordToken;

  LoginRequestModel({ this.userName,  this.password,  this.role,this.code,
  this.resetPasswordToken});


Map<String , dynamic > toJson() =>{
  'UserName' : userName,
  'Password' : password,
  'Role' : role,
};
}