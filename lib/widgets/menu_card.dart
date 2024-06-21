import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/menu_bloc.dart';

class MenuItemCard extends StatelessWidget {
  final String item;
  final double? price;

  const MenuItemCard({
    super.key,
    required this.item,
    this.price,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (price != null) {
          context.read<MenuCubit>().addItem(item, price!);
        } else {
          // Example items for Bento Box
          List<Map<String, dynamic>> bentoBoxItems = [
            {'name': 'CHICKEN (GRILLED) BENTO BOX', 'price': 17.0},
            {'name': 'CHICKEN TEMPURA BENTO BOX', 'price': 17.0},
            {'name': 'FRIED TOFU BENTO BOX', 'price': 15.0},
            {'name': 'GRILLED TOFU BENTO BOX', 'price': 15.0},
            {'name': 'SALMON BENTO BOX', 'price': 16.0},
            {'name': 'SHRIMP (GRILLED) BENTO BOX', 'price': 17.0},
            {'name': 'SHRIMP (TEMPURA) BENTO BOX', 'price': 17.0},
            {'name': 'STEAK BENTO BOX', 'price': 18.0},
          ];
          if (item == 'BENTO BOX') {
            context.read<MenuCubit>().showMenu(item, bentoBoxItems);
          } else {
            context.read<MenuCubit>().showMenu(item, []);
          }
        }
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image.network(
                getMenuImageUrl(item),
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  item,
                  style: const TextStyle(fontSize: 10),
                ),
              ),
              if (price != null)
                Text('\$${price!.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 10)),
            ],
          ),
        ),
      ),
    );
  }

  String getMenuImageUrl(String itemName) {
    switch (itemName) {
      case 'BENTO BOX':
        return 'https://static01.nyt.com/images/2023/10/18/multimedia/EP-Air-fryer-chicken-tenders-cpmw/EP-Air-fryer-chicken-tenders-cpmw-superJumbo.jpg';
      case 'BUILD YOUR OWN RAMEN':
        return 'https://assets.tmecosys.com/image/upload/t_web767x639/img/recipe/ras/Assets/D990CCF4-0830-4357-B5F3-C28E8E184E9B/Derivates/e4dff957-d125-4f18-93f2-b1c82a36d7e0.jpg';
      case 'CHEESECAKE SERIES':
        return 'https://cdn.yemek.com/mnresize/1250/833/uploads/2023/10/frambuazli-cheesecake-yemekcom.jpg';
      case 'DESSERTS':
        return 'https://realfood.tesco.com/media/images/RFO-1400x919-classic-chocolate-mousse-69ef9c9c-5bfb-4750-80e1-31aafbd80821-0-1400x919.jpg';
      case 'DRINKS':
        return 'https://hips.hearstapps.com/hmg-prod/images/ice-tea-royalty-free-image-1621872849.jpg?resize=980:*';
      case 'EXTRAS':
        return 'https://cultmtl.com/wp-content/uploads/2021/04/Menu-Extra-dishes.jpeg';
      case 'FRUIT TEA':
        return 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSywkQZMv_tdv7tkX2wSbLjwqHTyc67mV5JqQ&s';
      case 'HANG-IN RAMEN':
        return 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2hHpYL0lmujDjPqm1iIvbpYftpvqNVbnUhQ&s';
      case 'JAM MILKY':
        return 'https://www.irishtimes.com/resizer/Pq5GMhR-Z1kHiFgjWcDIdp7PX0U=/1600x1600/filters:format(jpg):quality(70)/cloudfront-eu-central-1.images.arcpublishing.com/irishtimes/XDUQQO2UXX4SMCPC7XRYX36S24.jpg';
      case 'JAPANESE GRILLE':
        return 'https://kokorocares.com/cdn/shop/articles/25385778_s_640x.jpg?v=1677664324';
      case 'KID MENU':
        return 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqBH2v-Q-AarDWr-5zeBpnssisgfw_xqUI1g&s';
      case 'LEMONADE PARADISE':
        return 'https://www.sigaretnet.by/images/news/obzor/lemonade-paradise-salt.jpg';
      default:
        return 'https://img.freepik.com/free-vector/modern-restaurant-menu-fast-food_52683-48982.jpg';
    }
  }
}
