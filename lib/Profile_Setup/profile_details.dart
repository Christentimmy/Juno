import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:juno/Profile_Setup/country_selected.dart';
import 'package:juno/components/app_theme.dart';
import 'package:juno/components/button.dart';
import 'package:juno/pages/home_screen.dart';

class ProfileSetup extends StatefulWidget {
  const ProfileSetup({super.key});

  @override
  State<ProfileSetup> createState() => _ProfileSetupState();
}

bool isSelected = false;

class _ProfileSetupState extends State<ProfileSetup> {
  DateTime picked = DateTime.now();

  void _showDatePicker() {
    isSelected = true;
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
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

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10, top: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: basicColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: currentHeight * 0.02),
            const Text(
              'Profile Details',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: currentHeight * 0.05),
            Expanded(
              child: Container(
                width: currentWidth,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'assets/images/face.jpg',
                              width: 110,
                              height: 110,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: -2,
                            right: 0,
                            child: CircleAvatar(
                              radius: 22,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: basicColor,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.camera_alt_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: currentHeight * 0.02),
                    NamesInput(
                      currentWidth: currentWidth,
                      text: 'First Name',
                    ),
                    SizedBox(height: currentHeight * 0.02),
                    NamesInput(
                      currentWidth: currentWidth,
                      text: 'Last Name',
                    ),
                    SizedBox(height: currentHeight * 0.03),
                    GestureDetector(
                      onTap: _showDatePicker,
                      child: Container(
                        width: currentWidth,
                        height: currentHeight * 0.07,
                        decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.calendar_month,
                              size: 35,
                              color: basicColor,
                            ),
                            Text(
                              isSelected
                                  ? DateFormat('yyyy--MM--dd').format(picked)
                                  : 'Choose birthday date',
                              style: TextStyle(
                                fontSize: currentWidth * 0.05,
                                fontWeight: FontWeight.w700,
                                color: basicColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: currentHeight * 0.04),
                    Button(
                      text: 'Continue',
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const CountrySelected(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NamesInput extends StatelessWidget {
  final String text;
  const NamesInput({
    Key? key,
    required this.currentWidth,
    required this.text,
  }) : super(key: key);

  final double currentWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: currentWidth,
      height: 55,
      child: TextField(
        decoration: InputDecoration(
          labelText: text,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 2,
              color: Colors.grey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
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
