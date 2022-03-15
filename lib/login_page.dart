
import 'package:asset_trissur_work_new/create_dept.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:asset_trissur_work_new/authentication.dart';
import 'package:asset_trissur_work_new/descriptiion_page.dart';
import 'package:asset_trissur_work_new/constants.dart';
import 'package:asset_trissur_work_new/sign_up.dart';
import 'package:asset_trissur_work_new/user_home.dart';
import 'package:asset_trissur_work_new/asset_master_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:sizer/sizer.dart';

import 'home_head.dart';

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController pass_word = new TextEditingController();
  final TextEditingController user_name = new TextEditingController();
  final List<String> privilage = [
    "Select Privilage",
    "AssetMaster",
    "AssetHead",
    "User"
  ];
  String errorMsg="";
  String selectedPrivilage = "Select Privilage";

  String email = "";
  String password = "";
  String privi ="";

  void validate() async {
    if (formkey.currentState!.validate() && selectedPrivilage == "AssetHead") {
      formkey.currentState?.save();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: user_name.text, password: pass_word.text);

      setState(() {
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: const Text(
                    "Asset Head Login Successfull",
                  ),
                  content: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => asset_head_home(
                                  user_name: user_name.text,
                                  selectedPrivi: selectedPrivilage)));
                    },
                    child: const Text("Continue",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontSize: 20)),
                  ),
                ));
      });
    } else if (formkey.currentState!.validate() &&
        selectedPrivilage == "AssetMaster") {
      formkey.currentState?.save();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: user_name.text, password: pass_word.text);
      setState(() {
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: const Text(
                    "Asset Master Login Successfull",
                  ),
                  content: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => asset_master_home(
                                      user_name: user_name.text,
                                      selectedPrivi: '',
                                    )));
                      },
                      child: const Text("Continue",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontSize: 20))),
                ));
      });
    } else if (formkey.currentState!.validate() &&
        selectedPrivilage == "User") {
      formkey.currentState?.save();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: user_name.text, password: pass_word.text);
      setState(() {
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: const Text(
                    "User Login Successfull",
                  ),
                  content: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => user_home(
                                      user_name: user_name.text,
                                    )));
                      },
                      child: const Text("Continue",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontSize: 20))),
                ));
      });
    }

    else if(formkey.currentState!.validate()){
      AuthenticationHelper()
          .signIn(email: email, password: password,privi: selectedPrivilage)
          .then((result) {
        if (result == null)
        {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => create_dep()));
        }
       else {
          setState(() {
                 showDialog(
                     context: context,
                     builder: (ctx) =>  const AlertDialog(
                       title: Text("Login Failed!"),
                       content: const Text("Invalid User Credetials !!",style: TextStyle(color: Colors.black38),),
                       // content:
                       //   Text("$errorMsg"),
                     ));
               });
             }

      });
    }

    //else if (formkey.currentState!.validate()){

    // else if (formkey.currentState!.validate()) {
    //   try {
    //
    //     await FirebaseAuth.instance.signInWithEmailAndPassword(
    //         email: user_name.text, password: pass_word.text);
    //     errorMsg="";
    //   } on FirebaseAuthException catch (error) {
    //     errorMsg  = error.message!;
    //   }
    //
    //
    //   setState(() {
    //     showDialog(
    //         context: context,
    //         builder: (ctx) =>  AlertDialog(
    //           title: Text("Login Failed!"),
    //           //content: Text("Invalid User Credetials"),
    //           content:
    //             Text("$errorMsg"),
    //         ));
    //   });
    // }
  }

  final focus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(0),
                child: Form(
                  // autovalidate: true,
                  key: formkey,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white,
                          Colors.white,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Opacity(
                              opacity: 0.7,
                              child: Container(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  decoration:
                                      const BoxDecoration(color: Colors.white),
                                  child: Image.asset('images/bg.png',
                                      fit: BoxFit.fill))),
                        ),
                        //Logo of the app
                        Padding(
                          padding: const EdgeInsets.only(top: 150.0, left: 8),
                          child: Container(
                              height: 100,
                              width: 200,
                              child: Image.asset(
                                'images/room_logo.jpg',
                                fit: BoxFit.cover,
                              )),
                        ),
                        //asset mngmnt sys  text
                        const Padding(
                            padding: EdgeInsets.fromLTRB(30, 220, 40, 10),
                            child: Text(
                              "Assets Management System",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            )),
                        //lets login text
                        const Padding(
                            padding: EdgeInsets.fromLTRB(30, 270, 40, 10),
                            child: Text(
                              "Let's Login",
                              style: TextStyle(
                                  fontSize: 35, fontWeight: FontWeight.bold),
                            )),
                        //do u hv accnt text
                        const Padding(
                            padding: EdgeInsets.fromLTRB(30, 320, 40, 10),
                            child: Text(
                              "Do you have an account? Login",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            )),
                        //username
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 400, 40, 0),
                          // Email validation
                          child: TextFormField(
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "Username  can't be blank"),
                            ]),
                            controller: user_name,
                            autocorrect: true,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.email_outlined,
                                  color: Color(0xFF468c90)),
                              hintText: 'Username ',
                              hintStyle: TextStyle(color: Color(0xFF468c90)),
                              filled: true,
                              fillColor: Color(0xFFe0f4f5),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                    color: Color(0xFFe0f4f5), width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                            autofocus: false,
                            textInputAction: TextInputAction.done,
                          ),
                        ),
                        //password
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 470, 40, 30),
                          child: TextFormField(
                            controller: pass_word,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "Password can't be blank"),
                            ]),
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.lock_outline,
                                  color: Color(0xFF468c90)),
                              hintText: 'Password',
                              hintStyle: TextStyle(color: Color(0xFF468c90)),
                              filled: true,
                              fillColor: Color(0xFFe0f4f5),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                borderSide: BorderSide(
                                    color: Color(0xFFe0f4f5), width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                            textInputAction: TextInputAction.done,
                            autofocus: false,
                            onFieldSubmitted: (_) => FocusScope.of(context)
                                .unfocus(), // focus to next
                            // Hides the keyboard.
                          ),
                        ),

                        //login button
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 610, left: 150, right: 35),
                          //  padding: const EdgeInsets.fromLTRB(150,610,20,30),
                          child: TextButton(
                            onPressed: validate,
                            child: GestureDetector(
                              onTap: validate,
                              child: Container(
                                height: 40,
                                width: 250,
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xFF64C9CF),
                                        Color(0xFF468c90),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xFF5663ff)),
                                child: const Center(
                                  child: Text(
                                    'Login   →',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        //privilage
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 540, 40, 10),
                          child: Container(
                            width: 400,
                            height: 55,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFFe0f4f5)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                // isDense: true,
                                // isExpanded: false,
                                elevation: 10,
                                iconEnabledColor: const Color(0xFF468c90),
                                value: selectedPrivilage,
                                onChanged: (value) {
                                  setState(() {
                                    selectedPrivilage = value!;
                                  });
                                },

                                items: privilage
                                    .map<DropdownMenuItem<String>>((value) {
                                  return DropdownMenuItem(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 30.0),
                                      child: Text(
                                        value,
                                        style:
                                            const TextStyle(color: const Color(0xFF468c90)),
                                      ),
                                    ),
                                    value: value,
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
