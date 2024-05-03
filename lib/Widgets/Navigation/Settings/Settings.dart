import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartmeter/Widgets/Navigation/Settings/Profile/ProfileInfo.dart';
import 'package:smartmeter/Widgets/Navigation/Settings/address/UtilityAccount.dart';
import 'package:smartmeter/helpers/image_upload_helper.dart';

import '../../../helpers/SnackBarHelper.dart';
import '../../../main.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SettingsState();
  }
}

class _SettingsState extends State<Settings> {
  late SharedPreferences preferences;
  String userName = "Chiruhas Bobbadi";

  String imageUrl = "";

  void _clearData() async {
    await preferences.clear();
  }

  void asyncDataFetch() async {
    preferences = await SharedPreferences.getInstance();

    setState(() {
      userName =
      "${preferences.getString("firstName")} ${preferences.getString(
          "lastName")}";
    });
  }

  void navigate(String dest) {
    switch (dest) {
      case 'profile':
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ProfileInfo(),
          ),
        );
        break;
      case 'utilityAccount':
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>  UtilityAccount(prefs : preferences),
          ),
        );
        break;
    }
  }

  @override
  void initState() {
    super.initState();

    asyncDataFetch();
  }

  void setProfileImage(BuildContext context) {


    /**
     *
     */

    File? selectedImage;

    ImagePicker()
        .pickImage(source: ImageSource.gallery)
        .then((value) async {
      selectedImage = File(value!.path);
      //apikall

      showPlatformDialog(
        context: context,
        builder: (context) =>
            BasicDialogAlert(
              title: const Text("Confirm Image Selection"),
              content: const Text(
                  "Are you sure you want to set this image as your profile picture"),
              actions: <Widget>[
                BasicDialogAction(
                  title: const Text("cancel"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                BasicDialogAction(
                  title: const Text("ok"),
                  onPressed: () async {
                    bool status =
                    await ImageUploadHelper.uploadProfileImage(selectedImage!);
                    if (status) {
                      SnackBarHelper.showMessage(
                          "Profile Image Uploaded Sucessfully", context);
                      Navigator.pop(context);
                    } else {
                      SnackBarHelper.showMessage(
                          "Profile Image Upload Failed", context);
                    }
                  },
                ),
              ],
            ),
      );
    }).onError((error, stackTrace) {});
  }

  @override
  Widget build(BuildContext context) {
    Widget w = imageUrl.isEmpty ? CircleAvatar(
      radius: 64,
      backgroundColor: Colors.brown.shade800,
      child: Text(
        imageUrl.isNotEmpty
            ? ""
            : "${userName.split(" ")[0][0]}${userName.split(" ")[1][0]}",
        style: const TextStyle(color: Colors.white, fontSize: 32),
      ),
    ) : CircleAvatar(
      radius: 64,
      backgroundColor: Colors.brown.shade800,
      backgroundImage: NetworkImage(imageUrl),
      child: Text(
        imageUrl.isNotEmpty
            ? ""
            : "${userName.split(" ")[0][0]}${userName.split(" ")[1][0]}",
        style: const TextStyle(color: Colors.white, fontSize: 32),
      ),
    );


    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
              onTap: () {
                setProfileImage(context);
              },
              child:w
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            userName,
            style: const TextStyle(
                color: Colors.blueAccent,
                fontSize: 32,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "User Since : Jan 2024",
            style: TextStyle(
                color: Color(0xff9D9B9B),
                fontSize: 16,
                fontWeight: FontWeight.normal),
          ),
          const SizedBox(
            height: 64,
          ),
          InkWell(
            onTap: () {
              navigate("profile");
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    width: 3,
                    color: Colors.grey,
                    style: BorderStyle.solid,
                  )),
              height: 48,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.account_circle,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Profile Info",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  Spacer(flex: 1),
                  Icon(Icons.arrow_right_alt_rounded, color: Colors.grey)
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  width: 3,
                  color: Colors.grey,
                  style: BorderStyle.solid,
                )),
            height: 48,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.group_add,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "User Management",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                Spacer(flex: 1),
                Icon(Icons.arrow_right_alt_rounded, color: Colors.grey)
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          InkWell(
            onTap: () {
              navigate("utilityAccount");
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    width: 3,
                    color: Colors.grey,
                    style: BorderStyle.solid,
                  )),
              height: 48,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.electric_meter,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Utility Account Info",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  Spacer(flex: 1),
                  Icon(Icons.arrow_right_alt_rounded, color: Colors.grey)
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  width: 3,
                  color: Colors.grey,
                  style: BorderStyle.solid,
                )),
            height: 48,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.support_rounded,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Help Center",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                Spacer(flex: 1),
                Icon(Icons.arrow_right_alt_rounded, color: Colors.grey)
              ],
            ),
          ),
          const Spacer(
            flex: 2,
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
            child: ElevatedButton(
              onPressed: () {
                // clear shared prefs and navigate to main page
                _clearData();

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyApp()),
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), // <-- Radius
                  ),
                  side: const BorderSide(color: Colors.red)),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Logout"),
                  SizedBox(
                    width: 16,
                  ),
                  Icon(Icons.logout_rounded)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
