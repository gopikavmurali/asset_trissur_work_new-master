
import 'dart:io';
import 'package:asset_trissur_work_new/asset_master_home.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'constants.dart';
import 'create_page_master.dart';
import 'login_page.dart';

enum ImageSourceType { gallery, camera }

class image_picking extends StatelessWidget {
  void _handleURLButtonPress(BuildContext context, var type) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ImageFromGalleryEx(type)));
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
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back,color: Colors.black,)),
              title:  Text("Select source",style: TextStyle(color: Colors.black),),
              actions: [

                SizedBox(width: 10,),

                SizedBox(width: 10,),
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                          asset_master_home(user_name: "", selectedPrivi:"")));
                    },
                    child: Icon(Icons.home,color: Colors.black,)),
                SizedBox(width: 010,),
              ]


          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left:30,bottom:15,right: 30,),
                  child: GestureDetector(
                    onTap: (){
                      _handleURLButtonPress(context, ImageSourceType.gallery);
                    },
                    child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width*2,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFF64C9CF), Color(0xFF468c90),],),

                            borderRadius: BorderRadius.circular(10),color: Color(0xFF5663ff)),


                        child: Center(child: Text("Pick Image From gallery",style:buildTextStyle()))
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left:30,bottom:15,right: 30,),
                  child: GestureDetector(
                    onTap: (){
                    //  Navigator.push(context, MaterialPageRoute(builder: (context)=>create_page()));
                      _handleURLButtonPress(context, ImageSourceType.camera);
                    },
                    child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width*2,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFF64C9CF), Color(0xFF468c90),],),

                            borderRadius: BorderRadius.circular(10),color: Color(0xFF5663ff)),


                        child: Center(child: Text("Pick Image From Camera",style:buildTextStyle()))
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

class ImageFromGalleryEx extends StatefulWidget {
  final type;

  ImageFromGalleryEx(this.type);

  @override
  ImageFromGalleryExState createState() => ImageFromGalleryExState(this.type);
}

class ImageFromGalleryExState extends State<ImageFromGalleryEx> {
  var _image;
  var imagePicker;
  var type;

  ImageFromGalleryExState(this.type);

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    imagePicker = new ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back,color: Colors.black,),
            onPressed: () {
                Navigator.pop(context);
            },),
          backgroundColor: Colors.white,
            elevation: 0,
            actions: [
              IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>
                    //     asset_master_home(user_name: "", selectedPrivi:"")));
                  },
                  icon: Icon(Icons.home,color: Colors.black,))
            ],
            title: Text(type == ImageSourceType.camera
                ? "Image from Camera"
                : "Image from Gallery",style: buildFontlink(),)),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Center(
              child: GestureDetector(
                onTap: () async {
                  var source = type == ImageSourceType.camera
                      ? ImageSource.camera
                      : ImageSource.gallery;
                  XFile image = await imagePicker.pickImage(
                      source: source,
                      imageQuality: 50,
                      preferredCameraDevice: CameraDevice.front);
                  setState(() {
                    _image = File(image.path);
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Container(
                     width: MediaQuery.of(context).size.width,
                     height: MediaQuery.of(context).size.height/1.5,
                    decoration: BoxDecoration(color: Colors.red[200]),
                    child: _image != null
                        ? Image.file(
                            _image,
                            fit: BoxFit.cover,
                          )
                        : Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Container(
                              decoration: BoxDecoration(color: Colors.red[200]),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height/1.5,
                              child: Icon(
                                Icons.camera_alt,size: 35,
                                color: Colors.grey[800],
                              ),
                            ),
                        ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                child: Text("Cancel",style: buildFontlink(),)),

                SizedBox(width: 20,),

                TextButton(onPressed: () {
                  final snackBar = SnackBar(
                    content: const Text('Image Saved!'),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        // Some code to undo the change.
                      },
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Text("Ok",style: buildFontlink(),))
              ],
            )

          ],
        ),
      ),
    );
  }
}
