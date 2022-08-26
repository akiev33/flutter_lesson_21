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
  late FocusNode emailFocus;
  late FocusNode passwordFocus;

  final Map userData = {'эльдар': '1234', 'фарш': '123'};
  String isAuth = '';

  final email = TextEditingController();
  final password = TextEditingController();

  //

  @override
  void initState() {
    super.initState();
    emailFocus = FocusNode();
    passwordFocus = FocusNode();

    email.addListener(() {
      setState(() {});
    });
    password.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

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
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextField(
                        title: 'Email',
                        controller: email,
                        focus: emailFocus,
                        onSubmitted: (v) {
                          passwordFocus.requestFocus();
                        },
                      ),
                      const SizedBox(height: 24),
                      AppTextField(
                        title: 'Password',
                        controller: password,
                        focus: passwordFocus,
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
                          onPressed: () {
                            authUser();
                          },
                          child: const Text('Join'),
                        ),
                      ),
                      const SizedBox(height: 50),
                      Center(child: Text(isAuth)),
                    ],
                  ),
                ),
              ),
              // const SizedBox(height: 60),
              // Text('Email - ${email.text}'),
              // const SizedBox(height: 12),
              // Text('Password - ${password.text}'),
              // const SizedBox(height: 150),
              // const SizedBox(
              //   height: 20,
              // ),
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
