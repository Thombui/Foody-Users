import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodpanda_users_app/Widgets/order_card.dart';
import 'package:foodpanda_users_app/Widgets/progress_bar.dart';
import 'package:foodpanda_users_app/Widgets/simple_app_bar.dart';
import 'package:foodpanda_users_app/assistantMethods/assistant_methods.dart';
import 'package:foodpanda_users_app/global/global.dart';

class HistoryScreen extends StatefulWidget
{


  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SimpleAppBar(title: "Lịch sử đặt hàng",),
        body: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(sharedPreferences!.getString("uid"))
                .collection("orders")
                .where("status", isEqualTo: "Giao thành công")
                .orderBy("orderTime", descending: true)
                .snapshots(),
            builder: (c, snapshot)
            {
              return snapshot.hasData? ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (c, index)
                {
                  return FutureBuilder<QuerySnapshot>(
                    future: FirebaseFirestore.instance
                        .collection("items")
                        .where("itemID", whereIn: separateOrdersItemIDs((snapshot.data!.docs[index].data()! as Map<String, dynamic>) ["productIDs"] ))
                        .where("orderBy", whereIn : (snapshot.data!.docs[index].data()! as Map<String, dynamic>) ["uid"])
                        .orderBy("publishedDate", descending: true)
                        .get(),
                    builder: (c, snap)
                    {
                      return snap.hasData
                          ? OrderCard(
                        itemCount: snap.data!.docs.length,
                        data: snap.data!.docs,
                        orderID: snapshot.data!.docs[index].id,
                        seperateQuantitiesList: separateOrderItemQuantities((snapshot.data!.docs[index].data()! as Map<String, dynamic>)["productIDs"] ),
                      )
                          : Center(child: circularProgress(),);
                    },
                  );

                },
              )
                  : Center(child: circularProgress(),);
            },

          ),

        )
      ),
    );
  }
}
