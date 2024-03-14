import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

// class FetchPokemonData extends HomeEvent {
//   const FetchPokemonData();
//   @override
//   List<Object> get props => [];
//
// }

class ClearDatabaseTable extends HomeEvent {
  final BuildContext context;

  const ClearDatabaseTable(this.context);

  @override
  List<Object> get props => [context];
}

class DeletePokemon extends HomeEvent {
  final String selectedMon;
  final BuildContext context;
  DeletePokemon(this.selectedMon, this.context);
  @override
  List<Object> get props => [selectedMon, context];
}

class EditPokemon extends HomeEvent {
  final Map<String, dynamic> pokemonToEdit;
  final BuildContext context;
  EditPokemon(this.pokemonToEdit, this.context);
}

class PokemonSearch extends HomeEvent {
  final String searchTerm;
  final BuildContext context;
  PokemonSearch(this.searchTerm, this.context);
}

class FetchPokemonEvent extends HomeEvent {
  final String searchTerm;

  const FetchPokemonEvent({this.searchTerm = ''});

  @override
  List<Object> get props => [searchTerm];
}



