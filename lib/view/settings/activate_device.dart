import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gotaps/utils/links.dart';

class ActivateDevice extends StatelessWidget {
  const ActivateDevice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FA),
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset("assets/icons/backarrow.svg"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Activate device"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text(
              "Activate a Gotap device",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Text(
              "Choose the device you are activating",
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF9AA0A6),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: device.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 1.1,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          device[index].image,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          device[index].name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
