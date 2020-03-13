import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app77/Pages/address_page.dart';
import 'package:flutter_app77/Pages/laundry_page.dart';

class RecheckOrder extends StatefulWidget {
  List<CategoryType> valuesChosen;
  double totalValue;
  RecheckOrder({
    Key key,
    @required this.valuesChosen,
    @required this.totalValue,
  }) : super(key: key);

  @override
  _RecheckOrderState createState() => _RecheckOrderState();
}

class _RecheckOrderState extends State<RecheckOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black, size: 28),
        title: Text("Review Order",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        elevation: 0.0,
      ),
      body: Container(
        height: double.infinity,
        child: Padding(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          widget
                                              .valuesChosen[position].typePrice,
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
      ),
      bottomNavigationBar: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Sub-Total",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Text("\₦" + widget.totalValue.toStringAsFixed(2),
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo)),
              Text("Fee",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              Text("\₦" + (widget.totalValue * 0.1).toStringAsFixed(2),
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo)),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Total",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  Text("\₦" + (widget.totalValue * 1.1).toStringAsFixed(2),
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: MaterialButton(
                  focusColor: Colors.deepPurple,
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.deepPurple,
                            Colors.blueAccent,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.deepPurple),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: Text(
                              "PLACE TO ORDER ",
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
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => AddressPage(),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
