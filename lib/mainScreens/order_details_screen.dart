import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodpanda_users_app/Widgets/delete_history_design.dart';
import 'package:foodpanda_users_app/Widgets/delete_order_design.dart';
import 'package:foodpanda_users_app/Widgets/progress_bar.dart';
import 'package:foodpanda_users_app/Widgets/shipment_address_design.dart';
import 'package:foodpanda_users_app/Widgets/status_banner.dart';
import 'package:foodpanda_users_app/global/global.dart';
import 'package:foodpanda_users_app/models/address.dart';
import 'package:foodpanda_users_app/models/orders.dart';
import 'package:intl/intl.dart';

class OrderDetailsScreen extends StatefulWidget
{

  final String? orderID;

  OrderDetailsScreen({this.orderID});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen>
{

  String orderStatus = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection("users")
              .doc(sharedPreferences!.getString("uid"))
              .collection("orders")
              .doc(widget.orderID)
              .get(),
          builder: (c, snapshot)
          {
            Map? dataMap;
            if(snapshot.hasData)
            {
              dataMap = snapshot.data!.data()! as Map<String, dynamic>;
              orderStatus = dataMap["status"].toString();
            }
            return snapshot.hasData
                ? Container(
                      child: Column(
                        children: [
                          StatusBanner(
                            status: dataMap!["isSuccess"],
                            orderStatus: orderStatus,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Tổng tiền:  ${dataMap["totalAmount"]} Đ",
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Trạng thái đơn hàng:  ${dataMap["status"]}",
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Mã vận đơn : ${widget.orderID!}",
                                style: const TextStyle(fontSize: 16),
                              ),
                            )

                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Thời gian đặt đơn: ${DateFormat("dd MMMM, yyyy -  hh:mm aa")
                                      .format(DateTime.fromMillisecondsSinceEpoch(int.parse(dataMap["orderTime"])))}",
                                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                                ),
                              )

                          ),
                          orderStatus == "Giao thành công"
                          ?
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Thời gian giao hàng: ${DateFormat("dd MMMM, yyyy -  hh:mm aa")
                                      .format(DateTime.fromMillisecondsSinceEpoch(int.parse(dataMap["endedTime"])))}",
                                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                                ),
                              )

                          )
                          :
                              Text(""),
                          const Divider(thickness: 4,),
                          orderStatus == "Giao thành công"
                              ? Image.asset("images/delivered.jpg")
                              : Image.asset("images/state.jpg"),
                          const Divider(thickness: 4,),
                          FutureBuilder<DocumentSnapshot>(
                            future: FirebaseFirestore.instance
                                .collection("users")
                                .doc(sharedPreferences!.getString("uid"))
                                .collection("userAddress")
                                .doc(dataMap["addressID"])
                                .get(),
                            builder: (c, snapshot)
                            {
                              return snapshot.hasData
                                  ? ShipmentAddressDesign(
                                model: Address.fromJson(
                                  snapshot.data!.data()! as Map<String, dynamic>
                                )
                              ) : Center(child: circularProgress(),);
                            },
                          ),
                          orderStatus == "Giao thành công"
                              ?
                          FutureBuilder<DocumentSnapshot>(
                            future: FirebaseFirestore.instance
                                .collection("users")
                                .doc(sharedPreferences!.getString("uid"))
                                .collection("orders")
                                .doc(dataMap["orderId"])
                                .get(),
                            builder: (c, snapshot)
                            {
                              return snapshot.hasData
                                  ? DeleteHistoryDesign(
                                  model: Orders.fromJson(
                                      snapshot.data!.data()! as Map<String, dynamic>
                                  )
                              ) : Center(child: circularProgress(),);
                            },
                          )
                          :
                          FutureBuilder<DocumentSnapshot>(
                            future: FirebaseFirestore.instance
                                .collection("users")
                                .doc(sharedPreferences!.getString("uid"))
                                .collection("orders")
                                .doc(dataMap["orderId"])
                                .get(),
                            builder: (c, snapshot)
                            {
                              return snapshot.hasData
                                  ? DeleteOrderDesign(
                                  model: Orders.fromJson(
                                      snapshot.data!.data()! as Map<String, dynamic>
                                  )
                              ) : Center(child: circularProgress(),);
                            },
                          )


                        ],
                      ),
            )
                : Center(child: circularProgress(),);

          },
        ),
      ),
    );
  }
}
