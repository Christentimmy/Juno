import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:juno/Profile_Setup/profile_details.dart';
import 'package:juno/components/app_theme.dart';

class OTPscreen extends StatefulWidget {
  const OTPscreen({super.key});

  @override
  State<OTPscreen> createState() => _OTPscreenState();
}

bool isLoading = false;

bool isGone = false;

class _OTPscreenState extends State<OTPscreen> {
  late Timer _timer;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    autoTimerStart();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  Future autoTimerStart() async {
    await Future.delayed(const Duration(milliseconds: 500));
    startCountDown();
  }

  double timeleft = 60.00;

  verifyToContinue() {
    if (_formKey.currentState!.validate()) {
      isGone
          ? null
          : Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const ProfileSetup(),
              ),
            );
    }
  }

  startCountDown() {
    _timer = Timer.periodic(const Duration(milliseconds: 3000), (timer) {
      if (timeleft > 0) {
        setState(() {
          timeleft--;
        });
      } else {
        timer.cancel();
        isGone = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
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
                  SizedBox(height: currentHeight * 0.01),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        timeleft == 0 ? 'TimeOut' : timeleft.toString(),
                        style: TextStyle(
                          color: timeleft == 0 ? Colors.red : Colors.black,
                          fontSize: 35,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Type the verification code\nwe've sent you",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: currentHeight / 18),
                      Form(
                        key: _formKey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            OtpInput(),
                            OtpInput(),
                            OtpInput(),
                            OtpInput(),
                          ],
                        ),
                      ),
                      SizedBox(height: currentHeight * 0.09),
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            isLoading = true;
                          });
                          await Future.delayed(
                            const Duration(milliseconds: 2000),
                          );
                          setState(() {
                            isLoading = false;
                          });
                          verifyToContinue();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: timeleft == 0
                                ? basicColor.withOpacity(0.2)
                                : basicColor,
                          ),
                          width: double.infinity,
                          height: 60,
                          alignment: Alignment.center,
                          child: isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  'Continue',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OtpInput extends StatelessWidget {
  const OtpInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68,
      width: 64,
      child: TextFormField(
        decoration: InputDecoration(
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Colors.red,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              width: 2,
              color: Colors.grey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              width: 2,
              color: basicColor,
            ),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "error";
          }
          return null;
        },
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        style: Theme.of(context).textTheme.headline6,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }
}
