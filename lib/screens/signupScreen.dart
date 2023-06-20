import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:testproj/constant/color.dart';
import 'package:testproj/screens/signin.dart';

class signUp extends StatefulWidget {
  const signUp({super.key});

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  String email="";
  String password="";
  String confPassword="";
  String output="";

Future<void> signUpFirebase() async{
  if(password==confPassword){
  try{
    UserCredential userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    Fluttertoast.showToast(msg: "User Signed Up Sucessfully.",toastLength: Toast.LENGTH_SHORT);
  }
  on FirebaseAuthException catch(e) {
    if(e.code=='weak-password'){
      Fluttertoast.showToast(msg: "Password Provided too weak.",toastLength: Toast.LENGTH_SHORT);
    }
    else if(e.code=='email-already-in-use'){
      Fluttertoast.showToast(msg: "User already exists for the given email.",toastLength: Toast.LENGTH_SHORT);
    }
  }
  catch (e){
    Fluttertoast.showToast(msg: e.toString(),toastLength: Toast.LENGTH_SHORT);
  }}
  else{
    Fluttertoast.showToast(msg: "Password does not match.",toastLength: Toast.LENGTH_SHORT);
  }
}
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text(" "),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                children: [
                  Text(
                    "Let’s Create Your ",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: textColor),
                  ),
                  Text(
                    "Account",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: companyColor),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Text(
                "Be Creative...",
                style: TextStyle(fontSize: 20, color: textColor),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 30),
              child: TextField(
                onChanged:(value)=> setState(() {
                  email=value;
                }),
                decoration: InputDecoration(
                  hintText: "Enter your email",
                  filled: true,
                  fillColor: trans,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: textColor, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: companyColor, width: 1.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 20),
              child: TextField(onChanged:(value)=> setState(() {
                  password=value;
                }),
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Create your password",
                  filled: true,
                  fillColor: trans,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: textColor, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: companyColor, width: 1.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 20),
              child: TextField(
                onChanged:(value)=> setState(() {
                  confPassword=value;
                }),
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Confirm password",
                  filled: true,
                  fillColor: trans,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: textColor, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: companyColor, width: 1.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 40),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: TextButton(
                  onPressed: signUpFirebase,
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(companyColor),
                    foregroundColor: MaterialStatePropertyAll(lightGrey),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        color: textColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 20),

              child: GestureDetector(
                onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const signIn()),);
              },
                child: Center(
                          
                  child: Text("Already have an account",
                    style: TextStyle(
                      fontSize: 15,
                      color: textColor,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
