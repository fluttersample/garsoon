import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';


part 'UserModel.g.dart';

@JsonSerializable()
//ignore: must_be_immutable
class VMUser extends Equatable {
  String? UserFirstName;
  String? UserLastName;
  String? Birthdate;
  bool? IsGender;
  String? PhoneNumber;
  String? UserId;
  String? ShopName;
  String? ShopId;
  ServicesUserInfoModel? Services;
  List<ServicesIconsUserInfoModel>? ServicesIcons;
  String? Iban;
  VMUser({this.UserFirstName, this.UserLastName, this.Birthdate, this.IsGender, this.PhoneNumber, this.UserId,
    this.ShopId,
    this.Iban,
    this.Services,
    this.ServicesIcons,
    this.ShopName});

  factory VMUser.fromJson(Map<String, dynamic> json) => _$VMUserFromJson(json);

  Map<String, dynamic> toJson() => _$VMUserToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [
        UserFirstName,
        UserLastName,
        Birthdate,
        IsGender,
        Services,
        ShopId,
        Iban,
        PhoneNumber,
        ShopName
      ];
}

@JsonSerializable()
//ignore: must_be_immutable
class ServicesUserInfoModel extends Equatable{
  bool? HyperIsActive;
  bool? ShopIsActive;
  bool? RestaurantIsActive;



  ServicesUserInfoModel(
      {this.HyperIsActive,
        this.ShopIsActive,
        this.RestaurantIsActive,
        });

  factory ServicesUserInfoModel.fromJson(Map<String, dynamic> json) => _$ServicesUserInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$ServicesUserInfoModelToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [
    HyperIsActive,
    RestaurantIsActive,
    ShopIsActive
  ];
}


@JsonSerializable()
//ignore: must_be_immutable
class ServicesIconsUserInfoModel extends Equatable{
  int? IsType;
  String? Picture;



  ServicesIconsUserInfoModel(
      {this.IsType,
        this.Picture,
      });

  factory ServicesIconsUserInfoModel.fromJson(Map<String, dynamic> json) => _$ServicesIconsUserInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$ServicesIconsUserInfoModelToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [
    IsType,
    Picture,
  ];
}