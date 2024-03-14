import 'package:equatable/equatable.dart';

abstract class PokemonFormState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PokemonFormInitial extends PokemonFormState {

}

class PokemonFormLoading extends PokemonFormState {

}

class PokemonFormSuccess extends PokemonFormState {

}

class PokemonFormValidationError extends PokemonFormState {}


class PokemonFormFailure extends PokemonFormState {
  final String error;

  PokemonFormFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
