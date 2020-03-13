import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class RateOrder extends StatefulWidget {
  RateOrder({Key key}) : super(key: key);
  @override
  _RateOrderState createState() => _RateOrderState();
}

class _RateOrderState extends State<RateOrder> {
  double ratingNum = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black, size: 28),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Rate Order",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
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
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
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
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.check_circle,
                        color: Colors.blue,
                      ),
                      Flexible(
                        child: Text(
                          "Hey Jhon, your order has been successfully completed",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  )),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Rate your last order experience",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SmoothStarRating(
                    allowHalfRating: true,
                    onRatingChanged: (v) {
                      ratingNum = v;
                      setState(() {});
                    },
                    starCount: 5,
                    rating: ratingNum,
                    size: 40.0,
                    filledIconData: Icons.star,
                    halfFilledIconData: Icons.star_half,
                    color: Colors.blue,
                    borderColor: Colors.blue,
                    spacing: 0.0),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Share your experience in words",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  height: 150,
                  child: CupertinoTextField(
                    placeholder: "Type something here...",
                    padding: EdgeInsets.all(10),
                    maxLines: 10,
                    onChanged: (e) {
                      setState(() {});
                    },
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
              TextField(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                child: MaterialButton(
                    focusColor: Colors.deepPurple,
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colors.deepPurple,
                            Colors.blueAccent,
                          ]),
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.deepPurple),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(9.0),
                              child: Text(
                                "SUBMIT REVIEW",
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
                    onPressed: () {}),
              )
            ],
          ),
        ],
      ),
    );
  }
}
