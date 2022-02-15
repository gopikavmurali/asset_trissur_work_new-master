import 'package:asset_trissur_work_new/descriptiion_page.dart';
import 'package:asset_trissur_work_new/amc_notification.dart';
import 'package:asset_trissur_work_new/button_widget.dart';
import 'package:asset_trissur_work_new/home_head.dart';
import 'package:asset_trissur_work_new/notification_screen.dart';
import 'package:asset_trissur_work_new/create_institution.dart';
import 'package:asset_trissur_work_new/create_item.dart';
import 'package:asset_trissur_work_new/create_page_master.dart';
import 'package:asset_trissur_work_new/create_user.dart';
import 'package:asset_trissur_work_new/history.dart';
import 'package:asset_trissur_work_new/pending_list.dart';
import 'package:asset_trissur_work_new/report.dart';
import 'package:asset_trissur_work_new/service_history.dart';
import 'package:asset_trissur_work_new/sign_up.dart';
import 'package:asset_trissur_work_new/complaints.dart';
import 'package:asset_trissur_work_new/updation.dart';
import 'package:asset_trissur_work_new/user_home.dart';
import 'package:asset_trissur_work_new/asset_master_home.dart';
import 'package:flutter/material.dart';
import 'create_asset_head.dart';
import 'create_dept.dart';
import 'create_page_head.dart';
import 'create_service_center.dart';
import 'login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:login(),
    );
  }
}
