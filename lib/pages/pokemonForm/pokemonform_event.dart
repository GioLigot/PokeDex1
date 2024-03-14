import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class PokemonFormEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PokemonFormSubmitted extends PokemonFormEvent {
  final BuildContext context;
  final bool addPokemon;
  final String name;
  final String type;
  final String description;
  final String? selectedMon;

  PokemonFormSubmitted(
      {required this.context,
      required this.addPokemon,
      required this.name,
      required this.type,
      required this.description,
      this.selectedMon});

  @override
  List<Object?> get props => [context, name, type, description, selectedMon, addPokemon];
}
