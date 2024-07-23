import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gotaps/view/auth/forgotpassword.dart';
import 'package:gotaps/view/auth/signup.dart';
import 'package:dio/dio.dart';
import 'package:gotaps/view/bottomnavigationbar.dart';
import 'package:gotaps/model/userdetails_model.dart';
import 'package:gotaps/utils/app_api.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool? isChecked = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                  "Sign In",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 18),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Sign In with your email and password below",
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
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: SizedBox(
                      width: double.infinity,
                      child: TextFormField(
                        style: const TextStyle(height: 1),
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
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(right: 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                          value: isChecked,
                          activeColor: Colors.black,
                          onChanged: (newbool) {
                            setState(() {
                              isChecked = newbool;
                            });
                          }),
                      const Text(
                        "Keep me logged in",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ForgotPassword()));
                    },
                    child: const Text(
                      "Forget Password?",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                    ),
                  )
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
                  "Sign in",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  Map<String, dynamic> signInData = {
                    'email': emailController.text,
                    'password': passwordController.text,
                  };
                  Map<String, dynamic> header = {
                    'Accept': 'application/json',
                    'Device-ID': '12345',
                  };
                  Dio dio = Dio();
                  //dio.options.headers = header;

                  try {
                    Response response = await dio.post(
                      ApiLinks.signin,
                      data: signInData,
                      options: Options(headers: header),
                    );

                    if (response.statusCode == 200) {
                      if (response.data['message'] ==
                          'Logged in successfully.') {
                        User user = User.fromJson(response.data['user']);
                        await User.saveUser(user);
                        User.updateInstance(response.data['user']);
                        // log(response.data.toString());
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NavBar(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Invalid email or password. Please try again.'),
                          ),
                        );
                      }
                    }
                    // ignore: deprecated_member_use
                  } on DioError catch (e) {
                    if (e.response != null) {
                      print("DioError with response: ${e.response}");
                    } else {
                      print("DioError without response: $e");
                    }
                  } catch (e) {
                    print("Error: $e");
                  }
                }
              },
            ),
            const Center(
              child: Text(
                "OR",
                style: TextStyle(fontSize: 20),
              ),
            ),
            CupertinoButton(
                child: Container(
                  width: 343,
                  height: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30)),
                  child: const Text(
                    "Create a new Account",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SignUp()));
                })
          ],
        ),
      ),
    );
  }
}
