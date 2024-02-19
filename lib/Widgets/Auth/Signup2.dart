import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';

import '../../helpers/auth_helpers.dart';
import '../../helpers/autocomplete_helper.dart';
import 'Signup.dart';

class SignUpPhase2 extends StatefulWidget {
  SignUpPhase2({super.key, required this.map});

  Map<String, String> map;

  @override
  State<StatefulWidget> createState() {
    return _SignUpPhase2State();
  }

  void isAuthenticated(bool bool) {}
}

class _SignUpPhase2State extends State<SignUpPhase2> {
  final _addressController = TextEditingController();
  final _apartmentController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();

  List<Map<String, String>> map = [];
  Map<String, String> temp = {};
  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  Future<List<String>> addressStringChanged() async {
    map = await AutoCompleteHelper.addressHelper(_addressController.text.trim());

    List<String> data = [];
    for (var d in map) {
      data.add(d["address"]!);
    }

    return data;
  }

  void populateData(String selected) {


    for (var d in map) {
      if (d["address"] == selected) {
        temp = d;
        break;
      }
    }

    _cityController.text = temp["city"]!;
    _zipCodeController.text = temp["zipCode"]!;
    _stateController.text = temp["state"]!;
  }

  void goBack() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Signup(
                map: widget.map,
                showSignup: (bool status) {},
              )),
    );
  }

  void finishSignUp() async{
    /// after performing apicall
    /// if authenticated =>  widget.isAuthenticated(true);
    /// else  => widget.isAuthenticated(false) and show a snack bar with appropriate message


    if(_addressController.text.isEmpty){
      /// show error
      ScaffoldMessenger.of(context).clearSnackBars();

      /// showing snack bar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Address field is required!."),
          duration: Duration(seconds: 5),
        ),
      );
      return;
    }

    widget.map.addAll(temp);

    bool status = await AuthHelper.signUpHelper(widget.map);


    // update shared prefs
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 64,
            ),
            const Text(
              "Address",
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 32,
                  fontWeight: FontWeight.w700),
            ),
            const Text(
              "We use your address to link up utility accounts",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
                // padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                child: EasyAutocomplete(
                    asyncSuggestions: (value) => addressStringChanged(),
                    debounceDuration: const Duration(seconds: 1),
                    progressIndicatorBuilder: const CircularProgressIndicator(
                      color: Colors.blueAccent,
                    ),
                    controller: _addressController,
                    cursorColor: Colors.blueAccent,
                    onSubmitted: (String val) {
                      populateData(val);
                    },
                    inputTextStyle: const TextStyle(color: Colors.white),
                    suggestionBackgroundColor: Colors.black,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.home),
                        labelText: 'Address Line 1',
                        hintText: 'enter your address',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16))),
                    suggestionBuilder: (data) {
                      return Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(4),
                            child: Text(
                              data,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Divider()
                        ],
                      );
                    })),
            const SizedBox(
              height: 20,
            ),
            TextField(
              keyboardType: TextInputType.name,
              controller: _apartmentController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.tag),
                  labelText: 'Apartment Number',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16))),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.name,
                    style: const TextStyle(color: Colors.white),
                    controller: _cityController,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.location_city),
                        labelText: 'City',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16))),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.name,
                    style: const TextStyle(color: Colors.white),
                    controller: _zipCodeController,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.push_pin),
                        labelText: 'Zip Code',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16))),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _stateController,
              keyboardType: TextInputType.name,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.map),
                  labelText: 'State',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16))),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    goBack();
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_back),
                      SizedBox(
                        width: 8,
                      ),
                      Text("Back")
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    finishSignUp();
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Complete Signup"),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(Icons.task_alt),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
