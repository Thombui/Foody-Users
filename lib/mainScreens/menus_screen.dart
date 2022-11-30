import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodpanda_users_app/Widgets/menus_design.dart';
import 'package:foodpanda_users_app/Widgets/progress_bar.dart';
import 'package:foodpanda_users_app/Widgets/text_widget_header.dart';
import 'package:foodpanda_users_app/assistantMethods/assistant_methods.dart';
import 'package:foodpanda_users_app/mainScreens/home_screen.dart';
import 'package:foodpanda_users_app/models/menus.dart';
import 'package:foodpanda_users_app/models/sellers.dart';
import 'package:foodpanda_users_app/splashScreen/splash_screen.dart';

class MenusScreen extends StatefulWidget
{
  final Sellers? model;
  MenusScreen({this.model});


  @override
  State<MenusScreen> createState() => _MenusScreenState();
}

class _MenusScreenState extends State<MenusScreen> {
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
                begin:  FractionalOffset((0.0), 0.0),
                end:  FractionalOffset(1.0, 0.0),
                stops: [0.0,1.0],
                tileMode: TileMode.clamp,
              )
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: ()
          {
            clearCartNow(context);
            Navigator.push(context, MaterialPageRoute(builder: (c) => const MySplashScreen()));
          },
        ),
        title: const Text(
          "Foody",
          style: TextStyle(fontSize: 45, fontFamily: "Signatra"),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(pinned: true,delegate: TextWidgetHeader(title: "${widget.model!.sellerName} Menus")),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("sellers")
                .doc(widget.model!.sellerUID)
                .collection("menus")
                .orderBy("publishedDate", descending: true)
                .snapshots(),
            builder: (context, snapshot)
            {
              return !snapshot.hasData
                  ? SliverToBoxAdapter(
                child: Center(child: circularProgress(),),
              )
                  : SliverStaggeredGrid.countBuilder(
                      crossAxisCount: 1,
                      staggeredTileBuilder: (c) => const StaggeredTile.fit(1),
                      itemBuilder: (context, index)
                  {
                      Menus model = Menus.fromJson(
                      snapshot.data!.docs[index].data()! as Map<String, dynamic>,
                  );
                  return MenusDesgnWidget(
                    model: model,
                    context: context,
                  );
                },
                itemCount: snapshot.data!.docs.length,
              );
            },
          ),
        ],

      ),
    );
  }
}
