import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';

import '../../helpers/SnackBarHelper.dart';
import '../../helpers/auth_helpers.dart';
import '../../helpers/autocomplete_helper.dart';
import '../Navigation/Navigation.dart';
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
    _apartmentController.dispose();
    _zipCodeController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    super.dispose();
  }

  Future<List<String>> addressStringChanged() async {
    map =
        await AutoCompleteHelper.addressHelper(_addressController.text.trim());

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
    temp['country']="USA";
    temp['street'] = _addressController.text;

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

  void finishSignUp(BuildContext context) async{
    /// after performing apicall
    /// if authenticated =>  widget.isAuthenticated(true);
    /// else  => widget.isAuthenticated(false) and show a snack bar with appropriate message

    temp['aptSuite']=_apartmentController.text;
    if (_addressController.text.isEmpty) {
      SnackBarHelper.showMessage("Address field is required!.",context);

      return;
    }



    //make an api call to address service and fetch the details of UAN

    int val =  await AuthHelper.fetchUAN(temp);

    if(val==-1){
      // not available popup

      showPlatformDialog(
        context: context,
        builder: (context) => BasicDialogAlert(
          title: Text("Current Location doesn't have our service"),
          content:
          Text("Your current location cannot be serviced at this time."),
          actions: <Widget>[
            BasicDialogAction(
              title: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
      return;

    }else{
      temp['utilityAccountNumber'] = val.toString();
      // confirmation Popup
      showPlatformDialog(
        context: context,
        builder: (context) => BasicDialogAlert(
          title: Text("Do you want to proceed?"),
          content: Text("Current location is mapped to the Utility Account ${val}, as per our records."),
          actions: <Widget>[
            BasicDialogAction(
              title: Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            BasicDialogAction(
              title: Text("Confirm"),
              onPressed: () async{
                widget.map.addAll(temp);

                bool status = await AuthHelper.signUpHelper(widget.map);

                if (status){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Navigation()),
                  );
                }else{
                  SnackBarHelper.showMessage("SignUp Failed", context);
                }

              },
            ),
          ],
        ),
      );


    }


  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(8),
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
                      debounceDuration: const Duration(milliseconds: 100),
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
                      finishSignUp(context);
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
      ),
    );
  }
}
