

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';

class InsertOrderRequestModel extends Equatable{
  final String? PhoneNumber;
  final String? OrderId;
  final int? TotalAmount;
  final int? PosPay;
  final int? CashPay;
  final int? BonusUsed;
  final String? TrackingCodeWaiter;
  final String? TableId;
  final String? TableName;
  final int? IsPaymentType;
  final String? CreatedAt;
  final List<CartListModel>? Cart;
  /// if 0 ( ثبت سفارش ) if 1 ( تغییر در سفارش )
   int? StatusOrder;
  /// if 0 ( در حال ارسال به سرور ) if 1 ( خطا در ارتباط با سرور )
   int? StatusSend;

  InsertOrderRequestModel({this.PhoneNumber,
    this.OrderId,
    this.TotalAmount,
    this.PosPay,
    this.CashPay,
    this.BonusUsed,
    this.TrackingCodeWaiter,
    this.IsPaymentType,
    this.TableName,
    this.CreatedAt,
    this.TableId,
    this.StatusOrder =0,
    this.StatusSend = 0,
    this.Cart});


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PhoneNumber'] = PhoneNumber;
    data['OrderId'] = OrderId;
    data['TotalAmount'] = TotalAmount;
    data['PosPay'] = PosPay;
    data['TableId'] = TableId;
    data['CashPay'] = CashPay;
    data['BonusUsed'] = BonusUsed;
    data['TrackingCodeWaiter'] = TrackingCodeWaiter;
    data['IsPaymentType'] = IsPaymentType;
    data['CreatedAt'] = CreatedAt;
    data['StatusOrder'] = StatusOrder;
    data['StatusSend'] = StatusSend;
    data['TableName'] = TableName;
    if(Cart != null){
      List<CartListModel> basketData = Cart!;
      var myData = basketData.map((e) => e.toJson()).toList();
      data['Cart'] = myData;
    }

    return data;
  }


  factory InsertOrderRequestModel.fromJson(Map<String, dynamic> json) {
    return InsertOrderRequestModel(
          TrackingCodeWaiter: json['TrackingCodeWaiter'],
          OrderId: json['OrderId'],
          CashPay: json['CashPay'],
          BonusUsed: json['BonusUsed'],
          PosPay: json['PosPay'],
          IsPaymentType: json['IsPaymentType'],
          TotalAmount: json['TotalAmount'],
          PhoneNumber: json['PhoneNumber'],
          CreatedAt: json['CreatedAt'],
          StatusOrder: json['StatusOrder'],
          StatusSend: json['StatusSend'],
          TableId: json['TableId'],
          TableName: json['TableName'],
          Cart: (json['Cart'] as List<dynamic>?)
              ?.map((e) => CartListModel.fromJson(e as Map<String, dynamic>))
              .toList(),

      );
  }

  @override
  List<Object?> get props => [
    TrackingCodeWaiter,
    OrderId,
    CashPay,
    BonusUsed,
    PosPay,
    IsPaymentType,
    TotalAmount,
    PhoneNumber,
    CreatedAt,
    StatusOrder,
    StatusSend,
    Cart,
    TableId,
  ];


}

class CartListModel extends Equatable{

  final String? SchemaId;
  final int? Quantity;
  final int? Price;
  final int? OffPrice;
  final String? CustomerDescription;

  const CartListModel(
      {required this.SchemaId, required this.Quantity, required this.Price, required this.OffPrice,this.CustomerDescription});

  Map<String, dynamic> toJson() {
    return {
      'SchemaId': SchemaId,
      'Quantity': Quantity,
      'Price': Price,
      'OffPrice': OffPrice,
      'CustomerDescription': CustomerDescription,
    };
  }

 factory CartListModel.fromJson(Map<String, dynamic> json) =>
      CartListModel(SchemaId: json['SchemaId'],
          Quantity: json['Quantity'],
          Price: json['Price'],
          CustomerDescription: json['CustomerDescription'],
          OffPrice: json['OffPrice']);

  @override
  List<Object?> get props => [
    SchemaId ,
    Quantity ,
    Price ,
    OffPrice ,
    CustomerDescription ,

  ];

}
