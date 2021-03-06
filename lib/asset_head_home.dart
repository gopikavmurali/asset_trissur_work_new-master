

import 'package:asset_trissur_work_new/amc_notification.dart';
import 'package:asset_trissur_work_new/constants.dart';
import 'package:asset_trissur_work_new/create_page_head.dart';
import 'package:asset_trissur_work_new/login_page.dart';
import 'package:asset_trissur_work_new/notification_screen.dart';
import 'package:asset_trissur_work_new/updation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'defect_reason.dart';
import 'history.dart';
import 'image_picker_two.dart';



class asset_head_home extends StatefulWidget {
  final String user_name;
  final String selectedPrivi;
  const asset_head_home({Key? key, required this.user_name, required this.selectedPrivi}) : super(key: key);


  @override
  _asset_head_homeState createState() => _asset_head_homeState();
}

class _asset_head_homeState extends State<asset_head_home> {
  String qrCode = 'Scanned Result';
  final descriptionController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController moveController = TextEditingController();
  TextEditingController assetController = TextEditingController();
  final List<String> backtostock = ["Back To Stock","Department 1","Department 2","Department 3"];
  String selectedstock = "Back To Stock";
  final List<String> outside = ["Move To Outside","Centre 1","Centre 2","Centre 3"];
  String selectedcentre = "Move To Outside";
  final List<String> department = ["Department","Dept 1","Dept  2","Dept 3"];
  String selecteddept = "Department";
  String reallocate = "Move To Outside";
  int  selectedRadio = -1;

  List<Exercise> reasons= [
    Exercise(name: 'Defective Product'),
    Exercise(name: 'Expired'),
    Exercise(name: 'Change in Requirement'),
  ];

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  void addupdations() {
    FirebaseFirestore.instance.collection("headupdation").add({
      "values": descriptionController.text,
      "date": DateTime.now(),
      "id":idController.text,
      "stock":selectedstock,
      "center": selectedcentre,
      "reallocate": reallocate,
      "radiovalue": selectedRadio,
      "result": qrCode,

    });
    FirebaseFirestore.instance.collection("assetid").add({
      "id": idController.text,
    });
    // FirebaseFirestore.instance.collection("headupdation").add({
    //   "id": descriptionController.text,
    // });

  }



