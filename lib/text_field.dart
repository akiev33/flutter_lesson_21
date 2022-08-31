import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    Key? key,
    required this.controller,
    required this.focus,
    required this.title,
    this.keyboardType = TextInputType.text,
    this.onSubmitted,
    this.isObscure = false,
  }) : super(key: key);

  final TextEditingController controller;
  final String title;
  final FocusNode focus;
  final bool isObscure;
  final Function(String)? onSubmitted;
  final TextInputType keyboardType;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool obsecured = widget.isObscure;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 80,
          child: TextFormField(
            controller: widget.controller,
            focusNode: widget.focus,
            onFieldSubmitted: widget.onSubmitted,
            keyboardType: widget.keyboardType,
            autofocus: true,
            obscureText: obsecured,
            autocorrect: true,
            enableSuggestions: false,
            maxLength: 25,
            validator: (value) {
              RegExp regexpAZ = RegExp(r'^(?=.*[A-Z])');
              RegExp regexpNumber = RegExp(r'(?=.*?[0-9])');
              if (widget.keyboardType == TextInputType.emailAddress) {
                if (!value!.contains('@')) {
                  return 'Нет знака "@"!';
                } else if (!value.contains('.')) {
                  return 'Не обнаружена "." после "@"!';
                } else if (value.length < 4) {
                  return 'Проверь правильность почты!';
                } else if (value.split('.').last.length < 2) {
                  return 'Некорректный адрес почты!';
                }
              }
              if (widget.keyboardType == TextInputType.visiblePassword) {
                if (value!.length < 8) {
                  return 'Пароль должен содержать не меньше 8 символов!';
                } else if (!regexpAZ.hasMatch(value)) {
                  return 'Пароль должен содержать одну заглавную букву!';
                } else if (!regexpNumber.hasMatch(value)) {
                  return 'Пароль должен содержать одну цифру!';
                }
              }
              return null;
            },
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              suffixIcon: Visibility(
                visible: widget.isObscure,
                child: IconButton(
                  icon: Icon(
                    obsecured ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    obsecured = !obsecured;
                    setState(() {});
                  },
                ),
              ),
              counterText: '',
              hintText: widget.title,
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
