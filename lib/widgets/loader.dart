import 'package:flutter/material.dart';

class loader extends StatelessWidget {
  final String actionName;

  const loader({
    super.key,
    required this.actionName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 130),
      child: Center(
        child: Column(
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 15),
            Text(
              actionName,
              style: TextStyle(fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }
}
