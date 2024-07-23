import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gotaps/view/settings/activate_device.dart';
import 'package:gotaps/view/auth/signin.dart';
import 'package:gotaps/view/bottomnavigationbar.dart';
import 'package:gotaps/components/componets.dart';
import 'package:gotaps/view/settings/how_to_tap.dart';
import 'package:gotaps/model/userdetails_model.dart';
import 'package:gotaps/view/profile/profilepreview.dart';
import 'package:gotaps/providers/profile_provider.dart';
import 'package:gotaps/view/share/share.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, provider, child) {
        final user = provider.user;
        return Scaffold(
          backgroundColor: const Color(0xFFF5F8FA),
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
              icon: SvgPicture.asset("assets/icons/backarrow.svg"),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const NavBar()));
              },
            ),
            title: const Text("Settings"),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 15, left: 15),
                  child: Text("Accounts (1)",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfilePreview()));
                  },
                  child: MyList(
                    icons: "assets/icons/Profile.svg",
                    title: user.firstName,
                    icons2: "assets/icons/nextarrow.svg",
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 15, left: 15),
                  child: Text("General",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ActivateDevice()));
                  },
                  child: const MyList(
                    icons: "assets/icons/key.svg",
                    title: 'Activate a Gotaps',
                    icons2: "assets/icons/nextarrow.svg",
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HowToTap()));
                  },
                  child: const MyList(
                    icons: "assets/icons/help.svg",
                    title: 'How to tap',
                    icons2: "assets/icons/nextarrow.svg",
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    launchUrl("https://gotaps.me/standard-products/");
                  },
                  child: const MyList(
                    icons: "assets/icons/copy.svg",
                    title: 'Buy a Gotap Device',
                    icons2: "assets/icons/nextarrow.svg",
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 15, left: 15),
                  child: Text("Share",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                ),
                MyList(
                  icons: "assets/icons/link.svg",
                  title: 'Profile link',
                  icons2: user.firstName,
                ),
                const SizedBox(height: 10),
                const MyList(
                  icons: "assets/icons/invite.svg",
                  title: 'Invite',
                  icons2: "assets/icons/nextarrow.svg",
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 15, left: 15),
                  child: Text("More",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                ),
                GestureDetector(
                  onTap: () {
                    User.deleteUser();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignIn()));
                  },
                  child: const MyList(
                    icons: "assets/icons/signout.svg",
                    title: 'Sign out',
                    icons2: "assets/icons/nextarrow.svg",
                  ),
                ),
                const SizedBox(height: 10)
              ],
            ),
          ),
        );
      },
    );
  }
}
