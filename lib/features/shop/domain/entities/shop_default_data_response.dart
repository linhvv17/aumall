class ShopDefaultDataResponse {
  ShopDefaultDataResponse({
    required this.status,
    required this.message,
    required this.data,
  });
  late final int status;
  late final String message;
  late final List<Data> data;

  ShopDefaultDataResponse.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.name,
    required this.alias,
    required this.description,
    this.priority,
    required this.childes,
  });
  late final int id;
  late final String name;
  late final String alias;
  late final String description;
  late final int? priority;
  late final List<Childes> childes;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    alias = json['alias'];
    description = json['description'] ??'';
    priority = json['priority'] ?? 0;
    childes = List.from(json['childes']).map((e)=>Childes.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['alias'] = alias;
    data['description'] = description;
    data['priority'] = priority;
    data['childes'] = childes.map((e)=>e.toJson()).toList();
    return data;
  }
}

class Childes {
  Childes({
    required this.id,
    required this.name,
    required this.alias,
    required this.description,
    this.priority,
    required this.parentId,
    required this.childes,
  });
  late final int id;
  late final String name;
  late final String alias;
  late final String description;
  late final int? priority;
  late final int parentId;
  late final List<Childes> childes;

  Childes.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    alias = json['alias'];
    description = json['alias'] ?? '';
    priority = json['alias'] ?? 1;
    parentId = json['parent_id'];
    childes = List.from(json['childes']).map((e)=>Childes.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['alias'] = alias;
    data['description'] = description;
    data['priority'] = priority;
    data['parent_id'] = parentId;
    data['childes'] = childes.map((e)=>e.toJson()).toList();
    return data;
  }
}