import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodpanda_users_app/assistantMethods/cart_item_counter.dart';
import 'package:foodpanda_users_app/global/global.dart';
import 'package:foodpanda_users_app/splashScreen/splash_screen.dart';
import 'package:provider/provider.dart';

separateOrdersItemIDs(orderIDs)
{
  List<String> separateItemIDsList = [], defaultItemList = [];
  int i = 0;

  defaultItemList = List<String>.from(orderIDs) ;

  for(i; i<defaultItemList.length; i++)
  {
    //56557657:7
    String item = defaultItemList[i].toString();
    var pos = item.lastIndexOf(":");

    //56557557
    String getItemId = (pos != -1) ? item.substring(0, pos) : item;

    print("\n This is itemID now = " + getItemId);

    separateItemIDsList.add(getItemId);

  }

  print("This is items List now = ");
  print(separateItemIDsList);

  return separateItemIDsList;
}

separateItemIDs()
{
  List<String> separateItemIDsList = [], defaultItemList = [];
  int i = 0;

  defaultItemList = sharedPreferences!.getStringList("userCart")!;

  for(i; i<defaultItemList.length; i++)
  {
    //56557657:7
    String item = defaultItemList[i].toString();
    var pos = item.lastIndexOf(":");

          //56557557
    String getItemId = (pos != -1) ? item.substring(0, pos) : item;
    
    print("\n This is itemID now = " + getItemId);

    separateItemIDsList.add(getItemId);
    
  }

  print("This is items List now = ");
  print(separateItemIDsList);

  return separateItemIDsList;
}


addItemToCart(String? foodItemID, BuildContext context, int itemCounter)
{
  List<String>? tempList = sharedPreferences!.getStringList("userCart");
  tempList!.add(foodItemID! + ":$itemCounter"); //56557557:7

  FirebaseFirestore.instance.collection("users")
      .doc(firebaseAuth.currentUser!.uid).update({
    "userCart": tempList,
  }).then((value)
  {
    Fluttertoast.showToast(msg: "Món ăn đã được thêm vào giỏ hàng");

    sharedPreferences!.setStringList("userCart", tempList);

    // update the badge
    Provider.of<CartItemCounter>(context, listen: false).displayCartListItemsNumber();
  });


}

separateItemQuantities()
{
  List<int> separateItemQuantitiesList = [];
  List<String> defaultItemList = [];
  int i = 1;

  defaultItemList = sharedPreferences!.getStringList("userCart")!;

  for(i; i<defaultItemList.length; i++)
  {
    //56557557:7
    String item = defaultItemList[i].toString();


    //7
    List<String> listItemCharacters = item.split(":").toList();

    var quanNumber = int.parse(listItemCharacters[1].toString());


    print("\n This is Quantity Number  = " + quanNumber.toString());

    separateItemQuantitiesList.add(quanNumber);

  }

  print("\nThis is Quantity List now = ");
  print(separateItemQuantitiesList);

  return separateItemQuantitiesList;
}


separateOrderItemQuantities(orderIDs)
{
  List<String> separateItemQuantitiesList = [];
  List<String> defaultItemList = [];
  int i = 1;

  defaultItemList = List<String>.from(orderIDs) ;

  for(i; i<defaultItemList.length; i++)
  {
    //56557557:7
    String item = defaultItemList[i].toString();


    //0=:
    //1=7
    //:7

    List<String> listItemCharacters = item.split(":").toList();

    //7
    var quanNumber = int.parse(listItemCharacters[1].toString());


    print("\n This is Quantity Number  = $quanNumber");

    separateItemQuantitiesList.add(quanNumber.toString());

  }

  print("\nThis is Quantity List now = ");
  print(separateItemQuantitiesList);

  return separateItemQuantitiesList;
}

clearCartNow(context)
{
  sharedPreferences!.setStringList("userCart", ['garbageValue']);
  List<String>? emptyList = sharedPreferences!.getStringList("userCart");

  FirebaseFirestore.instance
      .collection("users")
      .doc(firebaseAuth.currentUser!.uid)
      .update({"userCart": emptyList}).then((value)
  {
    sharedPreferences!.setStringList("userCart", emptyList!);

  });

}





