import 'package:flutter/material.dart';
import 'package:flutter_lesson_21/text_field.dart';
import 'dart:math';

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

  List<String> names = ['Eldar', 'Taalai', 'Erjan'];
  String nameValue = 'Eldar';
  bool isCheckActive = false;
  bool isSwitchActive = false;
  final random = Random();
  //
  Color _color = Colors.green;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(9);

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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: Colors.black,
        label: const Text('search'),
        icon: const Icon(Icons.search),
      ),
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
                            // onLongPress: () {
                            //   print('on long press');
                            // },
                            // onHover: (value) {
                            //   print(value);
                            // },
                            onPressed: isEmailFilled && isPasswordFilled
                                ? () {
                                    formKey.currentState?.validate();
                                    authUser();
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              primary: Colors.black,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.alarm),
                                SizedBox(width: 12),
                                Text('Join'),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                        Center(child: Text(isAuth)),
                        TextButton(
                          onPressed: () {
                            print('its text button');
                          },
                          child: const Text('Registration'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              DropdownButton<String>(
                value: nameValue,
                items: [
                  ...names.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    );
                  }).toList(),
                ],
                onChanged: (name) {
                  nameValue = name ?? '';
                  email.text = name ?? '';
                  setState(() {});
                },
              ),
              Checkbox(
                value: isCheckActive,
                onChanged: (value) {
                  isCheckActive = !isCheckActive;
                  setState(() {});
                },
              ),

              Switch.adaptive(
                  value: isSwitchActive,
                  onChanged: (value) {
                    isSwitchActive = value;
                    setState(() {});
                  }),
              // Center(
              //   child: RichText(
              //     text: const TextSpan(
              //       style: TextStyle(
              //         color: Colors.black,
              //         fontSize: 16,
              //         fontWeight: FontWeight.w500,
              //       ),
              //       children: [
              //         TextSpan(text: 'Dont have an account?'),
              //         TextSpan(
              //           text: ' Sign up',
              //           style: TextStyle(
              //             color: Colors.blue,
              //             fontSize: 16,
              //             fontWeight: FontWeight.w500,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              if (isSwitchActive)
                Center(
                  child: AnimatedContainer(
                    height: random.nextDouble() * 250,
                    width: random.nextDouble() * 250,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(random.nextInt(500),
                          random.nextInt(500), random.nextInt(500), 1),
                      borderRadius: _borderRadius,
                    ),
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn,
                  ),
                ),
              if (!isSwitchActive)
                Center(
                  child: AnimatedContainer(
                    height: random.nextDouble() * 250,
                    width: random.nextDouble() * 250,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(random.nextInt(500),
                          random.nextInt(500), random.nextInt(500), 1),
                      borderRadius: _borderRadius,
                    ),
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn,
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
