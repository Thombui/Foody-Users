import 'package:flutter/material.dart';
import 'package:foodpanda_users_app/mainScreens/items_screen.dart';
import 'package:foodpanda_users_app/models/menus.dart';
import 'package:foodpanda_users_app/models/sellers.dart';

class MenusDesgnWidget extends StatefulWidget {

  Menus? model;
  BuildContext? context;

  MenusDesgnWidget({this.model, this.context});


  @override
  State<MenusDesgnWidget> createState() => _MenusDesgnWidgetState();
}

class _MenusDesgnWidgetState extends State<MenusDesgnWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemsScreen(model: widget.model)));
      },
      splashColor: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          height: 285,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child:  Column(
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
                  widget.model!.menuTitle!,
                  style: const TextStyle(
                    color: Colors.cyan,
                    fontSize: 18,
                    fontFamily: "TrainOne",
                  ),
                ),
                Text(
                  widget.model!.menuInfo!,
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
