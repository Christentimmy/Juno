// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:juno/components/app_theme.dart';
import 'package:juno/pages/home_screen.dart';
import 'package:juno/pages/signup_Screen.dart';

import '../components/input_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();

final _formkey = GlobalKey<FormState>();

class _SignInScreenState extends State<SignInScreen> {
  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool loading = false;
  bool _value = false;
  bool islock = false;

  void logInUser() async {
    setState(() {
      loading = true;
    });
    await Future.delayed(
      const Duration(milliseconds: 500),
    );
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    )
        .then((value) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${error.toString()}'),
        ),
      );
    });
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xffEF753F),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              width: currentWidth,
              child: Column(
                children: [
                  SizedBox(height: currentHeight * 0.015),
                  Image.asset(
                    'assets/images/juno.png',
                    color: const Color(0xffF8CE9E),
                    width: currentWidth / 2,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Grow your family your way',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Color(0xffF8CE9E),
                    ),
                  ),
                  SizedBox(height: currentHeight * 0.03),
                  SizedBox(
                    height: 700,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 248, 248, 248),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: currentHeight * 0.03),
                          const Text(
                            'Welcome Back',
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 7),
                          const Text(
                            'Sign in to continue',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: currentHeight * 0.04),
                          Form(
                            key: _formkey,
                            child: Column(
                              children: [
                                const SizedBox(height: 20),
                                EmailInput(
                                  controller: _emailController,
                                ),
                                const SizedBox(height: 20),
                                newInputTest(
                                  currentWidth,
                                  _passwordController,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: currentHeight / 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: currentWidth * 0.2,
                                height: 1.5,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 15),
                              const Text(
                                'or sign up with',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 15),
                              Container(
                                width: currentWidth * 0.2,
                                height: 1.5,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          SizedBox(height: currentHeight * 0.01),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              AlterButtonSignUp(icon: Icons.facebook_outlined),
                              AlterButtonSignUp(icon: Icons.apple),
                              AlterButtonSignUp(icon: Icons.cloud),
                            ],
                          ),
                          SizedBox(height: currentHeight * 0.01),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Checkbox(
                                value: _value,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _value = value!;
                                  });
                                },
                              ),
                              const Text(
                                'Remember me',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 70),
                          GestureDetector(
                            onTap: logInUser,
                            child: Container(
                              alignment: Alignment.center,
                              width: currentWidth,
                              height: currentWidth * 0.15,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: basicColor,
                              ),
                              child: loading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text(
                                      'Continue',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 23,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox newInputTest(
    double currentWidth,
    TextEditingController controller,
  ) {
    return SizedBox(
      width: currentWidth,
      height: 60,
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'password is required';
          }
          if (value.length < 5) {
            return 'password is weak';
          }
          return null;
        },
        obscureText: !islock,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                islock = !islock;
              });
            },
            icon: islock
                ? Icon(
                    Icons.remove_red_eye,
                    color: basicColor,
                  )
                : FaIcon(
                    FontAwesomeIcons.eyeSlash,
                    color: basicColor,
                    size: 22,
                  ),
          ),
          prefixIcon: Icon(
            Icons.lock,
            color: basicColor,
            size: 26,
          ),
          hintText: 'Enter password',
          hintStyle: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              width: 2,
              color: basicColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              width: 2,
              color: basicColor,
            ),
          ),
        ),
      ),
    );
  }
}
