
import 'package:asset_trissur_work_new/user_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'login_page.dart';

class updation extends StatefulWidget {
  final String descriptionController;
  const updation({Key? key,
    required this.descriptionController}) : super(key: key);

  @override
  _updationState createState() => _updationState();
}

class _updationState extends State<updation> {
  @override
  int count = 0;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
              onTap: (){
                Navigator.pop(context);

                //Navigator.push(context, MaterialPageRoute(builder: (context)=>admin_user(user_name: '',)));
              },
              child: const Icon(Icons.arrow_back_outlined,color: Colors.black,)),
          title:  Text("Updations Screen",style: TextStyle(color: Colors.black),),
          actions: [
            GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
                },
                child: Icon(Icons.logout_outlined,color: Colors.black,)),
            SizedBox(width: 05,),




          ]),
        body: SafeArea(
          child:  StreamBuilder(
              stream: FirebaseFirestore.instance.collection("masterupdation").snapshots(),
              builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot)
              {
                if (!snapshot.hasData)
                {
                  return Center(child: CircularProgressIndicator());
                }
                else
                {

                  return  Expanded(
                    child: ListView(


                      children: snapshot.data!.docs.map((document) {
                        final dynamic data = document.data();
                        return ListTile(
                            title: Text(data["values"].toString()),
                            leading: Padding(
                              padding: const EdgeInsets.all(8.0),
                              //child: Text(data["date"].toString()),
                              child: Text("dd-mm-yyyy"),
                            )
                        );
                        // return Container(
                        //   height: 50,
                        //   width: MediaQuery.of(context).size.width,
                        //   child: Text("title:"+data["Title"]),
                        // );
                      }).toList(),

                    ),
                  );
                }
              }

          ),
          // child:ListView.builder(
          //
          //      itemCount: 10,
          //      itemBuilder: (context,snapshot){
          //
          //        return ListTile(
          //          leading: Padding(
          //           padding: EdgeInsets.only(top: 20.0),
          //            child: Text("12-12-2021"),
          //            ),
          //
          //          title: Padding(
          //             padding: EdgeInsets.only(top: 20.0),
          //            child: Text("${widget.descriptionTextController}"
          //                 "${widget.descriptionController}",style: TextStyle(color: Colors.black),),
          //           ),
          //
          //     );
          //       }
          //     )
        )
      // body: SafeArea(
      //   child: ListView.separated(
      //   itemBuilder: (ctx,index){
      //     SizedBox(height:20);
      //     return  ListTile(
      //       leading: Padding(
      //         padding: const EdgeInsets.only(top: 20.0),
      //         child: Text("12-12-2021"),
      //       ),
      //       title: Padding(
      //         padding: const EdgeInsets.only(top: 20.0),
      //         child: Text("${widget.descriptionController}",style: TextStyle(color: Colors.black),),
      //       ),
      //
      //     );
      //   },
      //   separatorBuilder: (ctx,index){
      //     return Divider();
      //   },
      //   itemCount: 3,
      // ),
      //
      //
      // ),
    );

  }
}

