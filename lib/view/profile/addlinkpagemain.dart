// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gotaps/view/profile/addlinks.dart';
import 'package:gotaps/view/profile/profile.dart';
import 'package:gotaps/providers/platforms_provider.dart';
import 'package:gotaps/utils/app_api.dart';
import 'package:provider/provider.dart';

class AddLinkPageMain extends StatefulWidget {
  const AddLinkPageMain({super.key});

  @override
  State<AddLinkPageMain> createState() => _AddLinkPageMainState();
}

class _AddLinkPageMainState extends State<AddLinkPageMain> {
  TextEditingController searchcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchcontroller.clear();
  }

  void dispose() {
    searchcontroller.dispose();
    super.dispose();
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    searchcontroller.clear();
  }

  Future<bool> _onWillPop() async {
    Navigator.pop(context);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: SvgPicture.asset("assets/icons/backarrow.svg"),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Profile()));
            },
          ),
          title: const Text("Add Links"),
        ),
        body: Consumer<PlatformsProvider>(
          builder: (context, PlatformsProvider, child) {
            if (PlatformsProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15, top: 20, bottom: 10),
                  child: SizedBox(
                    height: 50,
                    child: TextField(
                      controller: searchcontroller,
                      decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: SvgPicture.asset(
                              "assets/icons/search.svg",
                            ),
                          ),
                          prefixIconConstraints:
                              const BoxConstraints(minHeight: 20, minWidth: 20),
                          hintText: "Search links",
                          filled: true,
                          fillColor: const Color(0xFFF0F3F5),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 2)),
                      onChanged: (query) {
                        PlatformsProvider.filterSearchResults(query);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: PlatformsProvider.categories.length,
                    itemBuilder: (BuildContext context, int index) {
                      final category = PlatformsProvider.categories[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 70,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: const Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 16.0),
                              child: Text(
                                category.title_en,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: category.platforms.length,
                            itemBuilder: (BuildContext context, int index) {
                              final platform = category.platforms[index];
                              return ListTile(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 12),
                                title: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF0F3F5),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5, right: 8),
                                        child: CachedNetworkImage(
                                          imageUrl: ApiLinks.storageurl +
                                              platform.icon,
                                          height: 52,
                                          width: 52,
                                          placeholder: (context, url) =>
                                              const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                      Text(platform.title),
                                      const Spacer(),
                                      CupertinoButton(
                                          child: Container(
                                            width: platform.path != null &&
                                                    platform.path!.isNotEmpty
                                                ? 80
                                                : 70,
                                            height: 35,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Text(
                                              platform.path != null &&
                                                      platform.path!.isNotEmpty
                                                  ? "Update"
                                                  : "Add",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AddLinks(platform)));
                                          }),
                                    ],
                                  ),
                                ),
                                onTap: () {},
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10)
              ],
            );
          },
        ),
      ),
    );
  }
}
