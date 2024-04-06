import 'package:flutter/material.dart';
import 'package:juno/components/button.dart';
import 'package:juno/pages/first_screen.dart';

class EditFourth extends StatefulWidget {
  const EditFourth({super.key});

  @override
  State<EditFourth> createState() => _EditFourthState();
}

TextEditingController _textControlller = TextEditingController();  
String changes = '';

class _EditFourthState extends State<EditFourth> {
  bool isClick = false;
  bool isChanged = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Row(
                  children: [
                    SimPleCall(
                      icon: Icons.arrow_back_ios_new_rounded,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Edit Profile',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const TextFIlled(text: 'Full Name'),
                const TextFIlled(text: 'Email'),
                const TextFIlled(text: 'Phone Number'),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 185,
                      height: 50,
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Gender..',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 185,
                      height: 50,
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Age',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onDoubleTap: () {
                    setState(() {
                      isClick = !isClick;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: isClick
                        ? TextField(
                            controller: _textControlller,
                            decoration: InputDecoration(
                              labelText: 'About.............',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(185, 158, 158, 158),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            padding: const EdgeInsets.all(10),
                            constraints: const BoxConstraints(
                              minHeight: 0,
                              minWidth: 0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                width: 2,
                                color: const Color.fromARGB(185, 158, 158, 158),
                              ),
                            ),
                            child: Text(
                              isChanged
                                  ? changes
                                  : "voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam",
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 60),
                Button(
                  text: 'Save Changes',
                  onTap: () {
                    setState(() {
                      changes = _textControlller.text;
                      isChanged = true;
                      isClick = !isClick;
                    });
                  },
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextFIlled extends StatelessWidget {
  final String text;

  const TextFIlled({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    width: 2,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
