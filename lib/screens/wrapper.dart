import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/models/myuser.dart';
import 'package:brew_crew/screens/authenticate/authenticate.dart';
import 'package:brew_crew/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    if(user == null){
      return const Authenticate();
    }
    else{
      return Home();
    }
  }
}