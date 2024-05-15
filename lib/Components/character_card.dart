import 'package:studentdex/Components/bordered_title.dart';
import 'package:flutter/material.dart';

class CharacterCard extends StatefulWidget {
  const CharacterCard({
    super.key,
    required this.name,
    required this.picRoute,
  });

  final String name;
  final String picRoute;

  @override
  State<CharacterCard> createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        image: DecorationImage(
          image: NetworkImage(
            widget.picRoute,
          ),
          fit: BoxFit.fitWidth,
        ),
      ),
      margin: const EdgeInsets.all(5),
      child: BorderedTitle(
        title: widget.name,
        titleSize: 50,
      ),
    );
  }
}
