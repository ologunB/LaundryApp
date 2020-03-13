import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app77/main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:worm_indicator/shape.dart';
import 'package:worm_indicator/worm_indicator.dart';

class LogOn extends StatefulWidget {
  @override
  _LogOnState createState() => _LogOnState();
}

TabController __tabController;

class _LogOnState extends State<LogOn> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    __tabController = new TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.indigo, size: 28),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: TabBar(
            controller: __tabController,
            unselectedLabelColor: Colors.black54,
            labelColor: Colors.indigo,
            labelStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            unselectedLabelStyle:
                TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
            indicatorColor: Colors.white,
            indicator: BoxDecoration(),
            tabs: [
              Tab(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Sign In",
                  ),
                ),
              ),
              Tab(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Sign Up",
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [SigninPage(), SignupPage()],
          controller: __tabController,
        ),
      ),
    );
  }
}

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SigninPageState extends State<SigninPage> {
  TextEditingController _inEmail = TextEditingController();
  TextEditingController _inPass = TextEditingController();
  TextEditingController _inForgotPass = TextEditingController();
  // String iNEmail = "";
  // String iNPass = "";
  // String iNForgotpass = "";

  GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  SharedPreferences sharedPreferences;
  bool isLoading = false;
  bool isLoggedIn = false;
  final databaseReference = Firestore.instance;

  // Sign In with Email and Password
  Future signIn(String email, String password) async {
    setState(() {
      isLoading = true;
    });
    AuthResult result = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .catchError((err) {
      Toast.show(err.toString(), context);
      return;
    });
    FirebaseUser user = result.user;

    if (user != null) {
      if (user.isEmailVerified) {
        QuerySnapshot querySnapshot = await Firestore.instance
            .collection("Users")
            .where("ID", isEqualTo: user.uid)
            .getDocuments();

        List<DocumentSnapshot> list = querySnapshot.documents;

        await sharedPreferences.setString("ID", list[0]["ID"]);
        await sharedPreferences.setString("Name", list[0]["Name"]);
        await sharedPreferences.setString("Picture", list[0]["Picture"]);
        Navigator.push(
            context, CupertinoPageRoute(builder: (context) => MyApp()));
        Toast.show("Signed In!", context);
      } else {
        Toast.show("User Not Verified, Check your Email", context);
        setState(() {
          isLoading = false;
        });
      }
    } else {
      Toast.show("User Doesn't Exist", context);
      setState(() {
        isLoading = false;
      });
    }
  }

  // Sign Up with Google
  Future _handleGoogleSignIn() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true;
    });

    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    AuthResult result = await _firebaseAuth.signInWithCredential(credential);
    FirebaseUser user = result.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    if (user != null) {
      QuerySnapshot querySnapshot = await Firestore.instance
          .collection("Users")
          .where("ID", isEqualTo: user.uid)
          .getDocuments();

      List<DocumentSnapshot> list = querySnapshot.documents;
      if (list.length == 0) {
        Firestore.instance.collection("User").document(user.uid).setData({
          "ID": user.uid,
          "Name": user.displayName,
          "Picture": user.photoUrl
        });

        await sharedPreferences.setString("ID", user.uid);
        await sharedPreferences.setString("Name", user.displayName);
        await sharedPreferences.setString("Picture", user.photoUrl);
      } else {
        await sharedPreferences.setString("ID", list[0]["ID"]);
        await sharedPreferences.setString("Name", list[0]["Name"]);
        await sharedPreferences.setString("Picture", list[0]["Picture"]);
      }

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    //isSignedIn();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CupertinoTextField(
                    controller: _inEmail,
                    placeholder: "Email",
                    keyboardType: TextInputType.emailAddress,
                    padding: EdgeInsets.all(10),
                    onChanged: (e) {
                      setState(() {
                        // iNEmail = e;
                      });
                    },
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CupertinoTextField(
                    controller: _inPass,
                    placeholder: "Password",
                    padding: EdgeInsets.all(10),
                    obscureText: true,
                    onChanged: (e) {
                      setState(() {
                        //  iNPass = e;
                      });
                    },
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (_) => CupertinoAlertDialog(
                        title: new Column(
                          children: <Widget>[
                            Text("Forgot Password"),
                          ],
                        ),
                        content: CupertinoTextField(
                          //decoration: InputDecoration(hintText: "Password"),
                          controller: _inForgotPass,
                          placeholder: "Email",
                          padding: EdgeInsets.all(10),
                          keyboardType: TextInputType.emailAddress,

                          onChanged: (e) {
                            setState(() {
                              //   e = iNForgotpass;
                            });
                          },
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        actions: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Colors.deepPurple,
                                    Colors.blueAccent,
                                    // Colors.greenAccent
                                  ]),
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.deepPurple),
                              child: FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  //color: Colors.indigo,
                                  child: Text(
                                    "Retrieve Password",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w700),
                                  )),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                        color: Colors.indigo,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(9.0),
                              child: Text(
                                "SIGN IN",
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
                      if (_inEmail.text.toString().length == 0) {
                        Toast.show("Email is Empty", context);
                        return;
                      } else if (_inPass.text.toString().length == 0) {
                        Toast.show("Password is Empty", context);
                        return;
                      } else {
                        signIn(
                            _inEmail.text.toString(), _inPass.text.toString());
                        WormIndicator(
                          length: 3,
                          // controller: _controller,
                          shape: Shape(
                              width: 16,
                              height: 24,
                              spacing: 8,
                              shape: DotShape.Rectangle),
                        );
                      }
                    },
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    _handleGoogleSignIn();
                    //emailSignIn();
                  },
                  child: Container(
                      alignment: Alignment.center,
                      child: Text("SignIn using google")),
                ),
                Visibility(
                  visible: false,
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.white.withOpacity(0.5),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController _upEmail = TextEditingController();
  TextEditingController _upPass = TextEditingController();
  TextEditingController _upName = TextEditingController();

  bool isLoading = false;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Sign Up with Email and Password
  Future signUp(String email, String password, String _name) async {
    setState(() {
      isLoading = true;
    });
    AuthResult result = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .catchError((err) {
      Toast.show(err.toString(), context, duration: 3);
    }).then((result) {
      return;
    });

    FirebaseUser user = result.user;

    if (user != null) {
      Firestore.instance.collection("User").document(user.uid).setData({
        "ID": user.uid,
        "Name": _name,
        "Email": user.email,
      }).then((a) {
        Toast.show("Check email for Confirmation!", context, duration: 3);
      });
      user.sendEmailVerification();
      _firebaseAuth.signOut();
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoTextField(
                  controller: _upName,
                  padding: EdgeInsets.all(10),
                  keyboardType: TextInputType.text,
                  placeholder: "Name",
                  onChanged: (e) {
                    setState(() {
                      //e = uPName;
                    });
                  },
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoTextField(
                  controller: _upEmail,
                  placeholder: "Email",
                  padding: EdgeInsets.all(10),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (e) {
                    setState(() {
                      //e = uPEmail;
                    });
                  },
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoTextField(
                  controller: _upPass,
                  placeholder: "Password",
                  obscureText: true,
                  padding: EdgeInsets.all(10),
                  onChanged: (e) {
                    setState(() {
                      //e = uPPass;
                    });
                  },
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Text("Already A Member?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w500)),
                    MaterialButton(
                      onPressed: () {
                        __tabController.animateTo(0);
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                            color: Colors.indigo,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: Text(
                              "SIGN UP",
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
                    if (_upEmail.text.toString().length == 0) {
                      Toast.show("Email is Empty", context);
                      return;
                    } else if (_upPass.text.toString().length == 0) {
                      Toast.show("Password is Empty", context);
                      return;
                    } else if (_upName.text.toString().length == 0) {
                      Toast.show("Name is Empty", context);
                      return;
                    } else {
                      signUp(_upEmail.text.toString(), _upPass.text.toString(),
                          _upName.text.toString());
                    }
                  },
                ),
              )
            ],
          ),
        ),
      )
    ]);
  }
}
