import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:juno/Profile_Setup/help_screen.dart';
import 'package:juno/components/app_theme.dart';
import 'package:juno/components/button.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

String gender = '';

final String uid = FirebaseAuth.instance.currentUser!.uid;

void upDateUserGender() {
  FirebaseFirestore.instance.collection('users').doc(uid).update({
    'gender': gender,
  });
}

final List _list = [
  [
    'Woman',
    false,
  ],
  [
    'Man',
    false,
  ],
];

class _GenderScreenState extends State<GenderScreen> {
  //stores the user gender...

  tapGender(index) {
    setState(() {
      for (int i = 0; i < _list.length; i++) {
        _list[i][1] = false;
      }
      _list[index][1] = true;
      gender = _list[index][0];
    });
  }

  @override
  Widget build(BuildContext context) {
    double currentWidth = MediaQuery.of(context).size.width;
    double currentHeight = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: currentHeight * 0.1),
              Container(
                padding: const EdgeInsets.only(left: 5),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 30,
                    color: basicColor,
                  ),
                ),
              ),
              SizedBox(height: currentHeight * 0.18),
              const Text(
                'I identify as a...',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: currentHeight * 0.001),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  itemCount: _list.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: currentHeight * 0.09,
                      ),
                      child: GenderSelector(
                        currentWidth: currentWidth,
                        text: _list[index][0],
                        isTap: _list[index][1],
                        onTap: () {
                          tapGender(index);
                        },
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: currentHeight * 0.2),
              Button(
                text: 'Continue',
                onTap: () {
                  upDateUserGender();
                  for (var item in _list) {
                    setState(
                      () {
                        if (item[1] == true) {
                          gender = item[0];
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const HelpScreen(),
                            ),
                          );
                        }
                      },
                    );
                  }
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class GenderSelector extends StatelessWidget {
  final String text;
  final bool isTap;
  final VoidCallback onTap;
  const GenderSelector({
    Key? key,
    required this.currentWidth,
    required this.text,
    required this.isTap,
    required this.onTap,
  }) : super(key: key);

  final double currentWidth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: currentWidth,
        decoration: BoxDecoration(
          color: isTap ? basicColor : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: Colors.grey,
            style: isTap ? BorderStyle.none : BorderStyle.solid,
          ),
        ),
        child: Row(
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: isTap ? Colors.white : Colors.black,
              ),
            ),
            const Spacer(),
            Icon(
              isTap ? FontAwesomeIcons.check : Icons.select_all,
              color: isTap ? Colors.white : Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
