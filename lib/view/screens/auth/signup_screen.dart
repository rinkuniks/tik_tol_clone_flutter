import 'package:flutter/material.dart';
import 'package:tik_tol_clone_flutter/view/widgets/glitch.dart';
import 'package:tik_tol_clone_flutter/view/widgets/text_input.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _setPasswordController = new TextEditingController();
  TextEditingController _confrimPasswordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GlithEffect(
                    child: const Text(
                      'SignUp Screen',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children:  [
                      const CircleAvatar(
                        backgroundImage: NetworkImage('https://www.seekpng.com/png/detail/402-4022635_avatar-generic-person-icon.png'),
                        radius: 60,
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: const Icon(Icons.edit, size: 30,
                                color: Colors.black,)))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextInputField(
                        controller: _emailController,
                        myIcon: Icons.email_outlined,
                        myLabelText: 'Email'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextInputField(
                      controller: _setPasswordController,
                      myIcon: Icons.lock_open_outlined,
                      myLabelText: 'Set Password',
                      toHide: true,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextInputField(
                      controller: _confrimPasswordController,
                      myIcon: Icons.lock_open_outlined,
                      myLabelText: 'Confirm Password',
                      toHide: true,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextInputField(
                        controller: _emailController,
                        myIcon: Icons.person,
                        myLabelText: 'Username'),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 10),
                          child: const Text('Sign Up')))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}