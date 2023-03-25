import 'package:flutter/material.dart';

Widget orgCard(ImageProvider image, ontap) {
  return GestureDetector(
    onTap: ontap,
    child: UnconstrainedBox(
      child: Container(
        width: 100,
        height: 100,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                spreadRadius: 0,
                blurRadius: 4,
                offset: const Offset(0, 4), // changes position of shadow
              ),
            ],
            image: DecorationImage(image: image, fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(8)),
      ),
    ),
  );
}
