import 'package:flutter/material.dart';
import '../models/data_models.dart';

class RoomsProvider with ChangeNotifier {
  final List<Room> _rooms = [
    Room(
      id: '1',
      name: 'The Bridal Lounge',
      image:
          'https://images.weserv.nl/?url=https://i.pinimg.com/1200x/8e/f7/cb/8ef7cbdf58b59b5183b1456d5d3cc805.jpg',
    ),
    Room(
      id: '2',
      name: 'Diamond Vault',
      image:
          'https://images.weserv.nl/?url=https://i.pinimg.com/1200x/a5/c3/c6/a5c3c62788cbdc79c5d4b9f5973962e8.jpg',
    ),
    Room(
      id: '3',
      name: 'Vintage Gallery',
      image:
          'https://images.weserv.nl/?url=https://i.pinimg.com/1200x/67/4a/24/674a24be75ae9470234c9fbefe1e3246.jpg',
    ),
  ];

  List<Room> get rooms => [..._rooms];

  void addRoom(String name, String image) {
    final newRoom = Room(
      id: DateTime.now().toString(),
      name: name,
      image: image,
    );
    _rooms.add(newRoom);
    notifyListeners();
  }

  void addProductToRoom(String roomId, ProductItem product) {
    final roomIndex = _rooms.indexWhere((r) => r.id == roomId);
    if (roomIndex >= 0) {
      final room = _rooms[roomIndex];
      // Create a new list for products to trigger any listeners if they were observing the list itself
      final updatedProducts = [...room.products, product];
      _rooms[roomIndex] = Room(
        id: room.id,
        name: room.name,
        image: room.image,
        products: updatedProducts,
      );
      notifyListeners();
    }
  }
}
