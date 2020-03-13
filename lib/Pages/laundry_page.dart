import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app77/Pages/recheck_order.dart';
import 'package:toast/toast.dart';

class LaundryPage extends StatefulWidget {
  LaundryPage({Key key}) : super(key: key);

  @override
  _LaundryPageState createState() => _LaundryPageState();
}

class _LaundryPageState extends State<LaundryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              "Select Clothes",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            elevation: 0.0,
            centerTitle: true,
            bottom: TabBar(
                isScrollable: true,
                unselectedLabelColor: Colors.deepPurple,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.deepPurple,
                      Colors.blueAccent,
                    ]),
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.deepPurple),
                tabs: [
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Men",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Women",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Children",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Others",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  )
                ]),
          ),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            child: TabBarView(children: [
              MenClothes(),
              WomenClothes(),
              ChildrenClothes(),
              OtherClothes()
            ]),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
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
              onPressed: () {
                List<CategoryType> allClothes =
                    menList + womenList + childrenList + otherList;
                double totalPrice = 0;
                for (int n = 0; n < allClothes.length; n++) {
                  if (allClothes[n].typeCounter > 0) {
                    clothesSelected.add(allClothes[n]);
                    double res = double.parse(allClothes[n].typePrice) *
                        allClothes[n].typeCounter;
                    totalPrice = totalPrice + res;
                  }
                }

                if (clothesSelected.length == 0) {
                  Toast.show("No Clothes Selected", context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                } else {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => RecheckOrder(
                        valuesChosen: clothesSelected,
                        totalValue: totalPrice,
                      ),
                    ),
                  );
                }
                clothesPrice = (totalPrice * 1.1).toString();
              },
            ),
          ),
        ),
      ),
    );
  }
}

List<CategoryType> clothesSelected = [];
String clothesPrice;

// ignore: must_be_immutable
class CustomCategoryCard extends StatefulWidget {
  CustomCategoryCard({
    Key key,
    this.theList,
  }) : super(key: key);

  List<CategoryType> theList;

  @override
  _CustomCategoryCardState createState() => _CustomCategoryCardState();
}

class _CustomCategoryCardState extends State<CustomCategoryCard> {
  List<String> washType = ['Wash only', 'Wash and Iron', 'Wash and Bleach'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
          itemCount: widget.theList.length,
          itemBuilder: (context, position) {
            return Card(
              child: Container(
                height: 110,
                width: double.infinity,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                widget.theList[position].typeImageUrl),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 9),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              widget.theList[position].typeTitle,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),

                            DropdownButton<String>(
                              items: washType.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                );
                              }).toList(),
                              hint: Text("Select..."),
                              elevation: 0,
                              value: widget.theList[position].typeDropDownValue,
                              onChanged: (String newValue) {
                                widget.theList[position].typeDropDownValue =
                                    newValue;
                                setState(() {
                                  if (newValue == "Wash only") {
                                    widget.theList[position].typePrice =
                                        widget.theList[position].typePrice1;
                                  }
                                  if (newValue == "Wash and Iron") {
                                    widget.theList[position].typePrice =
                                        widget.theList[position].typePrice2;
                                  }
                                  if (newValue == "Wash and Bleach") {
                                    widget.theList[position].typePrice =
                                        widget.theList[position].typePrice3;
                                  }
                                });
                              },
                            ),

                            Text(
                              "\₦" + widget.theList[position].typePrice,
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
                      child: Align(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerRight,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "x ",
                                    style: TextStyle(
                                        fontSize: 28, color: Colors.black38),
                                  ),
                                  Text(
                                    widget.theList[position].typeCounter
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 28, color: Colors.black38),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.remove_circle,
                                      size: 35, color: Colors.black38),
                                  onPressed: () {
                                    setState(
                                      () {
                                        if (widget.theList[position]
                                                .typeCounter !=
                                            0) {
                                          widget
                                              .theList[position].typeCounter--;
                                        }
                                      },
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.add_circle,
                                      size: 35, color: Colors.deepPurple),
                                  onPressed: () {
                                    setState(
                                      () {
                                        widget.theList[position].typeCounter++;
                                      },
                                    );
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class MenClothes extends StatefulWidget {
  MenClothes({Key key}) : super(key: key);

  @override
  _MenClothesState createState() => _MenClothesState();
}

class _MenClothesState extends State<MenClothes>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          CustomCategoryCard(
            theList: menList,
          )
        ],
      ),
    );
  }
}

