import 'package:flutter/material.dart';

Widget orgCard(ImageProvider image) {
  return Container(
    width: 100,
    height: 100,
    margin: const EdgeInsets.only(right: 8),
    decoration: BoxDecoration(
        image: DecorationImage(image: image, fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(8)),
  );
}
