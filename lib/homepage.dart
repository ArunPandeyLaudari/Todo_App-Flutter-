import 'package:flutter/material.dart';
import 'package:todo_app/model/todo.dart';


class TodoApplication extends StatefulWidget {

 
  TodoApplication({super.key});

  

  final List<Todo> todos = [
    Todo(
      id: "1",
      title: "This is title",
      description: "Hero Arun",
      isCompleted: true,
    ),
    Todo(
      id: "2",
      title: "This is title",
      description: "Don Arun",
      isCompleted: true,
    ),
    Todo(
      id: "3",
      title: "This is title",
      description: "Timro Babe",
      isCompleted: true,
    ),
    Todo(
      id: "4",
      title: "This is title",
      description: "Binisha Don",
      isCompleted: true,
    ),
  ];

  @override
  State<TodoApplication> createState() => _TodoApplicationState();
}

class _TodoApplicationState extends State<TodoApplication> {
  final GlobalKey<FormState> todoFormKey = GlobalKey();


  String title ="";
  String description ="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Todo Application",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 21, 4, 145),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: widget.todos.length,
        itemBuilder: (ctx, i) {
          return ListTile(
            leading: Checkbox(
              value: widget.todos[i].isCompleted,
              onChanged: (value) {
               
              },
            ),
            title: Text(widget.todos[i].title),
            subtitle: Text(widget.todos[i].description),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        showModalBottomSheet(context: context, builder: (context)
        
        {
          return SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(child: Column(
                children: [
                  Text("Add Todo",style: TextStyle(fontSize: 28),),
                  TextFormField(decoration: InputDecoration(labelText: "Title"),
                   validator: (value) {
                    if (value == null || value.isEmpty){
                      return "Please Provide Description";
                    }
                    else{
                      return null;
                    }
                  }
                  ,
                  onSaved: (value) {
                    setState(() {
                      title=value!;
                    });
                    
                  },
                  ),
                  TextFormField(decoration: InputDecoration(labelText: "Description"), maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty){
                      return "Please Provide Description";
                    }
                    else{
                      return null;
                    }
                  },
                  onSaved: (value) {
                    setState(() {
                      description=value!;
                    });
                    
                  },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FilledButton(
                          onPressed: () {
                          Navigator.of(context).pop();
                          },
                          child: Text("Cancel"),
                        ),
                        FilledButton(onPressed: () {

                            if(!todoFormKey.currentState!.validate()){
                              return;
                            }
                        }, child: Text("Submit")),
                      ],
                    
                    ),
                  ),
                ],
              )),
            ),
          );
        }
        );
      },child: Icon(Icons.add),),
    );
  }
}