import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:asset_trissur_work_new/constants.dart';

import 'login_page.dart';

class AssetHeadScreen extends StatefulWidget {
  const AssetHeadScreen({Key? key}) : super(key: key);

  @override
  State<AssetHeadScreen> createState() => _AssetHeadScreenState();
}

class _AssetHeadScreenState extends State<AssetHeadScreen> {
  var asset_head;
  int index = 0;
  TextEditingController _assetheadController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? assetHead;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _assetheadController.dispose();
  }

  void addassethead() async {
    User? user = FirebaseAuth.instance.currentUser;
    final _uid = user!.uid;
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      setState(() {
        _isLoading = true;
      });
      try {
        final depDoc =
            await FirebaseFirestore.instance.collection('assethead').doc();
        Map<String, dynamic> depData = {
          'assetId': depDoc.id,
          'uploaded_By': _uid,
          'values': _assetheadController.text,
        };
        depDoc.set(depData);
        _assetheadController.clear();
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      print('it is not valid');
    }
  }

  void cleartext() {
    _assetheadController.clear();
  }

  _deleteAssetHead(String depId) async {
    final depDoc =
        await FirebaseFirestore.instance.collection('assethead').doc(depId);

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
          "Create Asset Head",
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
                          "Asset Head",
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
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter a Value";
                              } else {
                                return null;
                              }
                            },
                            controller: _assetheadController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),

                              // labelText: 'Item Name',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 180.0, left: 120),
                        child: GestureDetector(
                          onTap: () {
                            addassethead();
                            // cleartext();
                            // setState(() {
                            //   asset_head = assetheadController.text;
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
                          "List of Asset Head",
                          style: buildFontlink(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 350.0, left: 40, right: 40),
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("assethead")
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
                                          _deleteAssetHead(document.id);
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
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
