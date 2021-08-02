import 'dart:async';
import 'dart:convert';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pocket_health/screens/doctor_consult/call/utils.dart';
import 'package:pocket_health/widgets/verified_tag.dart';

class CallPage extends StatefulWidget {
  bool mutedAudio;
  bool mutedVideo;
  final String channelName;
  final ClientRole role;

  CallPage({Key key, this.channelName, this.role, this.mutedAudio, this.mutedVideo}) : super(key: key);

  @override
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  final _users = <int>[];
  final _infoStrings = <String>[];

  RtcEngine _engine;
  String baseUrl = ''; //Add the link to your deployed server here

  @override
  void dispose() {
    // clear users
    _users.clear();
    // destroy sdk
    _engine.destroy();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // initialize agora sdk
    initialize();
  }

  Future<void> initialize() async {
    //check for app_id
    if (APP_ID.isEmpty) {
      setState(() {
        _infoStrings.add(
          'APP_ID missing, please provide your APP_ID in settings.dart',
        );
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    }

    //init engine and channel
    _engine = await RtcEngine.create(APP_ID);
    await _engine.enableVideo();
    await _engine.setChannelProfile(ChannelProfile.Communication);

    // events
    _addAgoraEventHandlers();
    VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
    configuration.dimensions = VideoDimensions(1920, 1080);
    await _engine.setVideoEncoderConfiguration(configuration);
    final token = await getToken();
    await _engine.joinChannel(TEST_TOKEN, widget.channelName, null, 0);
    // await _engine.joinChannel(token, widget.channelName, null, 0);
  }

  // get token from token server
  Future<String> getToken() async {
    try {
      final response = await http.get(
        Uri.parse(
          baseUrl + '/rtc/' + widget.channelName + '/publisher/uid/' + 0.toString() + '?expiry=45',
        ),
      );
      return jsonDecode(response.body)['rtcToken'].toString();
    } catch (_) {
      print("failed to fetch token | $_");
      return null;
    }
  }

  // all agora events
  void _addAgoraEventHandlers() {
    _engine.setEventHandler(
      RtcEngineEventHandler(
        error: (code) {
          setState(() {
            final info = 'onError ❌ :: errorCode: $code';
            _infoStrings.add(info);
          });
        },
        connectionStateChanged: (connectionState, connectionReason) {
          setState(() {
            final info = "connectionStateChange ⚡ :: state:$connectionState reason:$connectionReason";
            _infoStrings.add(info);
          });
        },
        joinChannelSuccess: (channel, uid, elapsed) {
          setState(() {
            final info = 'onJoinChannelSuccess ✔ :: channel: $channel, uid: $uid, elapsed: $elapsed';
            _infoStrings.add(info);
          });
        },
        leaveChannel: (stats) {
          setState(() {
            _infoStrings.add('onLeaveChannel ✔ :: stats: ${stats.toJson()}');
            _users.clear();
          });
        },
        userJoined: (uid, elapsed) {
          setState(() {
            final info = 'userJoined ✔ :: $uid';
            _infoStrings.add(info);
            _users.add(uid);
          });
        },
        userOffline: (uid, elapsed) {
          setState(() {
            final info = 'userOffline ❌ :: $uid';
            _infoStrings.add(info);
            _users.remove(uid);
          });
        },
        firstRemoteVideoFrame: (uid, width, height, elapsed) {
          setState(() {
            final info = 'firstRemoteVideoFrame 📺 :: uid: $uid, dimensions: $width x $height';
            _infoStrings.add(info);
          });
        },
        tokenPrivilegeWillExpire: (token) async {
          final newToken = await getToken();
          await _engine.renewToken(newToken);
        },
      ),
    );
  }

  // Helper function to get list of native views
  List<Widget> _getRenderViews() {
    final List<StatefulWidget> list = [];
    if (widget.role == ClientRole.Broadcaster) {
      list.add(RtcLocalView.SurfaceView());
    }
    _users.forEach((int uid) => list.add(RtcRemoteView.SurfaceView(uid: uid)));
    return list;
  } // Toolbar layout

  Widget _actionsToolbar() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //end call
          RawMaterialButton(
            constraints: BoxConstraints(
              maxWidth: 64,
              minHeight: 64,
              minWidth: 64,
              maxHeight: 64,
            ),
            onPressed: () => _onCallEnd(context),
            child: Icon(
              Icons.call_end,
              color: Colors.white,
              size: 32.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Color(0xffEA493C),
            padding: EdgeInsets.zero,
          ),

          SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              //mute audio
              RawMaterialButton(
                constraints: BoxConstraints(
                  maxWidth: 48,
                  minHeight: 48,
                  minWidth: 48,
                  maxHeight: 48,
                ),
                onPressed: _onToggleMuteAudio,
                child: Icon(
                  widget.mutedAudio ? Icons.mic_off : Icons.mic,
                  color: Colors.white,
                  size: 24.0,
                ),
                shape: CircleBorder(),
                elevation: 2.0,
                fillColor: widget.mutedAudio ? Color(0xffEA493C) : Color(0xff434649),
                padding: EdgeInsets.zero,
              ),

              //mute video
              RawMaterialButton(
                constraints: BoxConstraints(
                  maxWidth: 48,
                  minHeight: 48,
                  minWidth: 48,
                  maxHeight: 48,
                ),
                onPressed: _onToggleMuteVideo,
                child: Icon(
                  widget.mutedVideo ? MdiIcons.videoOffOutline : MdiIcons.videoOutline,
                  color: Colors.white,
                  size: 24.0,
                ),
                shape: CircleBorder(),
                elevation: 2.0,
                fillColor: widget.mutedVideo ? Color(0xffEA493C) : Color(0xff434649),
                padding: EdgeInsets.zero,
              ),

              //switch camera
              RawMaterialButton(
                constraints: BoxConstraints(
                  maxWidth: 48,
                  minHeight: 48,
                  minWidth: 48,
                  maxHeight: 48,
                ),
                onPressed: _onSwitchCamera,
                child: Icon(
                  Icons.switch_camera,
                  color: Colors.white,
                  size: 24.0,
                ),
                shape: CircleBorder(),
                elevation: 2.0,
                fillColor: Color(0xff434649),
                padding: EdgeInsets.zero,
              ),

              //more
              RawMaterialButton(
                constraints: BoxConstraints(
                  maxWidth: 48,
                  minHeight: 48,
                  minWidth: 48,
                  maxHeight: 48,
                ),
                onPressed: _onSwitchCamera,
                child: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                  size: 24.0,
                ),
                shape: CircleBorder(),
                elevation: 2.0,
                fillColor: Color(0xff434649),
                padding: EdgeInsets.zero,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Info panel to show logs
  Widget _logs() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 48),
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        heightFactor: 0.5,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 48),
          child: ListView.builder(
            reverse: true,
            itemCount: _infoStrings.length,
            itemBuilder: (BuildContext context, int index) {
              if (_infoStrings.isEmpty) {
                return Text("null"); // return type can't be null, a widget was required
              }
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.yellowAccent,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          _infoStrings[index],
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  /// Video view wrapper
  Widget _videoView(view) {
    return Expanded(child: Container(child: view));
  }

  // Video view row wrapper
  Widget _expandedVideoRow(List<Widget> views) {
    final wrappedViews = views.map<Widget>(_videoView).toList();
    return Expanded(
      child: Row(
        children: wrappedViews,
      ),
    );
  }

  // Videos layout wrapper
  Widget _viewRows() {
    final views = _getRenderViews();
    switch (views.length) {
      case 1:
        return Container(
          child: Column(
            children: <Widget>[_videoView(views[0])],
          ),
        );
      case 2:
        return Container(
          child: Column(
            children: <Widget>[
              _expandedVideoRow([views[0]]),
              _expandedVideoRow([views[1]])
            ],
          ),
        );
      case 3:
        return Container(
          child: Column(
            children: <Widget>[
              _expandedVideoRow(views.sublist(0, 2)),
              _expandedVideoRow(
                views.sublist(2, 3),
              ),
            ],
          ),
        );
      case 4:
        return Container(
          child: Column(
            children: <Widget>[
              _expandedVideoRow(views.sublist(0, 2)),
              _expandedVideoRow(
                views.sublist(2, 4),
              ),
            ],
          ),
        );
      default:
    }
    return Container();
  }

  //audio call
  Widget _audioCallView() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage("assets/images/progile.jpeg"),
                ),

                SizedBox(width: 10),

                //name
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dr. Darren Eder',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),
                        VerifiedTag(),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Psychologist',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white60,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // connection state
          // Container(
          //   color: accentColorLight,
          //   width: 414,
          //   height: 24,
          //   alignment: Alignment.center,
          //   child: Text(
          //     'Connected',
          //     style: TextStyle(
          //       fontWeight: FontWeight.w600,
          //       fontSize: 14,
          //       color: accentColorDark,
          //     ),
          //   ),
          // ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 60.0),
              child: Center(
                child: CircleAvatar(
                  radius: 72,
                  backgroundImage: AssetImage("assets/images/progile.jpeg"),
                ),
              ),
            ),
          ),
        ],
      );

  //video call
  Widget _videoCallView() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage("assets/images/progile.jpeg"),
                ),

                SizedBox(width: 10),

                //name
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dr. Darren Eder',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),
                        VerifiedTag(),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Psychologist',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white60,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(width: 1.sw, height: 734, child: _viewRows()),
        ],
      );

  //calling state
  Widget _callingView(String status) => AnimatedContainer(
        duration: Duration(milliseconds: 1000),
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 80.h),
            CircleAvatar(
              radius: 40.w,
              backgroundImage: AssetImage("assets/images/progile.jpeg"),
            ),
            SizedBox(height: 20.h),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Dr. Darren Eder',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 10),
                    VerifiedTag(),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  'Psychologist',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white60,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Text(
              status,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                letterSpacing: 0.6,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      );

  //connected
  Widget _callConnectedView() => widget.mutedVideo ? _audioCallView() : _videoCallView();

  //btn actions
  _onCallEnd(BuildContext context) async {
    Navigator.pop(context);
    print(await _engine.getCallId());
    await _engine.leaveChannel();
  }

  _onToggleMuteAudio() async {
    setState(() {
      widget.mutedAudio = !widget.mutedAudio;
    });
    await _engine.muteLocalAudioStream(widget.mutedAudio);
  }

  _onToggleMuteVideo() async {
    setState(() {
      widget.mutedVideo = !widget.mutedVideo;
    });

    widget.mutedVideo ? await _engine.disableVideo() : await _engine.enableVideo();
  }

  _onSwitchCamera() async {
    await _engine.switchCamera();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff202124),
        body: Center(
          child: Stack(
            children: <Widget>[
              _users.isEmpty
                  ? _infoStrings.contains('userOffline')
                      ? _callingView("Disconnected")
                      : _callingView('Calling...')
                  : _callConnectedView(),
              _logs(),
              _actionsToolbar(),
            ],
          ),
        ),
      ),
    );
  }
}
