import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodpanda_users_app/Widgets/custom_text_field.dart';
import 'package:foodpanda_users_app/Widgets/error_dialog.dart';
import 'package:foodpanda_users_app/Widgets/loading_dialog.dart';
import 'package:foodpanda_users_app/mainScreens/home_screen.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStrorage;
import 'package:shared_preferences/shared_preferences.dart';

import '../global/global.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();


  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();

  String sellerImageUrl = "";

  Future<void> _getImage() async
  {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery); //cho phép người dùng lấy bất kỳ ảnh nào từ thư viện
    setState(() {
      imageXFile;
    });

  }



  // Chức năng đồng bộ
  Future<void> formValidation() async
  {
    if(imageXFile == null)
      {
        showDialog(
          context: context,
          builder: (c)
          {
              return ErrorDialog(
                message: "Vui lòng chọn ảnh",
              );
          }
        );
      }
    else
    {
      if(passwordController.text == confirmPasswordController.text)
      {

        if(confirmPasswordController.text.isNotEmpty && passwordController.text.isNotEmpty && nameController.text.isNotEmpty)
        {
          // start uploading image
          showDialog(
            context: context,
            builder: (c){
              return LoadingDialog(
                message: "Đang đăng ký tài khoản",
              );
            }
          );

          String fileName = DateTime.now().millisecondsSinceEpoch.toString();
          fStrorage.Reference reference = fStrorage.FirebaseStorage.instance.ref().child("users").child(fileName);
          fStrorage.UploadTask uploadTask = reference.putFile(File(imageXFile!.path));
          fStrorage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
          await taskSnapshot.ref.getDownloadURL().then((url) {
            sellerImageUrl = url;

            // save info to firestore
            authenticateSellerAndSignUp();
          });

        }
        else
          {
            showDialog(
                context: context,
                builder: (c)
                {
                  return ErrorDialog(
                    message: "Vui lòng viết đầy đủ thông tin yêu cầu để đăng ký.",
                  );
                }
            );
          }
      }
      else
      {
        showDialog(
            context: context,
            builder: (c)
            {
              return ErrorDialog(
                message: "Password không khớp",
              );
            }
        );
      }
    }
  }

  void authenticateSellerAndSignUp() async
  {
    User? currentUser;

    await firebaseAuth.createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    ).then((auth){
      currentUser = auth.user;
    }).catchError((error){
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c)
          {
            return ErrorDialog(
              message: error.message.toString(),
            );
          }
      );
    });

    if(currentUser != null)
      {
        saveDataToFirestore(currentUser!).then((value) {
          Navigator.pop(context);
          // send user to homePage

          Route newRoute = MaterialPageRoute(builder: (c) => const HomeScreen());
          Navigator.pushReplacement(context, newRoute);
        });
      }
  }


  Future saveDataToFirestore(User currentUser) async
  {
    FirebaseFirestore.instance.collection("users").doc(currentUser.uid).set({
      "uid": currentUser.uid,
      "Email": currentUser.email,
      "Name": nameController.text.trim(),
      "photoUrl": sellerImageUrl,
      "status": "approved",
      "userCart": ['garbageValue'],
    });

    // save data locally
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.setString("uid", currentUser.uid);
    await sharedPreferences!.setString("email", currentUser.email.toString());
    await sharedPreferences!.setString("name", nameController.text.trim());
    await sharedPreferences!.setString("photoUrl", sellerImageUrl);
    await sharedPreferences!.setStringList("userCart", ['garbageValue']);
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            // chọn hình ảnh đại diện
            const SizedBox(height: 10,),
            InkWell(
              onTap: (){
                _getImage();
              },
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.20,
                backgroundColor: Colors.white,
                backgroundImage: imageXFile == null ? null : FileImage(File(imageXFile!.path)) ,
                child: imageXFile == null
                  ?
                Icon(
                  Icons.add_photo_alternate,
                  size: MediaQuery.of(context).size.width * 0.20,
                  color: Colors.grey,
                ): null,


              ),
            ),
            const SizedBox(height: 10,),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    data: Icons.person,
                    controller: nameController,
                    hintText: "Tên khách hàng",
                    isObsecre: false,
                  ),
                  CustomTextField(
                    data: Icons.email,
                    controller: emailController,
                    hintText: "Email",
                    isObsecre: false,
                  ),
                  CustomTextField(
                    data: Icons.lock,
                    controller: passwordController,
                    hintText: "Password",
                    isObsecre: true,
                  ),
                  CustomTextField(
                    data: Icons.lock,
                    controller: confirmPasswordController,
                    hintText: "Xác nhận Password",
                    isObsecre: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.cyan,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10)
              ),
              onPressed: ()
              {
                formValidation();
              },
              child: const Text(
                "Đăng ký",
                 style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),
              ),
            ),
            const SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
}
