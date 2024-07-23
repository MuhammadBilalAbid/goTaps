// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:gotaps/utils/links.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gotaps/view/bottomnavigationbar.dart';

class Connection extends StatelessWidget {
  const Connection({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: SvgPicture.asset("assets/icons/backarrow.svg"),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const NavBar()));
            },
          ),
          title: const Padding(
            padding: EdgeInsets.only(right: 50),
            child: Text("Connection"),
          ),
          actions: [
            Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/Connection.svg",
                  color: Colors.black,
                ),
                const SizedBox(width: 13),
                SvgPicture.asset("assets/icons/external-link.svg"),
              ],
            ),
            const SizedBox(width: 13),
          ],
          bottom: const PreferredSize(
              preferredSize: Size.fromHeight(8),
              child: Divider(
                color: Color(0xFFE0E0E0),
              )),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: SvgPicture.asset(
                          "assets/icons/search.svg",
                        ),
                      ),
                      prefixIconConstraints:
                          const BoxConstraints(minHeight: 20, minWidth: 20),
                      hintText: "Search name, companies and more",
                      filled: true,
                      fillColor: const Color(0xFFF0F3F5),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 2)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30)),
                    labelColor: Colors.white,
                    labelStyle: const TextStyle(fontSize: 15),
                    unselectedLabelColor: Colors.black,
                    tabs: const [
                      Tab(
                        text: 'People',
                      ),
                      Tab(
                        text: 'Group',
                      )
                    ]),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: listofpeople.length,
                  itemBuilder: (BuildContext context, int index) {
                    final isLastItem = index == listofpeople.length - 1;

                    return Padding(
                      padding: EdgeInsets.only(
                          left: 12,
                          right: 12,
                          top: 8,
                          bottom: isLastItem ? 8 : 8),
                      child: Container(
                        color: Colors.white,
                        child: ListTile(
                          leading: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(listofpeople[index].image),
                              ),
                            ),
                          ),
                          title: Row(
                            children: [
                              Text(listofpeople[index].name),
                              const SizedBox(width: 5),
                              Image.asset("assets/images/verified.png"),
                            ],
                          ),
                          subtitle: Text(
                            listofpeople[index].desigination,
                            style: const TextStyle(color: Color(0xFF94ADB8)),
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
