import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/components/button1.dart';
import 'package:pokedex/components/my_textfield.dart';
import 'package:pokedex/components/pokemonCard.dart';
import 'package:pokedex/pages/homepage/homepage_bloc.dart';
import 'package:pokedex/pages/homepage/homepage_event.dart';
import 'package:pokedex/pages/homepage/homepage_state.dart';
import 'package:pokedex/pages/pokemonForm/pokemonForm.dart';
import 'package:pokedex/pages/pokemonForm/pokemonform_bloc.dart';
import 'package:pokedex/services/database_helper.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc _homeBloc;
  @override
  void initState() {
    super.initState();
    _homeBloc = HomeBloc(SQLHelper());
    _homeBloc.add(FetchPokemonEvent());
  }
  @override
  void dispose() {
    _homeBloc.close();
    super.dispose();
  }
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: const Text(
          "PokeDex",
          style: TextStyle(
              fontFamily: "Outfit", fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: MyTextField(
              controller: searchController,
              height: 15,
              hintText: "Search...",
              onChanged: (value) {
                _homeBloc.add(FetchPokemonEvent(searchTerm: value));
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: BlocListener<HomeBloc, HomeState>(
              listener: (context, state) {
                if (state is PokemonDeleted || state is PokemonDataLoaded) {
                  _homeBloc.add(FetchPokemonEvent());
                }
              },
              child:
              BlocBuilder<HomeBloc, HomeState>(
                  bloc: _homeBloc,
                  builder: (context, state) {
                    if (state is PokemonDataLoading) {
                      return const CircularProgressIndicator();
                    } else if (state is PokemonDataLoaded) {
                      print("BlocBuilder in HomePage is rebuilding");
                      return state.pokemonData.isNotEmpty
                          ? ListView.builder(
                              itemCount: state.pokemonData.length,
                              itemBuilder: (_, index) => Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: PokemonCard(
                                      index: index,
                                      name: state.pokemonData[index]['name'],
                                      type: state.pokemonData[index]['type'],
                                      description: state.pokemonData[index]
                                          ['description'],
                                      edit: () {
                                        context.read<HomeBloc>().add(
                                            EditPokemon(
                                                state.pokemonData[index],
                                                context));
                                      },
                                      delete: () {
                                        context.read<HomeBloc>().add(
                                            DeletePokemon(
                                                state.pokemonData[index]
                                                    ['name'],
                                                context));
                                      },
                                    ),
                                  ))
                          : const Center(
                              child: Text(
                              'No Pokemons Found',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: "Outfit",
                                  fontWeight: FontWeight.bold),
                            ));
                    } else if (state is PokemonSearchLoaded) {
                      return ListView.builder(
                          itemCount: state.filteredPokemons.length,
                          itemBuilder: (_, index) => Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: PokemonCard(
                                  index: index,
                                  name: state.filteredPokemons[index]['name'],
                                  type: state.filteredPokemons[index]['type'],
                                  description: state.filteredPokemons[index]
                                      ['description'],
                                  edit: () {
                                    _homeBloc.add(EditPokemon(
                                        state.filteredPokemons[index],
                                        context));
                                  },
                                  delete: () {
                                    context.read<HomeBloc>().add(DeletePokemon(
                                        state.filteredPokemons[index]['name'],
                                        context));
                                  },
                                ),
                              ));
                    } else if (state is PokemonDataError) {
                      return Center(child: Text(state.message));
                    } else {
                      return const SizedBox();
                    }
                  }),
            ),
          ),
        ],
      )),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close, // Choose an animated icon
        backgroundColor: Colors.green,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        children: [
          SpeedDialChild(
            backgroundColor: Colors.lightGreen,
            onTap: () {
              print("add button has been pressed");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (newContext) => BlocProvider.value(
                    value: _homeBloc,
                    child: PokemonForm(addPokemon: true),
                  ),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
          SpeedDialChild(
            backgroundColor: Colors.lightGreen,
            onTap: () => _homeBloc.add(ClearDatabaseTable(context)),
            child: const Icon(Icons.delete_forever),
          ),
        ],
      ),
    );
  }
}
