import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app77/Pages/delivery_time_page.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'laundry_page.dart';

class AddressPage extends StatefulWidget {
  @override
  _AddressPageState createState() => _AddressPageState();
}

class AddressType {
  String type;
  String icon;

  AddressType({this.type, this.icon});
}

List<AddressType> addressType = [
  AddressType(type: "Home", icon: "assets/images/home.png"),
  AddressType(type: "Office", icon: "assets/images/building.png"),
  AddressType(type: "Others", icon: "assets/images/team.png")
];

class _AddressPageState extends State<AddressPage> {
  TextEditingController _zipController;
  TextEditingController _streetController;
  TextEditingController _numberController;
  String chosenCity;
  int selectedIn;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<int> _addIndex;
  Future<String> _phoNumber;
  Future<String> _streetName;
  Future<String> _citySelect;
  Future<String> _zipCode;

  Future<void> add1(int num) async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      _addIndex = prefs.setInt("_addIndex", num).then((bool success) {
        return num;
      });
    });
  }

  Future<void> add4(String num) async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      _citySelect = prefs.setString("_citySelect", num).then((bool success) {
        return num;
      });
    });
  }

  Future<void> add2(String num) async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      _phoNumber = prefs.setString("_phoNumber", num).then((bool success) {
        return num;
      });
    });
  }

  Future<void> add3(String num) async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      _streetName = prefs.setString("_streetName", num).then((bool success) {
        return num;
      });
    });
  }

  Future<void> add5(String num) async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      _zipCode = prefs.setString("_zipCode", num).then((bool success) {
        return num;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _addIndex = _prefs.then((prefs) {
      return (prefs.getInt('_addIndex') ?? 1);
    });
    _phoNumber = _prefs.then((SharedPreferences prefs) {
      return (prefs.getString('_phoNumber') ?? "");
    });
    _streetName = _prefs.then((SharedPreferences prefs) {
      return (prefs.getString('_streetName') ?? "");
    });
    _citySelect = _prefs.then((SharedPreferences prefs) {
      return (prefs.getString('_citySelect') ?? null);
    });
    _zipCode = _prefs.then((SharedPreferences prefs) {
      return (prefs.getString('_zipCode') ?? "");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black, size: 28),
        title: Text(
          "Select Address",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Select Pickup & Delivery Address",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.indigo),
              ),
            ),
            FutureBuilder<int>(
                future: _addIndex,
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                  selectedIn = snapshot.data;
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: addressType.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIn = index;
                                add1(selectedIn);
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                    color: selectedIn == index
                                        ? Colors.blue
                                        : Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color(0x44000000),
                                          offset: Offset(0.0, 0.0),
                                          blurRadius: 1.0,
                                          spreadRadius: 1.0),
                                    ]),
                                width: 130,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Center(
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                addressType[index].icon),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        addressType[index].type,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          color: selectedIn == index
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Enter Address Details",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.indigo),
              ),
            ),
            FutureBuilder<String>(
                future: _phoNumber,
                builder: (context, AsyncSnapshot<String> snapshot) {
                  _numberController =
                      TextEditingController(text: snapshot.data);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CupertinoTextField(
                      //decoration: InputDecoration(hintText: "Email"),
                      //controller: _inEmail,
                      placeholder: "Phone Number",
                      keyboardType: TextInputType.number,
                      padding: EdgeInsets.all(10),
                      controller: _numberController,
                      onChanged: (String e) {
                        setState(() {
                          add2(e);
                        });
                      },
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  );
                }),
            FutureBuilder<String>(
                future: _streetName,
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  _streetController =
                      TextEditingController(text: snapshot.data);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CupertinoTextField(
                      controller: _streetController,
                      placeholder: "Street number, Street address, Locality",
                      padding: EdgeInsets.all(10),
                      onChanged: (String e) {
                        setState(() {
                          add3(e);
                        });
                      },
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  );
                }),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    FutureBuilder<String>(
                        future: _citySelect,
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          chosenCity = snapshot.data;
                          return Expanded(
                            child: DropdownButton<String>(
                              items: <String>[
                                'Lagos',
                                'Abuja',
                                'Portharcourt',
                                'Akure',
                                'Kano',
                                'Rivers'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 0),
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                        fontSize: 22,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                              hint: Text("Select City..."),
                              elevation: 0,
                              value: chosenCity,
                              onChanged: (String newValue) {
                                setState(() {
                                  this.chosenCity = newValue;
                                  add4(chosenCity);
                                });
                              },
                            ),
                          );
                        }),
                    FutureBuilder<String>(
                        future: _zipCode,
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          _zipController =
                              TextEditingController(text: snapshot.data);
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Container(
                                child: CupertinoTextField(
                                  controller: _zipController,
                                  keyboardType: TextInputType.number,
                                  placeholder: "Zip Code",
                                  padding: EdgeInsets.only(bottom: 5, top: 10),
                                  onChanged: (b) {
                                    setState(() {
                                      add5(_zipController.text);
                                    });
                                  },
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ),
                            ),
                          );
                        })
                  ],
                ))
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: MaterialButton(
          focusColor: Colors.deepPurple,
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.deepPurple,
                  Colors.blueAccent,
                  // Colors.greenAccent
                ]),
                borderRadius: BorderRadius.circular(50),
                color: Colors.deepPurple),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "PAY",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "\₦$clothesPrice ",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "NEXT ",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: Colors.white),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          //color: Colors.indigo,
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => DeliveryPage()),
            );

            String fct(DateTime d) {
              return DateFormat("EEE, \nMMM dd", "en_US").format(d).toString();
            }

            DateTime theTime = DateTime.now();
            dateList.add(fct(theTime));
            for (int n = 0; n < 10; n++) {
              DateTime nextDay =
                  DateTime(theTime.year, theTime.month, theTime.day + 1);
              DateTime next5Day =
                  DateTime(theTime.year, theTime.month, theTime.day + 5);
              dateList.add(fct(nextDay));
              date5List.add(fct(next5Day));

              theTime = nextDay;
            }

            String p = addressType[selectedIn].type;
            String p1 = _numberController.text;
            String p2 = _streetController.text;
            String p3 = _zipController.text;

            add1(selectedIn);
            add2(p1);
            add3(p2);
            add4(chosenCity);
            add5(p3);
            addressMap.putIfAbsent("Address Type", () => p);
            addressMap.putIfAbsent("Street Name", () => p2);
            addressMap.putIfAbsent("Zip Code", () => p3);
            addressMap.putIfAbsent("City Name", () => chosenCity);
            addressMap.putIfAbsent("Phone Number", () => p1);
          },
        ),
      ),
    );
  }
}

List<String> dateList = [];
List<String> date5List = [];

Map<String, String> addressMap = HashMap();
