import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_call/constants.dart';
import 'package:video_call/providers/user_provider.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class VideoCallScreen extends StatelessWidget {
  static const String routeName = '/call-screen';
  final String callId;
  const VideoCallScreen({super.key, required this.callId});

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: myAppId,
      appSign: myAppSign,
      userID: Provider.of<UserProvider>(context).user.id.toString(),
      userName: Provider.of<UserProvider>(context).user.username.toString(),
      callID: callId,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }
}
