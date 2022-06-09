
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'login_page.dart';

class item_req extends StatefulWidget {
  const item_req({Key? key}) : super(key: key);

  @override
  _item_reqState createState() => _item_reqState();
}

class _item_reqState extends State<item_req> {
  final List<String> asset_types = ["Item Names", "laptop", "Desktop","Table","Chairs",
    "Operating Assets","Non Operating Assets"];
  String selectedtype = "Item Names";

  final TextEditingController requestController = TextEditingController();

  clearText(){
    requestController.clear();
  }
  void itemrreq(){
    FirebaseFirestore.instance.collection("requestforitems").add({
      "request": requestController.text,
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_outlined,color: Colors.black,)),
        title:  Text("Request Items",style: TextStyle(color: Colors.black),),
        actions: [
          GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
              },
              child: Icon(Icons.logout_outlined,color: Colors.black,)),
          SizedBox(width: 05,),
          //Icons.notification_important,

        ],
      ),
      body: SingleChildScrollView(

        child: Column(
          children: [
            SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Request for available items",style: buildFontlink(),)
                  ],
                ),
              ),
            SizedBox(height: 20,),
            ListTile(
              minLeadingWidth : 01,
              minVerticalPadding: 10,
              horizontalTitleGap: 06,

              title: Text("Available Items",style: buildFontlink(),),
             // leading: Icon(Icons.arrow_right),
              trailing: Container(
                width: 212,
                height: 35,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(5)),

                child:  DropdownButtonHideUnderline(


                  child: DropdownButton<String>(
                    // isDense: true,
                    // isExpanded: false,

                    elevation: 10,

                    iconEnabledColor: Colors.black,
                    value: selectedtype,
                    onChanged: (value){
                      setState(() {
                        selectedtype = value!;
                      });
                    },

                    items: asset_types.map<DropdownMenuItem<String>>((value){

                      return DropdownMenuItem(

                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(    value),
                        ),
                        value: value,

                      );
                    }).toList(),
                  ),
                ),

              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Request for other items",style: buildFontlink(),)
                ],
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.only(left:20,bottom:50,right: 30,),
              child: Container(
                 height: 100,
                // width: 320,
                //decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    //labelText: "Update Notes"
                  ),
                  maxLines: 10,
                  controller: requestController,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left:30,bottom:15,right: 30,),
              child:
              GestureDetector(
                onTap: (){

                  itemrreq();
                  clearText();
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context)=> complaints(descriptionTextController: complaintController.text,
                  //       descriptionController: '',)));
                },
                child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width*2,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF64C9CF), Color(0xFF468c90),],),

                      borderRadius: BorderRadius.circular(10),color: Color(0xFF5663ff),),


                    child: Center(child: Text("Send Request",style:buildTextStyle()))
                ),
              ),
            ),

          ],
        ),
      ),

    );

  }
}

