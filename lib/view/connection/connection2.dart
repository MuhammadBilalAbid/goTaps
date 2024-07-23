// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:gotaps/providers/contacts_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gotaps/utils/app_api.dart';
import 'package:gotaps/view/bottomnavigationbar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gotaps/view/connection/scanCard.dart';
import 'package:provider/provider.dart';

class Connection2 extends StatelessWidget {
  const Connection2({super.key});

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
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ScanCard()));
                  },
                  child: SvgPicture.asset(
                    "assets/icons/Connection.svg",
                    color: Colors.black,
                  ),
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
        body:
            Consumer<ConnectionsProvider>(builder: (context, Provider, child) {
          return Column(
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
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 2)),
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
                      tabs: [
                        GestureDetector(
                          child: Tab(
                            text: 'People',
                          ),
                          onTap: () {},
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
                  itemCount: Provider.connections.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Connections = Provider.connections;
                    final isLastItem = index == Connections.length - 1;

                    return Padding(
                      padding: EdgeInsets.only(
                          left: 12,
                          right: 12,
                          top: 8,
                          bottom: isLastItem ? 8 : 8),
                      child: Container(
                        color: Colors.white,
                        child: Slidable(
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) => {},
                                backgroundColor: const Color(0xFF808080),
                                foregroundColor: Colors.white,
                                label: 'Remove',
                              ),
                              SlidableAction(
                                onPressed: (context) => {},
                                backgroundColor: const Color(0xFF489EF4),
                                foregroundColor: Colors.white,
                                label: 'Favourite',
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(ApiLinks.storageurl +
                                      Connections[index].connectionPhoto),
                                ),
                              ),
                            ),
                            title: Row(
                              children: [
                                Text(Connections[index].connectionFirstName),
                                const SizedBox(width: 5),
                                Image.asset("assets/images/verified.png"),
                              ],
                            ),
                            subtitle: Text(
                              Connections[index].connectionJobTitle,
                              style: const TextStyle(color: Color(0xFF94ADB8)),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
