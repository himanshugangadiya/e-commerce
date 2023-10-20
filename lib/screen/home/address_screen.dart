//  import 'package:flutter/material.dart';
//
// import '../../utils/app_color.dart';
// import '../../utils/app_image.dart';
// import '../../widget/common_back_button.dart';
//
// class AddressScreen extends StatefulWidget {
//   const AddressScreen({super.key});
//
//   @override
//   State<AddressScreen> createState() => _AddressScreenState();
// }
//
// class _AddressScreenState extends State<AddressScreen> {
//   int selectedIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.sizeOf(context).height;
//     double width = MediaQuery.sizeOf(context).width;
//     return SafeArea(
//       child: Scaffold(
//         appBar: PreferredSize(
//           preferredSize: Size(
//             double.infinity,
//             height*(0.1),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: AppBar(
//               backgroundColor: Colors.transparent,
//               elevation: 0.0,
//               title: const Text("Address"),
//               centerTitle: true,
//               leading: Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: CommonBackButton(
//                   onTap: () {},
//                 ),
//               ),
//             ),
//           ),
//         ),
//         body: Padding(
//           padding: EdgeInsets.symmetric(
//             horizontal: width*(0.05),
//           ),
//           child: Column(
//             children: [
//               /// create new address
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: GestureDetector(
//                   onTap: () {},
//                   child: Container(
//                     height: height*(0.07),
//                     width: double.infinity,
//                     alignment: Alignment.center,
//                     color: AppColor.grey.withOpacity(0.1),
//                     child: const Text(
//                       "Add New Address",
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//               ),
//
//                SizedBox(
//                 height: height*0.02,
//               ),
//               /// address list
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: 3,
//                   physics: const BouncingScrollPhysics(),
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: EdgeInsets.only(bottom: height*(0.025)),
//                       child: Row(
//                         children: [
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(10),
//                             child: Container(
//                               height: height*(0.07),
//                               width: height*(0.07),
//                               decoration: const BoxDecoration(
//                                 image: DecorationImage(
//                                   image: AssetImage(
//                                     AppImage.location,
//                                   ),
//                                 ),
//                               ),
//                               child: const Icon(
//                                 Icons.location_on_outlined,
//                                 color: AppColor.orange,
//                                 size: 30,
//                               ),
//                             ),
//                           ),
//                            SizedBox(
//                             width: width*0.03,
//                           ),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   "Chhatak, Sunamgonj 12/8AB",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                   maxLines: 1,
//                                 ),
//                                  SizedBox(
//                                   height: height*0.005,
//                                 ),
//                                 const Text(
//                                   "Surat",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: AppColor.grey,
//                                   ),
//                                   maxLines: 1,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Radio(
//                             value: index,
//                             groupValue: selectedIndex,
//                             onChanged: (value) {
//                               setState(() {
//                                 selectedIndex = index;
//                               });
//                             },
//                             activeColor: AppColor.green,
//                           )
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
