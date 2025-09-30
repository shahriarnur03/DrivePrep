class DeviceModel {
  String? id;
  String name;
  DeviceData? data;
  String? createdAt;
  String? updatedAt;

  DeviceModel({
    this.id,
    required this.name,
    this.data,
    this.createdAt,
    this.updatedAt,
  });

  factory DeviceModel.fromJson(Map<String, dynamic> json) {
    return DeviceModel(
      id: json['id'],
      name: json['name'],
      data: json['data'] != null ? DeviceData.fromJson(json['data']) : null,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DeviceData {
  String? color;
  dynamic capacity;
  double? price;
  String? generation;
  int? year;
  String? cpuModel;
  String? hardDiskSize;
  String? strapColor;
  String? caseSize;
  String? description;
  dynamic screenSize;

  DeviceData({
    this.color,
    this.capacity,
    this.price,
    this.generation,
    this.year,
    this.cpuModel,
    this.hardDiskSize,
    this.strapColor,
    this.caseSize,
    this.description,
    this.screenSize,
  });

  factory DeviceData.fromJson(Map<String, dynamic> json) {
    return DeviceData(
      color: json['color'],
      capacity: json['capacity'] ?? json['capacity GB'],
      price: json['price'] is String
          ? double.tryParse(json['price'])
          : json['price'] is int
          ? (json['price'] as int).toDouble()
          : json['price'] as double?,
      generation: json['Generation'] ?? json['generation'],
      year: json['year'],
      cpuModel: json['CPU model'],
      hardDiskSize: json['Hard disk size'],
      strapColor: json['Strap Colour'],
      caseSize: json['Case Size'],
      description: json['Description'],
      screenSize: json['Screen size'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (color != null) data['color'] = color;
    if (capacity != null) data['capacity'] = capacity;
    if (price != null) data['price'] = price;
    if (generation != null) data['generation'] = generation;
    if (year != null) data['year'] = year;
    if (cpuModel != null) data['CPU model'] = cpuModel;
    if (hardDiskSize != null) data['Hard disk size'] = hardDiskSize;
    if (strapColor != null) data['Strap Colour'] = strapColor;
    if (caseSize != null) data['Case Size'] = caseSize;
    if (description != null) data['Description'] = description;
    if (screenSize != null) data['Screen size'] = screenSize;
    return data;
  }
}
