import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_scalable_ocr/flutter_scalable_ocr.dart';
import 'package:gotaps/view/connection/addContacts.dart';

class ScanCard extends StatefulWidget {
  const ScanCard({super.key});

  @override
  State<ScanCard> createState() => _AddContactsState();
}

class _AddContactsState extends State<ScanCard> {
  String text = "";
  StreamController<String> textController = StreamController<String>();

  void setText(value) {
    textController.add(value);
    text = value;
  }

  @override
  void dispose() {
    textController.close();
    super.dispose();
  }

  void navigateToScanCardData() {
    Timer(
      Duration(seconds: 1),
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddContacts(
              text: text,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan Card"),
      ),
      body: Center(
        child: Column(
          children: [
            ScalableOCR(
              paintboxCustom: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 10.0
                ..color = Color.fromARGB(153, 255, 255, 255),
              boxLeftOff: 15,
              boxBottomOff: 10,
              boxRightOff: 13,
              boxTopOff: 10,
              boxHeight: MediaQuery.of(context).size.height / 3.5,
              getRawData: (value) {
                inspect(value);
              },
              getScannedText: (value) {
                setText(value);
              },
            ),
            ElevatedButton(
                onPressed: navigateToScanCardData, child: Text("Scan Text")),
            SizedBox(height: 10),
            StreamBuilder<String>(
              stream: textController.stream,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Scanned text:\n\n${snapshot.data != null ? snapshot.data!.replaceAll(' ', " ") : ""}",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
