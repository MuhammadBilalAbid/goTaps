import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gotaps/view/profile/addlinkpagemain.dart';
import 'package:gotaps/view/profile/profilepreview.dart';
import 'package:gotaps/view/profile/edit_profile.dart';
import 'package:gotaps/providers/platforms_provider.dart';
import 'package:gotaps/providers/profile_provider.dart';
import 'package:gotaps/widgets/loader.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gotaps/utils/app_api.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool direct = false;
  bool privateprofile = false;

  @override
  Widget build(BuildContext context) {
    return Consumer2<ProfileProvider, PlatformsProvider>(
      builder: (context, ProfileProvider, PlatformsProvider, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
              icon: SvgPicture.asset("assets/icons/send.svg"),
              onPressed: () {},
            ),
            title: Image.asset(
              "assets/images/gotaps_logo_landscape 1.png",
              height: 150,
              width: 100,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12, left: 69),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(_createRouteProfilePreview());
                  },
                  child: const Text(
                    "Preview",
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.w400),
                  ),
                ),
              )
            ],
          ),
          body: ProfileProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            height: 90,
                            width: 21,
                          ),
                          CircleAvatar(
                              radius: 20,
                              backgroundImage: FileImage(
                                  File(ProfileProvider.user.profileImage))),
                          const SizedBox(width: 12),
                          Text(
                            ProfileProvider.user.firstName,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const Spacer(),
                          CupertinoButton(
                              child: Container(
                                width: 120,
                                height: 28,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: const Color(0xff9AA0A6)),
                                    borderRadius: BorderRadius.circular(30)),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.edit),
                                    SizedBox(width: 5),
                                    Text(
                                      "Edit Profile",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              onPressed: () {
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const EditProfile();
                                    });
                              }),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: const Color(0xFFF5F8FA),
                            border: Border.all(color: Colors.black, width: 2)),
                        height: 585,
                        width: 411,
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                        "assets/images/info-circle.png"),
                                    const SizedBox(width: 5),
                                    const Text(
                                      "Direct",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(width: 7),
                                    SizedBox(
                                      height: 33,
                                      width: 45,
                                      child: FittedBox(
                                        fit: BoxFit.fill,
                                        child: Switch(
                                            activeTrackColor: Colors.black,
                                            value: direct,
                                            onChanged: (value) {
                                              setState(() {
                                                direct = value;
                                              });
                                            }),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(width: 40),
                                Row(
                                  children: [
                                    Image.asset(
                                        "assets/images/info-circle.png"),
                                    const SizedBox(width: 5),
                                    const Text(
                                      "Private Profile",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(width: 7),
                                    SizedBox(
                                      height: 33,
                                      width: 45,
                                      child: FittedBox(
                                        fit: BoxFit.fill,
                                        child: Switch(
                                            activeTrackColor: Colors.black,
                                            value: privateprofile,
                                            onChanged: (value) {
                                              setState(() {
                                                privateprofile = value;
                                              });
                                            }),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            CupertinoButton(
                              child: Container(
                                width: 320,
                                height: 45,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(30)),
                                child: const Text(
                                  "Add Links",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const AddLinkPageMain(),
                                  ),
                                );
                              },
                            ),
                            Expanded(
                              child: Stack(
                                children: [
                                  Visibility(
                                    visible: !PlatformsProvider.isLoading,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: PlatformsProvider
                                            .filteredPlatforms.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          final isLastItem = index ==
                                              PlatformsProvider
                                                      .filteredPlatforms
                                                      .length -
                                                  1;
                                          final platform = PlatformsProvider
                                              .filteredPlatforms[index];

                                          return Padding(
                                            padding: EdgeInsets.only(
                                                left: 12,
                                                right: 12,
                                                top: 8,
                                                bottom: isLastItem ? 110 : 8),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.white,
                                              ),
                                              child: ListTile(
                                                contentPadding:
                                                    EdgeInsets.only(left: 5),
                                                leading: Container(
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        ApiLinks.storageurl +
                                                            platform.icon,
                                                    height: 47,
                                                    width: 47,
                                                    placeholder: (context,
                                                            url) =>
                                                        const CircularProgressIndicator(),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
                                                  ),
                                                ),
                                                title: Text(platform.title),
                                                trailing: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 5),
                                                  child: Switch(
                                                      activeTrackColor:
                                                          Colors.black,
                                                      value:
                                                          platform.direct == 1,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          platform.direct =
                                                              value ? 1 : 0;
                                                        });
                                                      }),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                  Visibility(
                                    visible: PlatformsProvider.isLoading,
                                    child: loader(actionName: 'Loading...'),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
        );
      },
    );
  }
}

Route _createRouteProfilePreview() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const ProfilePreview(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: const Duration(seconds: 1));
}
