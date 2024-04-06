import 'package:flutter/material.dart';
import 'package:juno/Profile_Setup/gender_screen.dart';
import 'package:juno/components/app_theme.dart';

class CountrySelected extends StatefulWidget {
  const CountrySelected({super.key});

  @override
  State<CountrySelected> createState() => _CountrySelectedState();
}

class _CountrySelectedState extends State<CountrySelected> {
  @override
  Widget build(BuildContext context) {
    double currentHeight = MediaQuery.of(context).size.height;
    double currentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                  fillColor: const Color.fromARGB(255, 241, 240, 240),
                  filled: true,
                  hintText: 'Search.....',
                  hintStyle: const TextStyle(fontWeight: FontWeight.w500),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                      size: 25,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: currentWidth * 0.02),
            //country lists to be done.....................................
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Container(
                    width: double.infinity,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: basicColor,
                    ),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                  );
                },
              ),
            ),
            Container(
              width: double.infinity,
              height: currentHeight * 0.25,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 241, 240, 240),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const GenderScreen(),
                        ),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color: basicColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 23,
                        ),
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
