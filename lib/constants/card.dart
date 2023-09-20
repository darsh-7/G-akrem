import 'package:flutter/material.dart';

class Card {
  final Image img;
  final String title;
  final int? action;

  const Card({
    required this.img,
    required this.title,
    this.action,
  });
}
