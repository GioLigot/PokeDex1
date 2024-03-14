import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokedex/models/queries.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:xml/xml.dart' as xml;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS mons (
		id INTEGER PRIMARY KEY,
		name TEXT,
		type TEXT,
		description TEXT
		);""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'pokemon.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        print("creating a table");
        await createTables(database);
      },
    );
  }

  static Future<List<Queries>> getQueriesFromXML() async {
    try {
      String xmlString = await rootBundle.loadString('assets/data/queries.xml');
      var raw = xml.XmlDocument.parse(xmlString);
      final queries = raw.findAllElements('queries').map((queryElement) {
        final name = queryElement.getAttribute('name').toString();
        final text = queryElement.text.trim();
        return Queries(name: name, text: text);
      }).toList();
      return queries;
    } catch (error) {
      print("Error reading XML: $error");
      return [];
    }
  }

  Future<void> addPokemon(
      BuildContext context,
      String name,
      String type,
      String description,
      ) async {
    final db = await SQLHelper.db();
    try {
      List<Queries> queries = await getQueriesFromXML();
      List<dynamic> pokemon = await getPokemon(name);
      if (pokemon.isEmpty) {
        final addPokemonText =
            queries.firstWhere((query) => query.name == "addPokemon");
        final addPokemonQuery = addPokemonText.text;
        List<dynamic> params = [name, type, description];
        await db.rawInsert(addPokemonQuery, params);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pokemon added!'), duration: Durations.short1,),
        );
        return;
      } else if (pokemon.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Pokemon with that name already exists!')),
        );
        return;
      }
    } catch (error) {
      print("Error: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error Adding Pokemon!')),
      );
      return;
    }
  }
   Future<void> updatePokemon(
      String selectedMon,
      String name,
      String type,
      String description,
      ) async {
    final db = await SQLHelper.db();
    try {
      List<Queries> queries = await getQueriesFromXML();
      List<dynamic> pokemon = await getPokemon(name);
      if (pokemon.isEmpty) {
        final updatePokemonText =
            queries.firstWhere((query) => query.name == "updatePokemon");
        final updatePokemonQuery = updatePokemonText.text;
        List<dynamic> params = [name, type, description, selectedMon];
        await db.rawQuery(updatePokemonQuery, params);
        print("Update made");

        return;
      } else if (pokemon.isNotEmpty) {
        return;
      }
    } catch (error) {
      print("Error: $error");
      return;
    }
  }

   Future<List<Map<String, dynamic>>> getPokemons() async {
    final db = await SQLHelper.db();

    try {
      List<Queries> queries = await getQueriesFromXML();

      final getPokemonsText =
          queries.firstWhere((query) => query.name == "getAllPokemons");
      final getPokemonsQuery = getPokemonsText.text;

      return await db.rawQuery(getPokemonsQuery);
    } catch (error) {
      print("Error: $error");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getPokemon(String name) async {
    final db = await SQLHelper.db();
    try {
      List<Queries> queries = await getQueriesFromXML();
      final getPokemonText =
          queries.firstWhere((query) => query.name == "getPokemon");
      final getPokemonQuery = getPokemonText.text;
      List<dynamic> params = [name];
      return await db.rawQuery(getPokemonQuery, params);
    } catch (error) {
      print("Error: $error");
      return [];
    }
  }

   Future<void> deletePokemon(String selectedMon) async {
    final db = await SQLHelper.db();
    try {
      List<Queries> queries = await getQueriesFromXML();
      final deletePokemonText =
          queries.firstWhere((query) => query.name == "deletePokemon");
      final deletePokemonQuery = deletePokemonText.text;
      List<dynamic> params = [selectedMon];
      await db.rawQuery(deletePokemonQuery, params);

    } catch (error) {
      print("Error: $error");

    }
  }

  Future<void> clearTable() async {
    final db = await SQLHelper.db();
    try {
      List<Queries> queries = await getQueriesFromXML();
      final clearTableText =
          queries.firstWhere((query) => query.name == "clear");
      final clearTableQuery = clearTableText.text;
      await db.rawQuery(clearTableQuery);
      print("table cleared");
    } catch (error) {
      print("Error: $error");
    }
  }
}
