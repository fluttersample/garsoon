
import 'package:equatable/equatable.dart';

class GetOrderInfoRequestModel extends Equatable {
  final String? OrderId;

  const GetOrderInfoRequestModel({this.OrderId});


  Map<String , dynamic > toJson() =>{
    'OrderId' : OrderId,
  };

  @override
  List<Object?> get props => [
        OrderId,
      ];
}
