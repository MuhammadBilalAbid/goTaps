import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gotaps/view/bottomnavigationbar.dart';
import 'package:gotaps/model/platfrom_model.dart';
import 'package:gotaps/model/userdetails_model.dart';
import 'package:gotaps/view/profile/profile.dart';
import 'package:gotaps/view/profile/profilepreview.dart';
import 'package:gotaps/providers/platforms_provider.dart';
import 'package:gotaps/utils/app_api.dart';
import 'package:provider/provider.dart';

class AddLinks extends StatefulWidget {
  final Platform platform;
  const AddLinks(this.platform, {super.key});
  @override
  State<AddLinks> createState() => _AddLinksState();
}

class _AddLinksState extends State<AddLinks> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.platform.path != null && widget.platform.path!.isNotEmpty) {
      usernameController.text = widget.platform.path!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlatformsProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(widget.platform.title,
                    style: const TextStyle(
                        fontSize: 21, fontWeight: FontWeight.w400)),
                const SizedBox(width: 50),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(_createRouteProfilePreview());
                  },
                  child: const Text(
                    "Preview",
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 216,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F8FA),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(ApiLinks.storageurl + widget.platform.icon,
                          height: 55),
                      const SizedBox(height: 6),
                      Text(widget.platform.title)
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 17),
                        child: SizedBox(
                          width: double.infinity,
                          child: TextFormField(
                            controller: usernameController,
                            style: const TextStyle(height: 1.0),
                            decoration: InputDecoration(
                              hintStyle:
                                  const TextStyle(color: Color(0xFF94ADB8)),
                              prefixIcon: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Username",
                                      style: TextStyle(
                                          color: Color(0xFF94ADB8),
                                          fontSize: 15),
                                    ),
                                    const SizedBox(width: 5),
                                    Image.asset(
                                        "assets/images/info-circle.png"),
                                  ],
                                ),
                              ),
                              filled: true,
                              fillColor: Color.fromARGB(255, 240, 243, 245),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter username';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 17),
                        child: Container(
                          width: double.infinity,
                          height: 48,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 240, 243, 245),
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, top: 10),
                            child: Text(
                              widget.platform.title,
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 210),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.platform.path != null &&
                            widget.platform.path!.isNotEmpty
                        ? CupertinoButton(
                            child: Container(
                              width: 145,
                              height: 45,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: const Color(0xFF94ADB8)),
                                  borderRadius: BorderRadius.circular(30)),
                              child: Text(
                                'Delete',
                                style: TextStyle(color: Color(0xFF94ADB8)),
                              ),
                            ),
                            onPressed: () async {
                              User? user = await User.loadUser();
                              String authToken = user!.token;
                              final dio = Dio();
                              try {
                                Response response = await dio.post(
                                  ApiLinks.deletePlatform,
                                  data: {'platform_id': widget.platform.id},
                                  options: Options(
                                    headers: {
                                      'Authorization': 'Bearer $authToken',
                                    },
                                  ),
                                );
                                if (response.statusCode == 200) {
                                  if (response.data['message'] ==
                                      'Plateform removed successfully') {
                                    Provider.of<PlatformsProvider>(context,
                                            listen: false)
                                        .removePlatform(widget.platform);

                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Profile()));
                                  }
                                }
                              } catch (e) {
                                print('Error deleting platform: $e');
                              }
                            },
                          )
                        : CupertinoButton(
                            child: Container(
                              width: 145,
                              height: 45,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: const Color(0xFF94ADB8)),
                                  borderRadius: BorderRadius.circular(30)),
                              child: Text(
                                'Cancel',
                                style: TextStyle(color: Color(0xFF94ADB8)),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                    CupertinoButton(
                      child: Container(
                        width: 145,
                        height: 45,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(30)),
                        child: Text(
                          widget.platform.path != null &&
                                  widget.platform.path!.isNotEmpty
                              ? 'Update'
                              : 'Add',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      onPressed: () async {
                        User? user = await User.loadUser();
                        String authToken = user!.token;
                        log(user.token);
                        if (_formKey.currentState!.validate()) {
                          await Provider.of<PlatformsProvider>(context,
                                  listen: false)
                              .addOrUpdatePlatform(widget.platform,
                                  usernameController.text, authToken);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NavBar(),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
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
