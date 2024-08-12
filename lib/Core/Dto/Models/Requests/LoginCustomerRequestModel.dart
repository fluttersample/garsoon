

class LoginCustomerRequestModel {

  final String? phoneNumber;
  final String? code;
  final String? presenterPhoneNumber;

  LoginCustomerRequestModel({ this.phoneNumber, this.code,this.presenterPhoneNumber});

  Map<String, dynamic> toJson() {
    if(presenterPhoneNumber != null){
      return {
        "phoneNumber": phoneNumber,
        "presenterPhoneNumber": presenterPhoneNumber,
      };
    }
    if(code != null){
      return {
        "phoneNumber": phoneNumber,
        "code": code,
      };
    }
      return {
        "phoneNumber": phoneNumber,
      };
  }
}