import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lesson_21/text_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Map userData = {'эльдар': '1234', 'фарш': '123'};

  String isAuth = '';

  final email = TextEditingController();
  final password = TextEditingController();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();

  //

  @override
  void initState() {
    email.addListener(() {
      if (email.text.length > 4) {
        isEmailFilled = true;
      } else {
        isEmailFilled = false;
      }
      setState(() {});
    });
    password.addListener(() {
      if (password.text.length > 4) {
        isPasswordFilled = true;
      } else {
        isPasswordFilled = false;
      }
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();
  bool isEmailFilled = false;
  bool isPasswordFilled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextField(
                          title: 'Email',
                          controller: email,
                          focus: emailFocus,
                          keyboardType: TextInputType.emailAddress,
                          onSubmitted: (v) {
                            passwordFocus.requestFocus();
                          },
                        ),
                        const SizedBox(height: 24),
                        AppTextField(
                          title: 'Password',
                          controller: password,
                          focus: passwordFocus,
                          isObscure: true,
                          keyboardType: TextInputType.visiblePassword,
                          onSubmitted: (v) {
                            authUser();
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: isEmailFilled && isPasswordFilled
                                ? () {
                                    formKey.currentState?.validate();
                                    authUser();
                                  }
                                : null,
                            child: const Text('Join'),
                          ),
                        ),
                        const SizedBox(height: 50),
                        Center(child: Text(isAuth)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Center(
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(text: 'Dont have an account?'),
                      TextSpan(
                        text: ' Sign up',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  authUser() {
    if (userData.containsKey(email.text)) {
      if (userData[email.text] == password.text) {
        isAuth = 'Вы успешно авторизовались!';
      } else {
        isAuth = 'Неверный пароль!';
      }
    } else {
      isAuth = 'Неверный логин!';
    }
    setState(() {});
  }
}
