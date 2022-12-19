import 'package:flutter/material.dart';

// -- package | shimmer
import 'package:shimmer/shimmer.dart';


class ListAllTestsContentLoading extends StatelessWidget {
  const ListAllTestsContentLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[200]!,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
