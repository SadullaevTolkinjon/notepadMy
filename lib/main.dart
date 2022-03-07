import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notepad/model/notepad_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:notepad/pages/trash_page.dart';

late Box box;
late Box trash;
late List <NotepadModel> trashes;

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(NotepadModelAdapter());

  box = await Hive.openBox<NotepadModel>("notepad");
  trash = await Hive.openBox<NotepadModel>("trash");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My application',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController textController = TextEditingController();

  NotepadModel? notes;

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              DrawerHeader(
                curve: Curves.linear,
                child: Container(
                  width: double.infinity,
                ),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/adler.png"),
                        fit: BoxFit.cover)),
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: Colors.blue,
                ),
                title: Text(
                  "All Notes",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Text(
                    "${box.length}",
                    style: TextStyle(color: Colors.white),
                  ),
                  radius: 15,
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.star,
                  color: Colors.blue,
                ),
                title: Text("Favorites",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              ListTile(
                leading: Icon(
                  Icons.schedule,
                  color: Colors.blue,
                ),
                title: Text("Reminders",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              ListTile(
                leading: Icon(
                  Icons.style,
                  color: Colors.blue,
                ),
                title:
                    Text("Tags", style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Text("Edit"),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TrashPAge(),
                    ),
                  );
                },
                leading: Icon(
                  Icons.delete,
                  color: Colors.blue,
                ),
                title: Text(
                  "Trash",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Text(
                    "${trash.length}",
                    style: TextStyle(color: Colors.white),
                  ),
                  radius: 15,
                ),
              ),
           const   ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Colors.blue,
                ),
                title: Text("Settings",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text("All Notes"),
      ),
      body: box.isEmpty
          ? Center(
              child: Container(
              height: 300,
              width: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://thumbs.gfycat.com/AnotherIncredibleDipper-size_restricted.gif")),
              ),
            ))
          : Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  notes = box.getAt(index);
                  trashes = trash.values.toList().cast();

                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (val) {
                      trash.add(
                          NotepadModel(name: notes!.name, text: notes!.text));
                      box.deleteAt(index);

                      setState(() {});
                    },
                    child: Card(
                      child: ListTile(
                        leading: Text("$index"),
                        title: Text(
                          notes!.name.toString(),
                        ),
                        subtitle: Text(notes!.text.toString()),
                      ),
                    ),
                  );
                },
                itemCount: box.length,
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: Container(
                    height: 250,
                    margin: EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          child: TextField(
                            decoration:
                                InputDecoration(hintText: "Title kiriting"),
                            controller: titleController,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          child: TextField(
                            decoration:
                                InputDecoration(hintText: "Text kiriting"),
                            controller: textController,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            String title = titleController.text;
                            String text = textController.text;

                            box.add(NotepadModel(name: title, text: text));

                            titleController.clear();
                            textController.clear();
                            setState(() {});
                            Navigator.pop(context);
                          },
                          child: Text("Save"),
                        )
                      ],
                    ),
                  ),
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
