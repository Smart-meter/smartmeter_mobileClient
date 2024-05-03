// ignore_for_file: use_build_context_synchronously

import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartmeter/helpers/user_details_helper.dart';

import '../../../../helpers/SnackBarHelper.dart';
import '../../../../helpers/auth_helpers.dart';
import '../../../../helpers/autocomplete_helper.dart';
import '../../Navigation.dart';

class UtilityAccount extends StatefulWidget {
  UtilityAccount({super.key, required this.prefs});

  SharedPreferences prefs;

  @override
  State<StatefulWidget> createState() {
    return UtilityAccountState();
  }
}

class UtilityAccountState extends State<UtilityAccount> {
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
    temp['country'] = "USA";
    temp['street'] = _addressController.text;
  }

  void showErrorDialog() {

    String? status = widget.prefs.getString("status");

    if(status == "CONFIRMED"){
      showPlatformDialog(
        context: context,
        builder: (context) => BasicDialogAlert(
          title: const Text("Bill Payment required"),
          content: Text(
              "You have a pending bill payment, please pay that to proceed with address change."),
          actions: <Widget>[
            BasicDialogAction(
              title: Text("Okay"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Navigation()),
                );
              },
            )
          ],
        ),
      );
    }


  }

  void updateAddress() async {
    temp['aptSuite'] = _apartmentController.text;

    if (_addressController.text.isEmpty) {
      SnackBarHelper.showMessage("Address field is required!.", context);
      return;
    }

    //make an api call to address service and fetch the details of UAN

    int val = await AuthHelper.fetchUAN(temp);

    if (val == -1) {
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
    } else {
      temp['utilityAccountNumber'] = val.toString();
      // confirmation Popup
      showPlatformDialog(
        context: context,
        builder: (context) => BasicDialogAlert(
          title: Text("Do you want to proceed?"),
          content: Text(
              "Current location is mapped to the Utility Account ${val}, as per our records."),
          actions: <Widget>[
            BasicDialogAction(
              title: Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            BasicDialogAction(
              title: Text("Confirm"),
              onPressed: () async {
                bool status = await UserDetailsHelper.updateAddress(temp);

                if (status) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Navigation()),
                  );
                } else {
                  SnackBarHelper.showMessage("Address Update Failed", context);
                }
              },
            ),
          ],
        ),
      );
    }
  }

  Future<void> _runsAfterBuild() async {
    await Future.delayed(Duration.zero); // <-- Add a 0 dummy waiting time
   showErrorDialog();
  }

  @override
  Widget build(BuildContext context) {
    _runsAfterBuild();
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white, // Change the color here
        ),
        title: const Text(
          'Utility Account Information',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    updateAddress();
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Update Address"),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(Icons.update),
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
