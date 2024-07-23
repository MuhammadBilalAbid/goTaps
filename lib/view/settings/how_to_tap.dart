import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gotaps/view/settings/gotap_android.dart';
import 'package:gotaps/view/settings/gotap_newphones.dart';
import 'package:gotaps/utils/links.dart';
import 'package:gotaps/view/settings/settings.dart';

class HowToTap extends StatelessWidget {
  const HowToTap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FA),
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset("assets/icons/backarrow.svg"),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Settings()));
          },
        ),
        title: const Text("Activate device"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16, top: 25),
            child: Text(
              "How to Gotap or Scan",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              "Choose the device you are sharing to",
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF9AA0A6),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: totap.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    if (totap[index].title1 == "Gotap to new iphones") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GoTapNewPhone()),
                      );
                    } else if (totap[index].title1 == "Gotap to old iphones") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GoTapAndroid()),
                      );
                    } else if (totap[index].title1 == "Gotap to androids") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GoTapAndroid()),
                      );
                    } else if (totap[index].title1 == "Gotap with QR code") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GoTapNewPhone()),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 9, bottom: 5),
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        contentPadding:
                            const EdgeInsets.only(left: 10, top: 30),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  totap[index].title1,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  totap[index].title2,
                                  style: const TextStyle(
                                      fontSize: 12, color: Color(0xFF9AA0A6)),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 20, right: 10),
                              child: Image.asset(
                                totap[index].image,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }
}
