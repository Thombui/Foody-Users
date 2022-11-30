import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';


class Orders
{
  String? address;
  String? addressID;
  String? earnings;
  bool? isSuccess;
  double? lat;
  double? lng;
  String? orderBy;
  String? orderId;
  String? orderTime;
  String? paymentDetails;
  String? reiderName;
  String? riderUID;
  String? sellerUID;
  String? status;
  double? totalAmount;


  Orders({
    this.address,
    this.addressID,
    this.earnings,
    this.isSuccess,
    this.lat,
    this.lng,
    this.orderBy,
    this.orderId,
    this.orderTime,
    this.paymentDetails,
    this.reiderName,
    this.riderUID,
    this.sellerUID,
    this.status,
    this.totalAmount,

  });
  Orders.fromJson(Map<String, dynamic> json)
  {
    address = json["address"];
    addressID = json['addressID'];
    earnings = json['earnings'];
    isSuccess = json['isSuccess'];
    lat = json['lat'];
    lng = json['lng'];
    orderBy = json['orderBy'];
    orderId = json['orderId'];
    orderTime = json['orderTime'];
    paymentDetails = json['paymentDetails'];
   // productIDs = json['productIDs'];
    reiderName = json['reiderName'];
    riderUID = json['riderUID'];
    sellerUID = json['sellerUID'];
    status = json['status'];
    totalAmount = json['totalAmount'];
  }

  Map<String, dynamic> toJson()
  {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["address"] = address;
    data["addressID"] = addressID;
    data["earnings"] = earnings;
    data["isSuccess"] = isSuccess;
    data["lat"] = lat;
    data["lng"] = lng;
    data["orderBy"] = orderBy;
    data["orderId"] = orderId;
    data["orderTime"] = orderTime;
    data["paymentDetails"] = paymentDetails;
    //data["productIDs"] = productIDs;
    data["reiderName"] = reiderName;
    data["riderUID"] = riderUID;
    data["sellerUID"] = sellerUID;
    data["status"] = status;
    data["totalAmount"] = totalAmount;


    return data;
  }
}