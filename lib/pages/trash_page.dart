import 'package:flutter/material.dart';
import 'package:notepad/main.dart';

class TrashPAge extends StatefulWidget {
  const TrashPAge({Key? key}) : super(key: key);

  @override
  _TrashPAgeState createState() => _TrashPAgeState();
}

class _TrashPAgeState extends State<TrashPAge> {
  @override
  Widget build(BuildContext context) {
    setState(() {
      
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("Trashes"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(trashes[index].name.toString()),
                subtitle: Text(trashes[index].text.toString()),
               
                ),
              
            );
          },
          itemCount: trashes.length,
        ),
      ),
    );
  }
}
