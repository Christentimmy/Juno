import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:juno/components/app_theme.dart';
import 'package:juno/pages/edit_fourth.dart';
import 'package:juno/pages/first_screen.dart';
import 'package:juno/pages/intro_screen.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

final List _list = [
  [
    Icons.person_pin_rounded,
    'Edit Profile',
    Icons.arrow_forward_ios_rounded,
  ],
  [
    Icons.notifications,
    'Notifications',
    Icons.arrow_forward_ios_rounded,
  ],
  [
    Icons.lock,
    'Security',
    Icons.arrow_forward_ios_rounded,
  ],
  [
    Icons.remove_red_eye,
    'Dark Mode',
    Icons.swap_horizontal_circle_sharp,
  ],
  [
    Icons.logout,
    'Logout',
    Icons.arrow_forward_ios_rounded,
  ],
];

class _ProfileEditState extends State<ProfileEdit> {
  @override
  void initState() {
    getUserName();
    getProfilePic();
    super.initState();
  }

  bool isLoading = true;

  void outButton() {
    FirebaseAuth.instance.signOut().then((value) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const IntroScreen(),
        ),
      );
    });
  }

  final String uid = FirebaseAuth.instance.currentUser!.uid;

  String firstName = '';
  String lastName = '';

  getUserName() async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    setState(() {
      lastName = (snapshot.data() as Map<String, dynamic>)['last name'];
      firstName = (snapshot.data() as Map<String, dynamic>)['first name'];
    });
  }

  String profilePic = '';

  Future<String> getProfilePic() async {
    await Future.delayed(const Duration(milliseconds: 500));
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    setState(() {
      profilePic = (snapshot.data() as Map<String, dynamic>)['photoUrl'];
      isLoading = false;
    });
    return profilePic;
  }

  @override
  Widget build(BuildContext context) {
    double currentHeight = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: currentHeight * 0.058),
              Row(
                children: [
                  const Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Expanded(child: Column()),
                  SimPleCall(
                    icon: Icons.mode_edit_outline_outlined,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const EditFourth(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 5),
                  SimPleCall(
                    icon: Icons.more_vert_rounded,
                    onTap: () {},
                  ),
                ],
              ),
              SizedBox(height: currentHeight * 0.058),
              FutureBuilder(
                future: getProfilePic(),
                builder: (context, snapshot) {
                  return Center(
                    child: isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: basicColor,
                            ),
                          )
                        : CircleAvatar(
                            radius: 70,
                            backgroundImage: NetworkImage(profilePic),
                          ),
                  );
                },
              ),
              FutureBuilder(
                future: getUserName(),
                builder: (context, snapshot) {
                  return Center(
                    child: Text(
                      '$firstName $lastName',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
              Container(
                width: double.infinity,
                height: 2,
                color: const Color.fromARGB(36, 158, 158, 158),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _list.length,
                  itemBuilder: (context, index) {
                    return NoStressProfileDetails(
                      text: _list[index][1],
                      icon: _list[index][0],
                      icon1: _list[index][2],
                      onTap: () {
                        outButton();
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NoStressProfileDetails extends StatelessWidget {
  final String text;
  final IconData icon;
  final IconData icon1;
  final VoidCallback onTap;
  const NoStressProfileDetails({
    Key? key,
    required this.text,
    required this.icon,
    required this.icon1,
    required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 17),
          child: Row(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: basicColor.withOpacity(0.2),
                child: Icon(
                  icon,
                  color: basicColor,
                  size: 35,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Expanded(child: Column()),
              IconButton(
                onPressed: onTap,
                icon: Icon(
                  icon1,
                  color: basicColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          height: 2,
          color: const Color.fromARGB(36, 158, 158, 158),
        )
      ],
    );
  }
}
