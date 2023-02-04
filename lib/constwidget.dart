
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

final Color purplestyle = Colors.purple;

final IconData iconbright = Icons.wb_sunny;
final IconData iconDart = Icons.nights_stay;
class containerLottie extends StatelessWidget {
  const containerLottie({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 70,
        width: 100,
        child: Lottie.asset('asset/180-pencil-write.json'));
  }
}