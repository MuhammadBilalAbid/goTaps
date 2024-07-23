import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GoTapAndroid extends StatelessWidget {
  const GoTapAndroid({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset("assets/icons/backarrow.svg"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Activate device", style: TextStyle(fontSize: 20)),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Text(
              "Live Chat",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Gotap to Androids",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Text(
                "Every Android with NFC (almost all)",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF9AA0A6),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "To share to Androids, slide your Gotap around the center back area of their phone. Every Android has a slightly different spot for their NFC reader, but generally it's near the center",
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Image.asset("assets/images/danger 1.png"),
                  const SizedBox(width: 5),
                  const Text(
                    "Important",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Unlike iPhones, Androids have the ability to turn NFC off in settings. Before tapping to an Android, make sure their NFC is turned on. To turn NFC on, search 'NFC' in the Android phone settings",
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              Image.asset("assets/images/androidpngtap.png", height: 300),
              Row(
                children: [
                  Image.asset("assets/images/howtotap/Group 33921.png",
                      height: 50),
                  const SizedBox(width: 5),
                  const Text(
                    "You Always Have a Backup",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "If you've tried everything and your Gotap device is still not working, you can always use your Gotap QR code to share your profile! Your Gotap QR code can be found in the share tab at the bottom center of your screen",
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
