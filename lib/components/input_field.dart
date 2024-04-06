import 'package:flutter/material.dart';
import 'package:juno/components/app_theme.dart';
import 'package:regexed_validator/regexed_validator.dart';

class NameInput extends StatelessWidget {
  final String text;
  final IconData icon;
  final TextEditingController controller;

  const NameInput({
    super.key,
    required this.controller,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    double currentWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: currentWidth,
      height: 60,
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'Username cannot be valid';
          }
          return null;
        },
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: basicColor,
            size: 26,
          ),
          labelText: text,
          labelStyle: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              width: 2,
              color: basicColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              width: 2,
              color: basicColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              width: 2,
              color: basicColor,
            ),
          ),
        ),
      ),
    );
  }
}

class EmailInput extends StatelessWidget {
  final TextEditingController controller;

  const EmailInput({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    double currentWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: currentWidth,
      height: 60,
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'Email cannot be empty';
          }
          if (!validator.email(value)) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Processing'),
              ),
            );
          }
          return null;
        },
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.email,
            color: basicColor,
            size: 26,
          ),
          hintText: 'Enter Email',
          hintStyle: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              width: 2,
              color: basicColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              width: 2,
              color: basicColor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              width: 2,
              color: basicColor,
            ),
          ),
        ),
      ),
    );
  }
}
