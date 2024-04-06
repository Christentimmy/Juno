import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/app_theme.dart';

class DetailsScreen extends StatefulWidget {
  final String image;
  final String name;
  final String loc;
  final String work;
  const DetailsScreen({
    super.key,
    required this.image,
    required this.name,
    required this.loc,
    required this.work,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

final List _list = [
  [
    'Sperm',
    false,
  ],
  [
    'Womb',
    false,
  ],
  [
    'Eggs',
    false,
  ],
  [
    'Embryos',
    false,
  ],
];

class _DetailsScreenState extends State<DetailsScreen> {
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    getProfilePic();
    getUserPick1();
    getUserPick2();
    getUserPick3();
    getUserPick4();
    super.initState();
  }

  String userPick1 = '';
  String userPick2 = '';
  String userPick3 = '';
  String userPick4 = '';
  String profilePic = '';

  Future<String> getProfilePic() async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    setState(() {
      profilePic = (snapshot.data() as Map<String, dynamic>)['photoUrl'];
    });

    return profilePic;
  }

  Future<String> getUserPick1() async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    setState(() {
      userPick1 = (snapshot.data() as Map<String, dynamic>)['User Pick1'];
    });
    return userPick1;
  }

  Future<String> getUserPick2() async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    setState(() {
      userPick2 = (snapshot.data() as Map<String, dynamic>)['User Pick2'];
    });
    return userPick2;
  }

  Future<String> getUserPick3() async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    setState(() {
      userPick3 = (snapshot.data() as Map<String, dynamic>)['User Pick3'];
    });
    return userPick3;
  }

  Future<String> getUserPick4() async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    setState(() {
      userPick4 = (snapshot.data() as Map<String, dynamic>)['User Pick4'];
    });
    return userPick4;
  }

  onclicked(index) {
    setState(() {
      for (var i = 0; i < _list.length; i++) {
        _list[i][1] = false;
      }
      _list[index][1] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    double currentWidth = MediaQuery.of(context).size.width;
    double currentHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: currentWidth,
                height: currentHeight * 0.6,
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      width: currentWidth,
                      height: currentHeight * 0.47,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      margin: const EdgeInsets.only(top: 25, left: 25),
                      padding: const EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(68, 255, 255, 255),
                        border: Border.all(
                          width: 2,
                          color: Colors.white,
                        ),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        width: currentWidth,
                        height: currentHeight * 0.23,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 248, 248, 248),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: currentHeight * 0.095),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.name,
                                      style: const TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      widget.work,
                                      style: const TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      width: 2,
                                      color: const Color.fromARGB(
                                          52, 158, 158, 158),
                                    ),
                                  ),
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.share,
                                      color: basicColor,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 150,
                      child: SizedBox(
                        width: currentWidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SwipeHelpIcon(
                              onTap: () {
                                //store the dislike cards
                              },
                              icon: Icons.clear,
                              iconSize: currentHeight * 0.05,
                              radius: currentHeight * 0.04,
                            ),
                            TheBigMiddleIcon(
                              icon: Icons.favorite,
                              onTap: () {},
                              iconSize: currentHeight * 0.07,
                              radius: currentHeight * 0.06,
                            ),
                            SwipeHelpIcon(
                              icon: Icons.star,
                              onTap: () {
                                //store the like card
                              },
                              iconSize: currentHeight * 0.05,
                              radius: currentHeight * 0.04,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: currentWidth,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Location',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Chicago II, united States',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Expanded(child: Column()),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(71, 255, 172, 64),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: 80,
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: basicColor,
                          ),
                          Text(
                            '${widget.loc}km',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: basicColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: currentHeight * 0.025),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'About',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: currentHeight * 0.01),
                    Container(
                      width: currentWidth,
                      constraints: const BoxConstraints(
                        minHeight: 0,
                        minWidth: 0,
                      ),
                      child: Text(
                        'My name is ${widget.name} and i enjoy meeting new people and finding ways to help them have an uplifting experience, I enjoy reading ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam.......',
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(height: currentHeight * 0.01),
                    Text(
                      'Read more',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: basicColor,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: currentHeight * 0.02),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Text(
                  "What I'm looking for ",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: currentHeight * 0.02),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  itemCount: _list.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return NeedChecked(
                      needText: _list[index][0],
                      isChecked: _list[index][1],
                      onTap: () {
                        onclicked(index);
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: currentHeight * 0.075),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    const Text(
                      'Gallery',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Expanded(child: Column()),
                    Text(
                      'see all',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: basicColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: currentHeight * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FutureBuilder(
                    future: getUserPick1(),
                    builder: (context, snapshot) {
                      return GalleryImages(
                        image: userPick1,
                        height: 300,
                        width: currentWidth * 0.47,
                      );
                    },
                  ),
                  FutureBuilder(
                    future: getProfilePic(),
                    builder: (context, snapshot) {
                      return GalleryImages(
                        image: profilePic,
                        height: 300,
                        width: currentWidth * 0.47,
                      );
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FutureBuilder(
                    future: getUserPick2(),
                    builder: (context, snapshot) {
                      return GalleryImages(
                        image: userPick2,
                        height: 200,
                        width: currentWidth * 0.315,
                      );
                    },
                  ),
                  FutureBuilder(
                    future: getUserPick3(),
                    builder: (context, snapshot) {
                      return GalleryImages(
                        image: userPick3,
                        height: 200,
                        width: currentWidth * 0.315,
                      );
                    },
                  ),
                  FutureBuilder(
                    future: getUserPick4(),
                    builder: (context, snapshot) {
                      return GalleryImages(
                        image: userPick4,
                        height: 200,
                        width: currentWidth * 0.315,
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: currentHeight * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}

class GalleryImages extends StatelessWidget {
  final double width;
  final double height;
  final String image;
  const GalleryImages({
    Key? key,
    required this.image,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class NeedChecked extends StatelessWidget {
  final String needText;
  final bool isChecked;
  final VoidCallback onTap;
  const NeedChecked({
    Key? key,
    required this.needText,
    required this.isChecked,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: 130,
        height: 45,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isChecked ? basicColor : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isChecked
                ? Icon(
                    Icons.check,
                    color: basicColor,
                  )
                : const SizedBox(),
            Text(
              needText,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isChecked ? basicColor : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SwipeHelpIcon extends StatelessWidget {
  final double radius;
  final double iconSize;
  final VoidCallback onTap;
  final IconData icon;
  const SwipeHelpIcon({
    Key? key,
    required this.icon,
    required this.onTap,
    required this.radius,
    required this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 5),
              blurRadius: 14,
              color: Color.fromARGB(38, 158, 158, 158),
            )
          ],
        ),
        child: CircleAvatar(
          radius: radius,
          backgroundColor: Colors.white,
          child: Icon(
            icon,
            color: basicColor,
            size: iconSize,
          ),
        ),
      ),
    );
  }
}

class TheBigMiddleIcon extends StatelessWidget {
  final double radius;
  final double iconSize;
  final VoidCallback onTap;
  final IconData icon;
  const TheBigMiddleIcon({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.radius,
    required this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 17),
            blurRadius: 18,
            color: Color.fromARGB(36, 255, 153, 0),
          )
        ],
      ),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: basicColor,
        child: Icon(
          Icons.favorite,
          color: Colors.white,
          size: iconSize,
        ),
      ),
    );
  }
}