class WomenClothes extends StatefulWidget {
  @override
  _WomenClothesState createState() => _WomenClothesState();
}

class _WomenClothesState extends State<WomenClothes>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          CustomCategoryCard(
            theList: womenList,
          )
        ],
      ),
    );
  }
}

class ChildrenClothes extends StatefulWidget {
  @override
  _ChildrenClothesState createState() => _ChildrenClothesState();
}

class _ChildrenClothesState extends State<ChildrenClothes>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          CustomCategoryCard(
            theList: childrenList,
          )
        ],
      ),
    );
  }
}

class OtherClothes extends StatefulWidget {
  @override
  _OtherClothesState createState() => _OtherClothesState();
}

class _OtherClothesState extends State<OtherClothes>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          CustomCategoryCard(
            theList: otherList,
          )
        ],
      ),
    );
  }
}

class CategoryType {
  String typeTitle,
      typeImageUrl,
      typePrice,
      typePrice1,
      typePrice2,
      typePrice3,
      typeDropDownValue;
  int typeCounter;

  CategoryType(
      {this.typeTitle,
      this.typeImageUrl,
      this.typePrice,
      this.typePrice1,
      this.typePrice2,
      this.typePrice3,
      this.typeDropDownValue,
      this.typeCounter});
}

List<CategoryType> menList = [
  CategoryType(
      typeTitle: "T-Shirts",
      typeImageUrl: "assets/images/c10.png",
      typePrice1: "150",
      typePrice: "150",
      typePrice2: "170",
      typePrice3: "200",
      typeDropDownValue: "Wash only",
      typeCounter: 0),
  CategoryType(
      typeTitle: "Top",
      typeImageUrl: "assets/images/c10.png",
      typePrice1: "150",
      typePrice: "150",
      typePrice2: "170",
      typePrice3: "200",
      typeDropDownValue: "Wash only",
      typeCounter: 0),
  CategoryType(
      typeTitle: "Jersey",
      typeImageUrl: "assets/images/c10.png",
      typePrice1: "150",
      typePrice: "150",
      typePrice2: "170",
      typePrice3: "200",
      typeDropDownValue: "Wash only",
      typeCounter: 0),
  CategoryType(
      typeTitle: "Jeans",
      typeImageUrl: "assets/images/c10.png",
      typePrice1: "180",
      typePrice2: "200",
      typePrice: "150",
      typePrice3: "200",
      typeDropDownValue: "Wash only",
      typeCounter: 0),
  CategoryType(
      typeTitle: "Shorts",
      typeImageUrl: "assets/images/c10.png",
      typePrice1: "150",
      typePrice2: "170",
      typePrice: "150",
      typePrice3: "200",
      typeDropDownValue: "Wash only",
      typeCounter: 0),
  CategoryType(
      typeTitle: "Jacket",
      typeImageUrl: "assets/images/c10.png",
      typePrice1: "150",
      typePrice: "150",
      typePrice2: "170",
      typePrice3: "200",
      typeDropDownValue: "Wash only",
      typeCounter: 0),
  CategoryType(
      typeTitle: "Trousers",
      typeImageUrl: "assets/images/c10.png",
      typePrice1: "150",
      typePrice2: "170",
      typePrice: "150",
      typePrice3: "200",
      typeDropDownValue: "Wash only",
      typeCounter: 0)
];

