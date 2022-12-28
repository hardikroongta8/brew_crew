import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/brew_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  const BrewList({super.key});

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>?>(context);
    if (brews != null) {
      return ListView.builder(
        itemBuilder:(context, index) => BrewTile(brew: brews[index]),
        itemCount: brews.length,
      );
    }
    else{
      return const Text('No users as of now...');
    }
  }
}