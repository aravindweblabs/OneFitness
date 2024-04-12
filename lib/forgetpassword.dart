import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
//import 'package:mailer/mailer.dart';
import 'constants.dart';
import 'forgetpassotp.dart';
//import 'package:mailer/smtp_server.dart';


class ForgetPassword extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  String? otp;

  String generateOTP() {
    final random = Random();
    return '${random.nextInt(1000000).toString().padLeft(6, '0')}';
  }

  Future<void> _emailSend(BuildContext context) async {
    otp = generateOTP();
    print(' generated otp:${otp}');
    try {
      final response = await http.post(
        Uri.parse('http://$ipAddress/$ProjectName/forget_password.php'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'POST' : 'POST',
          'email': _emailController.text,
          'otp' : otp!,
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          // OTP sent successfully
          print('OTP sent successfully');
        }  else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('email does not exist'),
              backgroundColor: Colors.red,
            ),
          );
        }
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EnterOtpPage(
                email: _emailController.text,
                otp:otp!
            )),
          );
        }
    } catch (e) {
      print("Error logging in: $e");
    }
  }



 /* void _resetPassword(BuildContext context) {
    String email = _emailController.text;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Password Reset'),
          content: const Text('An email has been sent.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  EnterOtpPage(otp:otp!)),
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
*/
  /*Future<void> sendEmailWithOTP(String email, String otp) async {
    final smtpServer = gmail('aravind.weblabs@gmail.com', 'rgo awuo kaug mjxf');
    //trgo awuo kaug mjxf
    final message = Message()
      ..from = Address('aravind.weblabs@gmail.com', 'one fitness')
      ..recipients.add(email)
      ..subject = 'Your OTP for login'
      ..text = 'Your OTP for login: $otp';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } catch (e) {
      print('Error sending email: $e');
    }
  }*/




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),

        backgroundColor: const Color(0xFFB070FA),
      ),
      body: Center(
        child: SizedBox(
          height: 250,
          width: 350,
          child: Card(
           // color: Colors.grey[200],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Reset Password',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                    controller: _emailController,
                  ),
                ),
                const SizedBox(height: 16),
               /* ElevatedButton(
                  onPressed: () {
                    _emailSend(context);
                  },
                  child: const Text('Reset Password'),
                ),*/
                Center(
                  child: Container(
                    width: 200,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        _emailSend(context);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFB070FA)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                      ),
                      child: const Text('Reset Password'),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
