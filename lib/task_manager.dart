import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskManager extends StatelessWidget {
   TaskManager({super.key});
  final CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');
   TextEditingController titleController = TextEditingController();
   TextEditingController descriptionController = TextEditingController();

  Future<void> updateTask(String id, bool completed)async {
    await tasks.doc(id).update({
      'title':titleController.text,
      'description':descriptionController.text,
      'completed' : completed,
    });
  }
   Future<void> updateStatus(String id, bool completed)async {
     await tasks.doc(id).update({
       'completed' : completed,
     });
   }

   Future<void> deleteTask(String id) async {
     await tasks.doc(id).delete();
   }

  Future<void>addTask()async {
      await tasks.add(
        {'title':titleController.text,
          'description':descriptionController.text,
          'completed' : false,
        }
      );
  }

  void showTaskDialog(BuildContext context, [DocumentSnapshot? doc]){
      if (doc!= null){
        titleController.text = doc ['title'];
        descriptionController.text = doc ['description'];
      }else{
        titleController.clear();
        descriptionController.clear();
      }
    showDialog(context: context, builder: (_)=> AlertDialog(
      title: Text(doc!=null? 'Update Tasks': "Add Task"),
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
        ElevatedButton(onPressed: (){


         doc !=null? updateTask(doc.id, doc['completed']): addTask();
          Navigator.pop(context);
        }, child: Text('Add'))
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
    body: StreamBuilder<QuerySnapshot>(
      stream: tasks.snapshots(),
      builder: (context, asyncSnapshot) {

        if(!asyncSnapshot.hasData) return Center(child: CircularProgressIndicator(),);
        final docs = asyncSnapshot.data!.docs;
        return ListView.builder(
          itemCount: docs.length,
            itemBuilder: (context,index){
            final doc = docs[index];
            return Slidable(
              key: ValueKey(doc.id),
              endActionPane: ActionPane(motion: DrawerMotion(),
                  children: [SlidableAction(onPressed: (_)=>deleteTask(doc.id),
                  backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                  ]),
              child: ListTile(
                title: Text(doc['title']),
                leading: Checkbox(value: doc['completed'], onChanged: (val){
                  updateStatus(doc.id, val!);
                }),
                subtitle: Text(doc['description']),
                trailing: IconButton(onPressed: () {
                  showTaskDialog(context, doc);
                }, icon:Icon(Icons.edit),),
              ),
            );
        
            });
      }
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: (){
        showTaskDialog( context);
      }, child:  Icon(Icons.add),),

    );
  }
}
