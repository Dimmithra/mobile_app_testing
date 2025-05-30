class HotelListResultModel {
  final dynamic status;
  final List<HotelListResultModelData>? data;

  HotelListResultModel({this.status, this.data});

  factory HotelListResultModel.fromJson(Map<String, dynamic> json) {
    return HotelListResultModel(
      status: json['status'],
      data: json['data'] != null
          ? List<HotelListResultModelData>.from(
              json['data'].map((x) => HotelListResultModelData.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': data?.map((x) => x.toJson()).toList(),
      };
}

class HotelListResultModelData {
  final dynamic id;
  final String? title;
  final String? description;
  final String? address;
  final String? postcode;
  final String? phoneNumber;
  final String? latitude;
  final String? longitude;
  final HotelImage? image;

  HotelListResultModelData({
    this.id,
    this.title,
    this.description,
    this.address,
    this.postcode,
    this.phoneNumber,
    this.latitude,
    this.longitude,
    this.image,
  });

  factory HotelListResultModelData.fromJson(Map<String, dynamic> json) {
    return HotelListResultModelData(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      address: json['address'],
      postcode: json['postcode'],
      phoneNumber: json['phoneNumber'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      image: json['image'] != null ? HotelImage.fromJson(json['image']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'address': address,
        'postcode': postcode,
        'phoneNumber': phoneNumber,
        'latitude': latitude,
        'longitude': longitude,
        'image': image?.toJson(),
      };
}

class HotelImage {
  final String? small;
  final String? medium;
  final String? large;

  HotelImage({this.small, this.medium, this.large});

  factory HotelImage.fromJson(Map<String, dynamic> json) {
    return HotelImage(
      small: json['small'],
      medium: json['medium'],
      large: json['large'],
    );
  }

  Map<String, dynamic> toJson() => {
        'small': small,
        'medium': medium,
        'large': large,
      };
}
