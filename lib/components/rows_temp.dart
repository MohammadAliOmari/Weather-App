import 'package:flutter/material.dart';

class RowsTemp extends StatelessWidget {
  const RowsTemp({
    super.key,
    required this.image,
    required this.name,
    required this.tempandclock,
    required this.image1,
    required this.name1,
    required this.tempandclock1,
  });
  final String image;
  final String image1;
  final String name;
  final String name1;
  final String tempandclock;
  final String tempandclock1;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(
              image,
              scale: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  tempandclock,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            )
          ],
        ),
        Row(
          children: [
            Image.asset(
              image1,
              scale: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  tempandclock1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
