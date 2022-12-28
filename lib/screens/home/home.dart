import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/screens/home/settings_form.dart';
import 'package:brew_crew/services/database.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  Home({super.key});
  
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: const SettingsForm(),
        );
      });
    }
    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService(uid: '').brews,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          title: const Text('Brew Crew'),
          elevation: 0,
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.all(Colors.brown.shade400),
                foregroundColor: MaterialStateProperty.all(Colors.white)
              ),
              onPressed: ()async{
                _showSettingsPanel();
              }, 
              child: const Icon(Icons.settings),
            ),
            ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.all(Colors.brown.shade400),
                foregroundColor: MaterialStateProperty.all(Colors.white)
              ),
              onPressed: ()async{
                await _auth.signOut();
              }, 
              child: const Icon(Icons.logout),
            ),
          ],
        ),
        body: const BrewList(),
      ),
    );
  }
}