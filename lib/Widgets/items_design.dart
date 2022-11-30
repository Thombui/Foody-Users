import 'package:flutter/material.dart';
import 'package:foodpanda_users_app/mainScreens/item_detail_screen.dart';
import 'package:foodpanda_users_app/models/items.dart';

class ItemsDesignWidget extends StatefulWidget {

  Items? model;
  BuildContext? context;

  ItemsDesignWidget({this.model, this.context});


  @override
  State<ItemsDesignWidget> createState() => _ItemsDesignWidgetState();
}

class _ItemsDesignWidgetState extends State<ItemsDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemDetailsScreen(model: widget.model)));
      },
      splashColor: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          height: 285,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Divider(
                  height: 20,
                  thickness: 3,
                  color: Colors.grey[300],
                ),
                Image.network(
                  widget.model!.thumbnaiUrl!,
                  height: 220.0,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 1.0,),
                Text(
                  widget.model!.title!,
                  style: const TextStyle(
                    color: Colors.cyan,
                    fontSize: 18,
                    fontFamily: "TrainOne",
                  ),
                ),
                Text(
                  widget.model!.shortInfo!,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                Divider(
                  height: 4,
                  thickness: 3,
                  color: Colors.grey[300],
                ),

              ],
            ),
          )

        ),
      ),
    );
  }
}
