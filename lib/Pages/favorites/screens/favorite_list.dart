import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:natcorp/Pages/favorites/models/favorite_list_models.dart';
import 'package:natcorp/Pages/favorites/models/favorite_page_models.dart';
import 'package:provider/provider.dart';

class FavoriteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme.headline6;

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites', style: Theme.of(context).textTheme.headline1),
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.bookmark_border_outlined),
          //   // code of navigation to favorite page //
          //   onPressed: () => Navigator.pushNamed(context, '/favoritepage'),
          // ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Company')
              .where('fav',
                  arrayContains: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              print('error');
              return const Center(child: Text('Error'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              print('waiting');
              return const Padding(
                padding: EdgeInsets.only(top: 50),
                child: Center(
                    child: CircularProgressIndicator(
                  color: Colors.black,
                )),
              );
            }

            final data = snapshot.requireData;
            return ListView.builder(
              itemCount: snapshot.data?.size ?? 0,
              itemBuilder: (BuildContext context, int index) {
                List fav = data.docs[index]['fav'];
                // to call MyListItem widget //
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: LimitedBox(
                    maxHeight: 60,
                    child: Row(
                      children: [
                        AspectRatio(
                          aspectRatio: 1,
                          child: Image.network(data.docs[index]['companyLogo']),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data.docs[index]['companyName'],
                                  style: textTheme),
                              Text(data.docs[index]['position'],
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 24),
                        fav.contains(FirebaseAuth.instance.currentUser!.uid) ==
                                false
                            ? GestureDetector(
                                onTap: (() {
                                  FirebaseFirestore.instance
                                      .collection('Company')
                                      .doc(data.docs[index].id)
                                      .update({
                                    'fav': FieldValue.arrayUnion([
                                      FirebaseAuth.instance.currentUser!.uid,
                                    ]),
                                  });
                                }),
                                child: Icon(
                                  fav.contains(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      ? Icons.bookmark
                                      : Icons.bookmark_outline_outlined,
                                  color: fav.contains(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      ? Theme.of(context).primaryColor
                                      : Colors.black,
                                ),
                              )
                            : GestureDetector(
                                onTap: (() {
                                  FirebaseFirestore.instance
                                      .collection('Company')
                                      .doc(data.docs[index].id)
                                      .update({
                                    'fav': FieldValue.arrayRemove([
                                      FirebaseAuth.instance.currentUser!.uid,
                                    ]),
                                  });
                                }),
                                child: Icon(
                                  fav.contains(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      ? Icons.bookmark
                                      : Icons.bookmark_outline_outlined,
                                  color: fav.contains(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      ? Theme.of(context).primaryColor
                                      : Colors.black,
                                ),
                              )
                      ],
                    ),
                  ),
                );
              },
              // to specify count the list show //
            );
          }),
    );
  }
}

// UI of MyListItem widget //
class _MyListItem extends StatelessWidget {
  final int index;

  const _MyListItem(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var item = context.select<FavoriteListModel, Item>(
      // Here, we are only interested in the item at [index]. We don't favorite page
      // about any other change.
      (favoritelist) => favoritelist.getByPosition(index),
    );
    var textTheme = Theme.of(context).textTheme.headline6;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 60,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Image.asset(item.image),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name, style: textTheme),
                  Text(item.subtitle,
                      style: TextStyle(fontSize: 16, color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(width: 24),
            // to call AddButton widget //
            _AddButton(item: item),
          ],
        ),
      ),
    );
  }
}

// UI of AddButton widget //
class _AddButton extends StatelessWidget {
  final Item item;

  const _AddButton({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // The context.select() method will let you listen to changes to
    // a *part* of a model. You define a function that "selects" (i.e. returns)
    // the part you're interested in, and the provider package will not rebuild
    // this widget unless that particular part of the model changes.
    //
    // This can lead to significant performance improvements.
    var isInFavoritePage = context.select<FavoritePageModel, bool>(
      // Here, we are only interested whether [item] is inside the favorite page.
      (favoritepage) => favoritepage.items.contains(item),
    );

    return IconButton(
      icon: isInFavoritePage
          ? Icon(Icons.bookmark, color: Colors.green)
          : Icon(Icons.bookmark_border_outlined),
      onPressed: isInFavoritePage
          ? () {
              // To make the user removes the favorite item not only from the favorite page but also from the favorite list
              // We are using context.read() here because the callback
              // is executed whenever the user taps the button. In other
              // words, it is executed outside the build method.
              var favoritepage = context.read<FavoritePageModel>();
              favoritepage.remove(item);
            }
          : () {
              // If the item is not in favorite page, we let the user add it.
              // We are using context.read() here because the callback
              // is executed whenever the user taps the button. In other
              // words, it is executed outside the build method.
              var favoritepage = context.read<FavoritePageModel>();
              favoritepage.add(item);
            },
    );
  }
}
