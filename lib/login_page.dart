import 'package:asset_trissur_work_new/descriptiion_page.dart';
import 'package:asset_trissur_work_new/constants.dart';
import 'package:asset_trissur_work_new/sign_up.dart';
import 'package:asset_trissur_work_new/user_home.dart';
import 'package:asset_trissur_work_new/asset_master_home.dart';
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
   final TextEditingController controller = new TextEditingController();
   final TextEditingController user_name  = new TextEditingController();
   final List<String> privi = ["Privilage","AssetMaster","AssetHead","User"];
  String selectedPrivi = "Privilage";

  void validate()
   {

      if (formkey.currentState!.validate() &&
          selectedPrivi == "AssetHead" ) {
        showDialog(context: context, builder: (ctx) =>
            AlertDialog(
              title: const Text("Asset Head Login Successfull",),
              content: GestureDetector(
                  onTap: () {

                    Navigator.push(context, MaterialPageRoute(builder: (context) =>
                        asset_head_home(user_name: user_name.text, selectedPrivi: selectedPrivi)));

                  },
                  child: const Text("Continue", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontSize: 20))
              ),
            )
        );
      }

      else  if (formkey.currentState!.validate() &&
            selectedPrivi == "AssetMaster") {
          showDialog(context: context, builder: (ctx) =>
              AlertDialog(
                title: const Text("Asset Master Login Successfull",),
                content: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>
                              asset_master_home(user_name: user_name.text, selectedPrivi: '',)));
                    },
                    child: const Text("Continue", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontSize: 20))
                ),
              )
          );
        }


     else   if (formkey.currentState!.validate() && selectedPrivi == "User") {
          showDialog(context: context, builder: (ctx) =>
              AlertDialog(
                title: const Text("User Login Successfull",),
                content: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>
                              user_home(user_name: user_name.text,)));
                    },
                    child: const Text("Continue", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontSize: 20))),
              )
          );
        }

        //essential}

    else
         {
          showDialog(context: context, builder:(ctx) =>
            const AlertDialog(
              title: Text(" Alert Box"),
              content: Text("Login not Scuccessfull"),
           )
          );
         }
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
                        colors:  [Colors.white,Colors.white,],),
                      borderRadius:BorderRadius.circular(10),color: Colors.white,),
                    child: Stack(

                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Opacity(
                              opacity: 0.7,
                              child: Container(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(color: Colors.white),
                                  child: Image.asset('images/bg.png', fit: BoxFit.fill)
                              )
                          ),

                        ),

                        //Logo of the app
                        Padding(
                          padding: const EdgeInsets.only(top:150.0,left: 8),
                          child:
                          Container(
                              height: 100,
                              width: 200,
                              child: Image.asset('images/room_logo.jpg',fit: BoxFit.cover,)),
                        ),
                        //asset mngmnt sys  text
                        const Padding(
                            padding: EdgeInsets.fromLTRB(30,220,40,10),
                            child: Text("Assets Management System",
                              style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),)),
                        //lets login text
                        const Padding(
                            padding: EdgeInsets.fromLTRB(30,270,40,10),
                            child: Text("Let's Login",
                              style: TextStyle(fontSize: 35 ,fontWeight: FontWeight.bold),)),
                        //do u hv accnt text
                        const Padding(
                            padding: EdgeInsets.fromLTRB(30,320,40,10),
                            child: Text("Do you have an account? Login",
                              style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),)),
                        //username
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30,400,40,0),
                          // Email validation
                          child:  TextFormField(
                            validator: MultiValidator([
                              RequiredValidator(errorText: "Username  can't be blank"),
                            ]),
                            controller: user_name,
                            autocorrect: true,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.email_outlined,color:Color(0xFF468c90)),
                              hintText: 'Username ',
                              hintStyle: TextStyle(color: Color(0xFF468c90)),
                              filled: true,
                              fillColor: Color(0xFFe0f4f5),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Color(0xFFe0f4f5), width: 2),),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),

                              ),

                            ),
                            autofocus: false,
                            textInputAction: TextInputAction.done,
                            //textInputAction: TextInputAction.done, // Hides the keyboard.

                          ),

                        ),
                        //password
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30,470,40,30),
                          child:  TextFormField(
                             validator:  validatePassword,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.lock_outline,color:Color(0xFF468c90)),
                              hintText: 'Password',
                              hintStyle: TextStyle(color: Color(0xFF468c90)),
                              //hintStyle: Color(0xFF468c90),
                              //fontSize: 20,fontWeight: FontWeight.bold
                              // ),
                              filled: true,
                              fillColor:Color(0xFFe0f4f5),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                borderSide: BorderSide(color: Color(0xFFe0f4f5) , width: 2),),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                            // textInputAction: TextInputAction.done,
                            textInputAction: TextInputAction.done,
                            autofocus: false,
                            onFieldSubmitted: (_) => FocusScope.of(context).unfocus(), // focus to next


                            // Hides the keyboard.

                          ),
                        ),
                        //forgot password
                        // Align(
                        //   alignment: Alignment.centerRight,
                        //   child: Text("Forgot Password",style: TextStyle(color:  Color(0xFF468c90),
                        //       fontSize: 15,fontWeight: FontWeight.bold)),
                        // ),
                      //   Padding(
                      //   padding: EdgeInsets.only(top: 700,bottom: 10),
                      //  // padding: EdgeInsets.symmetric(vertical: 30.w,horizontal: 30.h),
                      // //  padding: const EdgeInsets.fromLTRB(140,765,10,30),
                      //     child: GestureDetector(
                      //       onTap: (){
                      //         //  Navigator.push(context, MaterialPageRoute(builder: (context)=>forgot_password()));
                      //
                      //       },
                      //       child: Align(
                      //
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             const Text("Forgot Password ?",style: TextStyle(color:  Color(0xFF468c90),
                      //                 fontSize: 15,fontWeight: FontWeight.bold)),
                      //           ],
                      //         ),
                      //       ),
                      //
                      //     ),
                      //   ),

                        //login button
                        Padding(
                          padding: const EdgeInsets.only(top:610,left: 150,right: 20),
                        //  padding: const EdgeInsets.fromLTRB(150,610,20,30),
                          child: FlatButton(
                            onPressed: validate,
                            child: GestureDetector(

                              onTap: validate,
                                  //(){
                              //   Navigator.push(context, MaterialPageRoute(builder: (context)=>user_log()));

                             // },
                              child: Container(
                                height: 40,
                                width: 250,
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [Color(0xFF64C9CF), Color(0xFF468c90),],),

                                    borderRadius: BorderRadius.circular(10),color: Color(0xFF5663ff)),
                                child: const Center(
                                  child: Text('Login   →',style: TextStyle(color: Colors.white,fontSize: 20),),
                                ),
                              ),
                            ),
                          ),
                        ),
                        //privilage
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30,540,40,10),
                          child: Container(
                            width: 400,
                            height: 55,
                            decoration: BoxDecoration(borderRadius:BorderRadius.circular(10),color: Color(0xFFe0f4f5)),
                            child:   DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                // isDense: true,
                                // isExpanded: false,
                                elevation: 10,
                                iconEnabledColor: Color(0xFF468c90),
                                value: selectedPrivi,
                                onChanged: (value)
                                {
                                  setState(() {
                                    selectedPrivi = value!;
                                  });
                                },

                                items: privi.map<DropdownMenuItem<String>>((value){
                                  return DropdownMenuItem(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 30.0),
                                      child: Text(value,style: TextStyle(color:Color(0xFF468c90) ),),
                                    ),
                                    value: value,
                                  );
                                 }
                                ).toList(),
                              ),
                            ),
                          ),
                        ),
                        //sign up
                        // Align(
                        //   alignment: Alignment.bottomCenter,
                        //   child: GestureDetector(
                        //     onTap: (){
                        //       Navigator.push(context, MaterialPageRoute(builder: (context)=>sign_up()));
                        //     },
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: const [
                        //        //
                        //         Text('Create an account ?',style: TextStyle(color: Colors.black,fontSize: 20),),
                        //         Text("Sign Up",style: TextStyle(color:  Color(0xFF468c90),
                        //             fontSize: 20,fontWeight: FontWeight.bold),),
                        //         SizedBox(height: 40,)
                        //       ],
                        //
                        //     ),
                        //
                        //   ),
                        // ),
                        //extra code

                        // Padding(
                        //   padding: const EdgeInsets.fromLTRB(50,780,40,30),
                        //    child: Container(
                        //      height: 60,
                        //       width: 300,
                        //        decoration: BoxDecoration(
                        //          borderRadius: BorderRadius.circular(10),
                        //           color: Colors.transparent),
                        //      child: GestureDetector(
                        //        onTap: (){
                        //          Navigator.push(context, MaterialPageRoute(builder: (context)=>sign_up()));
                        //        },
                        //         child: Row(
                        //          children: const [
                        //            SizedBox(width: 40,),
                        //             Text('Create an account ?',style: TextStyle(color: Colors.black,fontSize: 20),),
                        //              Text("Sign Up",style: TextStyle(color:  Color(0xFF468c90),
                        //                fontSize: 20,fontWeight: FontWeight.bold),)
                        //          ],
                        //        ),
                        //      ),
                        //    ),
                        // ),
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


