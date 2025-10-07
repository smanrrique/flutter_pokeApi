import 'package:flutter/material.dart';

class ElevateButtonLoadMore extends StatelessWidget {
  final Function loadMore;

  const ElevateButtonLoadMore({super.key, required this.loadMore});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF1E90FF)),
        onPressed: () {
          loadMore();
        },
        child: Text('Load More', style: TextStyle(color: Colors.white, fontSize: 20)),
      ),
    );
  }
}
