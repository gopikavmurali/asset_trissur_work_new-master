import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:asset_trissur_work_new/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login_page.dart';

class CreateDepartment extends StatefulWidget {
  @override
  _CreateDepartmentState createState() => _CreateDepartmentState();
}

class _CreateDepartmentState extends State<CreateDepartment> {
  int index = 0;
  var department;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _depController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void addDepartments() async {
    User? user = FirebaseAuth.instance.currentUser;
    final _uid = user!.uid;
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      setState(() {
        _isLoading = true;
      });
      try {
        final depDoc =
            await FirebaseFirestore.instance.collection('departments').doc();
        Map<String, dynamic> depData = {
          'depId': depDoc.id,
          'uploaded_By': _uid,
          'values': _depController.text,
        };
        depDoc.set(depData);
        _depController.clear();
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      print('it is not valid');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _depController.dispose();
  }

  void cleartext() {
    _depController.clear();
  }

  _deleteDepartment(String depId) async {
    final depDoc =
        await FirebaseFirestore.instance.collection('departments').doc(depId);

    depDoc.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
              //Navigator.push(context, MaterialPageRoute(builder: (context)=>admin_user(user_name: '',)));
            },
            child: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.black,
            )),
        //leading: const Icon(Icons.person,color: Colors.black,),
        title: const Text(
          "Create Department",
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => login()));
              },
              child: const Icon(
                Icons.logout_outlined,
                color: Colors.black,
              )),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
                key: _formKey,
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
                              //child: Text(qrCode)
                            )),
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 70.0, left: 40),
                        child: Text(
                          "Department",
                          style: buildFontlink(),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                            top: 100.0, left: 40, right: 40),
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 2,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [Colors.white, Colors.white]

                                  //colors: [Color(0xFF64C9CF), Color(0xFF468c90),],
                                  ),
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFF5663ff)),
                          child: TextFormField(
                            controller: _depController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter a Value";
                              } else {
                                return null;
                              }
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              // labelText: '',
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 180.0, left: 120),
                        child: GestureDetector(
                          onTap: () {
                            addDepartments();
                            // cleartext();
                            // setState(() {
                            //   department = _depController.text;
                            //   index++;
                            // });
                          },
                          child: Container(
                              height: 40,
                              width: 150,
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xFF64C9CF),
                                      Color(0xFF468c90),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color(0xFF5663ff)),
                              child: Center(
                                  child: Text("Add", style: buildTextStyle()))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 300, left: 40),
                        child: Text(
                          "List of Departments",
                          style: buildFontlink(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 350, left: 20),
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("departments")
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return const CircularProgressIndicator();
                              } else {
                                return Expanded(
                                  child: ListView(
                                    children:
                                        snapshot.data!.docs.map((document) {
                                      final dynamic data = document.data();
                                      return Dismissible(
                                        key: Key(document.id),
                                        onDismissed: (direction) {
                                          print(document.id);
                                          _deleteDepartment(document.id);
                                          //onDelete(document.id);
                                        },
                                        background: Container(
                                          color: Colors.red,
                                          child: const Icon(Icons.delete),
                                        ),
                                        child: ListTile(
                                            //   onTap: _deleteDepartment,

                                            title:
                                                Text(data["values"].toString()),
                                            leading:
                                                const Icon(Icons.arrow_right)),
                                      );
                                    }).toList(),
                                  ),
                                );
                              }
                            }),
                      )
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 350.0,left: 40,right: 40),
                      //   child: Container(
                      //     height: 100,
                      //     width: MediaQuery.of(context).size.width*2,
                      //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                      //         border: Border.all(color: Colors.black45)),
                      //     child:
                      //     Padding(
                      //       padding: const EdgeInsets.only(top: 8.0,left: 8),
                      //       child: Text("$index. $department",style: headingText(),),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
