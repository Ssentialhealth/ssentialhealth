import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:platform_alert_dialog/platform_alert_dialog.dart';
import 'package:pocket_health/bloc/manage_bookings/manage_bookings_cubit.dart';
import 'package:pocket_health/screens/Appointments/manage_appointments.dart';
import 'package:pocket_health/screens/menu_screens/contact_us.dart';
import 'package:pocket_health/screens/menu_screens/feedback_screen.dart';
import 'package:pocket_health/screens/profile/practitioner_info_screen.dart';
import 'package:pocket_health/screens/profile/user_info_screen.dart';
import 'package:pocket_health/widgets/menu_items.dart';
import 'package:pocket_health/widgets/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _type = "...";
  String nullCall = "Hello";

  @override
  void initState() {
    super.initState();
    getName();
  }

  void getName() async {
    _name = await getStringValuesSF();
    setState(() {
      _fullName = _name;
    });
    print(_fullName);
  }

  String _fullName;
  String _name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFFEAFCF6),
      appBar: AppBar(
        title: Text("Account"),
        backgroundColor: Color(0xFF00FFFF),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Container(
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    Container(
                      color: Color(0xFF00FFFF),
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => UserInfoScreen()));
                        },
                        child: Column(
                          children: [
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Container(
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(40),
                                        child: Image.asset(
                                          "assets/images/profile.png",
                                          height: 70,
                                        )),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  child: Column(
                                    children: [
                                      Text("$_fullName", style: mediumTextStyle()),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      LinearPercentIndicator(
                                        width: 200.0,
                                        lineHeight: 10.0,
                                        percent: 0.3,
                                        backgroundColor: Colors.white,
                                        progressColor: Color(0xff163C4D),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(
                                  flex: 2,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    _type = await getTypeValuesSF();

                                    print(_type);
                                    if (_type == 'individual') {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => UserInfoScreen()));
                                      showDialog<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return PlatformAlertDialog(
                                            title: Text('Please Note'),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: <Widget>[
                                                  Text(
                                                      'That your general and health information are confidentially managed and are used to enhance the function of features of the app including emergency use. It is important to input the right information as your health may depend on it.'),
                                                  Text(
                                                      'The app uses other identifiers other than name to keep your information private when you share it with health providers. A PIN will be requested with every health information sharing request. To see other privacy measures.'),
                                                  Text(
                                                    'Click here..',
                                                    style: TextStyle(color: Colors.lightBlueAccent),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              PlatformDialogAction(
                                                child: Text('Proceed'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              PlatformDialogAction(
                                                child: Text('Cancel'),
                                                actionType: ActionType.Destructive,
                                                onPressed: () {
                                                  // Navigator.pushReplacement(context, MaterialPageRoute(
                                                  //     builder: (context) => ProfileScreen()
                                                  // ));
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    } else if (_type == 'health practitioner') {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => PractitionerInfo()));
                                    } else {
                                      _showSnackBar("Login To Access This Feature");
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.arrow_forward_ios_outlined),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 60,
                  color: Color(0xFFEAFCF6),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 25),
                              child: Text(
                                "Chat and Calls",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.arrow_forward_ios),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Divider(
                          height: 1,
                          color: Color(0xFFC6C6C6),
                        ),
                        MenuItems(
                          image: "assets/images/icons/Saved.png",
                          text: "Balance,Payments & Subscriptions",
                          press: () {},
                        ),
                        Divider(
                          color: Color(0xFFC6C6C6),
                          indent: 10,
                          endIndent: 10,
                        ),
                        MenuItems(
                          image: "assets/images/icons/Saved.png",
                          text: "Appointments",
                          press: () async {
                            final userCategory = await getTypeValuesSF();
                            if (userCategory != "individual") {
                              context.read<ManageBookingsCubit>()..loadBookingsById(4);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ManageAppointments(),
                                ),
                              );
                            }
                          },
                        ),
                        Divider(
                          color: Color(0xFFC6C6C6),
                          indent: 10,
                          endIndent: 10,
                        ),
                        MenuItems(
                          image: "assets/images/icons/Saved.png",
                          text: "Saved",
                          press: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => WebSocketDemo(title: 'test'),
                              ),
                            );
                          },
                        ),
                        Divider(
                          color: Color(0xFFC6C6C6),
                          indent: 10,
                          endIndent: 10,
                        ),
                        MenuItems(
                          image: "assets/images/icons/document.png",
                          text: "Documents",
                          press: () {},
                        ),
                        Divider(
                          color: Color(0xFFC6C6C6),
                          indent: 10,
                          endIndent: 10,
                        ),
                        MenuItems(
                          image: "assets/images/icons/insurance agency.png",
                          text: "Health Insurer Details",
                          press: () {},
                        ),
                        Divider(
                          color: Color(0xFFC6C6C6),
                          indent: 10,
                          endIndent: 10,
                        ),
                        MenuItems(
                          image: "assets/images/icons/shared medical.png",
                          text: "Shared Medical Info",
                          press: () {},
                        ),
                        Divider(height: 1, color: Color(0xFFC6C6C6)),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 9,
                ),
                Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Divider(
                        height: 1,
                        color: Color(0xFFC6C6C6),
                      ),
                      MenuItems(
                        image: "assets/images/icons/help.png",
                        text: "Help",
                        press: () {},
                      ),
                      Divider(
                        color: Color(0xFFC6C6C6),
                        indent: 10,
                        endIndent: 10,
                      ),
                      MenuItems(
                        image: "assets/images/icons/feedback.png",
                        text: "Feedback",
                        press: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackPage()));
                        },
                      ),
                      Divider(
                        color: Color(0xFFC6C6C6),
                        indent: 10,
                        endIndent: 10,
                      ),
                      MenuItems(
                        image: "assets/images/icons/contact us.png",
                        text: "Contact Us",
                        press: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUs()));
                        },
                      ),
                      Divider(height: 1, color: Color(0xFFC6C6C6)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 9,
                ),
                Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Divider(
                        height: 1,
                        color: Color(0xFFC6C6C6),
                      ),
                      MenuItems(
                        image: "assets/images/icons/terms and conditions.png",
                        text: "Terms & Conditions",
                        press: () {},
                      ),
                      Divider(
                        color: Color(0xFFC6C6C6),
                        indent: 10,
                        endIndent: 10,
                      ),
                      MenuItems(
                        image: "assets/images/icons/terms and conditions.png",
                        text: "Privacy Policy",
                        press: () {},
                      ),
                      Divider(height: 1, color: Color(0xFFC6C6C6)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSnackBar(message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}

getStringValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  String stringValue = prefs.getString('fullName');
  return stringValue;
}

getTypeValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  String stringValue = prefs.getString('userType');
  return stringValue;
}

class WebSocketDemo extends StatefulWidget {
  const WebSocketDemo({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  _WebSocketDemoState createState() => _WebSocketDemoState();
}

class _WebSocketDemoState extends State<WebSocketDemo> {
  final TextEditingController _controller = TextEditingController();

  final _channel = WebSocketChannel.connect(
    Uri.parse('wss://echo.websocket.events'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: const InputDecoration(labelText: 'Send a message'),
              ),
            ),
            const SizedBox(height: 24),
            StreamBuilder(
              stream: _channel.stream,
              builder: (context, snapshot) {
                return Text(snapshot.hasData ? '${snapshot.data}' : '');
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: const Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      _channel.sink.add(_controller.text);
    }
  }

  @override
  void dispose() {
    _channel.sink.close();
    _controller.dispose();
    super.dispose();
  }
}
