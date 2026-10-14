import 'dart:typed_data';

import 'package:donut_repository/donut_repository.dart';

abstract class DonutRepo{
  Stream<List<Donut>> getDonuts();

  Future<void> createDonut(Donut donut);

  Future<String> sendImage(Uint8List file, String name);
}