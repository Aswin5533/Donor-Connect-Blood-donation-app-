import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class ListProvider extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String searchBlood = '';

  Future<void> saveBlood(String names, String blood, String numbers) async {
    await firestore.collection('Bloods').add({
      'name': names,
      'bloodGroup': blood,
      'phoneNumber': numbers,
    });
    notifyListeners();
  }

  Future<void> updateBlood(
    String docId,
    String names,
    String blood,
    String numbers,
  ) async {
    await firestore.collection('Bloods').doc(docId).update({
      'name': names,
      'bloodGroup': blood,
      'phoneNumber': numbers,
    });
    notifyListeners();
  }


  Future<void> deleteblood(String docid) async {
    return firestore.collection('Bloods').doc(docid).delete();
    notifyListeners();
  }


  void updateSearchBlood(String query) {
    searchBlood = query.toUpperCase();
    notifyListeners();
  }


  Stream<QuerySnapshot> get blood {
    if (searchBlood.isEmpty) {
      return FirebaseFirestore.instance.collection('Bloods').snapshots();
    } else {
      return firestore
          .collection('Bloods')
          .where('bloodGroup', isGreaterThanOrEqualTo: searchBlood)
          .where('bloodGroup', isLessThan: searchBlood + 'z')
          .snapshots();
    }
  }
}
