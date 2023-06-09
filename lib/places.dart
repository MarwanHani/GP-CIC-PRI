

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:gp_cic/StatusRecognition.dart';
import 'package:gp_cic/notifications.dart';
import 'package:gp_cic/places3.dart';

import 'package:gp_cic/RemoteServices/Api.dart';
import 'package:gp_cic/places1.dart';
import 'package:gp_cic/places3.dart';
import 'package:gp_cic/profile_page.dart';
import 'package:gp_cic/trips.dart';

class Places extends StatefulWidget {
  final String token;
  final String type;
  final String name;
  final String email;

  const Places({Key? key,required this.token , required this.type,required this.name , required this.email }) : super(key: key);

  @override
  State<Places> createState() => _PlacesState();

}

class _PlacesState extends State<Places> {

  @override

  int _selectedIndex = 1;



  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Perform actions based on the selected index
      if (_selectedIndex == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  Notifications(token: widget.token,)),
        );

      } else if (_selectedIndex == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>Places(token: widget.token, type: widget.type ,name: "",email: "",)),
        );


      } else if (_selectedIndex == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  Profile(name: widget.name,email: widget.email,token: widget.token,type: widget.type,)),
        );

      }
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF0E5D4),
      appBar: AppBar(
        title: const Text(
          "Amun",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.normal,
          ),
        ),
        backgroundColor: const Color(0xffAD8B73),
      ),
      bottomNavigationBar: BottomNavigationBar(

        backgroundColor: const Color(0xffAD8B73),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        fixedColor: Colors.black,
        selectedFontSize: 20,
      ),
      body: ListView(
    padding: const EdgeInsets.all(16),
    children: [
        buildImageCard(),
      buildImageCard2(),
      Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Ink.image(
              image: const NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6cGfuFPkt6-rvq-igMdro_6TU8v00ftmfxw&usqp=CAU',
              ),
              height: 150,
              fit: BoxFit.cover,
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Places3(token: widget.token,)),
                    );
                  }
              ),
            ),
            const Text(
              'Temple Places',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 35,
              ),
            ),
          ],
        ),
      ),
      buildImageCard4(),
    ],
    ),

    );
  }

  Widget buildImageCard() => Card(
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    child: Stack(
      alignment: Alignment.center,
      children: [
        Ink.image(
          image: const NetworkImage(
            'https://image.jimcdn.com/app/cms/image/transf/dimension=1040x10000:format=jpg/path/s2217cd0bb1220415/image/i3e72eddc44cdfeaa/version/1652918268/image.jpg',
          ),
          height: 150,
          fit: BoxFit.cover,
          child: InkWell(
            onTap: () {

            },
          ),
        ),
        const Text(
          'Hiroghliphics Translation',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 35,
          ),
        ),
      ],
    ),
  );

  Widget buildImageCard2() => Card(
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    child: Stack(
      alignment: Alignment.center,
      children: [
        Ink.image(
          image: const NetworkImage(
            'https://i.pngimg.me/thumb/f/720/5e8eb6d8e63b4c6ba120.jpg',
          ),
          height: 150,
          fit: BoxFit.cover,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StatuseRecognition(token: widget.token)),
              );
            },
          ),
        ),
        const Text(
          'Statue Recognation ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 35,
          ),
        ),
      ],
    ),
  );

  /*Widget buildImageCard3() => Card(
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    child: Stack(
      alignment: Alignment.center,
      children: [
        Ink.image(
          image: NetworkImage(
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6cGfuFPkt6-rvq-igMdro_6TU8v00ftmfxw&usqp=CAU',
          ),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed('places3');
            }
          ),
          height: 150,
          fit: BoxFit.cover,
        ),
        Text(
          'Templet Places',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 35,
          ),
        ),
      ],
    ),
  );*/
  Widget buildImageCard4() => Card(
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    child: Stack(
      alignment: Alignment.center,
      children: [
        Ink.image(
          image: const NetworkImage(
            'https://static.vecteezy.com/system/resources/previews/002/397/391/non_2x/tourist-take-photo-of-pyramids-in-egypt-vector.jpg',
          ),
          height: 150,
          fit: BoxFit.cover,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Trips(type: widget.type,token: widget.token,minPrice: "",maxPrice: "",placeName: "",)),
              );
            },
          ),
        ),
        const Text(
          'Trips',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 35,
          ),
        ),
      ],
    ),
  );

}
