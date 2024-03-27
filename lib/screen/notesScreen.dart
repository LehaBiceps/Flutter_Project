import 'package:flutter/material.dart';

class notesScreen extends StatefulWidget {
  const notesScreen({super.key});

  @override
  State<notesScreen> createState() => _notesScreenState();
}

String notes = "";
List userNotes = [];

@override
void initState()
{
  initState();
  userNotes.addAll([""]);
}

class _notesScreenState extends State<notesScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[500],
          centerTitle: true,
          title: const Text("Заметки", style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),),
          leading: IconButton(onPressed: (){
            Navigator.pushReplacementNamed(context, "/");
          },icon: const Icon(Icons.chevron_left_rounded),),
        ),
        body: ListView.builder(
        itemCount: userNotes.length,
        itemBuilder: (BuildContext context, int index)
        {
          return Dismissible(
            key: Key(userNotes[index]),
            child: Card(
              child: ListTile(
                title: Text(userNotes[index]),
                trailing: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.grey[500],
                  ),
                  onPressed: ()
                  {
                    setState(()
                    {
                      userNotes.removeAt(index);
                    });
                  },
                ),
              ),
            ),
            onDismissed: (direction)
            {
              setState(()
              {
                userNotes.removeAt(index);
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[500],
        onPressed: ()
        {
          showDialog(context: context, builder: (BuildContext context)
          {
            return AlertDialog(
              title: Text("Введите заметку:"),
              content: TextField(
                onChanged: (String value)
                {
                  notes = value;
                },
              ),
              actions: [
                ElevatedButton(onPressed: ()
                {
                  setState(()
                  {
                    userNotes.add(notes);
                  });
                  Navigator.of(context).pop();
                }, child: Text("Добавить"))
              ],
            );
          });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      ),
    );
  }
}
