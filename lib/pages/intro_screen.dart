import 'package:flutter/material.dart';
import 'package:juno/components/button.dart';
import 'package:juno/pages/signin_screen.dart';
import 'package:juno/pages/signup_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../components/app_theme.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

List<String> list = [
  'assets/images/mah.jpg',
  'assets/images/woo.jpg',
  'assets/images/mah.jpg',
  'assets/images/lei.jpg',
];

int _activeIndex = 0;

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    double currentHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: currentHeight * 0.06),
            CarouselSlider.builder(
              itemCount: list.length,
              itemBuilder: (context, index, realIndex) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage(
                        list[index],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                height: currentHeight / 2.1,
                viewportFraction: 0.7,
                initialPage: 0,
                enableInfiniteScroll: true,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                onPageChanged: (index, reason) {
                  setState(() {
                    _activeIndex = index;
                  });
                },
              ),
            ),
            SizedBox(height: currentHeight / 80),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        'Swipe',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: basicColor,
                        ),
                      ),
                    ),
                    SizedBox(height: currentHeight / 100),
                    const Center(
                      child: Text(
                        'users go through a vetting process to ensure you match with genuine people',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: currentHeight / 60),
                    AnimatedSmoothIndicator(
                      effect: SwapEffect(
                        activeDotColor: basicColor,
                        dotHeight: 12.0,
                        dotWidth: 12.0,
                      ),
                      activeIndex: _activeIndex,
                      count: list.length,
                    ),
                    SizedBox(height: currentHeight / 30),
                    Button(
                      text: 'Create an account',
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: currentHeight * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account?',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const SignInScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: basicColor,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
