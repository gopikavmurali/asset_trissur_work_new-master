

import 'package:asset_trissur_work_new/constants.dart';
import 'package:asset_trissur_work_new/login_page.dart';
import 'package:asset_trissur_work_new/complaints.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'item_request.dart';


class user_home extends StatefulWidget {
  final String user_name;
  const user_home({Key? key, required this.user_name}) : super(key: key);


  @override
  _user_homeState createState() => _user_homeState();
}

class _user_homeState extends State<user_home> {
  String qrCode = 'Scanned Result';
  TextEditingController complaintController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController moveController = TextEditingController();
  TextEditingController assetController = TextEditingController();


  void addcomplaints() {
    FirebaseFirestore.instance.collection("usercomplaints").add({
      "values": complaintController.text,
      "date": Timestamp.now(),
    });
    FirebaseFirestore.instance.collection("assetid").add({
      "id": idController.text,
    });
  }
   void cleartext(){
    complaintController.clear();
    idController.clear();
   }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(

      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
              onTap: (){
                 Navigator.of(context, rootNavigator: true).pop();



                //Navigator.push(context, MaterialPageRoute(builder: (context)=>admin_user(user_name: '',)));
              },
              child: const Icon(Icons.perm_identity,color: Colors.black,)),
          title:  Text(widget.user_name,style: const TextStyle(color: Colors.black),),
          actions: [
            GestureDetector(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
                },
                child: const Icon(Icons.logout_outlined,color: Colors.black,)),
            const SizedBox(width: 10,),

          ],


        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Form
                (
                  child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors:  [Colors.white,Colors.white,],),
                  borderRadius:BorderRadius.circular(10),color: Colors.white,),
                child:
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Opacity(
                          opacity: 0.7,
                          child: Column(
                            children: [
                              //scan qr code
                              Padding(
                                padding: const EdgeInsets.only(left:30,bottom:15,right: 30,top: 30),
                                child:
                                GestureDetector(
                                  onTap: scanQRCode,

                                  child: Container(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width*2,
                                      decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [Color(0xFF64C9CF), Color(0xFF468c90),],),

                                          borderRadius: BorderRadius.circular(10),color: const Color(0xFF5663ff)),


                                      child: Center(child: Text("Scan QR Code",style:buildTextStyle()))
                                  ),
                                ),

                              ),
                              //or
                              const Padding(
                                padding: EdgeInsets.only(left:30,bottom:15,right: 30,),
                                child: Text("OR",style: TextStyle(color: Colors.black),),
                              ),
                              //asset id
                              Padding(
                                padding: const EdgeInsets.only(left:30,bottom:15,right: 30,),
                                child:
                                Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width*2,
                                  decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors:[ Colors.white,Colors.white]

                                        //colors: [Color(0xFF64C9CF), Color(0xFF468c90),],
                                      ),

                                      borderRadius: BorderRadius.circular(10),color: const Color(0xFF5663ff)),


                                  child: TextField(
                                    controller: idController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Asset Id",
                                    ),
                                  ),
                                ),
                              ),
                              //scanned result
                              Padding(
                                padding: const EdgeInsets.only(left:30,bottom:15,right: 30,),
                                child:
                                Container(
                                    height: 40,
                                    width: MediaQuery.of(context).size.width*2,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(05),
                                        border: Border.all(color: Colors.black26,)
                                    ),


                                    child: Center(child: Text(qrCode))
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:30,bottom:15,right: 30,),
                                child:
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context)=> const item_req()));
                                  },
                                  child: Container(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width*2,
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [Color(0xFF64C9CF), Color(0xFF468c90),],),

                                        borderRadius: BorderRadius.circular(10),color: const Color(0xFF5663ff),),


                                      child: Center(child: Text(" Item Request",style:buildTextStyle()))
                                  ),
                                ),
                              ),
                              const SizedBox(height: 40,),
                              //complaint caption
                              Padding(
                                padding: const EdgeInsets.only(left:30,bottom:15,right: 30,),
                                child: Text("Enter your Complaints",style: headingText(),),
                              ),
                              //enter your complaints
                              Padding(
                                padding: const EdgeInsets.only(left:30,bottom:15,right: 30,),
                                child: SizedBox(
                                  height: 250,
                                  width: 320,
                                  //decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                                  child: TextField(
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      //labelText: "Update Notes"
                                    ),
                                    maxLines: 50,
                                    controller: complaintController,
                                  ),
                                ),
                              ),
                              //update button
                              Padding(
                                padding: const EdgeInsets.only(left:30,bottom:15,right: 30,),
                                child:
                                GestureDetector(
                                  onTap: (){

                                    addcomplaints();
                                    cleartext();
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context)=>
                                            complaints(
                                              descriptionTextController: complaintController.text,
                                          )));
                                  },
                                  child: Container(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width*2,
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [Color(0xFF64C9CF), Color(0xFF468c90),],),

                                        borderRadius: BorderRadius.circular(10),color: const Color(0xFF5663ff),),


                                      child: Center(child: Text("Send",style:buildTextStyle()))
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                    ),
                  ) )],
          ),
        ),
      ),
    );



  }
  Future<void> scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );

      if (!mounted) return;

      setState(() {
        this.qrCode = qrCode;
      });
    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
  }


}
