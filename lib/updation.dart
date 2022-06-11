
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

  var now;


  @override
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
          title:  const Text("Updations Screen",style: TextStyle(color: Colors.black),),
          actions: [
            GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
                },
                child: const Icon(Icons.logout_outlined,color: Colors.black,)),
            const SizedBox(width: 05,),




          ]),
        body: SafeArea(
          child:  StreamBuilder(
              stream: FirebaseFirestore.instance.collection("masterupdation").orderBy("values").snapshots(),
              builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot)
              {
                if (!snapshot.hasData)
                {
                  return const Center(child: CircularProgressIndicator());
                }
                else
                {

                  return  Expanded(
                    child: ListView(


                      children: snapshot.data!.docs.map((document) {
                        final dynamic data = document.data();
                        return ListTile(
                            title: Text(data["values"].toString()),
                            leading: const Padding(
                              padding:EdgeInsets.all(8.0),
                             // child: Text(data["date"].toString()),
                            //child: Text(data["date"] as Timestamp).toDate();
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

