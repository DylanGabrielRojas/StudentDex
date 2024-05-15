import 'package:flutter/material.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  const TopBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(50);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.red,
      leading: IconButton(
        icon: const Icon(
          Icons.account_circle,
          color: Colors.white,
        ),
        onPressed: () {Navigator.pushNamed(context, '/login');},
      ),
      title: const Center(
        child: Text(
          "StudentDex",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "PokemonSolid",
            fontSize: 30,
            letterSpacing: 4,
          ),
        ),
      ),
    );
  }
}
