import 'package:flutter/material.dart';
import 'package:onefitness/resetpass.dart';

class EnterOtpPage extends StatefulWidget {
  final String email;
  final String otp;

  EnterOtpPage({
    Key? key,
    required this.email,
    required this.otp,
  }) : super(key: key);

  @override
  _EnterOtpPageState createState() => _EnterOtpPageState();
}

class _EnterOtpPageState extends State<EnterOtpPage> {
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Your Otp'),
        backgroundColor: Color(0xFFB070FA),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: otpController, // Add controller here
                    decoration: InputDecoration(
                      labelText: 'Enter OTP',
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
               /* ElevatedButton(
                  onPressed: () {
                    String enteredOtp = otpController.text; // Update enteredOtp here
                    if (enteredOtp == widget.otp) {
                      print('Entered OTP: $enteredOtp');
                      print('Received OTP: ${widget.otp}');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResetPasswordPage(
                              email:widget.email,
                              otp:widget.otp
                          ),
                        ),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Incorrect OTP'),
                            content: Text('Please enter the correct OTP.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
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
                        String enteredOtp = otpController.text; // Update enteredOtp here
                        if (enteredOtp == widget.otp) {
                          print('Entered OTP: $enteredOtp');
                          print('Received OTP: ${widget.otp}');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResetPasswordPage(
                                  email:widget.email,
                                  otp:widget.otp
                              ),
                            ),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Incorrect OTP'),
                                content: Text('Please enter the correct OTP.'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
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
                      child: const Text('Verify'),
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
