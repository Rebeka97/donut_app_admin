import 'dart:developer';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donut_repository/donut_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseDonutRepo implements DonutRepo {
  final donutCollection = FirebaseFirestore.instance.collection('donuts');

  @override
  Future<void> createDonut(Donut donut) async {
    try {
      donut.donutId = donutCollection.doc().id;
      await donutCollection.doc(donut.donutId).set(donut.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<String> sendImage(Uint8List file, String name) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('donuts/${DateTime.now().millisecondsSinceEpoch}_$name');

      await ref.putData(file, SettableMetadata(contentType: 'image/jpeg'));
      return await ref.getDownloadURL();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Stream<List<Donut>> getDonuts() {
    return donutCollection.snapshots().map(
      (snapshot) => snapshot.docs
          .map(
            (document) => Donut.fromEntity(
              DonutEntity.fromDocument(document.data(), document.id),
            ),
          )
          .toList(),
    );
  }
}