import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'constants.dart';

class create_user extends StatefulWidget {
  final String? user_name;
  const create_user({Key? key, required this.user_name}) : super(key: key);

  // const sign_up({Key? key}) : super(key: key);

  @override
  _create_userState createState() => _create_userState();
}

class _create_userState extends State<create_user> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final List<String> subjects = ["Privilage", "AssetHead", "User"];
  final List<String> head = [
    "Asset Head",
    "IT",
    "BioMedical",
    "Cleaning",
    "Electrical & Maintanence"
  ];
  String selectedSubject = "Privilage";
  String assethead = "AssetHead";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _createpass = TextEditingController();
  final TextEditingController _cnfrmepass = TextEditingController();
  final TextEditingController _username = TextEditingController();
  String? assetHead;
  // String assetHead = "Asset Head";
  //GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _username.dispose();
    _cnfrmepass.dispose();
    _createpass.dispose();
  }

  void clearText() {
    _username.clear();
    _createpass.clear();
    _cnfrmepass.clear();
    //selectedSubject.clear();
    // assethead.clear();
  }

  void clearDrop() {
    setState(() {
      selectedSubject = "Privilage";
      assethead = "AssetHead";
      // assetHead = "";
    });
  }

  void validate() async {
    if (_formkey.currentState!.validate() && selectedSubject == "User" ||
        selectedSubject == "AssetHead") {
      try {
        await _auth.createUserWithEmailAndPassword(
            email: _username.text.trim().toLowerCase(),
            password: _createpass.text.trim());
        final User? user = _auth.currentUser;
        final _uid = user?.uid;
        FirebaseFirestore.instance.collection('users').doc(_uid).set({
          'userId': _uid,
          'userName': _username.text,
          'role': selectedSubject,
          'assetHead': assetHead,
        });
      } on FirebaseAuthException catch (e) {
        print(e);
      }
      setState(() {
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: const Text(
                    "Added Successfully",
                    style: TextStyle(color: Colors.black54),
                  ),
                  content: GestureDetector(
                    onTap: () {
                      clearText();
                      clearDrop();
                      Navigator.pop(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left: 108.0, right: 100),
                      child: Text(
                        "Ok",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w900,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ));
      });
      //Alert box code for showing status
    }

    // setState(() {
    //   showDialog(context: context, builder:(ctx) => AlertDialog(
    //     title: Text("User Created",style: TextStyle(color: Colors.black),),
    //     content: GestureDetector(
    //       onTap: (){
    //         clearText();
    //         clearDrop();
    //         Navigator.pop(context);
    //       },
    //       child: const Text("Continue",
    //         style: TextStyle(color: Colors.green,
    //             fontWeight: FontWeight.w900,fontSize: 20),),
    //     ),
    //   )
    //   );
    //
    // })

    else {
      showDialog(
          context: context,
          builder: (ctx) => const AlertDialog(
                //title: Text("User Creation Failed"),
                content: Text(
                  "User Creation Failed",
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w900,
                      fontSize: 20),
                ),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                  key: _formkey,
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
                        Padding(
                          padding: const EdgeInsets.only(top: 80.0, left: 8),
                          child: SizedBox(
                              height: 100,
                              width: 200,
                              child: Image.asset(
                                'images/room_logo.jpg',
                                fit: BoxFit.cover,
                              )),
                        ),
                        const Padding(
                            padding: EdgeInsets.fromLTRB(30, 145, 40, 10),
                            child: Text(
                              "Assets Management System",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            )),
                        const Padding(
                            padding: EdgeInsets.fromLTRB(30, 180, 40, 10),
                            child: Text(
                              "Create User",
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 250, 40, 10),
                          // Email validation
                          child: TextFormField(
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "Username can't be blank"),
                              // EmailValidator(errorText: 'Not a valid email'),
                            ]),
                            autocorrect: true,
                            controller: _username,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.person_outlined,
                                  color: Color(0xFF468c90)),
                              hintText: 'User Name',
                              hintStyle: TextStyle(color: Color(0xFF468c90)),
                              filled: true,
                              fillColor: Color(0xFFe0f4f5),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                    color: Color(0xFFe0f4f5), width: 0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 320, 40, 10),
                          child: Container(
                            width: 340,
                            height: 55,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFFe0f4f5)),
                            child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("assethead")
                                    .orderBy('values')
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  // var department = snapshot.data;
                                  // print(
                                  //     "department snapshot ${department.toString()}");
                                  if (!snapshot.hasData) {
                                    return const CircularProgressIndicator();
                                  } else {
                                    return DropdownButtonHideUnderline(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: DropdownButton<String>(
                                          hint: const Text(
                                            "Select Asset Head",
                                            textAlign: TextAlign.center,
                                          ),
                                          value: assetHead,
                                          onChanged: (value) {
                                            print("this is: ${value}");
                                            setState(() {
                                              assetHead = value!;
                                            });
                                          },
                                          items: snapshot.data?.docs.map(
                                              (QueryDocumentSnapshot document) {
                                            // final dynamic data =
                                            //     document.data();
                                            return DropdownMenuItem<String>(
                                                value: document['values'],
                                                child: Text(document["values"]
                                                    .toString()));
                                          }).toList(),
                                        ),
                                      ),
                                    );
                                  }
                                }),
                            // DropdownButtonHideUnderline(
                            //   child: DropdownButton<String>(
                            //     dropdownColor: Colors.white,
                            //     // isDense: true,
                            //     // isExpanded: false,
                            //
                            //     elevation: 10,
                            //
                            //     iconEnabledColor: const Color(0xFF468c90),
                            //     value: assethead,
                            //     onChanged: (value) {
                            //       setState(() {
                            //         assethead = value!;
                            //       });
                            //     },
                            //
                            //     items:
                            //         head.map<DropdownMenuItem<String>>((value) {
                            //       return DropdownMenuItem(
                            //         child: Padding(
                            //           padding:
                            //               const EdgeInsets.only(left: 30.0),
                            //           child: Text(
                            //             value,
                            //             style: const TextStyle(
                            //                 color: Color(0xFF468c90)),
                            //           ),
                            //         ),
                            //         value: value,
                            //       );
                            //     }).toList(),
                            //   ),
                            // ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 390, 40, 10),
                          // Email validation
                          child: TextFormField(
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return "Passwordn can't be blank";
                              } else if (value!.length < 6 ||
                                  value.length > 6) {
                                return "Should have 6 characters ";
                              }
                              if (_createpass.text != _cnfrmepass.text) {
                                return "Password does not match";
                              }
                              return null;
                            },
                            controller: _createpass,
                            autocorrect: true,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.lock_open,
                                  color: Color(0xFF468c90)),
                              hintText: 'Create Password',
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
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 460, 40, 10),
                          // Email validation
                          child: TextFormField(
                            // MultiValidator([
                            //   RequiredValidator(errorText: "Password can't be blank"),
                            //   //EmailValidator(errorText: 'Not a vali'),

                            // ]),
                            controller: _cnfrmepass,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter a paswword";
                              }
                              if (value.length > 6 || value.length < 6) {
                                return "Should be 6 characters";
                              }
                              if (_createpass.text != _cnfrmepass.text) {
                                return "Password does not match";
                              }
                              return null;
                            },
                            autocorrect: true,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.lock_outline,
                                  color: Color(0xFF468c90)),
                              hintText: 'Confirm Password',
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
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 530, 40, 10),
                          child: Container(
                            width: 340,
                            height: 55,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFFe0f4f5)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                elevation: 10,
                                iconEnabledColor: const Color(0xFF468c90),
                                value: selectedSubject,
                                onChanged: (value) {
                                  setState(() {
                                    selectedSubject = value!;
                                  });
                                },
                                items: subjects
                                    .map<DropdownMenuItem<String>>((value) {
                                  return DropdownMenuItem(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 30.0),
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                            color: Color(0xFF468c90)),
                                      ),
                                    ),
                                    value: value,
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 700, left: 0, right: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: 40,
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xFF468c90)),
                                    // gradient: const LinearGradient(
                                    //   begin: Alignment.topLeft,
                                    //   end: Alignment.bottomRight,
                                    //   colors: [Color(0xFF64C9CF), Color(0xFF468c90),],),

                                    borderRadius: BorderRadius.circular(10),
                                    //color: Color(0xFF5663ff)
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(
                                          color: Color(0xFF468c90),
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                //onTap: validatethis,
                                onTap: validate, // (){
                                //Navigator.push(context, MaterialPageRoute(builder: (context)=>create_page()));
                                // },
                                child: Container(
                                  height: 40,
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
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
                                  child: Center(
                                    child: Text(
                                      'Create',
                                      style: buildTextStyle(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
