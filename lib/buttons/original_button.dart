import 'package:flutter/material.dart';


// class OriginalButton extends StatelessWidget {
//   final String text;
//   final VoidCallback onPressed;
//   final Color textColor;
//   final Color bgColor;

//   OriginalButton(
//       {required this.text,
//       required this.onPressed,
//       required this.textColor,
//       required this.bgColor});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 60,
//       width: double.infinity,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           primary: bgColor,
//           onPrimary: textColor,
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
//           textStyle: const TextStyle(fontSize: 18),
//         ),
//         onPressed: onPressed,
//         child: Text(text),
//       ),
//     );
//   }
// }

Widget originalButton(
    {required String text,
    required VoidCallback onPressed,
    required Color textColor,
    required Color bgColor}) {
  return SizedBox(
    height: 60,
    width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: bgColor,
        onPrimary: textColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        textStyle: const TextStyle(fontSize: 18),
      ),
      onPressed: onPressed,
      child: Text(text),
    ),
  );
}
