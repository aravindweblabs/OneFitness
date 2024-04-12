import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FootorPage extends StatelessWidget {
  final Uri whatsappUri = Uri.parse('https://wa.me/+911234567890');
  final Uri faceBookUri = Uri.parse('https://www.facebook.com');
  final Uri instaUri = Uri.parse('https://www.instagram.com');


  Future<void> _launchWhatsApp() async {
    if (await canLaunch(whatsappUri.toString())) {
      await launch(whatsappUri.toString());
    } else {
      throw 'Could not launch WhatsApp';
    }
  }

  Future<void> _launchFacebook() async {
    if (await canLaunch(faceBookUri.toString())) {
      await launch(faceBookUri.toString());
    } else {
      throw 'Could not launch Facebook';
    }
  }

  Future<void> _launchInsta() async {
    if (await canLaunch(instaUri.toString())) {
      await launch(instaUri.toString());
    } else {
      throw 'Could not launch Instagram';
    }
  }
  Future<void> _launchTwitter() async {
    final Uri twitterUri = Uri.parse('https://twitter.com');

    if (await canLaunch(twitterUri.toString())) {
      await launch(twitterUri.toString());
    } else {
      throw 'Could not launch Twitter';
    }
  }

  Future<void> _launchGmail() async {
    final Uri gmailUri = Uri(
      scheme: 'mailto',
      path: 'Email:info@weblabs.in',
      queryParameters: {'subject': 'Subject for the email', 'body': 'Body of the email'},
    );

    if (await canLaunch(gmailUri.toString())) {
      await launch(gmailUri.toString());
    } else {
      throw 'Could not launch Gmail';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: double.infinity,
      color: const Color(0xFFe2f3ec),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 8.0, bottom: 16.0),
            child: Text(
              'Quick Links',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const Text(
            'Contact: +91 1234567777',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height : 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              GestureDetector(
                onTap: _launchWhatsApp,
                child:  const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.whatsapp,
                      size: 30,
                      color: Colors.green,
                    ),
                    SizedBox(width: 8),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: _launchFacebook,
                child:  const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.facebook,
                      size: 30,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 8),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: _launchInsta,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.instagram,
                      size: 30,
                      color: Colors.pink,
                    ),
                    SizedBox(width: 8),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: _launchTwitter,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.twitter,
                      size: 30,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 8),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: _launchGmail,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.email,
                      size: 30,
                      color: Colors.red[400],
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ),

            ],
          ),
          const SizedBox(height: 16),

        ],
      ),
    );
  }
}