// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:gotaps/providers/contacts_provider.dart';
import 'package:gotaps/providers/platforms_provider.dart';
import 'package:gotaps/providers/profile_provider.dart';
import 'package:gotaps/view/splashscreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const goTaps());
}

class goTaps extends StatefulWidget {
  const goTaps({super.key});

  @override
  State<goTaps> createState() => _goTapsState();
}

class _goTapsState extends State<goTaps> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => PlatformsProvider()),
        ChangeNotifierProvider(create: (_) => ConnectionsProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
