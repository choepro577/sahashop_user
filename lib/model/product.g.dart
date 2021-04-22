// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 1;

  @override
  Product read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Product(
      id: fields[0] as int,
      name: fields[1] as String,
      storeId: fields[2] as int,
      description: fields[3] as String,
      indexImageAvatar: fields[4] as int,
      price: fields[5] as int,
      barcode: fields[6] as String,
      status: fields[7] as int,
      createdAt: fields[8] as DateTime,
      updatedAt: fields[9] as DateTime,
      details: (fields[10] as List)?.cast<Details>(),
      images: (fields[11] as List)?.cast<ImageProduct>(),
      categories: (fields[12] as List)?.cast<Category>(),
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.storeId)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.indexImageAvatar)
      ..writeByte(5)
      ..write(obj.price)
      ..writeByte(6)
      ..write(obj.barcode)
      ..writeByte(7)
      ..write(obj.status)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.updatedAt)
      ..writeByte(10)
      ..write(obj.details)
      ..writeByte(11)
      ..write(obj.images)
      ..writeByte(12)
      ..write(obj.categories);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DetailsAdapter extends TypeAdapter<Details> {
  @override
  final int typeId = 2;

  @override
  Details read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Details(
      id: fields[0] as int,
      name: fields[1] as String,
      attributes: (fields[2] as List)?.cast<Attributes>(),
    );
  }

  @override
  void write(BinaryWriter writer, Details obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.attributes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AttributesAdapter extends TypeAdapter<Attributes> {
  @override
  final int typeId = 3;

  @override
  Attributes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Attributes(
      id: fields[0] as int,
      name: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Attributes obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttributesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ImageProductAdapter extends TypeAdapter<ImageProduct> {
  @override
  final int typeId = 4;

  @override
  ImageProduct read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ImageProduct(
      id: fields[0] as int,
      imageUrl: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ImageProduct obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
