import 'package:flutter/material.dart';

const TextStyle ndStylesTopBarHead = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.w600,
);
const TextStyle ndStylesTopBarDesc = TextStyle(
  fontSize: 13,
);

TextStyle ndStylesLinkText({bool isActive = false}) => TextStyle(
  fontSize: 15,
  color: isActive ? Colors.white : Colors.black,
);
