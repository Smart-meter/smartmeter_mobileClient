import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../helpers/SharedPrefHelper.dart';
import '../../../../helpers/SnackBarHelper.dart';
import '../../../../helpers/user_details_helper.dart';
import '../../../Auth/Auth.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({super.key});

  @override
  State<StatefulWidget> createState() {
    return ProfileInfoState();
  }
}

class ProfileInfoState extends State<ProfileInfo> {
  // make sure you dispose them
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void asyncStuff() async {
    SharedPreferences prefs = await SharedPrefsHelper.getPrefs();
    _firstNameController.text = prefs.getString("firstName")!;
    _lastNameController.text = prefs.getString("lastName")!;
  }

  @override
  void initState() {
    super.initState();
    asyncStuff();
    Future.delayed(Duration.zero).then((_) {});
  }

  Future<void> _userNameDialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change User Name'),
          content: SizedBox(
            height: 160,
            child: Column(
              children: [
                TextField(
                  keyboardType: TextInputType.text,
                  style: const TextStyle(color: Colors.black),
                  controller: _firstNameController,
                  decoration: InputDecoration(
                      labelText: 'First Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  keyboardType: TextInputType.text,
                  style: const TextStyle(color: Colors.black),
                  controller: _lastNameController,
                  decoration: InputDecoration(
                      labelText: 'Last Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Proceed'),
              onPressed: () async {
                if (_firstNameController.text.trim().isNotEmpty &&
                    _lastNameController.text.trim().isNotEmpty) {
                  // api call
                  String a = _firstNameController.text;
                  String b = _lastNameController.text;
                  bool response = await UserDetailsHelper.updateFLName(a, b);

                  if (response) {
                    SnackBarHelper.showMessage("Successfully Updated!", context);
                    Navigator.of(context).pop();
                  } else {
                    SnackBarHelper.showMessage("Request Failed", context);
                  }
                } else {
                  SnackBarHelper.showMessage("Fields Can't be empty", context);
                }
              },
            ),
          ],
        );
      },
    );
  }



  Future<void> _passwordDialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Password'),
          content: SizedBox(
            height: 160,
            child: Column(
              children: [
                TextField(
                  keyboardType: TextInputType.visiblePassword,
                  style: const TextStyle(color: Colors.black),
                  controller: _passwordController,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  keyboardType: TextInputType.visiblePassword,
                  style: const TextStyle(color: Colors.black),
                  controller: _rePasswordController,
                  decoration: InputDecoration(
                      labelText: 'Re-Enter Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Proceed'),
              onPressed: () async {
                if (_passwordController.text.trim().isNotEmpty &&
                    _rePasswordController.text.trim().isNotEmpty) {
                  if (_passwordController.text.trim() ==
                      _rePasswordController.text.trim()) {
                    // api call
                    bool response = await UserDetailsHelper.updatePassword(
                        _passwordController.text.trim());

                    if (response) {
                      SnackBarHelper.showMessage(
                          "Successfully Updated!", context);
                      // clear shared prefs and logout.

                      SharedPreferences prefs =
                          await SharedPrefsHelper.getPrefs();
                      prefs.clear();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Auth()),
                      );
                    } else {
                      SnackBarHelper.showMessage("Request Failed", context);
                    }
                  }
                } else {
                  SnackBarHelper.showMessage("Fields Can't be empty", context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white, // Change the color here
        ),
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                _userNameDialogBuilder(context);
              },
              child: Container(
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
                      Icons.account_circle,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "User Name",
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
            // InkWell(
            //   onTap: () {
            //     _emailDialogBuilder(context);
            //   },
            //   child: Container(
            //     padding: const EdgeInsets.all(8),
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(16),
            //         border: Border.all(
            //           width: 3,
            //           color: Colors.grey,
            //           style: BorderStyle.solid,
            //         )),
            //     height: 48,
            //     child: const Row(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       children: [
            //         Icon(
            //           Icons.email,
            //           color: Colors.grey,
            //         ),
            //         SizedBox(
            //           width: 8,
            //         ),
            //         Text(
            //           "Email Address",
            //           style: TextStyle(fontSize: 16, color: Colors.grey),
            //         ),
            //         Spacer(flex: 1),
            //         Icon(Icons.arrow_right_alt_rounded, color: Colors.grey)
            //       ],
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   height: 16,
            // ),
            InkWell(
              onTap: () {
                _passwordDialogBuilder(context);
              },
              child: Container(
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
                      Icons.password,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Password",
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
          ],
        ),
      ),
    );
  }
}
