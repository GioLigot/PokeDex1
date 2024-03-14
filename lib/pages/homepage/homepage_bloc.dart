import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/pages/homepage/homepage_state.dart';
import 'package:pokedex/pages/pokemonForm/pokemonForm.dart';
import 'homepage_event.dart';
import 'package:pokedex/services/database_helper.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final SQLHelper _databaseHelper;


  HomeBloc(this._databaseHelper) : super(HomeInitial()) {

    // on<FetchPokemonEvent>((event, emit) async {
    //   emit(PokemonDataLoading());
    //   try {
    //
    //     final pokemonData = await _databaseHelper.getPokemons();
    //     emit(PokemonDataLoaded(pokemonData));
    //     print("Pokemon Data fetched");
    //   } catch (error) {
    //     emit(PokemonDataError(error.toString()));
    //   }
    // });
    //
    // on<PokemonSearch>((event, emit) async {
    //   emit(PokemonDataLoading());  // Indicate that a search is in progress
    //   try {
    //     final pokemonData = event.searchTerm.isEmpty
    //         ? await _databaseHelper.getPokemons()
    //         : await _databaseHelper.getPokemon(event.searchTerm);
    //     emit(PokemonSearchLoaded(pokemonData));
    //   } catch (error) {
    //     emit(PokemonDataError(error.toString()));
    //   }
    // });

    on<FetchPokemonEvent>((event, emit) async {
      emit(PokemonDataLoading());
      try {
        final pokemonData = event.searchTerm.isEmpty
            ? await _databaseHelper.getPokemons()
            : await _databaseHelper.getPokemon(event.searchTerm);

        // Emit appropriate state based on searchTerm
        if (event.searchTerm.isEmpty) {
          emit(PokemonDataLoaded(pokemonData));
        } else {
          emit(PokemonSearchLoaded(pokemonData));
        }

      } catch (error) {
        emit(PokemonDataError(error.toString()));
      }
    });

    on<DeletePokemon> ( (event, emit) async {
      emit(PokemonDeleting());
      try {
        bool? userConfirmed = await showDialog(
            context: event.context,
            builder: (context) => AlertDialog(
              content: Text("Are you sure you want to delete ${event.selectedMon}?"),
              actions: [
                TextButton(
                  child: const Text("Cancel"),
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                ),
                TextButton(
                  child: const Text("Confirm"),
                  onPressed: () async {
                    Navigator.pop(context, true);
                  },
                )
              ],
            )
        );
        if (userConfirmed != true) {
          emit(PokemonDeletedCancelled());
          return;
        }
        await _databaseHelper.deletePokemon(event.selectedMon);
        emit(PokemonDeleted());
        emit(PokemonDataLoaded(await _databaseHelper.getPokemons()));
      } catch (error) {
        emit(PokemonDeleteError(error.toString()));
      }
    });

    on<EditPokemon>((event, emit) async {
      emit(PokemonEditing());
      try {
        final homeBloc = BlocProvider.of<HomeBloc>(event.context);
        await Navigator.push(
          event.context,
          MaterialPageRoute(
            builder: (context) => PokemonForm(addPokemon: false,pokemonToEdit: event.pokemonToEdit),
          ),
        );
        homeBloc.add(FetchPokemonEvent());


      } catch (error) {
        emit(PokemonEditError(error.toString()));
      }
    });

    on<ClearDatabaseTable>((event, emit) async {
      emit(DatabaseTableClearing());
      try {
        await _databaseHelper.clearTable();
        emit(DatabaseTableCleared());
        BlocProvider.of<HomeBloc>(event.context).add(FetchPokemonEvent());
      } catch (error) {
        emit(DatabaseTableClearError(error.toString()));
      }
    });





  }
}