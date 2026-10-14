import 'package:donut_repository/src/entities/macros_entity.dart';

class Macros {
  int? calories;
  int? protein;
  int? fat;
  int? carbs;

  Macros({
    required this.calories,
    required this.protein,
    required this.fat,
    required this.carbs,
  });

  static final empty = Macros(
    calories: 0,
    protein: 0,
    fat: 0,
    carbs: 0,
  );

  MacrosEntity toEntity() {
    return MacrosEntity(
      calories: calories,
      protein: protein,
      fat: fat,
      carbs: carbs,
    );
  }

  static Macros fromEntity(MacrosEntity entity) {
    return Macros(
      calories: entity.calories,
      protein: entity.protein,
      fat: entity.fat,
      carbs: entity.carbs,
    );
  }
}
