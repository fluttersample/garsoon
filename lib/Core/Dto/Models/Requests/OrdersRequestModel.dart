



class OrdersRequestModel {


  final int? skip;
  final int? take;
  final String? orderStatusString;
  OrdersRequestModel({ this.skip,  this.take, this.orderStatusString});


  Map<String , dynamic > toJson() =>{
    'Skip' : skip,
    'Take' : take,
    // 'OrderStatus' :'NEW',
  };
}