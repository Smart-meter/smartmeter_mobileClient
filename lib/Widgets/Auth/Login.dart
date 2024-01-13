import 'package:flutter/material.dart';
import 'package:smartmeter/Widgets/Auth/Signup.dart';

class Login extends StatefulWidget {
  Login({super.key, required this.isAuthenticated});

  void Function(bool authStatus) isAuthenticated;

  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  // make sure you dispose them
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _validateForm() {
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      setState(() {
        _emailController.clear();
        _passwordController.clear();
      });

      /// show error
      ScaffoldMessenger.of(context).clearSnackBars();

      /// showing snack bar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Email and password are required!"),
          duration: Duration(seconds: 5),
        ),
      );
      return;
    } else {
      _authenticate();
    }
  }

  void _authenticate() {
    /// if authentication is sucessful perform a setState and change
    /// _isAuthenticated to true, and also store the key and credentials in local memory
    ///
    //todo implement api calling functionality
    widget.isAuthenticated(true);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  bool isSignup = false;

  void showSignUp(bool flag) {

    setState(() {
      isSignup = flag;
    });
  }
  @override
  Widget build(BuildContext context) {


    Widget loginWidget = Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 64,
            ),
            const Text(
              "Sign In",
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 32,
                  fontWeight: FontWeight.w700),
            ),
            const Text(
              "Hey, there",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 32,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: Colors.white),
              controller: _emailController,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.mail),
                  labelText: 'Email',
                  hintText: 'enter your email',
                  helperText: 'Enter your email',
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(16))),
            ),
            const SizedBox(
              height: 32,
            ),
            TextField(
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.visiblePassword,
              controller: _passwordController,
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
              height: 32,
            ),
            ElevatedButton(
              onPressed: _validateForm,
              child: const Text("Log In"),
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
                const Text("Don't have an account? "),
                TextButton(
                    onPressed: ()=>showSignUp(true),
                    child: const Text("Sign Up"))
              ],
            )
          ],
        ),
      ),
    );

    Widget signUpWidget =
        SingleChildScrollView(child: Signup(showSignup: showSignUp, isAuthenticated: widget.isAuthenticated));
    return Padding(
        padding: const EdgeInsets.all(16),
        child: isSignup?signUpWidget:loginWidget);
  }
}
