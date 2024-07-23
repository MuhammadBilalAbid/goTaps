import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gotaps/providers/platforms_provider.dart';
import 'package:gotaps/providers/profile_provider.dart';
import 'package:gotaps/utils/app_api.dart';
import 'package:provider/provider.dart';

class ProfilePreview extends StatefulWidget {
  const ProfilePreview({super.key});

  @override
  State<ProfilePreview> createState() => _ProfilePreviewState();
}

class _ProfilePreviewState extends State<ProfilePreview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Consumer<ProfileProvider>(
            builder: (context, provider, child) {
              final user = provider.user;
              return Container(
                child: Column(
                  children: [
                    SizedBox(height: 13),
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            height: 170,
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                File(user.backgroundImage),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: const EdgeInsets.only(top: 130),
                            child: CircleAvatar(
                              radius: 47,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 44,
                                backgroundImage:
                                    FileImage(File(user.profileImage)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          user.firstName,
                          style: const TextStyle(fontSize: 17),
                        ),
                        const SizedBox(width: 5),
                        Image.asset("assets/images/verified.png")
                      ],
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: Text(
                        user.bio,
                        style: const TextStyle(color: Color(0xFF94ADB8)),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CupertinoButton(
                child: Container(
                  width: 270,
                  height: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30)),
                  child: const Text(
                    "Connect with",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onPressed: () {},
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: SvgPicture.asset("assets/icons/Connection2.svg",
                    height: 40),
              ),
            ],
          ),
          Container(
            height: 350,
            width: double.infinity,
            color: const Color(0xFFF5F8FA),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Consumer<ProfileProvider>(
                    builder: (context, provider, child) {
                      final user = provider.user;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Connect with ${user.firstName}",
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Consumer<PlatformsProvider>(
                  builder: (context, provider, child) {
                    final platforms = provider.filteredPlatforms;
                    return Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: platforms.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 1.2,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          final platform = platforms[index];
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                ApiLinks.storageurl + platform.icon,
                                height: 70,
                                width: 70,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(height: 3),
                              Text(
                                platform.title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
