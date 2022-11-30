import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodpanda_users_app/authentication/auth_screen.dart';
import 'package:foodpanda_users_app/global/global.dart';
import 'package:foodpanda_users_app/mainScreens/home_screen.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}



class _MySplashScreenState extends State<MySplashScreen>
{
  
  startTimer()
  {
    Timer(const Duration(seconds: 2), () async
    {
      //If seller is loggedin already
      if(firebaseAuth.currentUser != null)
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen() ));

      }
      //If seller is NOT loggedin already
      else
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> const AuthScreen() ));

      }
    });
  }
 //chức năng này được gọi tự động bất cứ khi nào người dùng đến màn hình của họ.
  @override
  void initState() {

    super.initState();
    startTimer();
  }

  @override

  Widget build(BuildContext context) {
    return Material(
      child: Container(

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset("images/foody-logo.jpg"),
              ),

              const SizedBox(height: 10,),

              const Padding(
               padding: EdgeInsets.all(10.0),
               child: Text(
                 "Ăn uống thả ga với Foody nhé",
                 textAlign: TextAlign.center,
                 style: TextStyle(
                   color: Colors.black87,
                   fontWeight: FontWeight.bold,
                   fontSize: 25,
                   fontFamily: "Regular",
                   letterSpacing: 3,
                 ),
               ),
             ),

            ],
          ),
        ),
      ),
    );
  }
}
