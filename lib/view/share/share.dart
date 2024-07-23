// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gotaps/providers/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:qr_bar_code/qr/qr.dart';
import 'package:url_launcher/url_launcher.dart';

class Share extends StatelessWidget {
  const Share({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<ProfileProvider>(builder: (context, provider, child) {
      return Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 70),
            child: Center(
              child: Text(
                "Share your profile via QR code",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: 185,
            width: 185,
            child: Column(
              children: [
                QRCode(data: "www.google.com"),
              ],
            ),
          ),
          const SizedBox(height: 15),
          const Center(child: Text("Tap to save QR code")),
          const SizedBox(height: 15),
          CupertinoButton(
            child: Container(
              width: 320,
              height: 45,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(30)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    height: 20,
                    "assets/icons/send.svg",
                    color: Colors.white,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Share",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            onPressed: () {},
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 42,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color(0xFFF3F5F7),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "gotap/${provider.user.firstName}",
                      style: TextStyle(fontSize: 17),
                    ),
                    SvgPicture.asset("assets/icons/copy.svg"),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    launchUrl('mailto:?subject=Welcome to ToTap');
                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: const Color(0xFFF3F5F7),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/email.svg",
                          height: 18,
                        ),
                        const Text(
                          "Email",
                          style: TextStyle(fontSize: 14),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    launchUrl('sms:?body=Welcome to ToTap');
                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: const Color(0xFFF3F5F7),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/message.svg",
                          height: 18,
                        ),
                        const Text(
                          "Text",
                          style: TextStyle(fontSize: 14),
                        )
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: const Color(0xFFF3F5F7),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/widget.svg",
                        height: 18,
                      ),
                      const Text(
                        "Widget",
                        style: TextStyle(fontSize: 14),
                      )
                    ],
                  ),
                ),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: const Color(0xFFF3F5F7),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/wallet.svg",
                        height: 18,
                      ),
                      const Text(
                        "Wallet",
                        style: TextStyle(fontSize: 14),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      );
    }));
  }
}

Future<void> launchUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
