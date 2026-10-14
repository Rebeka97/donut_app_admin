import 'package:donut_repository/src/entities/macros_entity.dart';
import 'package:donut_repository/src/models/models.dart';

String _requiredString(
  Map<String, dynamic> doc,
  String field, {
  String? alternateField,
}) {
  final value = doc[field] ??
      (alternateField == null ? null : doc[alternateField]);
  if (value is String) return value;
  throw FormatException(
    'Expected "$field" to be a string. Available fields: ${doc.keys.join(', ')}',
  );
}

bool _requiredBool(
  Map<String, dynamic> doc,
  String field,
  String documentId,
) {
  final value = doc[field];
  if (value is bool) return value;
  throw FormatException(
    'Expected "$field" to be a bool in donut document "$documentId"; '
    'got ${value == null ? 'null' : value.runtimeType}. '
    'Available fields: ${doc.keys.join(', ')}',
  );
}

class DonutEntity {
  String donutId;
  String picture;
  bool isFilled;
  bool isGlazed;
  String name;
  String description;
  double price;
  double discount;
  Macros macros;

  DonutEntity({
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

  Map<String, Object?> toDocument() {
    return {
      'donutId': donutId,
      'picture': picture,
      'isFilled': isFilled,
      'isGlazed': isGlazed,
      'name': name,
      'description': description,
      'price': price,
      'discount': discount,
      'macros': macros.toEntity().toDocument(),
    };
  }

  static DonutEntity fromDocument(
    Map<String, dynamic> doc,
    String documentId,
  ) {
    return DonutEntity(
      donutId: doc['donutId'] as String? ?? documentId,
      picture: _requiredString(doc, 'picture'),
      isFilled: _requiredBool(doc, 'isFilled', documentId),
      isGlazed: _requiredBool(doc, 'isGlazed', documentId),
      name: _requiredString(doc, 'name'),
      description: _requiredString(
        doc,
        'description',
        alternateField: 'decription',
      ),
      price: (doc['price'] as num).toDouble(),
      discount: (doc['discount'] as num).toDouble(),
      macros: Macros.fromEntity(MacrosEntity.fromDocument(doc['macros'])),
    );
  }
}