List<CategoryType> womenList = [
  CategoryType(
      typeTitle: "Women Shirts",
      typeImageUrl: "assets/images/c10.png",
      typePrice1: "150",
      typePrice: "150",
      typePrice2: "170",
      typePrice3: "200",
      typeDropDownValue: "Wash only",
      typeCounter: 0),
  CategoryType(
      typeTitle: "Women Top",
      typeImageUrl: "assets/images/c10.png",
      typePrice1: "150",
      typePrice: "150",
      typePrice2: "170",
      typePrice3: "200",
      typeDropDownValue: "Wash only",
      typeCounter: 0),
  CategoryType(
      typeTitle: "Women Suit",
      typeImageUrl: "assets/images/c10.png",
      typePrice1: "750",
      typePrice: "750",
      typePrice2: "1000",
      typePrice3: "1500",
      typeDropDownValue: "Wash only",
      typeCounter: 0),
  CategoryType(
      typeTitle: "Women Jeans",
      typeImageUrl: "assets/images/c10.png",
      typePrice1: "300",
      typePrice2: "400",
      typePrice: "300",
      typePrice3: "500",
      typeDropDownValue: "Wash only",
      typeCounter: 0),
  CategoryType(
      typeTitle: "Women Shorts",
      typeImageUrl: "assets/images/c10.png",
      typePrice1: "150",
      typePrice2: "170",
      typePrice: "150",
      typePrice3: "200",
      typeDropDownValue: "Wash only",
      typeCounter: 0),
  CategoryType(
      typeTitle: "Women Jacket",
      typeImageUrl: "assets/images/c10.png",
      typePrice1: "150",
      typePrice: "150",
      typePrice2: "170",
      typePrice3: "200",
      typeDropDownValue: "Wash only",
      typeCounter: 0),
  CategoryType(
      typeTitle: "Women Trousers",
      typeImageUrl: "assets/images/c10.png",
      typePrice1: "150",
      typePrice2: "170",
      typePrice: "150",
      typePrice3: "200",
      typeDropDownValue: "Wash only",
      typeCounter: 0)
];

List<CategoryType> childrenList = [
  CategoryType(
      typeTitle: "Children Shirts",
      typeImageUrl: "assets/images/c10.png",
      typePrice1: "150",
      typePrice: "150",
      typePrice2: "170",
      typePrice3: "200",
      typeDropDownValue: "Wash only",
      typeCounter: 0),
  CategoryType(
      typeTitle: "Children Top",
      typeImageUrl: "assets/images/c10.png",
      typePrice1: "150",
      typePrice: "150",
      typePrice2: "170",
      typePrice3: "200",
      typeDropDownValue: "Wash only",
      typeCounter: 0),
  CategoryType(
      typeTitle: "Children Jersey",
      typeImageUrl: "assets/images/c10.png",
      typePrice1: "150",
      typePrice: "150",
      typePrice2: "170",
      typePrice3: "200",
      typeDropDownValue: "Wash only",
      typeCounter: 0),
  CategoryType(
      typeTitle: "Children Jeans",
      typeImageUrl: "assets/images/c10.png",
      typePrice1: "180",
      typePrice2: "200",
      typePrice: "150",
      typePrice3: "200",
      typeDropDownValue: "Wash only",
      typeCounter: 0),
  CategoryType(
      typeTitle: "Children Jacket",
      typeImageUrl: "assets/images/c10.png",
      typePrice1: "250",
      typePrice: "250",
      typePrice2: "300",
      typePrice3: "400",
      typeDropDownValue: "Wash only",
      typeCounter: 0),
  CategoryType(
      typeTitle: "Children Trousers",
      typeImageUrl: "assets/images/c10.png",
      typePrice1: "150",
      typePrice2: "170",
      typePrice: "150",
      typePrice3: "200",
      typeDropDownValue: "Wash only",
      typeCounter: 0)
];

List<CategoryType> otherList = [
  CategoryType(
      typeTitle: "Jersey",
      typeImageUrl: "assets/images/c10.png",
      typePrice1: "150",
      typePrice: "150",
      typePrice2: "170",
      typePrice3: "200",
      typeDropDownValue: "Wash only",
      typeCounter: 0),
  CategoryType(
      typeTitle: "Aso Oke",
      typeImageUrl: "assets/images/c10.png",
      typePrice1: "180",
      typePrice2: "200",
      typePrice: "150",
      typePrice3: "200",
      typeDropDownValue: "Wash only",
      typeCounter: 0),
  CategoryType(
      typeTitle: "Masq. Wears",
      typeImageUrl: "assets/images/c10.png",
      typePrice1: "150",
      typePrice2: "170",
      typePrice: "150",
      typePrice3: "200",
      typeDropDownValue: "Wash only",
      typeCounter: 0)
];
