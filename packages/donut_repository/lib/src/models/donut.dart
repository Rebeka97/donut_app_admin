import 'package:donut_repository/src/entities/donut_entity.dart';
import 'package:uuid/uuid.dart';

import 'models.dart';

class Donut {
  String donutId;
  String picture;
  bool isFilled;
  bool isGlazed;
  String name;
  String description;
  double price;
  double discount;
  Macros macros;

  Donut({
    required this.donutId,
    required this.picture,
    required this.isFilled,
    required this.isGlazed,
    required this.name,
    required this.description,
    required this.price,
    required this.discount,
    required this.macros,
  });

  static final empty = Donut(
    donutId: const Uuid().v1(),
    picture: '',
    isFilled: false,
    isGlazed: false,
    name: '',
    description: '',
    price: 0,
    discount: 0,
    macros: Macros.empty,
  );

  DonutEntity toEntity() {
    return DonutEntity(
      donutId: donutId,
      picture: picture,
      isFilled: isFilled,
      isGlazed: isGlazed,
      name: name,
      description: description,
      price: price,
      discount: discount,
      macros: macros,
    );
  }

  static Donut fromEntity(DonutEntity entity) {
    return Donut(
      donutId: entity.donutId,
      picture: entity.picture,
      isFilled: entity.isFilled,
      isGlazed: entity.isGlazed,
      name: entity.name,
      description: entity.description,
      price: entity.price,
      discount: entity.discount,
      macros: entity.macros,
    );
  }

  @override
  String toString() {
    return '''
    donutId: $donutId,
    picture: $picture,
    isFilled: $isFilled,
    isGlazed: $isGlazed,
    name: $name,
    description: $description,
    price: $price,
    discount: $discount,
    macros: $macros,
    ''';
  }
}
