import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_call/constants.dart';
import 'package:video_call/providers/user_provider.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class VideoCallScreen extends StatelessWidget {
  static const String routeName = '/call-screen';
  const VideoCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: -1, // your AppID,
      appSign: myAppSign,
      userID: '',
      userName: '',
      callID: '',
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }
}
