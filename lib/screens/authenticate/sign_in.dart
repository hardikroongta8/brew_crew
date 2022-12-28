import 'package:flutter/material.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/loading.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  const SignIn({ required this.toggleView, super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0,
        title: const Text('Sign in'),
        actions: [
          TextButton.icon(
            style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.white)),
            onPressed: (){
              widget.toggleView();
            },
            icon: const Icon(Icons.login),
            label: const Text('Register')
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Form(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  cursorColor: Colors.brown[400],
                  cursorHeight: 24,
                  cursorWidth: 1,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email_rounded, color: Colors.brown[400],),
                    hintText: ' Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(width: 2)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.brown.shade400, width: 1.6)
                    )
                  ),
                  validator: (value) => value=='' ? 'Enter an Email' : null,
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  cursorColor: Colors.brown[400],
                  cursorHeight: 24,
                  cursorWidth: 1,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: Colors.brown[400],),
                    hintText: ' Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(width: 2)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.brown.shade400, width: 1.6)
                    )
                  ),
                  validator: (value){
                    if((value == null) || (value.length < 6)){
                      return 'Minimum 6 characters';
                    }
                    else{
                      return null;
                    }
                  },
                  obscureText: true,
                  onChanged: (value){
                    setState(() {
                      password = value;
                    });
                  },
                ),
                const SizedBox(height: 20,),
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.brown[500])),
                  onPressed: ()async{
                    if(_formKey.currentState!.validate()){
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _auth.signInEmail(email, password);
                      if(result == null){
                        setState(() {
                          setState(() {
                            loading = false;
                          });
                          error = 'Could not sign you in!';
                        });
                      }
                    }
                  },
                  child: const Text('Sign in', style: TextStyle(color: Colors.white),)
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}