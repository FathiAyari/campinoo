import 'package:campino/models/ProductModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';

import '../Models/Users.dart';

class StoreServices {
  var user = GetStorage().read('user');
  Future<bool> createProduct(Product product) async {
    try {
      var postsCollection = FirebaseFirestore.instance.collection("marketplace").doc();
      await postsCollection.set(product.Tojson(postsCollection.id));
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addItemTobasket(String item) async {
    try {
      String uid = user['uid'];
      var oldList = await FirebaseFirestore.instance.collection("users").doc(uid).get();
      var value = Cusers.fromJson(oldList.data() as Map<String, dynamic>).basket;

      if (value.contains(item)) {
        return false;
      } else {
        value.add(item);

        FirebaseFirestore.instance.collection("users").doc(uid).update({'basket': value});
        return true;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
