import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Places1 extends StatelessWidget {
  const Places1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF0E5D4),
      appBar: AppBar(
      leading: IconButton( onPressed: (){ Navigator. pop(context); }, icon:const Icon(Icons. arrow_back_ios)), //replace with our own icon data. )
        title: const Text(
          " Temple Places ",
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
        currentIndex: 1,
        fixedColor: Colors.black,
        selectedFontSize: 20,
      ),


      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          buildImageCard6(),
          buildImageCard62(),
          buildImageCard63(),
          buildImageCard64(),
          buildImageCard65(),
          buildImageCard66(),


        ],
      ),

    );
  }


  Widget buildImageCard6() => Card(
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    child: Stack(
      alignment: Alignment.center,
      children: [
        Ink.image(
          image: const NetworkImage(
            'https://cdn.britannica.com/88/124388-050-EFAFCE59/Hieroglyphs-temple-Ombos-Egypt.jpg',
          ),
          child: InkWell(
            onTap: () {},
          ),
          height: 150,
          fit: BoxFit.cover,
        ),
        const Text(
          'The Egyption Museum',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 45,
          ),
        ),
      ],
    ),
  );
  Widget buildImageCard62() => Card(
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    child: Stack(
      alignment: Alignment.center,
      children: [
        Ink.image(
          image: const NetworkImage(
            'https://media.istockphoto.com/id/1387319252/vector/egypt-stone-statue-set-vector-ancient-rock-ruin-pharaoh-clay-figurine-egyptian-gods.jpg?s=1024x1024&w=is&k=20&c=xFG-QKhdZu-LsD5BkOezDcEl9xgiYVBe2W5Yj786IqM=',
          ),
          child: InkWell(
            onTap: () {},
          ),
          height: 150,
          fit: BoxFit.cover,
        ),
        const Text(
          'Statue Recognation ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 45,
          ),
        ),
      ],
    ),
  );
  Widget buildImageCard63() => Card(
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    child: Stack(
      alignment: Alignment.center,
      children: [
        Ink.image(
          image: const NetworkImage(
            'https://cdn.britannica.com/88/124388-050-EFAFCE59/Hieroglyphs-temple-Ombos-Egypt.jpg',
          ),
          child: InkWell(
            onTap: () {},
          ),
          height: 150,
          fit: BoxFit.cover,
        ),
        const Text(
          'Templet Places',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 45,
          ),
        ),
      ],
    ),
  );
  Widget buildImageCard64() => Card(
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    child: Stack(
      alignment: Alignment.center,
      children: [
        Ink.image(
          image: const NetworkImage(
            'https://cdn.britannica.com/88/124388-050-EFAFCE59/Hieroglyphs-temple-Ombos-Egypt.jpg',
          ),
          child: InkWell(
            onTap: () {},
          ),
          height: 150,
          fit: BoxFit.cover,
        ),
        const Text(
          'Trips',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 45,
          ),
        ),
      ],
    ),
  );
  Widget buildImageCard65() => Card(
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    child: Stack(
      alignment: Alignment.center,
      children: [
        Ink.image(
          image: const NetworkImage(
            'https://cdn.britannica.com/88/124388-050-EFAFCE59/Hieroglyphs-temple-Ombos-Egypt.jpg',
          ),
          child: InkWell(
            onTap: () {},
          ),
          height: 150,
          fit: BoxFit.cover,
        ),
        const Text(
          'Trips',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 45,
          ),
        ),
      ],
    ),
  );
  Widget buildImageCard66() => Card(
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    child: Stack(
      alignment: Alignment.center,
      children: [
        Ink.image(
          image: const NetworkImage(
            'https://cdn.britannica.com/88/124388-050-EFAFCE59/Hieroglyphs-temple-Ombos-Egypt.jpg',
          ),
          child: InkWell(
            onTap: () {},
          ),
          height: 150,
          fit: BoxFit.cover,
        ),
        const Text(
          'Trips',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 45,
          ),
        ),
      ],
    ),
  );

}
