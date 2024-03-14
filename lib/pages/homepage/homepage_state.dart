import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class PokemonDataLoading extends HomeState {}

class PokemonDataLoaded extends HomeState {
  final List<dynamic> pokemonData; // Adjust the type accordingly
  const PokemonDataLoaded(this.pokemonData);
  @override
  List<Object> get props => [pokemonData];
}

class PokemonDataError extends HomeState {
  final String message;
  const PokemonDataError(this.message);
  @override
  List<Object> get props => [message];
}

class DatabaseTableClearing extends HomeState {}

class DatabaseTableCleared extends HomeState {}

class DatabaseTableClearError extends HomeState {
  final String message;
  DatabaseTableClearError(this.message);
  @override
  List<Object> get props => [message];
}

class PokemonDeleting extends HomeState {}
class PokemonDeleted extends HomeState {}
class PokemonDeletedCancelled extends HomeState {}
class PokemonDeleteError extends HomeState {
  final String message;
  PokemonDeleteError(this.message);
  @override
  List<Object> get props => [message];
}

class PokemonEditing extends HomeState {} // State for when you're editing

class PokemonEditError extends HomeState {
  final String message;

  PokemonEditError(this.message);
}
class PokemonSearchLoaded extends HomeState {
  final List<Map<String, dynamic>> filteredPokemons;
  PokemonSearchLoaded(this.filteredPokemons);
}