  @override
  Widget build(BuildContext context) {
    var text;
    return WillPopScope(

      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: GestureDetector(
                onTap: (){
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>admin_user(user_name: '',)));
                },
                child: const Icon(Icons.perm_identity,color: Colors.black,)),
            title:  Text(widget.user_name,style: const TextStyle(color: Colors.black),),
            actions: [
              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>const notification(complaintController:"")));
                  },
                  child: const Icon(Icons.notification_important_outlined,color: Colors.black,)),
              const SizedBox(width: 10,),
              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>const amc_notify()));
                  },
                  child: const Icon(Icons.notification_important,color: Colors.black,)),
              const SizedBox(width: 10,),
              GestureDetector(
                  onTap: ()async{
                    await FirebaseAuth.instance.signOut();

                    Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
                  },
                  child: const Icon(Icons.logout_outlined,color: Colors.black,)),
              const SizedBox(width: 010,),
            ]


        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Form
                (
                  child: Container(
               // height: MediaQuery.of(context).size.height,
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
                              //scan qr
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
                              //create
                              Padding(
                                padding: const EdgeInsets.only(left:30,bottom:15,right: 30,),
                                child:
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const create_page_head()));
                                    // if (widget.selectedPrivi =="AssetMaster")
                                    // {
                                    //   Navigator.push(context, MaterialPageRoute(builder: (context)=>create_page()));
                                    // }
                                    // else if (widget.selectedPrivi == "AssetHead")
                                    // {
                                    //   Navigator.push(context, MaterialPageRoute(builder: (context)=>create_page_head()));
                                    // }

                                  },
                                  child: Container(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width*2,
                                      decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [Color(0xFF64C9CF), Color(0xFF468c90),],),

                                          borderRadius: BorderRadius.circular(10),color: const Color(0xFF5663ff)),


                                      child: Center(child: Text("Create",style:buildTextStyle()))
                                  ),
                                ),
                              ),
                              //history
                              Padding(
                                padding: const EdgeInsets.only(left:30,bottom:15,right: 30,),
                                child:
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                        const history(asset_type: '', qrcode: '',)));
                                  },
                                  child: Container(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width*2,
                                      decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [Color(0xFF64C9CF), Color(0xFF468c90),],),

                                          borderRadius: BorderRadius.circular(10),color: const Color(0xFF5663ff)),


                                      child: Center(
                                          child:
                                          //Text(qrCode.toString())
                                          Text("History",style:buildTextStyle())
                                      )
                                  ),
                                ),
                              ),
                              //reallocation
                              Padding(
                                padding: const EdgeInsets.only(left:30,bottom:15,right: 30,),
                                child: GestureDetector(
                                  onTap: (){
                                    reallocation_alert_box();
                                  },
                                  child: Container(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width*2,
                                      decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [Color(0xFF64C9CF), Color(0xFF468c90),],),

                                          borderRadius: BorderRadius.circular(10),color: const Color(0xFF5663ff)),


                                      child: Center(child: Text("Realloction",style:buildTextStyle()))
                                  ),
                                ),
                              ),
                              //dispose
                              Padding(
                                padding: const EdgeInsets.only(left:30,bottom:15,right: 30,),
                                child: GestureDetector(
                                  onTap: (){
                                    dispose_alert_box();
                                  },
                                  child: Container(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width*2,
                                      decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [Color(0xFF64C9CF), Color(0xFF468c90),],),
                                          borderRadius: BorderRadius.circular(10),color: const Color(0xFF5663ff)),
                                      child: Center(child: Text("Dispose",style:buildTextStyle()))
                                  ),
                                ),
                              ),
                              //move to outside
                              Padding(
                                padding: const EdgeInsets.only(left:30,bottom:15,right: 30,),
                                child: Container(
                                  width: MediaQuery.of(context).size.width*2,
                                  height: 40,
                                  decoration: BoxDecoration(borderRadius:BorderRadius.circular(05),
                                      border:Border.all(color: Colors.black45)),
                                  child:   StreamBuilder(
                                      stream: FirebaseFirestore.instance.collection("servicecenter").orderBy("values").snapshots(),

                                      builder: (context,AsyncSnapshot<QuerySnapshot>snapshot) {
                                        if(!snapshot.hasData){
                                          return const CircularProgressIndicator();
                                        }
                                        else {
                                          return DropdownButtonHideUnderline(
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: DropdownButton<String>(
                                                  value: null,//selectedcentre,

                                                  onChanged: (value) {
                                                    print("$value");
                                                    setState(() {
                                                      selectedcentre = value!;
                                                    });
                                                  },
                                                  items: snapshot.data?.docs.map((QueryDocumentSnapshot document){
                                                    final dynamic data =document.data();
                                                    return DropdownMenuItem<String>(
                                                        value: data.toString(),
                                                        child: Text(document["values"].toString()));
                                                  }).toList(),
                                                ),
                                              ) );
                                        }
                                      }
                                  ),
                                ),
                              ),
                              //back to stock
                              Padding(
                                padding: const EdgeInsets.only(left:30,bottom:15,right: 30,),
                                child: Container(
                                  width: MediaQuery.of(context).size.width*2,
                                  height: 40,
                                  decoration: BoxDecoration(borderRadius:BorderRadius.circular(05),
                                      border:Border.all(color: Colors.black45)),
                                  child:   StreamBuilder(
                                      stream: FirebaseFirestore.instance.collection("departments").orderBy("values").snapshots(),
                                      builder: (context,AsyncSnapshot<QuerySnapshot>snapshot) {
                                        if(!snapshot.hasData){
                                          return const CircularProgressIndicator();
                                        }
                                        else {
                                          return DropdownButtonHideUnderline(
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: DropdownButton<String>(
                                                  value:null,

                                                  onChanged: (value) {
                                                    print("$value");
                                                    setState(() {
                                                      selectedstock = value!;
                                                    });
                                                  },
                                                  items: snapshot.data?.docs.map((QueryDocumentSnapshot document){
                                                    final dynamic data =document.data();
                                                    return DropdownMenuItem<String>(
                                                        value: data.toString(),
                                                        child: Text(document["values"].toString()));
                                                  }).toList(),
                                                ),
                                              ) );
                                        }
                                      }
                                  ),
                                ),
                              ),
                              //updte notes
                              Padding(
                                padding: const EdgeInsets.only(left:10,bottom:15,right: 30,),
                                child: Text("Update Notes",style: headingText(),),
                              ),
                              //Complaints
                              Padding(
                                padding: const EdgeInsets.only(left:30,bottom:30,right: 30,),
                                child: Container(
                                  height: 200,
                                  width: MediaQuery.of(context).size.width*2,
                                  decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                                  child: TextField(
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      //labelText: "Update Notes"
                                    ),
                                    maxLines: 90,
                                    controller: descriptionController,
                                  ),
                                ),
                              ),
                              //update
                              Padding(
                                padding: const EdgeInsets.only(left:50,bottom:30,right: 50,),
                                child:
                                GestureDetector(
                                  onTap: (){
                                    addupdations();
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context)=>updation(descriptionController: descriptionController.text,)));
                                    descriptionController.clear();
                                    idController.clear();
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
                                      child: Center(child: Text("Update",style:buildTextStyle()))
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

  Future dispose_alert_box(){

    return  showDialog(
      context: context,
      builder: (BuildContext context) {
       // int  selectedRadio = -1;
        void update() {
          FirebaseFirestore.instance.collection("disposereason").add({
            "radio": selectedRadio,
          });
        }
        return AlertDialog(
          title:const Text("Select Reason to Dispose",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,

                    children: List<Widget>.generate(reasons.length, (int index) {
                      return RadioListTile<int>(
                        title: Text(reasons[index].name),
                        activeColor:  const Color(0xFF468c90),
                        value: index,
                        groupValue: selectedRadio,
                        onChanged:
                            (value) {
                          setState(() =>
                          selectedRadio = value!);
                        },
                      );
                    }),
                  );
                },
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    child:InkWell(
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context)=>image_picking()));
                      },
                      child: Container(
                        height: 40,
                        // width: MediaQuery.of(context).size.width/4,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFF64C9CF), Color(0xFF468c90),],),

                            borderRadius: BorderRadius.circular(10),color: const Color(0xFF5663ff)),
                        child:  Center(
                          child: Text('Pick Image',style: buildTextStyle(),),
                        ),
                      ),
                    ),

                  ),


                ],
              ),
            ],
          ),

          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [



                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(

                        child: GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>
                            //     asset_head_home(user_name: "", selectedPrivi:"")));
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(border: Border.all(color: const Color(0xFF468c90)),
                              borderRadius: BorderRadius.circular(10),

                            ),
                            child: const Center(
                              child: Text('Cancel',style: TextStyle(color:Color(0xFF468c90),fontSize: 14),),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),


                      Expanded(
                        child: GestureDetector(
                          onTap: (){

                             update();
                            Navigator.pop(context);
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>
                            //     asset_head_home(user_name: "", selectedPrivi:"")));
                          },
                          child: Container(
                            height: 40,
                            // width: MediaQuery.of(context).size.width/4,
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [Color(0xFF64C9CF), Color(0xFF468c90),],),

                                borderRadius: BorderRadius.circular(10),color: const Color(0xFF5663ff)),
                            child:  Center(
                              child: Text('Confirm',style: buildTextStyle(),),
                            ),
                          ),
                        ),
                      ),


                    ],
                  ),
                ],
              ),
            )
          ],
        );

      },);

  }

  Future reallocation_alert_box() async{
    return  await showDialog(
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState){
                return AlertDialog(
                  title: const Text("Reallocate Department"),
                  content: SingleChildScrollView(
                    child:
                    Column(
                      children: [
                        Row(
                          children: [
                            const Expanded(child: Text("Current Department:",style: TextStyle(color: Colors.black54),)),
                            const SizedBox(width: 5,),
                            StreamBuilder(
                                stream: FirebaseFirestore.instance.collection("departments").doc("depart").snapshots(),
                                builder: (context ,AsyncSnapshot snapshot) {
                                  if (!snapshot.hasData) {
                                    return const CircularProgressIndicator();
                                  }

                                  final userDoc = snapshot.data;
                                  return Text(userDoc["values"]);
                                })
                            // Text("Department Name",style: TextStyle(color: Colors.black),),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.only(bottom:20),
                          child: Row(
                            children: const [
                              Text("Select New Department:",style: TextStyle(color: Colors.black54),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 0,),
                          child: Container(
                            width: MediaQuery.of(context).size.width*2,
                            height: 40,
                            decoration: BoxDecoration(borderRadius:BorderRadius.circular(05),
                                border:Border.all(color: Colors.black45)),
                            child:  StreamBuilder(
                                stream: FirebaseFirestore.instance.collection("departments").orderBy("values").snapshots(),
                                builder: (context,AsyncSnapshot<QuerySnapshot>snapshot) {
                                  if(!snapshot.hasData){
                                    return const CircularProgressIndicator();
                                  }
                                  else {
                                    return DropdownButtonHideUnderline(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: DropdownButton<String>(
                                            value: null,

                                            onChanged: (value) {
                                              print("$value");
                                              setState(() {
                                                reallocate = value!;
                                              });
                                            },
                                            items: snapshot.data?.docs.map((QueryDocumentSnapshot document){
                                              final dynamic data =document.data();
                                              return DropdownMenuItem<String>(
                                                  value: data.toString(),
                                                  child: Text(document["values"].toString()));
                                            }).toList(),
                                          ),
                                        ) );
                                  }
                                }
                            ),
                          ),
                        ),
                      ],
                    ),


                  ),
                  actions: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(

                            child: GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                                // Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                //     asset_head_home(user_name: "", selectedPrivi: "")));
                              },
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(border: Border.all(color: const Color(0xFF468c90)),
                                  borderRadius: BorderRadius.circular(10),

                                ),
                                child: const Center(
                                  child: Text('Cancel',style: TextStyle(color:Color(0xFF468c90),fontSize: 14),),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10,),


                          Expanded(
                            child: GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                                // Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                //     asset_head_home(user_name: "", selectedPrivi: "")));
                              },
                              child: Container(
                                height: 40,
                                // width: MediaQuery.of(context).size.width/4,
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [Color(0xFF64C9CF), Color(0xFF468c90),],),

                                    borderRadius: BorderRadius.circular(10),color: const Color(0xFF5663ff)),
                                child:  Center(
                                  child: Text('Confirm',style: buildTextStyle(),),
                                ),
                              ),
                            ),
                          ),


                        ],
                      ),
                    )
                  ],

                );
              }
          );});
  }


}
