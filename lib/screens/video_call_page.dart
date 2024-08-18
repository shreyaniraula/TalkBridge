import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:video_call/constants.dart';

class VideoCallPage extends StatelessWidget {
  static const String routeName = '/video-call';
  VideoCallPage({super.key});

  final AgoraClient _client = AgoraClient(
    agoraConnectionData: AgoraConnectionData(
      appId: myAppId,
      channelName: myChannelName,
      tempToken: myToken,
    ),
    enabledPermission: [
      Permission.camera,
      Permission.microphone,
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            AgoraVideoViewer(
              client: _client,
            ),
            AgoraVideoButtons(client: _client),
          ],
        ),
      ),
    );
  }
}
