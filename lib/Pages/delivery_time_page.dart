import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'address_page.dart';

class DeliveryPage extends StatefulWidget {
  @override
  _DeliveryPageState createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  String chosenCity;
  int selectedIn = 0;
  Widget _widget = Pickups();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black, size: 28),
        title: Text(
          "Select Date & Time",
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
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: _myType.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            selectedIn = index;
                            if (index == 0) {
                              setState(() {
                                _widget = Pickups();
                              });
                            } else {
                              setState(() {
                                _widget = Delivery();
                              });
                            }
                            print(index);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
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
                              width: 150,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Center(
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image:
                                              AssetImage(_myType[index].icon),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      _myType[index].type,
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
                ],
              ),
            ),
            _widget
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
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Text(
                      "PROCEED ",
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
            ),
          ),
          //color: Colors.indigo,
          onPressed: () {
            _pay(context);
            deli_pick_Map.putIfAbsent("Pickup Time", () => myTime[pickTimePos]);
            deli_pick_Map.putIfAbsent(
                "Pickup Date", () => dateList[pickDatePos]);
            deli_pick_Map.putIfAbsent(
                "Delivery Time", () => myTime[deliTimePos]);
            deli_pick_Map.putIfAbsent(
                "Delivery Date", () => date5List[deliTimePos]);
          },
        ),
      ),
    );
  }
}

class Pickups extends StatefulWidget {
  @override
  _PickupsState createState() => _PickupsState();
}

class _PickupsState extends State<Pickups> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<int> p1;
  Future<int> p2;

  Future<void> add1(int num) async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      p1 = prefs.setInt("p1", num).then((success) {
        return num;
      });
    });
  }

  Future<void> add2(int num) async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      p2 = prefs.setInt("p2", num).then((success) {
        return num;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    p1 = _prefs.then((SharedPreferences prefs) {
      return (prefs.getInt('p1') ?? 1);
    });
    p2 = _prefs.then((SharedPreferences prefs) {
      return (prefs.getInt('p2') ?? 1);
    });
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Select Pick Up Date",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.indigo),
          ),
        ),
        FutureBuilder<int>(
            future: p1,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              pickDatePos = snapshot.data;

              return Container(
                height: 100,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          pickDatePos = index;
                          add1(pickDatePos);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: pickDatePos == index
                                ? Colors.blue
                                : Colors.white10,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                dateList[index],
                                style: TextStyle(
                                    color: pickDatePos == index
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Select Pick Up Time",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.indigo),
          ),
        ),
        FutureBuilder<int>(
            future: p2,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              pickTimePos = snapshot.data;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  GridView.builder(
                    shrinkWrap: true,
                    itemCount: myTime.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            pickTimePos = index;
                            add2(pickTimePos);
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: pickTimePos == index
                                  ? Colors.blue
                                  : Colors.white12,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                myTime[index],
                                style: TextStyle(
                                    color: pickTimePos == index
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, childAspectRatio: 2),
                  )
                ],
              );
            })
      ],
    );
  }
}

class Delivery extends StatefulWidget {
  @override
  _DeliveryState createState() => _DeliveryState();
}

class _DeliveryState extends State<Delivery>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<int> p1;
  Future<int> p2;

  Future add1(int num) async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      p1 = prefs.setInt("d1", num).then((bool success) {
        return num;
      });
    });
  }

  Future add2(int num) async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      p2 = prefs.setInt("d2", num).then((bool success) {
        return num;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    p1 = _prefs.then((SharedPreferences prefs) {
      return (prefs.getInt('d1') ?? 1);
    });
    p2 = _prefs.then((SharedPreferences prefs) {
      return (prefs.getInt('d2') ?? 1);
    });
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Select Delivery Date",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.indigo),
          ),
        ),
        FutureBuilder<int>(
            future: p1,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              deliDatePos = snapshot.data;

              return Container(
                height: 100,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          deliDatePos = index;
                          add1(deliDatePos);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: deliDatePos == index
                                ? Colors.blue
                                : Colors.white10,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                date5List[index],
                                style: TextStyle(
                                    color: deliDatePos == index
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Select Delivery Time",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.indigo),
          ),
        ),
        FutureBuilder<int>(
            future: p2,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              deliTimePos = snapshot.data;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  GridView.builder(
                    shrinkWrap: true,
                    itemCount: myTime.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            deliTimePos = index;
                            add2(deliTimePos);
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: deliTimePos == index
                                  ? Colors.blue
                                  : Colors.white12,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                myTime[index],
                                style: TextStyle(
                                    color: deliTimePos == index
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, childAspectRatio: 2),
                  )
                ],
              );
            })
      ],
    );
  }
}

class Type {
  String type;
  String icon;

  Type({this.type, this.icon});
}

_pay(BuildContext context) {
  /** final snackBar_onFailure = SnackBar(content: Text('Transaction failed'));
      final snackBar_onClosed = SnackBar(content: Text('Transaction closed'));
      final _rave = RaveCardPayment(
      isDemo: true,
      encKey: "c53e399709de57d42e2e36ca",
      publicKey: "FLWPUBK-d97d92534644f21f8c50802f0ff44e02-X",
      transactionRef: "hvHPvKYaRuJLlJWSPWGGKUyaAfWeZKnm",
      amount: 100,
      email: "demo1@example.com",
      onSuccess: (response) {
      print("$response");
      print("Transaction Successful");
      if (true) {
      Scaffold.of(context).showSnackBar(
      SnackBar(
      content: Text("Transaction Sucessful!"),
      backgroundColor: Colors.green,
      duration: Duration(
      seconds: 5,
      ),
      ),
      );
      }
      },
      onFailure: (err) {
      print("$err");
      print("Transaction failed");
      Scaffold.of(context).showSnackBar(snackBar_onFailure);
      },
      onClosed: () {
      print("Transaction closed");
      Scaffold.of(context).showSnackBar(snackBar_onClosed);
      },
      context: context,
      );
      _rave.process(); **/
}

List<Type> _myType = [
  Type(type: "Pick Up", icon: "assets/images/go.png"),
  Type(type: "Delivery", icon: "assets/images/come.png"),
];

int pickTimePos = 0;
int pickDatePos = 0;
int deliTimePos = 0;
int deliDatePos = 0;

List<String> myTime = [
  "9:00 AM",
  "10:00 AM",
  "11:00 AM",
  "12:00 PM",
  "1:00 PM",
  "2:00 PM",
  "3:00 PM",
  "4:00 PM",
  "5:00 PM",
];

Map<String, String> deli_pick_Map = HashMap();
