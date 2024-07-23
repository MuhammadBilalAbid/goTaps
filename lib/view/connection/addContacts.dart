import 'package:flutter/material.dart';

class AddContacts extends StatefulWidget {
  const AddContacts({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  State<AddContacts> createState() => _AddContactsState();
}

class _AddContactsState extends State<AddContacts> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController websiteController = TextEditingController();

  Map<String, String> extractContactDetails(String text) {
    final RegExp emailRegex =
        RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b');
    final RegExp websiteRegex = RegExp(
      r'((https?:\/\/)?(www\.)?[a-zA-Z0-9\-]+\.[a-zA-Z]{2,}(\/[^\s]*)?)',
    );
    final RegExp phoneRegex = RegExp(r'\b\d{3,4}-?\d{7,8}\b');
    final RegExp nameRegex = RegExp(r'\b([A-Za-z]+)\s+([A-Za-z]+)\b');

    String? email = emailRegex.stringMatch(text);
    String? website = websiteRegex.stringMatch(text);
    String? phone = phoneRegex.stringMatch(text);
    List<String?>? name = nameRegex.firstMatch(text)?.groups([1, 2]);

    String? firstName = name != null && name.isNotEmpty ? name[0] : '';
    String? lastName = name != null && name.length > 1 ? name[1] ?? '' : '';

    return {
      'first_name': firstName ?? '',
      'last_name': lastName,
      'email': email ?? '',
      'phone': phone ?? '',
      'website': website ?? '',
    };
  }

  void initState() {
    super.initState();
    Map<String, String> contactDetails = extractContactDetails(widget.text);
    firstNameController.text = contactDetails['first_name'] ?? '';
    lastNameController.text = contactDetails['last_name'] ?? '';
    emailController.text = contactDetails['email'] ?? '';
    phoneNumberController.text = contactDetails['phone'] ?? '';
    websiteController.text = contactDetails['website'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Contact"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
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
                  controller: lastNameController,
                  decoration: InputDecoration(
                    hintText: "Last Name",
                    prefixIcon: const Icon(Icons.person),
                    filled: true,
                    fillColor: const Color.fromRGBO(240, 243, 245, 2),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your last name';
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
                      return 'Please enter your cell numer';
                    }
                    final emailPattern =
                        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailPattern.hasMatch(value)) {
                      return 'Please enter a valid cell number';
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
                      hintText: "Email Address",
                      prefixIcon: const Icon(Icons.email),
                      filled: true,
                      fillColor: const Color.fromRGBO(240, 243, 245, 1),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email address';
                    }
                    final phonePattern = RegExp(r'^\d{11}$');
                    if (!phonePattern.hasMatch(value)) {
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
                  controller: websiteController,
                  decoration: InputDecoration(
                      hintText: "website",
                      prefixIcon: const Icon(Icons.web),
                      filled: true,
                      fillColor: const Color.fromRGBO(240, 243, 245, 1),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your website';
                    }
                    return null;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
