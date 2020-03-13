import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class SeeAllServices extends StatefulWidget {
  @override
  _SeeAllServicesState createState() => _SeeAllServicesState();
}

class _SeeAllServicesState extends State<SeeAllServices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black, size: 28),
          title: Text(
            "All Services",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          elevation: 0.0,
          centerTitle: true,
        ),
        body: Container(
          child: ListView.builder(
            itemCount: _list.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {},
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
                          _list[index].title,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w700),
                        ),
                        subtitle: Text(
                          _list[index].subtitle,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.black54),
                        ),
                        leading: MaterialButton(
                          color: Colors.blue,
                          onPressed: () {
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  _list[index].theCode,
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w400),
                                ),
                                action: SnackBarAction(
                                  label: "COPY",
                                  onPressed: () {
                                    Toast.show(
                                        "Code Copied to Clipboard", context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);

                                    //function to copy _list[index].theCode
                                  },
                                ),
                              ),
                            );
                          },
                          child: Text("Reveal Code",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}

class EachOff {
  String theCode, title, subtitle;
  EachOff({this.theCode, this.title, this.subtitle});
}

List<EachOff> _list = [
  EachOff(
      theCode: "HDJSS2",
      title: "25% of on Jeans",
      subtitle: "You get 25% off on all Jeans washed in the month of december"),
  EachOff(
      theCode: "HJSSS8",
      title: "25% of on Jeans",
      subtitle: "You get 25% off on all Jeans washed in the month of december"),
  EachOff(
      theCode: "NSJSD8",
      title: "25% of on Jeans",
      subtitle: "You get 25% off on all Jeans washed in the month of december"),
  EachOff(
      theCode: "JDSSP0",
      title: "25% of on Jeans",
      subtitle: "You get 25% off on all Jeans washed in the month of december"),
  EachOff(
      theCode: "DSMHB9",
      title: "25% of on Jeans",
      subtitle: "You get 25% off on all Jeans washed in the month of december"),
  EachOff(
      theCode: "ATRATR",
      title: "25% of on Jeans",
      subtitle: "You get 25% off on all Jeans washed in the month of december"),
];
