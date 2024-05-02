import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:smartmeter/Widgets/Auth/Signup2.dart';

import '../../helpers/autocomplete_helper.dart';

class Signup extends StatefulWidget {
  Signup(
      {super.key, required this.showSignup, required this.map});

  Map<String, String> map;

  void Function(bool status) showSignup;


  @override
  State<StatefulWidget> createState() {
    return _SignupState();
  }
}

class _SignupState extends State<Signup> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController ;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;

  @override
  void initState() {
    _emailController = TextEditingController(text: widget.map["email"]);
    _passwordController = TextEditingController(text: widget.map["password"]);
    _firstNameController = TextEditingController(text:widget.map["firstName"]);
    _lastNameController = TextEditingController(text:widget.map["lastName"]);
  }




  static List<String> items = [];

  int addressStringLength = 0;

  void validateForm() {
    if (_emailController.text
        .trim()
        .isEmpty ||
        _passwordController.text
            .trim()
            .isEmpty ||
        _firstNameController.text
            .trim()
            .isEmpty ||
        _lastNameController.text
            .trim()
            .isEmpty
    ) {
      /// show error
      ScaffoldMessenger.of(context).clearSnackBars();

      /// showing snack bar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("All fields are required!"),
          duration: Duration(seconds: 5),
        ),
      );
      return;
    } else {
      // Navigate to second phase

      Map<String, String> map = {};

      map["firstname"] = _firstNameController.text.trim();
      map["lastname"] = _lastNameController.text.trim();
      map["password"] = _passwordController.text.trim();
      map["email"] = _emailController.text.trim();

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignUpPhase2(map: map)),
      );
    }
  }


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Material(
      color: Colors.black,
      child: Container(
          margin: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 64,
              ),
              const Text(
                "Sign Up",
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 32,
                    fontWeight: FontWeight.w700),
              ),
              const Text(
                "Signup quickly to access the platform",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                keyboardType: TextInputType.name,
                style: const TextStyle(color: Colors.white),
                controller: _firstNameController,
          
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person),
                    labelText: 'First Name',
                    hintText: 'enter your name',
                    helperText: 'enter your First Name',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16))),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                keyboardType: TextInputType.name,
                style: const TextStyle(color: Colors.white),
                controller: _lastNameController,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person),
                    labelText: 'Last Name',
                    hintText: 'enter your name',
                    helperText: 'enter your Last Name',
                    border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(16))),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.mail),
                    labelText: 'Email',
                    hintText: 'enter your email',
                    helperText: 'Enter your email',
                    border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(16))),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                controller: _passwordController,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.password),
                    labelText: 'Password',
                    hintText: 'enter your email',
                    helperText: 'Enter your password',
                    border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(16))),
              ),
              const SizedBox(
                height: 16,
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: validateForm,
                child: const Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Continue"),
                    SizedBox(width: 8,),
                    Icon(Icons.arrow_forward)
                  ],),
              ),
              const SizedBox(
                height: 16,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Or",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  TextButton(
                      onPressed: () => widget.showSignup(false),
                      child: const Text("Sign In"))
                ],
              )
            ],
          ),
        ),
    );
  }
}
