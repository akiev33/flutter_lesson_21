import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    required this.controller,
    required this.focus,
    required this.title,
    this.onSubmitted,
  }) : super(key: key);

  final TextEditingController controller;
  final String title;
  final FocusNode focus;
  final Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 50,
          child: TextField(
            controller: controller,
            autofocus: true,
            focusNode: focus,
            // obscureText: true,
            autocorrect: false,
            enableSuggestions: false,
            maxLength: 25,
            textInputAction: TextInputAction.next,
            onSubmitted: onSubmitted,
            decoration: InputDecoration(
              counterText: '',
              // suffixIcon: IconButton(
              //   icon: const Icon(Icons.remove_red_eye_outlined),
              //   onPressed: () {},
              // ),
              hintText: title,
              border: const OutlineInputBorder(),
              enabledBorder: const OutlineInputBorder(),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
