import 'package:flutter/material.dart';

import '../../../../helpers/user_details_helper.dart';

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
  final _userNameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _userNameController.dispose();
    super.dispose();
  }

  Future<void> _userNameDialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change User Name'),
          content: TextField(
            keyboardType: TextInputType.text,
            style: const TextStyle(color: Colors.black),
            controller: _userNameController,
            decoration: InputDecoration(
                labelText: 'User Name',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
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
                if (_userNameController.text.trim().isNotEmpty) {
                  // api call
                  await UserDetailsHelper.updateUserName(
                      _userNameController.text.trim());
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _emailDialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Email'),
          content: TextField(
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: Colors.black),
            controller: _emailController,
            decoration: InputDecoration(
                labelText: 'Email',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
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
                if (_emailController.text.trim().isNotEmpty) {
                  // api call
                  await UserDetailsHelper.updateEmail(
                      _emailController.text.trim());
                  Navigator.of(context).pop();
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
                SizedBox(height: 16,),
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
                    await UserDetailsHelper.updatePassword(
                        _passwordController.text.trim());
                    Navigator.of(context).pop();
                  }
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
            InkWell(
              onTap: () {
                _emailDialogBuilder(context);
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
                      Icons.email,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Email Address",
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
            InkWell(
              onTap: (){
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
