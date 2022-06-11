
import 'package:asset_trissur_work_new/constants.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'constants.dart';



class sign_up extends StatefulWidget {
  // const sign_up({Key? key}) : super(key: key);

  @override
  _sign_upState createState() => _sign_upState();
}

class _sign_upState extends State<sign_up> {
  final List<String> subjects = ["Privilage", "Asset Master", "Asset Head"];
  String selectedSubject = "Privilage";

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController createpassword = TextEditingController();
  TextEditingController confirmpassword =TextEditingController();
  TextEditingController userController =TextEditingController();
  TextEditingController institution =TextEditingController();


  void clearText() {
    createpassword.clear();
    confirmpassword.clear();
    userController.clear();
    institution.clear();
  }

  void validate(){
    if(formkey.currentState!.validate())
    {

      //Alert box code for showing status
      showDialog(context: context, builder:(ctx) =>  AlertDialog(
        title: const Text("User Created Succesfully",
          style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 20),),
        content: GestureDetector(
            onTap:  (){
              clearText();
              Navigator.pop(context);

            },
            child: const Text("Continue",style: TextStyle(color: Colors.green,fontWeight: FontWeight.w900,fontSize: 20),)),


      )
      );
    }
    else{
      showDialog(context: context, builder:(ctx) => const AlertDialog(
        title: Text("User Creation Failed",
          style: TextStyle(color: Colors.red,fontWeight: FontWeight.w900,fontSize: 20),),

      )
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    var currentValue;

    return WillPopScope(

      onWillPop: () async => false,
      child: Scaffold(
             body: SingleChildScrollView(
          child: Column(
            children: [
              Form(
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
                          padding: const EdgeInsets.only(top:80.0,left: 8),
                          child:
                          SizedBox(
                              height: 100,
                              width: 200,
                              child: Image.asset('images/room_logo.jpg',fit: BoxFit.cover,)),
                        ),


                        const Padding(
                            padding: EdgeInsets.fromLTRB(30,145,40,10),
                            child: Text("Assets Management System",
                              style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),)),
                        const Padding(
                            padding: EdgeInsets.fromLTRB(30,180,40,10),
                            child: Text("Create Asset Master",
                              style: TextStyle(fontSize: 25,),)),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(30,320,30,10),
                          // Email validation
                          child:  TextFormField(
                            validator: MultiValidator([
                              RequiredValidator(errorText: "Username can't be blank"),
                              //EmailValidator(errorText: 'Not a valid email'),

                            ]),
                            autocorrect: true,
                            controller: userController,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.person_outlined,color:Color(0xFF468c90)),
                              hintText: 'User Name',
                              hintStyle: TextStyle(color: Color(0xFF468c90)),
                              filled: true,
                              fillColor: Color(0xFFe0f4f5),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Color(0xFFe0f4f5), width: 0),),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),),

                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(30,390,30,10),
                          // Email validation
                          child:  TextFormField(
                            validator: validatePassword,
                            // validator: MultiValidator([
                            //   RequiredValidator(errorText: "Email can't be blank"),
                            //   EmailValidator(errorText: 'Not a valid email'),
                            //
                            // ]),
                            autocorrect: true,
                            controller: createpassword,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.lock_open,color:Color(0xFF468c90)),
                              hintText: 'Create Password',
                              hintStyle: TextStyle(color: Color(0xFF468c90)),
                              filled: true,
                              fillColor: Color(0xFFe0f4f5),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Color(0xFFe0f4f5), width: 2),),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),),

                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30,460,30,10),
                          // Email validation
                          child:  TextFormField(
                            controller: confirmpassword,
                            validator: (value){
                              if (value!.isEmpty)
                              {
                                return "Password can't be blank";
                              }
                              if (value.length>6)
                              {
                                return "Should be 6 characters";
                              }
                              if (createpassword.text !=confirmpassword.text)
                              {
                                return "Password does not match";
                              }
                              return null;
                            },


                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.lock_outline,color:Color(0xFF468c90)),
                              hintText: 'Confirm Password',
                              hintStyle: TextStyle(color: Color(0xFF468c90)),
                              filled: true,
                              fillColor: Color(0xFFe0f4f5),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Color(0xFFe0f4f5), width: 2),),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),),

                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(30,530,30,10),
                          // Email validation
                          child:  TextFormField(
                            validator: MultiValidator([
                              RequiredValidator(errorText: "Institution can't be blank"),
                              //EmailValidator(errorText: 'Not a valid Password'),

                            ]),
                            autocorrect: true,
                            controller: institution,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.add_business,color:Color(0xFF468c90)),
                              hintText: 'Institution',
                              hintStyle: TextStyle(color: Color(0xFF468c90)),
                              filled: true,
                              fillColor: Color(0xFFe0f4f5),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Color(0xFFe0f4f5), width: 2),),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),),

                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 700,left:0,right: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap:  (){
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width/2.5,
                                  decoration: BoxDecoration(border: Border.all(color: const Color(0xFF468c90)),
                                    // gradient: const LinearGradient(
                                    //   begin: Alignment.topLeft,
                                    //   end: Alignment.bottomRight,
                                    //   colors: [Color(0xFF64C9CF), Color(0xFF468c90),],),

                                    borderRadius: BorderRadius.circular(10),
                                    //color: Color(0xFF5663ff)
                                  ),
                                  child: const Center(
                                    child: Text('Cancel',style: TextStyle(color:Color(0xFF468c90),fontSize: 14),),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10,),
                              GestureDetector(
                                //onTap: validatethis,
                                onTap: validate,// (){
                                //Navigator.push(context, MaterialPageRoute(builder: (context)=>create_page()));
                                // },
                                child: Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width/2.5,
                                  decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [Color(0xFF64C9CF), Color(0xFF468c90),],),

                                      borderRadius: BorderRadius.circular(10),color: const Color(0xFF5663ff)),
                                  child:  Center(
                                    child: Text('Create',style: buildTextStyle(),),
                                  ),
                                ),
                              ),],
                          ),
                        ),





                      ],
                    ),
                  ))
            ],
          ),
        ),


      ),
    );
  }
}
