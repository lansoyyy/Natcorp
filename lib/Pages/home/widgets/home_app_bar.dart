import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:natcorp/Pages/notif/notif_page.dart';
import 'package:natcorp/widgets/text_widget.dart';

class HomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          left: 25,
          right: 25,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Welcome home',
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Princess Villegas',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                )
              ],
            ),

            //Notification
            Row(
              children: [
                Badge(
                  badgeContent:
                      TextRegular(text: '1', fontSize: 12, color: Colors.white),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const NotifPage()));
                    },
                    icon: const Icon(
                      Icons.notifications_none_outlined,
                      size: 30,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
