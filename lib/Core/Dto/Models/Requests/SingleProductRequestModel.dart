


class SingleProductRequestModel {


  final String? schemaId;
  SingleProductRequestModel({ this.schemaId});


  Map<String , dynamic > toJson() =>{
    'schemaId' : schemaId,
    // 'OrderStatus' :'NEW',
  };
}