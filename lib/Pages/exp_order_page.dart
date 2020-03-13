import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app77/Pages/rate_order.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'laundry_page.dart';

class ExpOrderPage extends StatefulWidget {
  List<CategoryType> valuesChosen;
  double totalValue;
  ExpOrderPage({
    Key key,
    @required this.valuesChosen,
    @required this.totalValue,
  }) : super(key: key);

  @override
  _ExpOrderPageState createState() => _ExpOrderPageState();
}

class _ExpOrderPageState extends State<ExpOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black, size: 28),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Active Order",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black12)],
                  borderRadius: BorderRadius.circular(15)),
              height: 80,
              child: Center(
                child: ListTile(
                  title: Text(
                    "Order No:" + " 323423223",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    "In Progress",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: Colors.red),
                  ),
                  leading: CircularPercentIndicator(
                    radius: 35.0,
                    animation: true,
                    circularStrokeCap: CircularStrokeCap.round,
                    lineWidth: 2.0,
                    percent: 0.25,
                    center: Icon(Icons.shopping_basket),
                    footer: Text("25%"),
                    progressColor: Colors.red,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Pickup Date and Time",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Wed, Dec 22 @ 10:00AM",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.indigo),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Pickup Address",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "21, Koforidua St, Wuse 2, Abuja",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.indigo),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Cloth List",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              child: ListView.builder(
                itemCount: widget.valuesChosen.length,
                shrinkWrap: true,
                itemBuilder: (context, position) {
                  return Card(
                    child: Container(
                      height: 110,
                      width: double.infinity,
                      child: Row(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      //TODO: Add
                                      image: AssetImage(widget
                                          .valuesChosen[position].typeImageUrl),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 9),
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        widget.valuesChosen[position].typeTitle,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        widget.valuesChosen[position]
                                            .typeDropDownValue,
                                        style: TextStyle(fontSize: 19),
                                      ),
                                      Text(
                                        "\₦" +
                                            widget.valuesChosen[position]
                                                .typePrice,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.deepPurple),
                                      )
                                      //CupertinoTextField()
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "x ",
                                      style: TextStyle(
                                          fontSize: 28, color: Colors.black38),
                                    ),
                                    Text(
                                      widget.valuesChosen[position].typeCounter
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 28, color: Colors.black38),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => RateOrder()),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Rate Order",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
