import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:juno/components/app_theme.dart';
import 'package:juno/components/button.dart';
import 'package:juno/verification/otp_screen.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

TextEditingController _phoneNumberController = TextEditingController();

class _PhoneScreenState extends State<PhoneScreen> {
  @override
  Widget build(BuildContext context) {
    final currentHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: currentHeight / 10),
              const Text(
                'My Mobile',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Please enter your valid phone number, we will send you a 4-digit code to verify your account',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              InText(
                controller: _phoneNumberController,
              ),
              const SizedBox(height: 50),
              Button(
                text: 'Continue',
                onTap: () {
                  if (_phoneNumberController.text.isNotEmpty) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const OTPscreen(),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InText extends StatelessWidget {
  final TextEditingController controller;
  const InText({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      controller: controller,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
      ),
      //regexed validator to be used....................................
      decoration: InputDecoration(
        //country flag with drop down....................................
        prefixIcon: IconButton(
          onPressed: () {},
          icon: const FaIcon(
            FontAwesomeIcons.flagUsa,
          ),
          color: basicColor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            width: 1,
            color: Colors.grey,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            width: 1,
            color: Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            width: 1,
            color: basicColor,
          ),
        ),
      ),
    );
  }
}
