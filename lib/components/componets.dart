// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

class MyList extends StatelessWidget {
  final String icons;
  final String title;
  final String icons2;

  const MyList({
    super.key,
    required this.icons,
    required this.title,
    required this.icons2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
          height: 45,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE4E4E4))),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: SvgPicture.asset(
                  icons,
                  color: Colors.black,
                  height: 20,
                ),
              ),
              Text(
                title,
                style: const TextStyle(fontSize: 16),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: icons2.endsWith('.svg')
                    ? CircleAvatar(
                        radius: 13,
                        backgroundColor: const Color(0xFFE0E0E0),
                        child: SvgPicture.asset(
                          icons2,
                          height: 15,
                        ),
                      )
                    : Text(
                        icons2,
                        style: const TextStyle(
                          color: Color(0xFF94ADB8),
                          fontSize: 15,
                        ),
                      ),
              ),
            ],
          )),
    );
  }
}
