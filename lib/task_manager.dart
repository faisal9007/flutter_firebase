import 'package:flutter/material.dart';

class TaskManager extends StatelessWidget {
  const TaskManager({super.key});

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
      onPressed: (){}, child:  Icon(Icons.add),),

    );
  }
}
