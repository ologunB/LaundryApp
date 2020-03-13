import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'exp_order_page.dart';
import 'laundry_page.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key key}) : super(key: key);

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "My Orders",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Container(
        child: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => ExpOrderPage(
                      // will get it from backend
                      valuesChosen: sampleList,
                      totalValue: 300,
                    ),
                  ),
                );
              },
              child: Padding(
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
            );
          },
        ),
      ),
    );
  }
}

List<CategoryType> sampleList = [
  CategoryType(
      typeTitle: "T-Shirts",
      typeImageUrl: "assets/images/c10.png",
      typePrice1: "150",
      typePrice: "150",
      typePrice2: "170",
      typePrice3: "200",
      typeDropDownValue: "Wash only",
      typeCounter: 0)
];
