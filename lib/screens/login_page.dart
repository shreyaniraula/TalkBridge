import 'package:flutter/material.dart';
import 'package:video_call/services/auth_service.dart';
import 'package:video_call/widgets/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _HomePageState();
}

class _HomePageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthService authService = AuthService();

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  void registerUser() {
    authService.registerUser(
      context: context,
      username: _usernameController.text,
      password: _passwordController.text,
    );
  }

  void loginUser() {
    authService.logInUser(
      context: context,
      username: _usernameController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(15.0),
                width: double.infinity,
                color: Colors.black87,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TalkBridge',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Column(
                children: [
                  CustomTextfield(
                      textField: 'Username', controller: _usernameController),
                  CustomTextfield(
                      textField: 'Password', controller: _passwordController),
                  ElevatedButton(
                    onPressed: loginUser,
                    style:
                        TextButton.styleFrom(backgroundColor: Colors.black87),
                    child: const Text(
                      'Login Now!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: registerUser,
                    style:
                        TextButton.styleFrom(backgroundColor: Colors.black87),
                    child: const Text(
                      'Create new account!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
