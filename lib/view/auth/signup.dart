import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gotaps/view/bottomnavigationbar.dart';
import 'package:gotaps/model/userdetails_model.dart';
import 'package:gotaps/utils/app_api.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool? isChecked = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController usertNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 70),
            Center(
              child: Image.asset(
                "assets/images/gotaps_logo_landscape 1.png",
              ),
            ),
            const SizedBox(height: 44),
            const Padding(
              padding: EdgeInsets.only(left: 18),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Sign up",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 18),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Sign up with your contact information below",
                  style: TextStyle(color: Color.fromRGBO(148, 173, 184, 1)),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: SizedBox(
                      width: double.infinity,
                      child: TextFormField(
                        style: const TextStyle(height: 0.7),
                        controller: usertNameController,
                        decoration: InputDecoration(
                          hintText: "User Name",
                          prefixIcon: const Icon(Icons.person),
                          filled: true,
                          fillColor: const Color.fromRGBO(240, 243, 245, 1),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: SizedBox(
                      width: double.infinity,
                      child: TextFormField(
                        style: const TextStyle(height: 0.7),
                        controller: firstNameController,
                        decoration: InputDecoration(
                          hintText: "First Name",
                          prefixIcon: const Icon(Icons.person),
                          filled: true,
                          fillColor: const Color.fromRGBO(240, 243, 245, 1),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: SizedBox(
                      width: double.infinity,
                      child: TextFormField(
                        style: const TextStyle(height: 0.7),
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
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: SizedBox(
                      width: double.infinity,
                      child: TextFormField(
                        style: const TextStyle(height: 0.7),
                        controller: phoneNumberController,
                        decoration: InputDecoration(
                            hintText: "Phone Number",
                            prefixIcon: const Icon(Icons.call),
                            filled: true,
                            fillColor: const Color.fromRGBO(240, 243, 245, 1),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your cell number';
                          }
                          final phonePattern = RegExp(r'^\d{11}$');
                          if (!phonePattern.hasMatch(value)) {
                            return 'Please enter a valid phone number';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: SizedBox(
                      width: double.infinity,
                      child: TextFormField(
                        style: const TextStyle(height: 0.7),
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                            hintText: "Password",
                            prefixIcon: const Icon(Icons.key),
                            filled: true,
                            fillColor: const Color.fromRGBO(240, 243, 245, 1),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Password';
                          }
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters long';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: SizedBox(
                      width: double.infinity,
                      child: TextFormField(
                        style: const TextStyle(height: 0.7),
                        obscureText: true,
                        controller: confirmPasswordController,
                        decoration: InputDecoration(
                            hintText: "Confirm Password",
                            prefixIcon: const Icon(Icons.key),
                            filled: true,
                            fillColor: const Color.fromRGBO(240, 243, 245, 1),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please confirm the password';
                          }
                          if (passwordController.text !=
                              confirmPasswordController.text) {
                            return "Password does not match";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            CupertinoButton(
                child: Container(
                  width: 343,
                  height: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30)),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    Map<String, dynamic> signUpData = {
                      'username': usertNameController.text,
                      'first_name': firstNameController.text,
                      'email': emailController.text,
                      'phone': phoneNumberController.text,
                      'password': passwordController.text,
                      'password_confirmation': confirmPasswordController.text,
                    };
                    Map<String, dynamic> header = {
                      'Accept': 'application/json',
                      'Device-ID': '12345',
                    };
                    Dio dio = Dio();
                    try {
                      Response response = await dio.post(ApiLinks.register,
                          data: signUpData, options: Options(headers: header));
                      if (response.statusCode == 200) {
                        User user = User.fromJson(response.data['user']);
                        await User.saveUser(user);
                        User.updateInstance(response.data['user']);
                        showDialog(
                          context: context,
                          builder: (_context) => const AlertDialog(
                            title: Text('Success'),
                            content: Text("Successfully Registered"),
                          ),
                        );
                        Future.delayed(const Duration(seconds: 2), () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NavBar()),
                          );
                        });
                      } else {
                        print("Error: ${response.statusCode}");
                      }
                      // ignore: deprecated_member_use
                    } on DioError catch (e) {
                      if (e.response != null) {
                        print("DioError with response: ${e.response}");
                      } else {
                        print("DioError without response: $e");
                      }
                    } catch (e) {
                      //log(e.toString());
                    }
                  }
                }),
          ],
        ),
      ),
    );
  }
}
