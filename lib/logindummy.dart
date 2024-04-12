import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:crypto/crypto.dart';
import 'package:onefitness/registrationForm.dart';
import 'constants.dart';
import 'forgetpassword.dart';
import 'home.dart';


class AuthController extends GetxController {
  RxInt uid = RxInt(0);

  void setUid(int newUid) {
    uid.value = newUid;
  }
}

final authController = AuthController();

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  String otp = '';
  final AuthController authController = Get.find<AuthController>();

  RxBool _obscureText = true.obs;
 // bool isLoading =false;

  bool get obscureText => _obscureText.value;

  void toggleObscureText() {
    _obscureText.value = !_obscureText.value;
  }

  void enableAutofill() {
    emailController.addListener(() {});
    passController.addListener(() {});
  }

  /*Future<void> loginSend() async {
    try {
      final response = await http.post(
        Uri.parse('http://$ipAddress/$ProjectName/login.php'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'phno': emailController.text, 'otp': otp.toString()},
      );

      if (response.statusCode == 200) {
        print('From login response : 200');
      } else {
        print('Failed to log in');
        print('Response status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print("Error logging in: $e");
    }
  }*/

  Future<bool> loginVerify(BuildContext context) async {
    try {
      //isLoading =true;
      final response = await http.post(
        Uri.parse('http://$ipAddress/$ProjectName/login.php'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'email': emailController.text,
          'password': passController.text,
          'submit': 'submit',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        bool success =data['success'];
        // bool success = true;
        if (success) {
          int uid = data['uid'];
          authController.setUid(uid);
          emailController.clear();
          passController.clear();
          Navigator.pushReplacement(
            context,
            //  MaterialPageRoute(builder: (context) => HomePage(uid: uid)),
            MaterialPageRoute(builder: (context) => HomePage(uid:  authController.uid.value)),
            // authController.customerId.value
          );
          // Get.offAll(HomePage(uid: uid));
        } else {
          String message = data['message'];
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Incorrect email or password'),
              backgroundColor: Colors.red,
            ),
          );
          print('Error logging in: $message');
          return false;
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to log in. Please try again later.'),
            backgroundColor: Colors.red,
          ),
        );
        print('Error logging in: ${response.body}');
        return false;
      }
    } catch (e) {
      print("Error logging in: $e");
      return false;
    }
    finally {
     // isLoading =false;
      return false;
    }
  }
}

class LoginScreendummy extends StatefulWidget {
  @override
  _LoginScreendummyState createState() => _LoginScreendummyState();
}

class _LoginScreendummyState extends State<LoginScreendummy> {

  final LoginController loginController = Get.put(LoginController());
  bool isLoading = false;
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
       backgroundColor: const Color(0xFFB070FA),
        //   backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            Center(
              child: Container(
                height: 500,
                width: 390,
                child: Card(
                 //   color: Colors.grey[200],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox(height: 15),
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.lock,
                            size: 30,
                            color: Colors.black,
                          ),
                          SizedBox(width: 15),
                          Text(
                            'Login',
                            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Enter Your Email',
                            prefixIcon: const Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          controller: loginController.emailController,
                          autofillHints: [AutofillHints.telephoneNumber],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Enter your Password',
                            prefixIcon: const Icon(Icons.lock),
                            /*  suffixIcon: IconButton(
                              icon: Icon(
                                loginController.obscureText ? Icons.visibility_off : Icons.visibility,
                              ),
                              onPressed: () {
                                loginController.toggleObscureText(); // Call the toggleObscureText method
                              },
                            ),*/
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            counterText: '',
                          ),
                          controller: loginController.passController,
                          obscureText: loginController.obscureText, // Use loginController.obscureText instead of _obscureText
                   //       autofillHints: [AutofillHints.oneTimeCode],
                        ),
                      ),


                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => ForgetPassword()),
                          );
                        },
                        child: const Text(
                          'forget password',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 150,
                        height: 40,
                        child:ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isLoading = true;
                            });

                            loginController.loginVerify(context).then((success) {
                              // After the login verification process completes
                              setState(() {
                                isLoading = false; // Hide loading indicator
                              });
                            });

                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(isLoading ? Colors.grey : const Color(0xFFB070FA)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero, // Adjust the radius as needed
                              ),
                            ),
                            textStyle: MaterialStateProperty.all<TextStyle>(
                              TextStyle(color: Colors.white), // Set text color to white
                            ),
                          ),
                          child: isLoading
                              ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Loading...', style: TextStyle(fontSize: 12)),
                              SizedBox(width: 10),
                              CircularProgressIndicator(color: Colors.white),
                            ],
                          )
                              : const Text('Login'),
                        ),

                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text(' Dont have an Account : '),
                          GestureDetector(
                            onTap: () {

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => RegistrationForm()),
                              );
                            },
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




