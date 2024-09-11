import 'dart:math';
import 'package:flutter/material.dart';
import 'package:video_call/screens/video_call_screen.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/home';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController codeController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.black87,
        title: const Text(
          'TalkBridge',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Icon(
            Icons.person,
            color: Colors.white,
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Real-Time Language Translation For Calls',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Break language barriers and communicate effortlessly',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            //Create a New Call
            TextButton(
              onPressed: () {
                Random random = Random();
                int callId = random.nextInt(10000);
                Navigator.pushNamedAndRemoveUntil(
                    context,
                    VideoCallScreen.routeName,
                    arguments: callId.toString(),
                    (route) => false);
              },
              style: TextButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  side: const BorderSide(color: Colors.black87),
                  foregroundColor: Colors.black),
              child: const Text(
                'New Call',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                //Join an existing call
                SizedBox(
                  width: 200.0,
                  child: TextField(
                    controller: codeController,
                    decoration: const InputDecoration(
                      hintText: 'Enter meeting code.',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0x00E5E4E2)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                TextButton(
                  onPressed: () {
                    String callId = codeController.text;
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      VideoCallScreen.routeName,
                      arguments: callId,
                      (route) => false,
                    );
                  },
                  style: TextButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    foregroundColor: Colors.grey,
                  ),
                  child: const Text(
                    'Join',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
              padding: const EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Image.asset('assets/images/call_animation.jpg'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
