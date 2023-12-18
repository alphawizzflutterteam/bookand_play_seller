// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
//
// import '../Helper/color.dart';
//
// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});
//
//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }
//
// class _ProfilePageState extends State<ProfilePage> {
//   int selectedGenderIndex = 0;
//
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//           backgroundColor: Colors.white,
//           body: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
//               decoration: const BoxDecoration(
//                 border: Border(),
//               ),
//               child: Form(
//                 key: _formKey,
//                 child: ListView(
//                   //   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Stack(
//                       children: [
//                         Container(
//                             height: MediaQuery.of(context).size.height * 0.25,
//                             width: MediaQuery.of(context).size.width,
//                             color: Colors.white,
//                             child: Image.asset(
//                               'assets/images/bg2.png',
//                               fit: BoxFit.fill,
//                             )),
//                         Container(
//                             height: MediaQuery.of(context).size.height * 0.25,
//                             width: MediaQuery.of(context).size.width,
//                             child: Row(
//                               children: [
//                                 Expanded(child: Container()),
//                                 Expanded(
//                                   child: Container(
//                                     padding: EdgeInsets.only(top: 45),
//                                     child: CircleAvatar(
//                                       radius: 80,
//                                       backgroundImage:
//                                       AssetImage('assets/images/profile.jpg')
//                                       as ImageProvider<
//                                           Object>, // Explicit casting
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(child: Container()),
//                               ],
//                             )),
//
//                       ],
//                     ),
//                     Center(
//                         child: Text(
//                           "Shubham Sharma",
//                           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                         )),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         //'assets/images/Warranty - Authentication.png'
//                         Icon(
//                           // asset('assets/images/lake.jpg'),
//                           Icons.countertops_rounded,
//                           color: Colors.yellow,
//                         ),
//                         Text(
//                           '500',
//                           style: TextStyle(color: Colors.red),
//                         )
//                       ],
//                     ),
//                     SizedBox(
//                       height: 30,
//                     ),
//                     profileTile(
//                       icon: Icons.call,
//                       title: 'Mobile No.',
//                       subtitle: '9009191688',
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     profileTile(
//                       icon: Icons.email,
//                       title: 'Email Id',
//                       subtitle: 'Paulhuntshubham@gmail.com',
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     profileTile(
//                       icon: Icons.person,
//                       title: 'First Name',
//                       subtitle: 'Shubham',
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     profileTile(
//                       icon: Icons.person,
//                       title: 'Last Name',
//                       subtitle: 'Sharma',
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     profileTile(
//                       icon: Icons.lock_open,
//                       title: 'Pin code',
//                       subtitle: '452002',
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     profileTile(
//                       icon: Icons.pin_drop_outlined,
//                       title: 'City/Location',
//                       subtitle: '83, Globus Colony, Jaipur (R.J)',
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     profileTile(
//                       icon: Icons.circle,
//                       title: 'Country',
//                       subtitle: 'India',
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     profileTile(
//                       icon: Icons.group_rounded,
//                       title: 'Gender',
//                       subtitle: 'Male',
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     profileTile(
//                       icon: Icons.calendar_today,
//                       title: 'Date of Birth',
//                       subtitle: '04/01/1994',
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     profileTile(
//                       icon: Icons.cake_sharp,
//                       title: 'Date of Annivarsary',
//                       subtitle: '04/01/1994',
//                     ),
//                     SizedBox(
//                       height: 50,
//                     ),
//                     InkWell(
//                       onTap: () {
//                         // Navigator.push(
//                         //   context,
//                         //   MaterialPageRoute(
//                         //       builder: (context) => const Verification()),
//                         // );
//                       },
//                       child: Container(
//                         margin: EdgeInsets.symmetric(
//                             horizontal: MediaQuery.of(context).size.width * 0.2),
//                         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                         decoration: BoxDecoration(
//                             border: Border.all(color: colors.primary, width: 2),
//                             borderRadius: BorderRadius.circular(10)),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Text("Edit Profile",
//                                 style: TextStyle(
//                                     fontSize: 16,
//                                     color: colors.primary,
//                                     fontWeight: FontWeight.bold)),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 30,
//                     )
//                   ],
//                 ),
//               )),
//         )
//     );
//   }
//
//   Widget profileTile(
//       {required IconData icon,
//         required String title,
//         required String subtitle}) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 20),
//       height: 70,
//       width: MediaQuery.of(context).size.width,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           border: Border.all(color: colors.primary),
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.red.withOpacity(0.2),
//               spreadRadius: 1,
//               blurRadius: 1,
//             )
//           ]),
//       child: Row(
//         children: [
//           Expanded(
//               flex: 1,
//               child: Container(
//                 child: Center(
//                   child: Icon(
//                     icon,
//                     color: Colors.red,
//                   ),
//                 ),
//               )),
//           Expanded(
//               flex: 3,
//               child: Container(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: TextStyle(color: Colors.grey, fontSize: 12),
//                     ),
//                     Text(
//                       subtitle,
//                       style:
//                       TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//                     )
//                   ],
//                 ),
//               )),
//           Expanded(
//               flex: 1,
//               child: Container(
//                 alignment: AlignmentDirectional.center,
//                 child: title == 'Mobile No.'
//                     ? Text(
//                   "Default login",
//                   style: TextStyle(
//                       fontSize: 10,fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
//                 )
//                     : null,
//               )),
//         ],
//       ),
//
//     );
//
//   }
// }