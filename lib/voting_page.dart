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
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No candidates found'));
        }

        final bdvote = snapshot.data!.docs;

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 10,
            childAspectRatio: 0.6,
          ),
          itemCount: bdvote.length,
          itemBuilder: (context, index) {
            final doc = bdvote[index]; // SAFE now
            final data = doc.data() as Map<String, dynamic>;

            return Card(
              child: Column(
                children: [
                  Expanded(
                    child: Image.network(data['imageUrl'], fit: BoxFit.cover),
                  ),
                  Text(data['name']),
                  Text('Vote: ${data['votes']}'),
                  ElevatedButton(
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('bdvote')
                          .doc(doc.id)
                          .update({'votes': FieldValue.increment(1)});
                    },
                    child: const Text('Vote'),
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
