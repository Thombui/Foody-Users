import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodpanda_users_app/Widgets/items_design.dart';
import 'package:foodpanda_users_app/Widgets/menus_design.dart';
import 'package:foodpanda_users_app/Widgets/sellers_design.dart';
import 'package:foodpanda_users_app/models/items.dart';
import 'package:foodpanda_users_app/models/menus.dart';
import 'package:foodpanda_users_app/models/sellers.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Future<QuerySnapshot>? restaurantsDocumentsList;
  String sellerNameText = "";

  initSearchingRestaurant(String textEntered) {
    restaurantsDocumentsList = FirebaseFirestore.instance
        .collection("sellers")
        .where("sellerName", isGreaterThanOrEqualTo: textEntered)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.cyan,
              Colors.amber,
            ],
            begin: FractionalOffset((0.0), 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          )),
        ),
        title: TextField(
          onChanged: (textEntered) {
            setState(() {
              sellerNameText = textEntered;
            });

            // init search
            initSearchingRestaurant(textEntered);
          },
          decoration: InputDecoration(
            hintText: "Tìm kiếm nhà hàng....",
            hintStyle: const TextStyle(color: Colors.white54),
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: const Icon(Icons.search),
              color: Colors.white,
              onPressed: () {
                initSearchingRestaurant(sellerNameText);
              },
            ),
          ),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: restaurantsDocumentsList,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    Sellers model = Sellers.fromJson(snapshot.data!.docs[index]
                        .data()! as Map<String, dynamic>);

                    return SellersDesgnWidget(
                      model: model,
                      context: context,
                    );
                  },
                )
              : const Center(
                  child: Text("Không tìm thấy kết quả"),
                );
        },
      ),
    );
  }
}
