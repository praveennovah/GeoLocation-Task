import 'package:flutter/material.dart';
import 'package:youtube_ui/_location.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final user = TextEditingController();
  final password = TextEditingController();
  final _form_key = GlobalKey<FormState>();
  String palindrome = "";

  bool isPalindrome(String username) {
    String lowercaseUsername = username.toLowerCase();
    int i = 0;
    int j = lowercaseUsername.length - 1;

    while (i < j) {
      if (lowercaseUsername[i] != lowercaseUsername[j]) {
        return false;
      }
      i++;
      j--;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login With GeoLocation "),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 200),
            child: Form(
              key: _form_key,
              child: Column(
                children: [
                  TextFormField(
                    controller: user,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      palindrome = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Username cannot be empty";
                      }
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: password,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'password cannot be Empty';
                      }
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_form_key.currentState!.validate() &&
                            isPalindrome(palindrome)) {
                          print("success");
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LocationScreen()));
                        }
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 20),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
