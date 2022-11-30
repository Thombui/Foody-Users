import 'package:flutter/material.dart';
import 'package:foodpanda_users_app/models/items.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

class CartItemDesign extends StatefulWidget
{
  final Items? model;
  BuildContext? context;
  final int? quanNumber;

  CartItemDesign({
    this.model,
    this.context,
    this.quanNumber,
});

  @override
  State<CartItemDesign> createState() => _CartItemDesignState();
}

class _CartItemDesignState extends State<CartItemDesign>
{

  TextEditingController counterTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.cyan,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(

              children: [

                // image
                Image.network(widget.model!.thumbnaiUrl!, width: 140, height: 120,),

                const SizedBox(width: 6,),

                //title
                //quantity Number
                // price

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //title
                     Text(

                      widget.model!.title!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: "Kiwi",
                      ),
                    ),
                    const SizedBox(
                      height: 1,
                    ),

                    // quantity number  //x7
                    Row( // x 7
                      children: [
                        const Text(
                          "x ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontFamily: "Acme",
                          ),
                        ),
                        Text(
                          widget.quanNumber.toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontFamily: "Acme",
                          ),
                        ),

                      ],
                    ),

                    // price
                    Row( // x 7
                      children: [
                        const Text(
                          "Đơn giá:  ",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,

                          ),
                        ),

                        Text(
                          widget.model!.price.toString() +" Đ",
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),

                  ],
                )
              ],
            ),
          )

        ),
      ),
    );
  }
}
