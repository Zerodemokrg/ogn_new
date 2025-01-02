// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryCreateResponse _$DeliveryCreateResponseFromJson(
        Map<String, dynamic> json) =>
    DeliveryCreateResponse(
      message: json['message'] as String,
      orderNumber: json['orderNumber'] as String,
      error: json['error'] as bool,
    );

Map<String, dynamic> _$DeliveryCreateResponseToJson(
        DeliveryCreateResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'orderNumber': instance.orderNumber,
      'error': instance.error,
    };

Appeal _$AppealFromJson(Map<String, dynamic> json) => Appeal(
      id: (json['id'] as num?)?.toInt(),
      type: json['type'] as String,
      authorName: json['authorName'] as String,
      authorPhone: json['authorPhone'] as String,
      value: json['value'] as String,
    );

Map<String, dynamic> _$AppealToJson(Appeal instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'authorName': instance.authorName,
      'authorPhone': instance.authorPhone,
      'value': instance.value,
    };

CalculateDistanceRequest _$CalculateDistanceRequestFromJson(
        Map<String, dynamic> json) =>
    CalculateDistanceRequest(
      idDepartment: (json['idDepartment'] as num).toInt(),
      startPoint:
          PointCoordinate.fromJson(json['startPoint'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CalculateDistanceRequestToJson(
        CalculateDistanceRequest instance) =>
    <String, dynamic>{
      'idDepartment': instance.idDepartment,
      'startPoint': instance.startPoint,
    };

PointCoordinate _$PointCoordinateFromJson(Map<String, dynamic> json) =>
    PointCoordinate(
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
    );

Map<String, dynamic> _$PointCoordinateToJson(PointCoordinate instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lon': instance.lon,
    };

AddressItem _$AddressItemFromJson(Map<String, dynamic> json) => AddressItem(
      address_name: json['address_name'] as String,
      building_name: json['building_name'] as String,
      full_name: json['full_name'] as String,
      id: json['id'] as String,
      name: json['name'] as String,
      point: PointCoordinate.fromJson(json['point'] as Map<String, dynamic>),
      purpose_name: json['purpose_name'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$AddressItemToJson(AddressItem instance) =>
    <String, dynamic>{
      'address_name': instance.address_name,
      'building_name': instance.building_name,
      'full_name': instance.full_name,
      'id': instance.id,
      'name': instance.name,
      'point': instance.point,
      'purpose_name': instance.purpose_name,
      'type': instance.type,
    };

Menu _$MenuFromJson(Map<String, dynamic> json) => Menu(
      groups: (json['groups'] as List<dynamic>)
          .map((e) => Group.fromJson(e as Map<String, dynamic>))
          .toList(),
      products: (json['products'] as List<dynamic>)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MenuToJson(Menu instance) => <String, dynamic>{
      'groups': instance.groups,
      'products': instance.products,
    };

Group _$GroupFromJson(Map<String, dynamic> json) => Group(
      id: (json['id'] as num).toInt(),
      sticker: (json['sticker'] as num).toInt(),
      icon: (json['icon'] as num).toInt(),
      scheduleId: (json['scheduleId'] as num).toInt(),
      indexSortId: (json['indexSortId'] as num).toInt(),
      enabled: json['enabled'] as bool,
      guidId: json['guidId'] as String,
      parentGuid: json['parentGuid'] as String,
      imageLinkFromExternalSystem:
          json['imageLinkFromExternalSystem'] as String,
      imageLink: json['imageLink'] as String,
      videoLink: json['videoLink'] as String,
      videoLinkPreview: json['videoLinkPreview'] as String,
      name: json['name'] as String,
      nameQaz: json['nameQaz'] as String,
      nameEnglish: json['nameEnglish'] as String,
      tags: json['tags'] as String,
      seoText: json['seoText'] as String,
      seoDescription: json['seoDescription'] as String,
      seoKeywords: json['seoKeywords'] as String,
      seoTitle: json['seoTitle'] as String,
      departmentIds: json['departmentIds'] as String,
    );

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
      'id': instance.id,
      'sticker': instance.sticker,
      'icon': instance.icon,
      'scheduleId': instance.scheduleId,
      'indexSortId': instance.indexSortId,
      'enabled': instance.enabled,
      'guidId': instance.guidId,
      'parentGuid': instance.parentGuid,
      'imageLinkFromExternalSystem': instance.imageLinkFromExternalSystem,
      'imageLink': instance.imageLink,
      'videoLink': instance.videoLink,
      'videoLinkPreview': instance.videoLinkPreview,
      'name': instance.name,
      'nameQaz': instance.nameQaz,
      'nameEnglish': instance.nameEnglish,
      'tags': instance.tags,
      'seoText': instance.seoText,
      'seoDescription': instance.seoDescription,
      'seoKeywords': instance.seoKeywords,
      'seoTitle': instance.seoTitle,
      'departmentIds': instance.departmentIds,
    };

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: (json['id'] as num).toInt(),
      stickerId: (json['stickerId'] as num).toInt(),
      iconId: (json['iconId'] as num).toInt(),
      scheduleId: (json['scheduleId'] as num).toInt(),
      indexSortId: (json['indexSortId'] as num).toInt(),
      guidId: json['guidId'] as String,
      parentGuid: json['parentGuid'] as String,
      modifiers: (json['modifiers'] as List<dynamic>?)
          ?.map((e) => Modifier.fromJson(e as Map<String, dynamic>))
          .toList(),
      groupModifier: (json['groupModifier'] as List<dynamic>?)
          ?.map((e) => GroupModifier.fromJson(e as Map<String, dynamic>))
          .toList(),
      imageLinkFromExternalSystem:
          json['imageLinkFromExternalSystem'] as String,
      imageLink: json['imageLink'] as String,
      imageLinkBasket: json['imageLinkBasket'] as String,
      videoLink: json['videoLink'] as String,
      videoLinkPreview: json['videoLinkPreview'] as String,
      name: json['name'] as String,
      nameQaz: json['nameQaz'] as String,
      nameEnglish: json['nameEnglish'] as String,
      description: json['description'] as String,
      descriptionQaz: json['descriptionQaz'] as String,
      descriptionEnglish: json['descriptionEnglish'] as String,
      composition: json['composition'] as String,
      compositionQaz: json['compositionQaz'] as String,
      compositionEng: json['compositionEng'] as String,
      tags: json['tags'] as String,
      seoText: json['seoText'] as String,
      seoDescription: json['seoDescription'] as String,
      seoKeywords: json['seoKeywords'] as String,
      seoTitle: json['seoTitle'] as String,
      departmentIds: json['departmentIds'] as String,
      sizePrice: (json['sizePrice'] as List<dynamic>)
          .map((e) => SizePrice.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'stickerId': instance.stickerId,
      'iconId': instance.iconId,
      'scheduleId': instance.scheduleId,
      'indexSortId': instance.indexSortId,
      'guidId': instance.guidId,
      'parentGuid': instance.parentGuid,
      'modifiers': instance.modifiers,
      'groupModifier': instance.groupModifier,
      'imageLinkFromExternalSystem': instance.imageLinkFromExternalSystem,
      'imageLink': instance.imageLink,
      'imageLinkBasket': instance.imageLinkBasket,
      'videoLink': instance.videoLink,
      'videoLinkPreview': instance.videoLinkPreview,
      'name': instance.name,
      'nameQaz': instance.nameQaz,
      'nameEnglish': instance.nameEnglish,
      'description': instance.description,
      'descriptionQaz': instance.descriptionQaz,
      'descriptionEnglish': instance.descriptionEnglish,
      'composition': instance.composition,
      'compositionQaz': instance.compositionQaz,
      'compositionEng': instance.compositionEng,
      'tags': instance.tags,
      'seoText': instance.seoText,
      'seoDescription': instance.seoDescription,
      'seoKeywords': instance.seoKeywords,
      'seoTitle': instance.seoTitle,
      'departmentIds': instance.departmentIds,
      'sizePrice': instance.sizePrice,
    };

SizePrice _$SizePriceFromJson(Map<String, dynamic> json) => SizePrice(
      sizeId: json['sizeId'] as String,
      price: Price.fromJson(json['price'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SizePriceToJson(SizePrice instance) => <String, dynamic>{
      'sizeId': instance.sizeId,
      'price': instance.price,
    };

Price _$PriceFromJson(Map<String, dynamic> json) => Price(
      currentPrice: (json['currentPrice'] as num).toDouble(),
    );

Map<String, dynamic> _$PriceToJson(Price instance) => <String, dynamic>{
      'currentPrice': instance.currentPrice,
    };

Modifier _$ModifierFromJson(Map<String, dynamic> json) => Modifier(
      id: (json['id'] as num).toInt(),
      guid: json['guid'] as String,
      defaultAmount: (json['defaultAmount'] as num).toInt(),
      minAmount: (json['minAmount'] as num).toInt(),
      maxAmount: (json['maxAmount'] as num).toInt(),
      required: json['required'] as bool,
    );

Map<String, dynamic> _$ModifierToJson(Modifier instance) => <String, dynamic>{
      'id': instance.id,
      'guid': instance.guid,
      'defaultAmount': instance.defaultAmount,
      'minAmount': instance.minAmount,
      'maxAmount': instance.maxAmount,
      'required': instance.required,
    };

GroupModifier _$GroupModifierFromJson(Map<String, dynamic> json) =>
    GroupModifier(
      id: (json['id'] as num).toInt(),
      guid: json['guid'] as String,
      minAmount: (json['minAmount'] as num).toInt(),
      maxAmount: (json['maxAmount'] as num).toInt(),
      required: json['required'] as bool,
      childModifiers: (json['childModifiers'] as List<dynamic>)
          .map((e) => Modifier.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GroupModifierToJson(GroupModifier instance) =>
    <String, dynamic>{
      'id': instance.id,
      'guid': instance.guid,
      'minAmount': instance.minAmount,
      'maxAmount': instance.maxAmount,
      'required': instance.required,
      'childModifiers': instance.childModifiers,
    };

BannerSite _$BannerSiteFromJson(Map<String, dynamic> json) => BannerSite(
      id: (json['id'] as num?)?.toInt(),
      scheduleId: (json['scheduleId'] as num).toInt(),
      indexSort: (json['indexSort'] as num?)?.toInt(),
      workSite: json['workSite'] as bool,
      workMobile: json['workMobile'] as bool,
      deleted: json['deleted'] as bool,
      name: json['name'] as String,
      description: json['description'] as String?,
      imageLinkPreview: json['imageLinkPreview'] as String?,
      imageLink: json['imageLink'] as String?,
      videoLink: json['videoLink'] as String?,
    );

Map<String, dynamic> _$BannerSiteToJson(BannerSite instance) =>
    <String, dynamic>{
      'id': instance.id,
      'scheduleId': instance.scheduleId,
      'indexSort': instance.indexSort,
      'workSite': instance.workSite,
      'workMobile': instance.workMobile,
      'deleted': instance.deleted,
      'name': instance.name,
      'description': instance.description,
      'imageLinkPreview': instance.imageLinkPreview,
      'imageLink': instance.imageLink,
      'videoLink': instance.videoLink,
    };

IconSite _$IconSiteFromJson(Map<String, dynamic> json) => IconSite(
      id: (json['id'] as num?)?.toInt(),
      deleted: json['deleted'] as bool,
      working: json['working'] as bool,
      name: json['name'] as String,
      imageLink: json['imageLink'] as String?,
    );

Map<String, dynamic> _$IconSiteToJson(IconSite instance) => <String, dynamic>{
      'id': instance.id,
      'deleted': instance.deleted,
      'working': instance.working,
      'name': instance.name,
      'imageLink': instance.imageLink,
    };

Organization _$OrganizationFromJson(Map<String, dynamic> json) => Organization(
      id: (json['id'] as num?)?.toInt(),
      externalSystemId: (json['externalSystemId'] as num?)?.toInt(),
      defaultDepartment: (json['defaultDepartment'] as num?)?.toInt(),
      deleted: json['deleted'] as bool,
      name: json['name'] as String,
      description: json['description'] as String?,
      BIN: json['BIN'] as String?,
      callCenterPhone: json['callCenterPhone'] as String?,
      reserveCallCenterPhone: json['reserveCallCenterPhone'] as String?,
    );

Map<String, dynamic> _$OrganizationToJson(Organization instance) =>
    <String, dynamic>{
      'id': instance.id,
      'externalSystemId': instance.externalSystemId,
      'defaultDepartment': instance.defaultDepartment,
      'deleted': instance.deleted,
      'name': instance.name,
      'description': instance.description,
      'BIN': instance.BIN,
      'callCenterPhone': instance.callCenterPhone,
      'reserveCallCenterPhone': instance.reserveCallCenterPhone,
    };

Sticker _$StickerFromJson(Map<String, dynamic> json) => Sticker(
      id: (json['id'] as num?)?.toInt(),
      deleted: json['deleted'] as bool,
      working: json['working'] as bool,
      name: json['name'] as String,
      imageDefaultLink: json['imageDefaultLink'] as String?,
      imageQazLink: json['imageQazLink'] as String?,
      imageEngLink: json['imageEngLink'] as String?,
    );

Map<String, dynamic> _$StickerToJson(Sticker instance) => <String, dynamic>{
      'id': instance.id,
      'deleted': instance.deleted,
      'working': instance.working,
      'name': instance.name,
      'imageDefaultLink': instance.imageDefaultLink,
      'imageQazLink': instance.imageQazLink,
      'imageEngLink': instance.imageEngLink,
    };

Department _$DepartmentFromJson(Map<String, dynamic> json) => Department(
      id: (json['id'] as num?)?.toInt(),
      scheduleId: (json['scheduleId'] as num?)?.toInt(),
      indexSort: (json['indexSort'] as num?)?.toInt(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      deleted: json['deleted'] as bool,
      working: json['working'] as bool,
      name: json['name'] as String,
      description: json['description'] as String?,
      nameQaz: json['nameQaz'] as String?,
      nameEng: json['nameEng'] as String?,
      address: json['address'] as String?,
      addressQaz: json['addressQaz'] as String?,
      addressEng: json['addressEng'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      externalGuidDepartment: json['externalGuidDepartment'] as String?,
      imageLink: json['imageLink'] as String?,
      mapLink: json['mapLink'] as String?,
      tourLink: json['tourLink'] as String?,
      forSite: json['forSite'] as bool,
      configs: (json['configs'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$DepartmentToJson(Department instance) =>
    <String, dynamic>{
      'id': instance.id,
      'scheduleId': instance.scheduleId,
      'indexSort': instance.indexSort,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'deleted': instance.deleted,
      'working': instance.working,
      'name': instance.name,
      'description': instance.description,
      'nameQaz': instance.nameQaz,
      'nameEng': instance.nameEng,
      'address': instance.address,
      'addressQaz': instance.addressQaz,
      'addressEng': instance.addressEng,
      'phoneNumber': instance.phoneNumber,
      'externalGuidDepartment': instance.externalGuidDepartment,
      'imageLink': instance.imageLink,
      'mapLink': instance.mapLink,
      'tourLink': instance.tourLink,
      'forSite': instance.forSite,
      'configs': instance.configs,
    };

Schedule _$ScheduleFromJson(Map<String, dynamic> json) => Schedule(
      id: (json['id'] as num?)?.toInt(),
      deleted: json['deleted'] as bool,
      name: json['name'] as String,
      description: json['description'] as String?,
      monday: Day.fromJson(json['monday'] as Map<String, dynamic>),
      tuesday: Day.fromJson(json['tuesday'] as Map<String, dynamic>),
      wednesday: Day.fromJson(json['wednesday'] as Map<String, dynamic>),
      thursday: Day.fromJson(json['thursday'] as Map<String, dynamic>),
      friday: Day.fromJson(json['friday'] as Map<String, dynamic>),
      saturday: Day.fromJson(json['saturday'] as Map<String, dynamic>),
      sunday: Day.fromJson(json['sunday'] as Map<String, dynamic>),
      enabled: json['enabled'] as bool,
      forSite: json['forSite'] as bool,
    );

Map<String, dynamic> _$ScheduleToJson(Schedule instance) => <String, dynamic>{
      'id': instance.id,
      'deleted': instance.deleted,
      'name': instance.name,
      'description': instance.description,
      'monday': instance.monday,
      'tuesday': instance.tuesday,
      'wednesday': instance.wednesday,
      'thursday': instance.thursday,
      'friday': instance.friday,
      'saturday': instance.saturday,
      'sunday': instance.sunday,
      'enabled': instance.enabled,
      'forSite': instance.forSite,
    };

Day _$DayFromJson(Map<String, dynamic> json) => Day(
      enable: json['enable'] as bool,
      timeStart: json['timeStart'] == null
          ? null
          : DateTime.parse(json['timeStart'] as String),
      timeEnd: json['timeEnd'] == null
          ? null
          : DateTime.parse(json['timeEnd'] as String),
    );

Map<String, dynamic> _$DayToJson(Day instance) => <String, dynamic>{
      'enable': instance.enable,
      'timeStart': instance.timeStart?.toIso8601String(),
      'timeEnd': instance.timeEnd?.toIso8601String(),
    };

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      orderType: json['orderType'] as String?,
      departmentId: (json['departmentId'] as num?)?.toInt(),
      coordinate: json['coordinate'] == null
          ? null
          : PointCoordinate.fromJson(
              json['coordinate'] as Map<String, dynamic>),
      orderAddress: json['orderAddress'] as String?,
      promocodeId: (json['promocodeId'] as num?)?.toInt(),
      positions: (json['positions'] as List<dynamic>)
          .map((e) => Position.fromJson(e as Map<String, dynamic>))
          .toList(),
      deliverySum: (json['deliverySum'] as num).toInt(),
      comment: json['comment'] as String?,
      paymentType: json['paymentType'] as String?,
      sumPrice: (json['sumPrice'] as num).toInt(),
      tableNumber: (json['tableNumber'] as num?)?.toInt(),
    )
      ..clientPhone = json['clientPhone'] as String?
      ..clientName = json['clientName'] as String?
      ..clientHouse = json['clientHouse'] as String?
      ..clientStreet = json['clientStreet'] as String?
      ..clientFlat = json['clientFlat'] as String?
      ..clientFloor = json['clientFloor'] as String?
      ..clientDoorphone = json['clientDoorphone'] as String?
      ..clientEntrance = json['clientEntrance'] as String?;

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'orderType': instance.orderType,
      'departmentId': instance.departmentId,
      'tableNumber': instance.tableNumber,
      'coordinate': instance.coordinate,
      'orderAddress': instance.orderAddress,
      'promocodeId': instance.promocodeId,
      'positions': instance.positions,
      'deliverySum': instance.deliverySum,
      'comment': instance.comment,
      'paymentType': instance.paymentType,
      'sumPrice': instance.sumPrice,
      'clientPhone': instance.clientPhone,
      'clientName': instance.clientName,
      'clientHouse': instance.clientHouse,
      'clientStreet': instance.clientStreet,
      'clientFlat': instance.clientFlat,
      'clientFloor': instance.clientFloor,
      'clientDoorphone': instance.clientDoorphone,
      'clientEntrance': instance.clientEntrance,
    };

Position _$PositionFromJson(Map<String, dynamic> json) => Position(
      productId: json['productId'] as String?,
      positionItems: (json['positionItems'] as List<dynamic>)
          .map((e) => PositionItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      positionPrice: (json['positionPrice'] as num?)?.toInt(),
      count: (json['count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PositionToJson(Position instance) => <String, dynamic>{
      'productId': instance.productId,
      'positionItems': instance.positionItems,
      'positionPrice': instance.positionPrice,
      'count': instance.count,
    };

PositionItem _$PositionItemFromJson(Map<String, dynamic> json) => PositionItem(
      modifierId: json['modifierId'] as String?,
      groupId: json['groupId'] as String?,
      count: (json['count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PositionItemToJson(PositionItem instance) =>
    <String, dynamic>{
      'modifierId': instance.modifierId,
      'groupId': instance.groupId,
      'count': instance.count,
    };

Recommendation _$RecommendationFromJson(Map<String, dynamic> json) =>
    Recommendation(
      id: (json['id'] as num).toInt(),
      indexSort: (json['indexSort'] as num).toInt(),
      enabled: json['enabled'] as bool,
      deleted: json['deleted'] as bool,
      typeRecommendation: json['typeRecommendation'] as String,
      guidProductId: json['guidProductId'] as String,
      guidRecommendationId: json['guidRecommendationId'] as String,
    );

Map<String, dynamic> _$RecommendationToJson(Recommendation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'indexSort': instance.indexSort,
      'enabled': instance.enabled,
      'deleted': instance.deleted,
      'typeRecommendation': instance.typeRecommendation,
      'guidProductId': instance.guidProductId,
      'guidRecommendationId': instance.guidRecommendationId,
    };

OrderStatusResponse _$OrderStatusResponseFromJson(Map<String, dynamic> json) =>
    OrderStatusResponse(
      orderStatus: json['orderStatus'] as String?,
      orderNumber: json['orderNumber'] as String?,
    );

Map<String, dynamic> _$OrderStatusResponseToJson(
        OrderStatusResponse instance) =>
    <String, dynamic>{
      'orderStatus': instance.orderStatus,
      'orderNumber': instance.orderNumber,
    };

OrderStatusRequest _$OrderStatusRequestFromJson(Map<String, dynamic> json) =>
    OrderStatusRequest(
      paymentId: (json['paymentId'] as num).toInt(),
      paymentTransactionId: json['paymentTransactionId'] as String?,
    );

Map<String, dynamic> _$OrderStatusRequestToJson(OrderStatusRequest instance) =>
    <String, dynamic>{
      'paymentId': instance.paymentId,
      'paymentTransactionId': instance.paymentTransactionId,
    };
