import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';


@JsonSerializable()
class DeliveryCreateResponse{
  String message;
  String orderNumber;
  bool error;

  DeliveryCreateResponse({required this.message,required this.orderNumber,required this.error});

  factory DeliveryCreateResponse.fromJson(Map<String, dynamic> json) => _$DeliveryCreateResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DeliveryCreateResponseToJson(this);
}
@JsonSerializable()
class Appeal {
  int? id;
  String type;
  String authorName;
  String authorPhone;
  String value;

  Appeal({
    this.id,
    required this.type,
    required this.authorName,
    required this.authorPhone,
    required this.value,
  });

  factory Appeal.fromJson(Map<String, dynamic> json) => _$AppealFromJson(json);
  Map<String, dynamic> toJson() => _$AppealToJson(this);
}

@JsonSerializable()
class CalculateDistanceRequest{
  int idDepartment;
  PointCoordinate startPoint;

  CalculateDistanceRequest({required this.idDepartment,required this.startPoint});

  factory CalculateDistanceRequest.fromJson(Map<String, dynamic> json) => _$CalculateDistanceRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CalculateDistanceRequestToJson(this);
}
@JsonSerializable()
class PointCoordinate{
  double lat;
  double lon;
  PointCoordinate({required this.lat,required this.lon});

  factory PointCoordinate.fromJson(Map<String, dynamic> json) => _$PointCoordinateFromJson(json);
  Map<String, dynamic> toJson() => _$PointCoordinateToJson(this);
}

@JsonSerializable()
class AddressItem {
  String address_name;
  String building_name;
  String full_name;
  String id;
  String name;
  PointCoordinate point;
  String purpose_name;
  String type;List<AddressItem> addresses=[];
  AddressItem({required this.address_name,required this.building_name,required this.full_name,required this.id,required this.name,required this.point,required this.purpose_name,required this.type});

  // @override
  // String toString(){
  //   return address_name;
  // }
  factory AddressItem.fromJson(Map<String, dynamic> json) => _$AddressItemFromJson(json);
  Map<String, dynamic> toJson() => _$AddressItemToJson(this);
}
@JsonSerializable()
class Menu {
  List<Group> groups;
  List<Product> products;

  Menu({
    required this.groups,
    required this.products,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);
  Map<String, dynamic> toJson() => _$MenuToJson(this);
}

@JsonSerializable()
class Group {
  int id;
  int sticker;
  int icon;
  int scheduleId;
  int indexSortId;
  bool enabled;
  String guidId;
  String parentGuid;
  String imageLinkFromExternalSystem;
  String imageLink;
  String videoLink;
  String videoLinkPreview;
  String name;
  String nameQaz;
  String nameEnglish;
  String tags;
  String seoText;
  String seoDescription;
  String seoKeywords;
  String seoTitle;
  String departmentIds;

  Group({
    required this.id,
    required this.sticker,
    required this.icon,
    required this.scheduleId,
    required this.indexSortId,
    required this.enabled,
    required this.guidId,
    required this.parentGuid,
    required this.imageLinkFromExternalSystem,
    required this.imageLink,
    required this.videoLink,
    required this.videoLinkPreview,
    required this.name,
    required this.nameQaz,
    required this.nameEnglish,
    required this.tags,
    required this.seoText,
    required this.seoDescription,
    required this.seoKeywords,
    required this.seoTitle,
    required this.departmentIds,
  });

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);
  Map<String, dynamic> toJson() => _$GroupToJson(this);
}
@JsonSerializable()
class Product {
  int id;
  int stickerId;
  int iconId;
  int scheduleId;
  int indexSortId;
  String guidId;
  String parentGuid;
  List<Modifier>? modifiers;
  List<GroupModifier>? groupModifier;
  String imageLinkFromExternalSystem;
  String imageLink;
  String imageLinkBasket;
  String videoLink;
  String videoLinkPreview;
  String name;
  String nameQaz;
  String nameEnglish;
  String description;
  String descriptionQaz;
  String descriptionEnglish;
  String composition;
  String compositionQaz;
  String compositionEng;
  String tags;
  String seoText;
  String seoDescription;
  String seoKeywords;
  String seoTitle;
  String departmentIds;
  List<SizePrice> sizePrice;

