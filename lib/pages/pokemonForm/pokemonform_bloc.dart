import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/pages/homepage/homepage_bloc.dart';
import 'package:pokedex/pages/homepage/homepage_event.dart';
import 'package:pokedex/pages/pokemonForm/pokemonform_event.dart';
import 'package:pokedex/pages/pokemonForm/pokemonform_state.dart';
import 'package:pokedex/services/database_helper.dart';

class PokemonFormBloc extends Bloc<PokemonFormEvent, PokemonFormState> {
  final SQLHelper _databaseHelper;

  PokemonFormBloc(this._databaseHelper) : super(PokemonFormInitial()) {

    on<PokemonFormSubmitted>((event, emit) async {
      emit(PokemonFormLoading());
      try {
          if (event.addPokemon == true) {
            await _databaseHelper.addPokemon(
                event.context,
                event.name,
                event.type,
                event.description);
          } else if (event.addPokemon == false) {
            await _databaseHelper.updatePokemon(
                event.selectedMon.toString(),
                event.name.toString(),
                event.type.toString(),
                event.description.toString()
            );
          }
          Navigator.of(event.context).pop();
          print("Dispatching FetchPokemonData from PokemonFormBloc");
          BlocProvider.of<HomeBloc>(event.context)
              .add(FetchPokemonEvent());
          print("Refresh Idol");
          emit(PokemonFormSuccess());

      } catch (error) {
        emit(PokemonFormFailure(error: error.toString()));
      }
    });
  }
}
