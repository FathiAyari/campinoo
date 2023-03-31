import 'package:campino/models/ProductModel.dart';
import 'package:campino/presentation/client/views/market_place/product_details.dart';
import 'package:campino/presentation/ressources/dimensions/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../Models/Users.dart';

class Basket extends StatefulWidget {
  const Basket({Key? key}) : super(key: key);

  @override
  _BasketState createState() => _BasketState();
}

class _BasketState extends State<Basket> {
  var user = GetStorage().read('user');

  late List<Product> myBasket;
  Future<List<Product>> getProducts() async {
    var allProducts = await FirebaseFirestore.instance.collection("marketplace").get();
    var itemsList = await FirebaseFirestore.instance.collection("users").doc(user['uid']).get();
    var myListOfProductsId = Cusers.fromJson(itemsList.data() as Map<String, dynamic>).basket;

    List<Product> myBasket = [];
    for (var product in allProducts.docs.toList()) {
      if (myListOfProductsId.contains(product.id)) {
        myBasket.add(Product.fromJson(product.data() as Map<String, dynamic>));
      }
    }

    return myBasket;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Color(0xffe3eaef),
            body: Column(
              children: [
                back_button(Colors.blueAccent, "Panier"),
                Expanded(
                  child: FutureBuilder<List<Product>>(
                    future: getProducts(),
                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    Get.to(ProductDetails(product: snapshot.data[index]));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                                    height: Constants.screenHeight * 0.2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Image.network(
                                            "${snapshot.data[index].image}",
                                            fit: BoxFit.cover,
                                            height: Constants.screenHeight * 0.15,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Nom : ${snapshot.data[index].name}"),
                                                Text("Adresse : ${snapshot.data[index].adresse}"),
                                                Text("Prix : ${snapshot.data[index].price}"),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ],
            )));
  }
}
