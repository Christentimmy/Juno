import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:juno/components/button.dart';
import 'package:juno/utils/storage_methods.dart';
import '../components/app_theme.dart';
import '../pages/home_screen.dart';
import '../utils/utils.dart';

class AddPhotos extends StatefulWidget {
  const AddPhotos({super.key});
  @override
  State<AddPhotos> createState() => _AddPhotosState();
}

Uint8List? image;
Uint8List? image1;
Uint8List? image2;
Uint8List? image3;

class _AddPhotosState extends State<AddPhotos> {
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  void selectImage() async {
    Uint8List im = await takeImage(ImageSource.gallery);
    setState(() {
      image = im;
    });
  }

  void two() async {
    Uint8List im1 = await takeImage(ImageSource.gallery);
    setState(() {
      image1 = im1;
    });
  }

  void three() async {
    Uint8List im2 = await takeImage(ImageSource.gallery);
    setState(() {
      image2 = im2;
    });
  }

  void four() async {
    Uint8List im3 = await takeImage(ImageSource.gallery);
    setState(() {
      image3 = im3;
    });
  }

  void updateUserImages(
    Uint8List file,
    Uint8List file1,
    Uint8List file2,
    Uint8List file3,
  ) async {
    List<Uint8List> files = [file, file1, file2, file3];
    List<String> downloadUrls =
        await StorageMethods().upLoadBucchesToStorage('User Photos', files);
    FirebaseFirestore.instance.collection('users').doc(uid).update({
      'User Pick1': downloadUrls[0],
      'User Pick2': downloadUrls[1],
      'User Pick3': downloadUrls[2],
      'User Pick4': downloadUrls[3],
    });
  }

  @override
  Widget build(BuildContext context) {
    double currentHeight = MediaQuery.of(context).size.height;
    double currentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 5),
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
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: basicColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Add your photos',
                      style: TextStyle(
                        fontSize: currentWidth * 0.08,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: currentHeight / 30),
                const Text(
                  'Add your photos to get a higher amount of daily matches',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        selectImage();
                      },
                      child: image != null
                          ? Container(
                              width: currentWidth * 0.45,
                              height: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: MemoryImage(image!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Container(
                              width: currentWidth * 0.45,
                              height: 250,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                  color: basicColor,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                image: const DecorationImage(
                                  image:
                                      AssetImage('assets/images/default2.png'),
                                  colorFilter: ColorFilter.mode(
                                    Color.fromARGB(54, 0, 0, 0),
                                    BlendMode.darken,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Center(
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor:
                                      const Color.fromARGB(164, 255, 255, 255),
                                  child: Icon(
                                    Icons.add_a_photo,
                                    color: basicColor,
                                    size: 40,
                                  ),
                                ),
                              ),
                            ),
                    ),
                    GestureDetector(
                      onTap: () {
                        two();
                      },
                      child: image1 != null
                          ? Container(
                              width: currentWidth * 0.45,
                              height: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: MemoryImage(image1!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Container(
                              width: currentWidth * 0.45,
                              height: 250,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                  color: basicColor,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                image: const DecorationImage(
                                  image:
                                      AssetImage('assets/images/default2.png'),
                                  colorFilter: ColorFilter.mode(
                                    Color.fromARGB(54, 0, 0, 0),
                                    BlendMode.darken,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Center(
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor:
                                      const Color.fromARGB(164, 255, 255, 255),
                                  child: Icon(
                                    Icons.add_a_photo,
                                    color: basicColor,
                                    size: 40,
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        three();
                      },
                      child: image2 != null
                          ? Container(
                              width: currentWidth * 0.45,
                              height: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: MemoryImage(image2!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Container(
                              width: currentWidth * 0.45,
                              height: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  width: 2,
                                  color: basicColor,
                                ),
                                image: const DecorationImage(
                                  image:
                                      AssetImage('assets/images/default2.png'),
                                  colorFilter: ColorFilter.mode(
                                    Color.fromARGB(54, 0, 0, 0),
                                    BlendMode.darken,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Center(
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor:
                                      const Color.fromARGB(164, 255, 255, 255),
                                  child: Icon(
                                    Icons.add_a_photo,
                                    color: basicColor,
                                    size: 40,
                                  ),
                                ),
                              ),
                            ),
                    ),
                    GestureDetector(
                      onTap: () {
                        four();
                      },
                      child: image3 != null
                          ? Container(
                              width: currentWidth * 0.45,
                              height: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: MemoryImage(image3!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Container(
                              width: currentWidth * 0.45,
                              height: 250,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                  color: basicColor,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                image: const DecorationImage(
                                  image:
                                      AssetImage('assets/images/default2.png'),
                                  colorFilter: ColorFilter.mode(
                                    Color.fromARGB(54, 0, 0, 0),
                                    BlendMode.darken,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Center(
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor:
                                      const Color.fromARGB(164, 255, 255, 255),
                                  child: Icon(
                                    Icons.add_a_photo,
                                    color: basicColor,
                                    size: 40,
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Button(
                  text: 'Continue',
                  onTap: () {
                    if (image != null &&
                        image1 != null &&
                        image2 != null &&
                        image3 != null) {
                      updateUserImages(image!, image1!, image2!, image3!);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please add all 4 photos'),
                        ),
                      );
                    }
                  },
                ),
                SizedBox(height: currentHeight / 20)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
