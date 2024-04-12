import 'dart:convert';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'logindummy.dart';
import 'package:http/http.dart' as http;

class ResetPasswordPage extends StatefulWidget {
  final String email;
  final String otp;

  ResetPasswordPage({required this.email, required this.otp});
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  bool _obscureText = true;
  bool _obscureText1 = true;


  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> resetPassword(String newPassword, String confirmPassword, /*String uid*/) async {


    try {
      final response = await http.post(
        Uri.parse('http://$ipAddress/$ProjectName/reset_password.php'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: {
          'reset': 'true',
          'newpassword': newPassword,
          'confirmpassword': confirmPassword,
          'email': widget.email,
          // 'uid': uid.toString(),
        },
      );

      if (response.statusCode == 200) {
        print('Password reset successful');
      } else {
        print('Failed to reset password: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
        backgroundColor: Color(0xFFB070FA),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: SizedBox(
            height: 250,
            width: 350,
            child: Card(
             // color: Colors.white,
             // color: Colors.grey[200],
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _newPasswordController,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        labelText: 'New Password',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _confirmPasswordController,
                      obscureText: _obscureText1,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText1 ? Icons.visibility_off: Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText1 = !_obscureText1;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                   /* ElevatedButton(
                      onPressed: () {
                        resetPassword(
                          _newPasswordController.text,
                          _confirmPasswordController.text,
                          //  uid: widget.uid,
                        );
                        if (_newPasswordController.text == _confirmPasswordController.text) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreendummy()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Passwords do not match'),
                            backgroundColor: Colors.red,
                          ));
                        }
                      },
                      child: const Text('Verify'),
                    ),*/

                    Center(
                      child: Container(
                        width: 150,
                        height: 40,
                        child: ElevatedButton(
                           onPressed: () {
                               resetPassword(
                                _newPasswordController.text,
                                _confirmPasswordController.text,
                            //  uid: widget.uid,
                            );
                    if (_newPasswordController.text == _confirmPasswordController.text) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreendummy()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Passwords do not match'),
                        backgroundColor: Colors.red,
                      ));
                    }
                  },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFB070FA)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                          ),
                          child: const Text('Reset'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
