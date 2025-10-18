import 'package:flutter/material.dart';
import 'package:firstapp1/components/profile_card.dart';

class SimpleCustomWidget extends StatelessWidget {
  const SimpleCustomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Widget')),
      body: Center(
        child: ProfileCard(
          name: 'Chalanthon Phetrain',
          position: 'TikTok star',
          email: 'fernfern5304@gmail.com',
          phoneNumber: '0971462601',
          imageUrl:
              'https://scontent.fbkk17-1.fna.fbcdn.net/v/t39.30808-6/336243590_1664112900708491_6433300951468557348_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=6ee11a&_nc_eui2=AeGZXwEokybG6dDjinWoDPjFkHZeAl8kFASQdl4CXyQUBAhIdAYtITacM3kXvAebM7dVVa4Km6djYjsyn1HNbtSE&_nc_ohc=WyM2d11xQZYQ7kNvwFv9h0C&_nc_oc=AdkbD6o9n0tFlMJLOPkIk6WBrS61kgqHEq3x_akRQ6btBDlnRmLnqq2rHZS0zpD3ICY&_nc_zt=23&_nc_ht=scontent.fbkk17-1.fna&_nc_gid=9ICEUtqNmWPhwlZ1HVrjnA&oh=00_Afe8JEvbYGfk-GGoYD5BLSugH8jGg2uWGbPzwRkONaVGew&oe=68F8D301',
        ),
      ),
    );
  }
}