  Product({
    required this.id,
    required this.stickerId,
    required this.iconId,
    required this.scheduleId,
    required this.indexSortId,
    required this.guidId,
    required this.parentGuid,
    this.modifiers,
    this.groupModifier,
    required this.imageLinkFromExternalSystem,
    required this.imageLink,
    required this.imageLinkBasket,
    required this.videoLink,
    required this.videoLinkPreview,
    required this.name,
    required this.nameQaz,
    required this.nameEnglish,
    required this.description,
    required this.descriptionQaz,
    required this.descriptionEnglish,
    required this.composition,
    required this.compositionQaz,
    required this.compositionEng,
    required this.tags,
    required this.seoText,
    required this.seoDescription,
    required this.seoKeywords,
    required this.seoTitle,
    required this.departmentIds,
    required this.sizePrice,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable()
class SizePrice {
  String sizeId;
  Price price;

  SizePrice({
    required this.sizeId,
    required this.price,
  });

  factory SizePrice.fromJson(Map<String, dynamic> json) => _$SizePriceFromJson(json);
  Map<String, dynamic> toJson() => _$SizePriceToJson(this);
}

@JsonSerializable()
class Price {
  double currentPrice;

  Price({
    required this.currentPrice,
  });

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);
  Map<String, dynamic> toJson() => _$PriceToJson(this);
}



@JsonSerializable()
class Modifier {
  int id;
  String guid;
  int defaultAmount;
  int minAmount;
  int maxAmount;
  bool required;

  Modifier({
    required this.id,
    required this.guid,
    required this.defaultAmount,
    required this.minAmount,
    required this.maxAmount,
    required this.required,
  });

  factory Modifier.fromJson(Map<String, dynamic> json) => _$ModifierFromJson(json);
  Map<String, dynamic> toJson() => _$ModifierToJson(this);
}

@JsonSerializable()
class GroupModifier {
  int id;
  String guid;
  int minAmount;
  int maxAmount;
  bool required;
  List<Modifier> childModifiers;

  GroupModifier({
    required this.id,
    required this.guid,
    required this.minAmount,
    required this.maxAmount,
    required this.required,
    required this.childModifiers,
  });

  factory GroupModifier.fromJson(Map<String, dynamic> json) => _$GroupModifierFromJson(json);
  Map<String, dynamic> toJson() => _$GroupModifierToJson(this);
}


@JsonSerializable()
class BannerSite{
  int? id;
  int scheduleId;
  int? indexSort;
  bool workSite;
  bool workMobile;
  bool deleted;
  String name;
  String? description;
  String? imageLinkPreview;
  String? imageLink;
  String? videoLink;

  BannerSite({
    this.id,
    required this.scheduleId,
    this.indexSort,
    required this.workSite,
    required this.workMobile,
    required this.deleted,
    required this.name,
    this.description,
    this.imageLinkPreview,
    this.imageLink,
    this.videoLink});

  factory BannerSite.fromJson(Map<String,dynamic> json)=>_$BannerFromJson(json);

  Map<String,dynamic> toJson()=>_$BannerToJson(this);
}

@JsonSerializable()
class IconSite {
  int? id;
  bool deleted;
  bool working;
  String name;
  String? imageLink;

  IconSite({
    this.id,
    required this.deleted,
    required this.working,
    required this.name,
    this.imageLink,
  });

  factory IconSite.fromJson(Map<String, dynamic> json) => _$IconSiteFromJson(json);

  Map<String, dynamic> toJson() => _$IconSiteToJson(this);
}

@JsonSerializable()
class Organization {
  int? id;
  int? externalSystemId;
  int? defaultDepartment;
  bool deleted;
  String name;
  String? description;
  String? BIN; // Использование "bin" вместо "BIN" для стиля Dart
  String? callCenterPhone;
  String? reserveCallCenterPhone;

  Organization({
    this.id,
    this.externalSystemId,
    this.defaultDepartment,
    required this.deleted,
    required this.name,
    this.description,
    this.BIN,
    this.callCenterPhone,
    this.reserveCallCenterPhone,
  });

  factory Organization.fromJson(Map<String, dynamic> json) => _$OrganizationFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizationToJson(this);
}

@JsonSerializable()
class Sticker {
  int? id;
  bool deleted;
  bool working;
  String name;
  String? imageDefaultLink;
  String? imageQazLink;
  String? imageEngLink;

  Sticker({
    this.id,
    required this.deleted,
    required this.working,
    required this.name,
    this.imageDefaultLink,
    this.imageQazLink,
    this.imageEngLink,
  });

  factory Sticker.fromJson(Map<String, dynamic> json) => _$StickerFromJson(json);

  Map<String, dynamic> toJson() => _$StickerToJson(this);
}

@JsonSerializable()
class Department {
  int? id;
  int? scheduleId;
  int? indexSort;
  double? latitude;
  double? longitude;
  bool deleted;
  bool working;
  String name;
  String? description;
  String? nameQaz;
  String? nameEng;
  String? address;
  String? addressQaz;
  String? addressEng;
  String? phoneNumber;
  String? externalGuidDepartment;
  String? imageLink;
  String? mapLink;
  String? tourLink;
  bool forSite;
  List<int>? configs;

  Department({
    this.id,
    this.scheduleId,
    this.indexSort,
    this.latitude,
    this.longitude,
    required this.deleted,
    required this.working,
    required this.name,
    this.description,
    this.nameQaz,
    this.nameEng,
    this.address,
    this.addressQaz,
    this.addressEng,
    this.phoneNumber,
    this.externalGuidDepartment,
    this.imageLink,
    this.mapLink,
    this.tourLink,
    required this.forSite,
    this.configs,
  });

  factory Department.fromJson(Map<String, dynamic> json) => _$DepartmentFromJson(json);

  Map<String, dynamic> toJson() => _$DepartmentToJson(this);
}

@JsonSerializable()
class Schedule {
  int? id;
  bool deleted;
  String name;
  String? description;
  Day monday;
  Day tuesday;
  Day wednesday;
  Day thursday;
  Day friday;
  Day saturday;
  Day sunday;
  bool enabled;
  bool forSite;

  Schedule({
    this.id,
    required this.deleted,
    required this.name,
    this.description,
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
    required this.enabled,
    required this.forSite,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => _$ScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleToJson(this);
}

@JsonSerializable()
class Day {
  bool enable;
  DateTime? timeStart;
  DateTime? timeEnd;

  Day({
    required this.enable,
    this.timeStart,
    this.timeEnd,
  });

  factory Day.fromJson(Map<String, dynamic> json) => _$DayFromJson(json);

  Map<String, dynamic> toJson() => _$DayToJson(this);
}

@JsonSerializable()
class Order{
  String? orderType;
  int? departmentId;
  PointCoordinate? coordinate;
  String? orderAddress;
  int? promocodeId;
  List<Position> positions=[];
  int deliverySum=0;
  String? comment;
  String? paymentType;
  int sumPrice=0;
  String? clientPhone;
  String? clientName;
  String? clientHouse;
  String? clientStreet;
  String? clientFlat;
  String? clientFloor;
  String? clientDoorphone;
  String? clientEntrance;
  Order({this.orderType,this.departmentId,this.coordinate,this.orderAddress,this.promocodeId,required this.positions,required this.deliverySum,this.comment,this.paymentType,required this.sumPrice});

  Order copyWith({
    List<Position>? positions,
    int? deliverySum,
    int? sumPrice,
    String? orderType,
  }) {
    return Order(
      positions: positions ?? this.positions,
      deliverySum: deliverySum ?? this.deliverySum,
      sumPrice: sumPrice ?? this.sumPrice,
      orderType: orderType ?? this.orderType,
    );
  }


  factory Order.fromJson(Map<String,dynamic> json)=>_$OrderFromJson(json);
  Map<String,dynamic> toJson()=>_$OrderToJson(this);
}
@JsonSerializable()
class Position{
  String? productId;
  List<PositionItem> positionItems=[];
  int? positionPrice;
  int? count=0;
  Position({this.productId,required this.positionItems,this.positionPrice,this.count});
  factory Position.fromJson(Map<String,dynamic> json)=>_$PositionFromJson(json);
  Map<String,dynamic> toJson()=>_$PositionToJson(this);
}
@JsonSerializable()
class PositionItem{
  String? modifierId;
  String? groupId;
  int? count=0;
  PositionItem({this.modifierId,this.groupId,this.count});
  factory PositionItem.fromJson(Map<String,dynamic> json)=>_$PositionItemFromJson(json);
  Map<String,dynamic> toJson()=>_$PositionItemToJson(this);
}

@JsonSerializable()
class Recommendation {
  int id;
  int indexSort;
  bool enabled;
  bool deleted;
  String typeRecommendation;
  String guidProductId;
  String guidRecommendationId;

  Recommendation({
    required this.id,
    required this.indexSort,
    required this.enabled,
    required this.deleted,
    required this.typeRecommendation,
    required this.guidProductId,
    required this.guidRecommendationId,
  });

  factory Recommendation.fromJson(Map<String, dynamic> json) => _$RecommendationFromJson(json);
  Map<String, dynamic> toJson() => _$RecommendationToJson(this);
}