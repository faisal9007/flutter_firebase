import 'package:flutter/material.dart';

class TaskManager extends StatelessWidget {
  const TaskManager({super.key});
  void showTaskDialog(BuildContext context){
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    showDialog(context: context, builder: (_)=> AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController ,
            decoration: InputDecoration(
              labelText: 'Title'
            ),
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(
                labelText: 'Description'
            ),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text('Cancel')),
        ElevatedButton(onPressed: (){}, child: Text('Add'))
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        title: Text('Task Manager'),
      centerTitle: true,
      backgroundColor: Colors.orange,
    ),
    body: ListView.builder(
      itemCount: 10,
        itemBuilder: (context,index){
        return ListTile(
          title: Text('This is title'),
          leading: Checkbox(value: false, onChanged: (val){}),
          subtitle: Text('here is description'),
          trailing: Icon(Icons.edit),
        );

        }),
    floatingActionButton: FloatingActionButton(
      onPressed: (){
        showTaskDialog( context);
      }, child:  Icon(Icons.add),),

    );
  }
}
