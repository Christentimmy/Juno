// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:juno/Profile_Setup/country_selected.dart';
import 'package:juno/components/input_field.dart';
import 'package:juno/utils/auth_methods.dart';
import 'package:juno/utils/utils.dart';
import '../components/app_theme.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

AuthMethods _sign = AuthMethods();

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _occupController = TextEditingController();
  Uint8List? _image;
  bool _isloading = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _passwordController = TextEditingController();
    _occupController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _occupController.dispose();
    _image;
    picked = DateTime.now();
    super.dispose();
  }

  bool isSelected = false;

  DateTime picked = DateTime.now();

  void _showDatePicker() {
    isSelected = true;
    showDatePicker(
      context: context,
      initialDate: picked,
      firstDate: DateTime(1950),
      lastDate: picked.add(
        const Duration(days: 4),
      ),
    ).then((value) {
      setState(() {
        picked = value!;
      });
    });
  }

  Future signUpUsers() async {
    setState(() {
      _isloading = true;
    });
    if (_formkey.currentState!.validate()) {
      if (_image == null) {
        return null;
      } else if (isSelected == false) {
        return null;
      } else {
        return _sign
            .createUser(
          doB: picked.toString(),
          email: _emailController.text,
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          password: _passwordController.text,
          file: _image!,
          occuPy: _occupController.text,
        )
            .then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Welcome on board'),
            ),
          );
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const CountrySelected(),
            ),
          );
        }).onError((error, stackTrace) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${error.toString()}'),
            ),
          );
          setState(() {
            _isloading = false;
          });
        });
      }
    }
    setState(() {
      _isloading = false;
    });
  }

  bool islock = false;

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    double currentHeight = MediaQuery.of(context).size.height;
    double currentWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 245, 243, 243),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: currentHeight * 0.06),
                  Image.asset(
                    'assets/images/juno.png',
                  ),
                  SizedBox(height: currentHeight * 0.014),
                  SizedBox(
                    width: 130,
                    height: 130,
                    child: Stack(
                      children: [
                        _image != null
                            ? CircleAvatar(
                                radius: 75,
                                backgroundImage: MemoryImage(_image!),
                              )
                            : const CircleAvatar(
                                radius: 75,
                                backgroundImage: AssetImage(
                                  'assets/images/default3.jpg',
                                ),
                              ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 22,
                              backgroundColor: basicColor,
                              child: IconButton(
                                onPressed: selectImage,
                                icon: const Icon(
                                  Icons.camera_alt_rounded,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: currentHeight * 0.037),
                  const Text(
                    'Sign Up To Continue',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: currentHeight*0.026),
                  Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        NameInput(
                          controller: _firstNameController,
                          text: 'Enter first name',
                          icon: Icons.person,
                        ),
                        SizedBox(height: currentHeight*0.026),
                        NameInput(
                          controller: _lastNameController,
                          text: 'Enter last name',
                          icon: Icons.person_pin,
                        ),
                        SizedBox(height: currentHeight*0.026),
                        EmailInput(
                          controller: _emailController,
                        ),
                       SizedBox(height: currentHeight*0.026),
                        newInputTest(
                          currentWidth,
                          _passwordController,
                        ),
                        SizedBox(height: currentHeight*0.026),
                        NameInput(
                          controller: _occupController,
                          text: 'Occupation',
                          icon: Icons.add_home_work_rounded,
                        ),
                        SizedBox(height: currentHeight*0.026),
                        GestureDetector(
                          onTap: _showDatePicker,
                          child: Container(
                            width: currentWidth,
                            height: currentHeight * 0.07,
                            padding: const EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: basicColor,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  size: 35,
                                  color: basicColor,
                                ),
                                const SizedBox(width: 20),
                                Text(
                                  isSelected
                                      ? DateFormat('yyyy-MM-dd').format(picked)
                                      : 'Choose birthday date',
                                  style: TextStyle(
                                    fontSize: currentWidth * 0.05,
                                    fontWeight: FontWeight.w600,
                                    color: basicColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: currentHeight*0.026),
                  GestureDetector(
                    onTap: () async {
                      await Future.delayed(
                        const Duration(milliseconds: 1200),
                      );
                      signUpUsers();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: currentWidth,
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: basicColor,
                      ),
                      child: _isloading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              'Continue',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: currentHeight / 15),
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
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      AlterButtonSignUp(icon: Icons.facebook_outlined),
                      AlterButtonSignUp(icon: Icons.apple),
                      AlterButtonSignUp(icon: Icons.cloud),
                    ],
                  ),
                  SizedBox(height: currentHeight * 0.02),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Terms of use & Privacy and Policy',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: basicColor,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 50),
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
          errorBorder: OutlineInputBorder(
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

class AlterButtonSignUp extends StatelessWidget {
  final IconData icon;
  const AlterButtonSignUp({
    Key? key,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
        onPressed: () {},
        icon: Icon(
          icon,
          color: basicColor,
          size: 40,
        ),
      ),
    );
  }
}
