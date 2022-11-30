import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodpanda_users_app/Widgets/error_dialog.dart';
import 'package:foodpanda_users_app/mainScreens/home_screen.dart';

import 'package:foodpanda_users_app/models/address.dart';
import 'package:foodpanda_users_app/models/orders.dart';
import 'package:foodpanda_users_app/splashScreen/splash_screen.dart';

import '../global/global.dart';


class DeleteHistoryDesign extends StatefulWidget {
  final Orders? model;

  //BuildContext? context;
  DeleteHistoryDesign({this.model});

  @override
  State<DeleteHistoryDesign> createState() => _DeleteHistoryDesignState();
}

class _DeleteHistoryDesignState extends State<DeleteHistoryDesign>
{
  void deleteOrders(String orderId)
  {
    FirebaseFirestore.instance.collection("users")
        .doc(sharedPreferences!
        .getString("uid"))
        .collection("orders")
        .doc(orderId)
        .get().then((snapshot)
    {
      if(snapshot.data()!["status"] == "Giao thành công")
      {
        FirebaseFirestore.instance.collection("users")
            .doc(sharedPreferences!
            .getString("uid"))
            .collection("orders")
            .doc(orderId)
            .delete()
            .then((snapshot)
        {
          FirebaseFirestore.instance
              .collection("orders")
              .doc(orderId)
              .delete();

        }
        );
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
        Fluttertoast.showToast(msg: "Đã xóa lịch sử đơn hàng thành công");

      }
      else
      {
        showDialog(
            context: context,
            builder: (c)
            {
              return ErrorDialog(
                message: "Không thể xóa lịch sử",
              );
            }
        );
      }
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: InkWell(
              onTap: () {
                deleteOrders(widget.model!.orderId!);
              },
              child: Container(
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
                width: MediaQuery.of(context).size.width - 40,
                height: 50,
                child: Center(
                  child: Text(
                    "Xóa lịch sử đơn hàng",
                    style:const TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }
}
