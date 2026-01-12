import 'package:flutter/material.dart';

class VotingPage extends StatelessWidget {
  const VotingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 16,
        childAspectRatio: .6,
      ),
      itemCount: 2,
      itemBuilder: (context, index) {
        return Card(
          child: Column(
            children: [
              Image.network(
                'https://img.freepik.com/free-psd/close-up-delicious-apple_23-2151868338.jpg',
              ),
              Text(
                'Name',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'Vote: 10',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(onPressed: () {}, child: Text('Vote')),
            ],
          ),
        );
      },
    );
  }
}
