// SingleChildScrollView(
//           child: Column(
//             children: [
//               ElevatedButton(
//                   onPressed: () {
//                     // Get.to(Api());
//                   },
//                   child: Text('click here')),
//               Container(
//                 width: double.infinity,
//                 height: 200,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment(0.00, -1.00),
//                     end: Alignment(0, 1),
//                     colors: [Color(0xFF152D5E), Color(0x00152D5E)],
//                   ),
//                 ),
//                 child: Center(
//                     child: CircleAvatar(
//                   radius: 80,
//                   child: Icon(
//                     Icons.account_circle,
//                     size: 160,
//                   ),
//                 )),
//               ),
//               Card(
//                 elevation: 15,
//                 child: Container(
//                   width: 327,
//                   height: 370,
//                   decoration: ShapeDecoration(
//                     color: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     shadows: [
//                       BoxShadow(
//                         color: Color(0x26000000),
//                         blurRadius: 4,
//                         offset: Offset(0, 4),
//                         spreadRadius: 0,
//                       )
//                     ],
//                   ),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         ListTile(
//                           onTap: () => Navigator.of(context).push(
//                               MaterialPageRoute(
//                                   builder: (BuildContext context) {
//                             return NameChange();
//                           })),
//                           leading: Image.asset(
//                             'assets/personalIcons/profile.png',
//                             height: 23,
//                           ),
//                           title: Text('Name'),
//                           subtitle: Text('hhjh'),
//                           trailing: Icon(CupertinoIcons.pen),
//                         ),
//                         ListTile(
//                           onTap: () => Navigator.of(context).push(
//                               MaterialPageRoute(
//                                   builder: (BuildContext context) {
//                             return PhoneNumberChange();
//                           })),
//                           leading: Image.asset(
//                             'assets/personalIcons/mail.png',
//                             height: 23,
//                           ),
//                           title: Text('Phone'),
//                           subtitle: Text('+91------xxx5'),
//                           trailing: Icon(CupertinoIcons.pen),
//                         ),
//                         ListTile(
//                           onTap: () => Navigator.of(context).push(
//                               MaterialPageRoute(
//                                   builder: (BuildContext context) {
//                             return EmailChange();
//                           })),
//                           leading: Image.asset(
//                             'assets/personalIcons/mail.png',
//                             height: 23,
//                           ),
//                           title: Text('E-mail Address'),
//                           subtitle: Text('syncverse@gmail.com'),
//                           trailing: Icon(CupertinoIcons.pen),
//                         ),
//                         ListTile(
//                           onTap: () => Navigator.of(context).push(
//                               MaterialPageRoute(
//                                   builder: (BuildContext context) {
//                             return AddressChange();
//                           })),
//                           leading: Image.asset(
//                             'assets/personalIcons/location.png',
//                             height: 23,
//                           ),
//                           title: Text('Location'),
//                           subtitle: Text('Delhi'),
//                           trailing: Icon(CupertinoIcons.pen),
//                         ),
//                         ListTile(
//                           onTap: () => Navigator.of(context).push(
//                               MaterialPageRoute(
//                                   builder: (BuildContext context) {
//                             return PlaceChange();
//                           })),
//                           leading: Image.asset(
//                             'assets/personalIcons/hotel.png',
//                             height: 23,
//                           ),
//                           title: Text('Place of use'),
//                           subtitle: Text('Hotel'),
//                           trailing: Icon(CupertinoIcons.pen),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         );