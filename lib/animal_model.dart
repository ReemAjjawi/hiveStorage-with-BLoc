// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive_flutter/adapters.dart';

import 'handling.dart';

class ListOf<T> extends ResultModel {
  List<T> data;
  ListOf({
    required this.data,
  });
}

@HiveType(typeId: 0)
class AnimalModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String image;

  AnimalModel({
    required this.name,
    required this.image,
  });

  AnimalModel copyWith({
    String? name,
    String? image,
  }) {
    return AnimalModel(
      name: name ?? this.name,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'image': image,
    };
  }

  factory AnimalModel.fromMap(Map<String, dynamic> map) {
    return AnimalModel(
      name: map['name'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AnimalModel.fromJson(String source) =>
      AnimalModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AnimalModel(name: $name, image: $image)';

  @override
  bool operator ==(covariant AnimalModel other) {
    if (identical(this, other)) return true;

    return other.name == name && other.image == image;
  }

  @override
  int get hashCode => name.hashCode ^ image.hashCode;
}

class AnimalModelAdapter extends TypeAdapter<AnimalModel> {
  @override
  final int typeId = 0;

  @override
  AnimalModel read(BinaryReader reader) {
    return AnimalModel(
      name: reader.readString(),
      image: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, AnimalModel obj) {
    writer.writeString(obj.name);
    writer.writeString(obj.image);
  }
}
