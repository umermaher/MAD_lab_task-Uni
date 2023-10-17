import 'package:chatscreenui/model/Message.dart';
import 'package:chatscreenui/ui/todo/todoprovider.dart';
import 'package:chatscreenui/ui/todo/todoscreen.dart';
import 'package:chatscreenui/utils/String.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


class FormsScreen extends StatefulWidget {

  const FormsScreen({super.key});

  @override
  State<FormsScreen> createState() => _FormsScreenState();

}

class _FormsScreenState extends State<FormsScreen> {

  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final emailTextController = TextEditingController();
  String? _selectedGender = Strings.male;
  int _groupValue = 0;
  var gestureDetectorScale = 1.0;
  Offset offset = const Offset(0.0, 0.0);
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void dispose() {
    usernameTextController.dispose();
    passwordTextController.dispose();
    emailTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.forms),
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color(0xff0c9100)
        ),
        backgroundColor: const Color(0xff0c9100),
        // leading: BackButton(
        //   onPressed:()=> Navigator.of(context).pop(),
        // ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.all(20),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: usernameTextController,
                        decoration: const InputDecoration(
                            labelText: "Username",
                            border: OutlineInputBorder(),
                            hintText: "Username",
                            hintStyle: TextStyle(color: Color(0xff0c9100)),
                            contentPadding: EdgeInsets.only(
                                left: 20.0, right: 20.0
                            )
                        ),
                        validator: (String? value) {
                          if(value?.isEmpty == true) {
                            return "Please Enter username!";
                          }
                          return null;
                        },
                        cursorColor: const Color(0xff0c9100),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: emailTextController,
                        decoration: const InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder(),
                            hintText: "Email",
                            hintStyle: TextStyle(color: Color(0xff0c9100)),
                            contentPadding: EdgeInsets.only(
                                left: 20.0, right: 20.0
                            )
                        ),
                        validator: (String? value) {
                          if(value?.isEmpty == true) {
                            return "Please Enter Email!";
                          }
                          return null;
                        },
                        cursorColor: const Color(0xff0c9100),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: passwordTextController,
                        obscureText: true,
                        decoration: const InputDecoration(
                            labelText: "Password",
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff0c9100))
                            ),
                            hintText: "Password",
                            contentPadding: EdgeInsets.only(
                                left: 20.0, right: 20.0
                            )
                        ),
                        validator: (String? value) {
                          return validatePassword(value);
                        },
                        cursorColor: const Color(0xff0c9100),
                      ),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              flex: 1,
                              child: RadioListTile(
                                value: Strings.male,
                                groupValue: _selectedGender,
                                title: const Text(Strings.male),
                                onChanged: (value) => _selectedGender = value,
                                selected: false,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: RadioListTile(
                                value: Strings.female,
                                groupValue: _selectedGender,
                                title: const Text(Strings.female),
                                onChanged: (value) => _selectedGender = value,
                                selected: false,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState?.validate() == true) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Form Submitted"),
                                    )
                                );
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => TodoScreen()
                                        //     ChangeNotifierProvider(
                                        //     create: (BuildContext c) {
                                        //       return TodoProvider();
                                        //     }
                                        // )
                                    )
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                primary: const Color(0xff0c9100),
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 10, bottom: 10
                                )
                            ),
                            child: Text("LOGIN")
                        ),
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("On Tab"),
                              )
                          );
                        },
                        onDoubleTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("On double Tab"),
                            )
                          );
                        },
                        onLongPress: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("On Long Press"),
                              )
                          );
                        },
                        onScaleUpdate: (details) {
                          setState(() {
                            gestureDetectorScale = details.scale;
                          });
                        },
                        child: Column(
                          children: [
                            Transform.scale(
                              scale: gestureDetectorScale,
                              child: Container(
                                height: 100,
                                width: double.infinity,
                                color: Colors.green,
                                child: const Center(
                                  child: Text("Gesture"),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Transform.translate(
                              offset: offset,
                              child: Container(
                                height: 50,
                                width: 50,
                                color: Colors.green,
                                child: const Center(
                                  child: Text("Gesture"),
                                ),
                              ),
                            )
                          ],
                        )
                      )
                    ],
                  )
              ),
            )
          ],
        ),
      ),
    );
  }

  String? validatePassword(String? value) {
    if(value == null) {
      return "Please enter password";
    }
    RegExp regex =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid password';
      } else {
        return null;
      }
    }
  }

}
