import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:juno/Profile_Setup/add_photos.dart';
import 'package:juno/components/app_theme.dart';
import 'package:juno/pages/first_screen.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

String whatUoffer = '';

final String uid = FirebaseAuth.instance.currentUser!.uid;

void updateUserOfferring() {
  FirebaseFirestore.instance.collection('users').doc(uid).update({
    'what you help with': whatUoffer,
  });
}

final List _list = [
  [
    'Womb',
    'assets/images/child.png',
    false,
  ],
  [
    'Sperm',
    'assets/images/ftus.png',
    false,
  ],
  [
    'Eggs',
    'assets/images/fetus.png',
    false,
  ],
  [
    'woman',
    'assets/images/egg.png',
    false,
  ],
];

class _HelpScreenState extends State<HelpScreen> {
  onClicked(index) {
    setState(() {
      for (var i = 0; i < _list.length; i++) {
        _list[i][2] = false;
      }
      _list[index][2] = true;
      whatUoffer = _list[index][0];
    });
  }

  verifySelection() {
    updateUserOfferring();
    for (var item in _list) {
      if (item[2] == true) {
        whatUoffer = item[0];
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const AddPhotos(),
          ),
        );
      }
    }
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double currentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              SimPleCall(
                icon: Icons.arrow_back_ios,
                onTap: () {},
              ),
              const SizedBox(height: 30),
              const Text(
                'I have..',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Let everyone know what you're willing to help with. ",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 200,
                width: currentWidth,
                child: GridView.builder(
                  itemCount: _list.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2.7,
                    mainAxisSpacing: 30.5,
                    crossAxisSpacing: 13.5,
                  ),
                  itemBuilder: (context, index) {
                    return NeedContain(
                      text: _list[index][0],
                      image: _list[index][1],
                      isCheck: _list[index][2],
                      onTap: () {
                        onClicked(index);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 80),
              GestureDetector(
                onTap: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await Future.delayed(
                    const Duration(milliseconds: 1000),
                  );
                  setState(() {
                    isLoading = false;
                  });
                  verifySelection();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: currentWidth,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: basicColor,
                  ),
                  child: isLoading
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
            ],
          ),
        ),
      ),
    );
  }
}

class NeedContain extends StatelessWidget {
  final String text;
  final String image;
  final bool isCheck;
  final VoidCallback onTap;
  const NeedContain({
    Key? key,
    required this.text,
    required this.isCheck,
    required this.onTap,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 50,
        decoration: BoxDecoration(
          color: isCheck ? basicColor : null,
          border: Border.all(
            width: 2,
            color:
                isCheck ? basicColor : const Color.fromARGB(127, 158, 158, 158),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              color: isCheck ? Colors.white : Colors.black,
            ),
            const SizedBox(width: 4),
            Text(
              text,
              style: TextStyle(
                fontSize: 18,
                color: isCheck ? Colors.white : Colors.black,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}
