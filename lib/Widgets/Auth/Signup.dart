import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  Signup({super.key, required this.showSignup, required this.isAuthenticated});

  void Function(bool status) showSignup;
  void Function(bool status) isAuthenticated;

  @override
  State<StatefulWidget> createState() {
    return _SignupState();
  }

}

class _SignupState extends State<Signup> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();

  void validateForm() {
    if (_emailController.text
        .trim()
        .isEmpty ||
        _passwordController.text
            .trim()
            .isEmpty ||
        _nameController.text
            .trim()
            .isEmpty ||
        _addressController.text
            .trim()
            .isEmpty) {

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
      apiCall();
    }
  }

    void apiCall() {
      /// after performing apicall
      /// if authenticated =>  widget.isAuthenticated(true);
      /// else  => widget.isAuthenticated(false) and show a snack bar with appropriate message

      widget.isAuthenticated(true);
    }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

    @override
    Widget build(BuildContext context) {
      return Column(
        mainAxisSize: MainAxisSize.max,
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
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 32,
          ), TextField(
            keyboardType: TextInputType.name,
            style: const TextStyle(color: Colors.white),
            controller: _nameController,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person),
                labelText: 'Name',
                hintText: 'enter your name',
                helperText: 'Choose a username',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16))),
          ), const SizedBox(
            height: 32,
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
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16))),
          ),
          const SizedBox(
            height: 32,
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
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16))),
          ),
          const SizedBox(
            height: 32,
          ),
          TextField(
            controller: _addressController,
            style: const TextStyle(color: Colors.white),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.home),
                labelText: 'Address',
                hintText: 'enter your address',
                helperText: 'Enter your Address',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16))),
          ),
          const SizedBox(
            height: 32,
          ),
          ElevatedButton(
            onPressed: validateForm,
            child: const Text("Sign Up"),
          ),
          const SizedBox(
            height: 32,
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
              TextButton(onPressed: () => widget.showSignup(false),
                  child: const Text("Sign In"))
            ],
          )
        ],
      );
    }
  }