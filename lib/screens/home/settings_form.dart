import 'package:brew_crew/models/myuser.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4', '5'];

  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){

          UserData userData = snapshot.data!;

          return Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  'Update your brew settings.',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  initialValue: userData.name,
                  validator: (value) => value == '' ? 'Please enter your name' : null,
                  onChanged: (value) => setState(() {
                    _currentName = value;
                  }),
                  decoration: textInputDecoration.copyWith(
                    hintText: 'Name'
                  ),
                  cursorColor: Colors.brown[400],
                  cursorHeight: 24,
                  cursorWidth: 1,
                ),
                const SizedBox(height: 20,),
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  items: sugars.map((e){
                    return DropdownMenuItem(
                      value: e,
                      child: Text('$e sugars'),
                    );
                  }).toList(),
                  onChanged: (value){
                    if(value != null){
                      setState(() {
                        _currentSugars = value;
                      });
                    }
                  },
                  value: _currentSugars ?? userData.sugars,
                  
                ),
                const SizedBox(height: 20,),
                Slider(
                  min: 100,
                  max: 900,
                  divisions: 8,
                  onChanged: (value){
                    setState(() {
                      _currentStrength = value.toInt();
                    });
                  },
                  value: (_currentStrength ?? userData.strength).toDouble(),
                  inactiveColor: Colors.brown[50],
                  activeColor: Colors.brown[_currentStrength ?? userData.strength],
                  label: 'Strength',
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.brown[300])
                  ),
                  onPressed: ()async{
                    if(_formKey.currentState!.validate()){
                      await DatabaseService(uid: user.uid).updateUserData(
                        _currentSugars ?? userData.sugars,
                        _currentName ?? userData.name,
                        _currentStrength ?? userData.strength
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Submit')
                )
              ],
            ),
          );
        }
        else{
          return Loading();
        }        
      }
    );
  }
}