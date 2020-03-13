import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app77/E_Libs/carousel_slider.dart';
import 'package:flutter_app77/Pages/see_all_services.dart';
import 'package:flutter_app77/main.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIn = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 24.0),
            child: Text(
              "Explore",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Flat 50% off on First Order",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.black38),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CarouselSlider(
              height: MediaQuery.of(context).size.height / 4,
              autoPlay: true,
              enableInfiniteScroll: true,
              enlargeCenterPage: true,
              pauseAutoPlayOnTouch: Duration(seconds: 10),
              items: [
                "assets/images/c1.jpg",
                "assets/images/c2.jpg",
                "assets/images/c3.jpg",
                "assets/images/c4.png",
                "assets/images/c5.jpg"
              ].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                            color: Colors.black38,
                            backgroundBlendMode: BlendMode.dstOut,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            image: DecorationImage(
                              image: AssetImage(""),
                              fit: BoxFit.fill,
                            )),
                        child: Stack(
                          children: <Widget>[
                            Align(
                              child: Image(
                                image: AssetImage(i),
                                fit: BoxFit.fill,
                                color: Colors.black38,
                                colorBlendMode: BlendMode.dstOut,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    " TOP OFFER ",
                                    style: TextStyle(
                                        backgroundColor: Colors.blueAccent,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white),
                                  ),
                                ),
                                subtitle: Text("20% off on Dry Clean",
                                    style: TextStyle(
                                        backgroundColor: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.blueAccent)),
                              ),
                            )
                          ],
                        ));
                  },
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Services",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => SeeAllServices(),
                      ),
                    );
                  },
                  child: Text(
                    "See All",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              height: 120,
              child: ListView.builder(
                itemCount: _list.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, position) {
                  return Center(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIn = position;
                        });
                      },
                      child: Card(
                        child: Center(
                          child: Container(
                            height: 120,
                            decoration: BoxDecoration(
                              color: selectedIn == position
                                  ? Colors.blue
                                  : Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            width: 220,
                            child: Center(
                              child: ListTile(
                                isThreeLine: true,
                                title: Text(
                                  _list[position].name,
                                  style: TextStyle(
                                      fontSize: 22.0,
                                      color: selectedIn == position
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.w700),
                                ),
                                subtitle: Text(
                                  _list[position].subtitle,
                                  style: TextStyle(
                                      color: selectedIn == position
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                leading: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                _list[position].imageUrl)))),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8, right: 8, top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Active Orders",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                ),
                MaterialButton(
                  onPressed: () {
                    pageSelectedIndex = 2;
                    setState(() {
                      pageSelectedIndex = 2;
                    });
                  },
                  child: Text(
                    "See previous",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: MediaQuery.removePadding(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [BoxShadow(color: Colors.black12)],
                            borderRadius: BorderRadius.circular(15)),
                        height: 70,
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
              removeTop: true,
              context: context,
            ),
          )
        ],
      ),
    );
  }
}

class Services {
  String imageUrl, name, subtitle;
  Services({this.name, this.subtitle, this.imageUrl});
}

List<Services> _list = [
  new Services(
      name: "Wash and Iron",
      subtitle: "Min 48 hours",
      imageUrl: "assets/images/c6.png"),
  new Services(
      name: "Dry Clean",
      subtitle: "Min 24 hours",
      imageUrl: "assets/images/c7.png"),
  new Services(
      name: "Home services",
      subtitle: "Min 8 hours",
      imageUrl: "assets/images/c9.png"),
  new Services(
      name: "Delivery services",
      subtitle: "Min 8 hours",
      imageUrl: "assets/images/c8.png"),
];

class ClippingClass extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);
    var controlPoint = Offset(size.width - (size.width / 2), size.height - 120);
    var endPoint = Offset(size.width, size.height);
    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}

/** Cupertino dialog

      onTap: () {
      showDialog(
      barrierDismissible: false,
      context: context,
      child: new CupertinoAlertDialog(
      title: new Column(
      children: <Widget>[
      Text("GridView"),
      Icon(
      Icons.favorite,
      color: Colors.green,
      ),
      ],
      ),
      content: Text("Selected Item $index"),
      actions: <Widget>[
      FlatButton(
      onPressed: () {
      Navigator.of(context).pop();
      },
      child: Text("OK"))
      ],
      ),
      );
      },

    //
    //
    //

    body: Stack(
    overflow: Overflow.visible,
    fit: StackFit.loose,
    children: <Widget>[
    ClipPath(
    clipper: ClippingClass(),
    child: Container(
    width: double.infinity,
    height: MediaQuery.of(context).size.height * 2 / 7,
    decoration: BoxDecoration(
    gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
    Colors.indigo,
    Colors.indigo,
    Colors.deepPurple
    ])),
    ),
    ),
    Padding(
    padding: EdgeInsets.all(8.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
    Text("Dear, Customer",
    textAlign: TextAlign.left,
    style: TextStyle(
    fontSize: 28,
    color: Colors.white,
    )),
    Text(
    "Get your laundry cleaned, ironed, folded and delivered at your door step",
    style: TextStyle(
    fontSize: 18,
    color: Colors.white,
    )),
    Padding(
    padding: EdgeInsets.all(20.0),
    child: GridView.builder(
    itemCount: 4,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2),
    itemBuilder: (BuildContext context, int index) {
    return GestureDetector(
    child: Padding(
    padding: EdgeInsets.all(10.0),
    child: Card(
    elevation: 5.0,
    child: Container(
    alignment: Alignment.center,
    child: Text('Item $index'),
    ),
    ),
    ),
    );
    }),
    ),
    ],
    ),
    ),
    ],
    ),

 **/
