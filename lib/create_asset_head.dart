import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:asset_trissur_work_new/constants.dart';

import 'login_page.dart';

class asset_head extends StatefulWidget {
  // const user_log({Key? key}) : super(key: key);
  @override
  _asset_headState createState() => _asset_headState();
}

class _asset_headState extends State<asset_head> {
  var asset_head;
  int index = 0;
  TextEditingController assetheadController = TextEditingController();

  void addassethead() async {
    await FirebaseFirestore.instance.collection("assethead").add({
      "values": assetheadController.text,
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    assetheadController.dispose();
  }

  void cleartext() {
    assetheadController.clear();
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
                          decoration: const BoxDecoration(color: Colors.white),
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
                    padding:
                        const EdgeInsets.only(top: 100.0, left: 40, right: 40),
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
                      child: TextField(
                        controller: assetheadController,
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
                        cleartext();
                        setState(() {
                          asset_head = assetheadController.text;
                          index++;
                        });
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
                    padding:
                        const EdgeInsets.only(top: 350.0, left: 40, right: 40),
                    child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width * 2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.black45)),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 8),
                        child: Text(
                          "$index. $asset_head",
                          style: headingText(),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
