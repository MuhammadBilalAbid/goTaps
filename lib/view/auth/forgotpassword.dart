// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gotaps/view/auth/otpVerify.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: SizedBox(
                width: double.infinity,
                child: TextFormField(
                  style: const TextStyle(height: 1),
                  controller: emailController,
                  decoration: InputDecoration(
                      hintText: "Email address",
                      prefixIcon: const Icon(Icons.email),
                      filled: true,
                      fillColor: const Color.fromRGBO(240, 243, 245, 1),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    final emailPattern =
                        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailPattern.hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          CupertinoButton(
              child: Container(
                width: 343,
                height: 45,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(30)),
                child: const Text(
                  "Send Code",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OtpVerification(),
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
