import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:juno/pages/details_screen.dart';
import '../components/app_theme.dart';
import '../components/tinder_card.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

AppinioSwiperController controller = AppinioSwiperController();

bool isLoading = false;

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    super.initState();
    _fetchData().then((_) {
      _loadCards();
      setState(() {});
    });
  }

  final String userUid = FirebaseAuth.instance.currentUser!.uid;

  List<ProfileCard> cards = [];

  late List<DocumentSnapshot> _documents;

  Future<void> _fetchData() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').get();
    _documents = snapshot.docs;
  }

  void _loadCards() {
    for (var document in _documents) {
      final imageUrl = document['photoUrl'];
      final name = document['first name'];
      final ocuppy = document['Occupation'];
      final userUid = document['uid'];
      cards.add(
        ProfileCard(
          uid: userUid,
          image: imageUrl,
          name: name,
          loc: '',
          work: ocuppy,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DetailsScreen(
                  image: imageUrl,
                  name: name,
                  loc: '',
                  work: ocuppy,
                ),
              ),
            );
          },
        ),
      );
    }
  }

  processReloadcards() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(
      const Duration(milliseconds: 2000),
    );
    setState(() {
      isLoading = false;
    });
    _loadCards();
  }

  @override
  Widget build(BuildContext context) {
    final currentHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: currentHeight * 0.02),
              const BeginRow(),
              Expanded(
                child: Center(
                  child: isLoading
                      ? CircularProgressIndicator(
                          color: basicColor,
                        )
                      : Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: AppinioSwiper(
                            cards: cards,
                            controller: controller,
                            onEnd: () {
                              processReloadcards();
                            },
                            onSwipe: (int index,
                                AppinioSwiperDirection direction) async {
                              if (direction == AppinioSwiperDirection.right) {
                                //store the card to like collection
                              }
                              if (direction.index == 1) {
                                //store the card to dislike
                                debugPrint('card swipe left');
                              }
                            },
                          ),
                        ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SwipeHelpIcon(
                    onTap: () => controller.swipeLeft(),
                    icon: Icons.clear,
                    iconSize: currentHeight * 0.05,
                    radius: currentHeight * 0.04,
                  ),
                  TheBigMiddleIcon(
                    icon: Icons.favorite,
                    onTap: () {},
                    iconSize: currentHeight * 0.07,
                    radius: currentHeight * 0.05,
                  ),
                  SwipeHelpIcon(
                    icon: Icons.star,
                    onTap: () => controller.swipeRight(),
                    iconSize: currentHeight * 0.05,
                    radius: currentHeight * 0.04,
                  ),
                ],
              ),
              SizedBox(height: currentHeight * 0.02),
            ],
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
            offset: Offset(0, 8),
            blurRadius: 18,
            color: Color.fromARGB(50, 255, 153, 0),
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

class BeginRow extends StatelessWidget {
  const BeginRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SimPleCall(
          icon: Icons.notifications,
          onTap: () {},
        ),
        Column(
          children: const [
            Text(
              'Discover',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'Chicago, II',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SimPleCall(
          icon: Icons.menu,
          onTap: () {},
        )
      ],
    );
  }
}

class SimPleCall extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  const SimPleCall({
    Key? key,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 2,
          color: const Color.fromARGB(52, 158, 158, 158),
        ),
      ),
      child: IconButton(
        onPressed: onTap,
        icon: Icon(
          icon,
          color: basicColor,
        ),
      ),
    );
  }
}
