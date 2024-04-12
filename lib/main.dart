import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:onefitness/registrationForm.dart';
import 'package:onefitness/resetpass.dart';
import 'contactUs.dart';
import 'forgetpassword.dart';
import 'home.dart';
import 'logindummy.dart';
//import 'package:uni_links/uni_links.dart';
import 'myplan.dart';

void main() {
  runApp(MyApp());
 // handleIncomingLinks();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());
    return  MaterialApp(
      home://RegistrationForm(),
      //  LoginScreendummy(),
      // ContactUs(),
      HomePage(uid : 3),
    );
  }
}

/*void handleIncomingLinks() {
  // Listen for incoming app links
  getUriLinksStream().listen((Uri? uri) {
    if (uri != null && uri.scheme == 'abconefitness123' && uri.host == 'paymentsweblabs123') {
      int uid = int.tryParse(uri.queryParameters['uid'] ?? '') ?? 0;
      runApp(MaterialApp(home: MyPlan(uid: uid)));
    }
  }, onError: (err) {
    print('Error listening to URI: $err');
  });
}*/




/*void handleIncomingLinks() {
  // Listen for incoming app links
  getUriLinksStream().listen((Uri? uri) {
    if (uri != null && uri.scheme == 'abconefitness123' && uri.host == 'paymentsweblabs123') {
      int uid = int.parse(uri.queryParameters['uid'] ?? '0');
       runApp(MaterialApp(home:MyPlan(uid: uid)));
    }
  }, onError: (err) {
    print('Error listening to URI: $err');
  });
}*/


/*
Note: C:\Users\Welcome\AppData\Local\Pub\Cache\hosted\pub.dev\uni_links-0.5.1\
android\src\main\java\name\avioli\unilinks\UniLinksPlugin.java uses or
overrides a deprecated API.
Note: Recompile with -Xlint:deprecation for details.*/
