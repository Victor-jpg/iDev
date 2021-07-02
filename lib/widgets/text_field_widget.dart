// import 'package:flutter/material.dart';

// // ignore: must_be_immutable
// class TextFieldWidget extends StatefulWidget {
//   Function onChanged;
//   String labelText;
//   Widget prefixIcon;
//   Widget suffixIcon;
//   TextEditingController controller;
//   Function validator;
//   double width;
//   double height;
//   double marginRight;
//   double marginLeft;
//   int maxLines;
//   int maxLength;
//   bool obscureText;
//   String obscuringCharacter;
//   TextInputType keyboardType;
//   bool enabled;
//   bool readOnly;
//   Function onTap;
//   String initialValue;
//   String hint;
//   FocusNode focus;
//   bool filled;
//   bool alignLabelWithHint;

//   TextFieldWidget(
//       {this.labelText = '',
//       this.height = 0,
//       this.alignLabelWithHint = false,
//       this.maxLines = 1,
//       this.maxLength = 0,
//       this.width = double.infinity,
//       this.obscureText = false,
//       this.enabled = true,
//       this.readOnly = false,
//       this.marginRight = 0,
//       this.marginLeft = 0,
//       this.hint = ''});

//   @override
//   _TextFieldWidgetState createState() => _TextFieldWidgetState();
// }

// class _TextFieldWidgetState extends State<TextFieldWidget> {
//   FocusNode _focusNode;

//   @override
//   void initState() {
//     super.initState();
//     _focusNode = FocusNode();
//     _focusNode.addListener(() {
//       setState(() {});
//     });
//   }

//   @override
//   void dispose() {
//     _focusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: widget.width,
//       height: widget.height,
//       margin: EdgeInsets.only(
//           left: widget.marginLeft ?? 30,
//           top: 20,
//           right: widget.marginRight ?? 30),
//       child: TextFormField(
//         textAlignVertical: TextAlignVertical.bottom,
//         autofocus: true,
//         decoration: InputDecoration(
//             fillColor: Colors.white,
//             border: InputBorder.none,
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(5.0),
//               borderSide: BorderSide(
//                 width: 0.8,
//                 color: Colors.grey,
//               ),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(5.0),
//               borderSide: BorderSide(
//                 width: 0.8,
//                 color: Colors.grey,
//               ),
//             ),
//             disabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(5.0),
//               borderSide: BorderSide(
//                 width: 0.8,
//                 color: Colors.white,
//               ),
//             ),
//             labelText: 'Senha',
//             prefixIcon: Icon(
//               Icons.alternate_email_outlined,
//               color: Colors.white,
//             ),
//             labelStyle: Theme.of(context).textTheme.subtitle1),
//       ),
//     );
//   }
// }
