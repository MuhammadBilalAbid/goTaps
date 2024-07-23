import 'package:flutter/material.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({Key? key}) : super(key: key);

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  List<TextEditingController> otpControllers =
      List.generate(6, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            6,
            (index) => SizedBox(
              width: 50,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: TextFormField(
                  controller: otpControllers[index],
                  maxLength: 1,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    counterText: '',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  onChanged: (value) {
                    if (value.length == 1 && index < 5) {
                      FocusScope.of(context).nextFocus();
                    } else if (value.isEmpty && index > 0) {
                      FocusScope.of(context).previousFocus();
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
