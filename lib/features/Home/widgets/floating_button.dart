import 'package:flutter/material.dart';
import '../../../shared/cubit/cubit.dart';



class FloatingButton extends StatelessWidget {
  const FloatingButton({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56.0,
      height: 56.0,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xff3371FF),
            Color(0xff8426D6),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(
            30.0), // Adjust the border radius as needed
      ),
      child: Icon(
        iconFloating,
        color: Colors.white,
      ),
    );
  }
}