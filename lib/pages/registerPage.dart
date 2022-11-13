import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

import '../controllers/UserController.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final Uuid uuid = const Uuid();

  //controllers to get the actual input at a time
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();

  @override
  String dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    super.dispose();
    return "";
  }

  addUserDetails(String firstName, String lastName, String email) async {
    String userId = uuid.v4();
    usrCtrl.setValue("userId", userId);
    usrCtrl.setValue("username", firstName);
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'first name': firstName,
      'last name': lastName,
      'email': email,
    });
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> signUp() async {
    //create a user
    if (passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());

      //add user details
      addUserDetails(_firstNameController.text.trim(),
          _lastNameController.text.trim(), _emailController.text.trim()
          // int.parse(_ageController.text.trim())
          );
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
            child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  // Positioned(
                  //   left: 0,
                  //   top: -20,
                  //   child: Transform.rotate(
                  //       // origin: const Offset(-1000, -200),
                  //       angle: 20,
                  //       child: Container(
                  //         width: 200,
                  //         height: 200,
                  //         // backgroundColor: Colors.grey[200],
                  //         decoration: BoxDecoration(
                  //           color: Colors.amber[500],
                  //         ),
                  //       )),
                  // ),
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Center(
                        child: Text(
                          'YOTICKET',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      //email field
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Text("Register", style: GoogleFonts.roboto(fontSize: 24)),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),

                      //first name field
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.white)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: TextField(
                              controller: _firstNameController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter your First name'),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),

                      // last name field
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.white)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: TextField(
                              controller: _lastNameController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter your last name'),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),

                      //age field

                      //email field
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.white)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: TextField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none, hintText: 'Email'),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      //password fireld
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.white)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Password'),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      //password fireld
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.white)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: TextField(
                              controller: _confirmPasswordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: ' Confirm Password'),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      //signin button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: GestureDetector(
                          onTap: signUp,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.orange[500],
                                borderRadius: BorderRadius.circular(12)),
                            child: const Center(
                              child: Text(
                                ' Sign up ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      GestureDetector(
                        onTap: widget.showLoginPage,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Already a memeber  ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Login now',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        )),
      );
}
