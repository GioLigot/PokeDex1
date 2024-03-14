import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PokemonCard extends StatefulWidget {
  final Function()? edit;
  final Function()? delete;
  final int index;
  final String name;
  final String type;
  final String description;

  const PokemonCard(
      {super.key,
      this.edit,
      this.delete,
      required this.index,
      required this.name,
      required this.type,
      required this.description});

  @override
  State<PokemonCard> createState() => _PokemonCardState();
}

class _PokemonCardState extends State<PokemonCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
            backgroundColor:
                widget.index % 2 == 0 ? Colors.green : Colors.greenAccent,
            foregroundColor: Colors.white,
            child: Text(
              widget.name[0].toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25,
                fontFamily: 'Outfit',
              ),
            )),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.name,
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                fontFamily: 'Outfit',
              ),
            ),
            Text(
              widget.type,
              style: const TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.normal,
                fontSize: 15,
                fontFamily: 'Zilla',
              ),
            ),
            Text(
              widget.description,
              style: const TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.normal,
                fontSize: 15,
                fontFamily: 'Zilla',
              ),
            ),
          ],
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(
            children: [
              GestureDetector(
                  onTap: widget.edit, child: const Icon(Icons.edit)),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                  onTap: widget.delete, child: const Icon(Icons.delete)),
            ],
          ),
        ),
      ),
    );
  }
}
