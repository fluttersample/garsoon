
import 'package:equatable/equatable.dart';

class CheckPaymentRequestModel extends Equatable {
  final String? orderId;
  final int? money;
  final String? userName;

  const CheckPaymentRequestModel({this.money, this.userName,this.orderId});


  Map<String , dynamic > toJson() =>{
    'orderId' : orderId,
    'money' : money,
    'userName' : userName,
  };

  @override
  List<Object?> get props => [
    orderId,
    money,
    userName,
      ];
}
