import 'package:flutter/material.dart';
import 'package:juno/pages/first_screen.dart';
import 'package:juno/utils/final_class1.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

FirstScreenFinals _finals = FirstScreenFinals();

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    double currentWidth = MediaQuery.of(context).size.width;
    double currentHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: currentHeight * 0.046),
                Row(
                  children: [
                    const Text(
                      'Matches',
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Expanded(child: Column()),
                    SimPleCall(
                      icon: Icons.drive_file_rename_outline_rounded,
                      onTap: () {},
                    ),
                  ],
                ),
                SizedBox(height: currentHeight * 0.025),
                const Text(
                  'This is a list of people who have liked you and your matches',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: currentHeight * 0.025),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: currentWidth * 0.35,
                      height: 0.5,
                      color: Colors.grey,
                    ),
                    const Text(
                      'Today',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      width: currentWidth * 0.35,
                      height: 0.5,
                      color: Colors.grey,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 500,
                  child: GridView.builder(
                    itemCount: 4,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) {
                      return MatcheCards(
                        image: _finals.images[index][3],
                        name: _finals.images[index][0],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: currentWidth * 0.30,
                      height: 0.5,
                      color: Colors.grey,
                    ),
                    const Text(
                      'Yesterday',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      width: currentWidth * 0.30,
                      height: 0.5,
                      color: Colors.grey,
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 500,
                  child: GridView.builder(
                    itemCount: _finals.imageUrls.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) {
                      return MatcheCards(
                        image: _finals.imageUrls[index][1],
                        name: _finals.imageUrls[index][0],
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MatcheCards extends StatelessWidget {
  final String image;
  final String name;
  const MatcheCards({
    Key? key,
    required this.image,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double currentWidth = MediaQuery.of(context).size.width;
    double currentHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: const EdgeInsets.all(4),
      width: currentWidth * 0.49,
      height: currentHeight * 0.32,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [
                  Colors.black87,
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.center,
              ),
            ),
          ),
          Positioned(
            bottom: currentHeight * 0.051,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: currentWidth * 0.21,
                    height: currentHeight * 0.061,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                      color: Colors.black.withOpacity(0.5),
                      backgroundBlendMode: BlendMode.srcOver,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                  Container(
                    width: 2,
                    height: currentHeight * 0.061,
                    color: Colors.white,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: currentWidth * 0.21,
                    height: currentHeight * 0.061,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                      color: Colors.black.withOpacity(0.5),
                      backgroundBlendMode: BlendMode.srcOver,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
