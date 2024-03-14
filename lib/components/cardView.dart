// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'my_textfield.dart';
//
// class PokemonDialog1 extends StatefulWidget {
//   final String name;
//   final String type;
//   final String description;
//   final bool addButton;
//   final int? pokemonID;
//
//
//   PokemonDialog1({
//     Key? key,
//     required this.name,
//     required this.type,
//     required this.description,
//
//     required this.addButton,
//     this.pokemonID,
//
//
//   }) : super(key: key);
//
//   @override
//   _PokemonDialog1State createState() => _PokemonDialog1State();
// }
//
// class _PokemonDialog1State extends State<PokemonDialog1> {
//   final nameController = TextEditingController();
//   final typeController = TextEditingController();
//   final descriptionController = TextEditingController();
//   late int pokemonID = 0;
//   late bool addButton;
//
//
//
//
//   @override
//   void initState() {
//     super.initState();
//
//     pokemonID = widget.pokemonID!;
//     addButton = widget.addButton;
//
//     if(addButton == false){
//       nameController.text = widget.name;
//       typeController.text = widget.type;
//       descriptionController.text = widget.description;
//     }
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Edit Pokémon'),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           MyTextField(
//             controller: nameController,
//             hintText: "Name",
//           ),
//           const SizedBox(height: 10,),
//           MyTextField(
//             controller: typeController,
//             hintText: "Type",
//           ),
//           const SizedBox(height: 10,),
//           MyTextField(
//             controller: descriptionController,
//             hintText: "Description",
//           ),
//           const SizedBox(height: 10,),
//         ],
//       ),
//       actions: [
//         ElevatedButton(
//             onPressed: () async{
//
//               bool addButton = widget.addButton;
//               String name = nameController.text.trim();
//               String type = typeController.text.trim();
//               String description = descriptionController.text.trim();
//
//               print("Selected Pokemon ID: $pokemonID");
//
//               if(name.isNotEmpty && type.isNotEmpty && description.isNotEmpty){
//
//                 if(addButton == true) {
//
//                 }else if(addButton == false){
//
//                 }
//               }else{
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('All fields are required!')),
//                 );
//               }
//             },
//             child: Text(addButton == true ? "Add"  : "Update",
//               style: const TextStyle(
//                 color: Colors.black87,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18,
//                 fontFamily: 'Outfit',
//
//               ),
//             )
//         ),
//         const SizedBox(height: 10,),
//       ],
//     );
//   }
// }
