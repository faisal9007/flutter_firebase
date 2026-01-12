import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VotingPage extends StatelessWidget {
  const VotingPage({super.key});

  @override
  Widget build(BuildContext context) {
    VoteParticipant(String id) {
      FirebaseFirestore.instance.collection('bdvote').doc(id).update({
        'votes': FieldValue.increment(1),
      });
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('bdvote').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final bdvote = snapshot.data?.docs ?? [];
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 10,
            childAspectRatio: 0.60,
          ),
          itemCount: 2,
          itemBuilder: (context, index) {
            final doc = bdvote[index];
            final data = doc.data() as Map<String, dynamic>;
            return Card(
              child: Column(
                children: [
                  Image.network(data['imageUrl'], fit: BoxFit.cover),
                  Text(
                    data['name'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Vote: ${data['votes']}',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () => VoteParticipant(doc.id),
                      child: Text('Vote'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
