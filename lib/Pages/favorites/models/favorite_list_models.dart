/// A proxy of the favorite list of items the user can buy.
///
/// In a real app, this might be backed by a backend and cached on device.
/// In this sample app, the favorite list is procedurally generated and infinite.
///
/// For simplicity, the favorite list is expected to be immutable (no Lists are
/// expected to be added, removed or changed during the execution of the app).
class FavoriteListModel {
  // change the list title from here in order with image path and subtitle //
  static List<String> itemNames = [
    'Google LLC,',
    'Airbnb inc',
    'Linked corp',
    'Bootstrap',
    'C-sharp',
    'Flutter Apps',
    'intellij-idea',
    'java-coffee',
    'json',
    'kotlin',
    'PHP Designer',
    'python',
    'React Native',
    'Stack over flow',
    'Unity 5',
  ];

  // change the list subtitle from here in order with name and image path //
  static List<String> itemSubtitle = [
    'some app for any developer',
    'some app for any developer',
    'some app for any developer',
    'some app for any developer',
    'some app for any developer',
    'some app for any developer',
    'some app for any developer',
    'some app for any developer',
    'some app for any developer',
    'some app for any developer',
    'some app for any developer',
    'some app for any developer',
    'some app for any developer',
    'some app for any developer',
    'some app for any developer',
  ];

  // change or add the image path from here in order with name and subtitle //
  static List<String> itemImages = [
    ("assets/images/google_logo.png"),
    ("assets/images/airbnb_logo.png"),
    ("assets/images/linkedin_logo.png"),
    ("assets/favorites/bootstrap.png"),
    ("assets/favorites/c-sharp.png"),
    ("assets/favorites/flutter.png"),
    ("assets/favorites/intellij-idea.png"),
    ("assets/favorites/java.png"),
    ("assets/favorites/json.png"),
    ("assets/favorites/kotlin.png"),
    ("assets/favorites/php-designer.png"),
    ("assets/favorites/python.png"),
    ("assets/favorites/react-native.png"),
    ("assets/favorites/stackoverflow.png"),
    ("assets/favorites/unity-5.png"),
  ];

  /// Get item by [id].
  ///
  /// In this sample, the catalog is infinite, looping over [itemNames].
  Item getById(int id) => Item(
        id,
        itemNames[id % itemNames.length],
        itemSubtitle[id % itemSubtitle.length],
        itemImages[id % itemImages.length],
      );

  /// Get item by its position in the List.
  Item getByPosition(int position) {
    // In this simplified case, an item's position in the List
    // is also its id.
    return getById(position);
  }
}

class Item {
  final int id;
  final String name;
  final String subtitle;
  final String image;

  const Item(
    this.id,
    this.name,
    this.subtitle,
    this.image,
  );

  // To make the sample app look nicer, each item is given id ,name and icon.

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Item && other.id == id;
}
