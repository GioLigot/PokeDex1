// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:listview_test/components/my_textfield.dart';
// import 'package:pokedex/components/my_textfield.dart';
//
// class PokemonDialog extends StatefulWidget {
//   final BuildContext context;
//   final bool addBtn;
//
//   const PokemonDialog({
//     super.key,
//     required this.context,
//     required this.addBtn});
//
//   @override
//   State<PokemonDialog> createState() => _PokemonDialogState();
// }
//
// class _PokemonDialogState extends State<PokemonDialog> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController typeController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(widget.context).size.height;
//
//     return Container(
//       child: Material(
//           color: const Color(0xFF78C850),
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(20),
//               topRight: Radius.circular(20)),
//         child: Container(
//
//           height: screenHeight*.50,
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               MyTextField(
//                 controller: nameController,
//                 hintText: "Name...",
//               ),
//               SizedBox(height: 10.0),
//               MyTextField(
//                 controller: typeController,
//                 hintText: "Type...",
//               ),
//               SizedBox(height: 10.0),
//               MyTextField(
//                 controller: descriptionController,
//                 hintText: "Description...",
//                 height: 50,
//               ),
//               SizedBox(height: 20.0),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () {
//
//                       print('Button 1 pressed');
//
//                     },
//                     child: Text(widget.addBtn == true ? "Add" : "Update"),
//                   ),
//                   if(widget.addBtn == false)
//                   ElevatedButton(
//                     onPressed: () {
//
//                       print('Button 2 pressed');
//
//                     },
//                     child: Text('Delete'),
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
