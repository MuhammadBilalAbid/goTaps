import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gotaps/model/userdetails_model.dart';
import 'package:gotaps/view/profile/profilepreview.dart';
import 'package:gotaps/providers/profile_provider.dart';
import 'package:gotaps/utils/app_api.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late ImagePicker _imagePicker;
  String? coverImage;
  String? profileImage;
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
    _loadUserData();
  }

  void _loadUserData() {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    User user = profileProvider.user;
    nameController.text = user.firstName;
    locationController.text = user.address;
    bioController.text = user.bio;
    coverImage = user.backgroundImage;
    profileImage = user.profileImage;
  }

  Future<void> _pickCoverImageFromGallery() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        coverImage = pickedFile.path;
      });
    }
  }

  Future<void> _pickProfileImageFromGallery() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        profileImage = pickedFile.path;
      });
    }
  }

  Future<void> _updateProfile() async {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    User user = profileProvider.user;
    String authToken = user.token;

    if (coverImage == null || profileImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select both cover and profile images'),
        ),
      );
      return;
    }

    FormData updateProfileData = FormData.fromMap({
      'first_name': nameController.text,
      'address': locationController.text,
      'bio': bioController.text,
      'cover_photo':
          await MultipartFile.fromFile(coverImage!, filename: 'cover.jpg'),
      'photo':
          await MultipartFile.fromFile(profileImage!, filename: 'profile.jpg'),
    });

    Dio dio = Dio();

    try {
      Response response = await dio.post(
        ApiLinks.updateProfile,
        data: updateProfileData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $authToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        if (response.data['message'] == 'Profile updated successfully') {
          user.firstName = nameController.text;
          user.address = locationController.text;
          user.bio = bioController.text;
          user.backgroundImage = coverImage!;
          user.profileImage = profileImage!;
          profileProvider.updateCoverImage(coverImage!);
          profileProvider.updateProfileImage(profileImage!);
          profileProvider.updateUser(user);
          await User.saveUser(user);
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile not updated'),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error updating profile'),
          ),
        );
      }
    } catch (e) {
      log('Error updating profile: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred while updating the profile'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, provider, child) {
        return SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 5, left: 18),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "X",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        "Edit Profile",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(flex: 2),
                    ],
                  ),
                ),
                const Divider(
                  height: 0,
                  thickness: 2,
                  color: Color(0xFFE0E0E0),
                ),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        height: 170,
                        width: double.infinity,
                        child: coverImage != null
                            ? Image.file(
                                File(coverImage!),
                                fit: BoxFit.cover,
                              )
                            : Container(
                                color: const Color(0xFFE0E0E0),
                                child: const Center(
                                  child: Text(
                                    'Select a cover image',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: 135),
                        child: CircleAvatar(
                          radius: 44,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 41,
                            backgroundColor: const Color(0xFFF0F3F5),
                            backgroundImage: profileImage != null
                                ? FileImage(File(profileImage!))
                                : null,
                            child: profileImage == null
                                ? const Icon(
                                    Icons.person,
                                    size: 41,
                                    color: Colors.grey,
                                  )
                                : null,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 195, left: 67),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: _pickProfileImageFromGallery,
                            child:
                                SvgPicture.asset("assets/icons/add-circle.svg"),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 143, right: 27),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: _pickCoverImageFromGallery,
                            child: const CircleAvatar(
                              radius: 16,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.camera_alt_rounded),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: "Name",
                      filled: true,
                      fillColor: const Color(0xFFF0F3F5),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  child: TextField(
                    controller: locationController,
                    decoration: InputDecoration(
                      hintText: "Location",
                      filled: true,
                      fillColor: const Color(0xFFF0F3F5),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  child: TextField(
                    maxLines: 4,
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.top,
                    controller: bioController,
                    decoration: InputDecoration(
                      hintText: "Bio",
                      filled: true,
                      fillColor: const Color(0xFFF0F3F5),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      child: Container(
                        width: 145,
                        height: 45,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: const Color(0xFF94ADB8)),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Text(
                          "Preview",
                          style: TextStyle(color: Color(0xFF94ADB8)),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfilePreview(),
                          ),
                        );
                      },
                    ),
                    CupertinoButton(
                      child: Container(
                        width: 145,
                        height: 45,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Text(
                          "Update",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      onPressed: _updateProfile,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }
}
