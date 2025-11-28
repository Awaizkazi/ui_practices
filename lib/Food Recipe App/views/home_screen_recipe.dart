import 'package:flutter/material.dart';
import 'package:ui_practices/Food%20Recipe%20App/colors/colors.dart';
import 'package:ui_practices/Food%20Recipe%20App/models/categories_recipe.dart';
import 'package:ui_practices/Food%20Recipe%20App/models/recipe_model.dart';

class HomeScreenRecipe extends StatefulWidget {
  const HomeScreenRecipe({super.key});

  @override
  State<HomeScreenRecipe> createState() => _HomeScreenRecipeState();
}

class _HomeScreenRecipeState extends State<HomeScreenRecipe> {
  int selectedIndex = 0;
  int selectedIndexBottomNav = 0;
  void _onItemTapped(int index) {
    setState(() {
      selectedIndexBottomNav = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: recipeAppBackgroundColor,
      body: SafeArea(
        child: ListView(
          children: [
            headerParts(),
            const SizedBox(height: 20),
            mySearchField(),
            const SizedBox(height: 30),
            rowSectionDivider('Popular menus', 'See all'),
            const SizedBox(height: 20),
            popularMenuItems(),
            const SizedBox(height: 20),

            // MAIN CARD LIST
            recipeImageCard(context),
            const SizedBox(height: 20),
            rowSectionDivider('Categories', 'See all'),
            const SizedBox(height: 10),
            categoryItems(),
            const SizedBox(height: 10),
            chefInformationDetails(),
            const SizedBox(height: 10),
          ],
        ),
      ),
      bottomNavigationBar: bottomNavBar(),
    );
  }

  BottomNavigationBar bottomNavBar() {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart_rounded),
          label: 'Business',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border_outlined),
          label: 'Favoriates',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline_rounded),
          label: 'Favoriates',
        ),
      ],
      currentIndex: selectedIndexBottomNav,
      unselectedItemColor: Colors.black87,
      selectedItemColor: Colors.green[400],
      onTap: _onItemTapped,

      showUnselectedLabels: true,
    );
  }

  Padding chefInformationDetails() {
    return Padding(
      padding: EdgeInsetsGeometry.all(40),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(
                  'https://media.istockphoto.com/id/1213660289/photo/young-beautiful-chinese-chef-woman-wearing-cooker-uniform-and-hat-holding-tray-with-dome-with.jpg?s=612x612&w=0&k=20&c=Acr3SpWXvGhElDWXTo2Z7hfc7jpUQrXJuOs9SzuZEHA=',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hona Ci Minh',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Expert Chef',
                style: TextStyle(color: Colors.black.withValues(alpha: 0.5)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  SingleChildScrollView categoryItems() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          recipeCategory.length,
          (index) => Padding(
            padding: index == 0
                ? EdgeInsetsGeometry.only(left: 20, right: 20)
                : EdgeInsetsGeometry.only(right: 20),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 33,
                  backgroundColor: recipeCategory[index].color,
                  child: Image.asset(
                    recipeCategory[index].image,
                    fit: BoxFit.cover,
                    height: 40,
                    width: 40,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  recipeCategory[index].name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox recipeImageCard(BuildContext context) {
    return SizedBox(
      height: 250,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(recipeItems.length, (index) {
            final recipe = recipeItems[index];

            return Padding(
              padding: index == 0
                  ? const EdgeInsets.only(left: 20, right: 10)
                  : const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width / 2.45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage(recipe.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      /// ⬆️Top FAV BUTTON
                      Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: recipe.fav ? Colors.red : Colors.black38,
                        ),
                        child: Icon(
                          Icons.favorite_border_outlined,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),

                      /// 🔽 This pushes bottom content to bottom cleanly
                      const Spacer(),

                      /// 🔽 Bottom Info Box
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black45,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    recipe.name,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amberAccent,
                                      size: 18,
                                    ),
                                    Text(
                                      "${recipe.rate}",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 3),
                            Text(
                              "1 Bow(${recipe.weight}g)",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              "${recipe.calorie} Kkal | 25% AKL",
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  // 🔵 Popular Text Row
  Padding rowSectionDivider(String leftText, String rightText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leftText,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            rightText,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  // 🔵 Menu Filter Buttons
  SingleChildScrollView popularMenuItems() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          menuItems.length,
          (index) => Padding(
            padding: const EdgeInsets.only(left: 20),
            child: GestureDetector(
              onTap: () {
                setState(() => selectedIndex = index);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [
                      selectedIndex == index ? Colors.green : Colors.white,
                      selectedIndex == index
                          ? Colors.greenAccent
                          : Colors.white,
                    ],
                  ),
                ),
                child: Text(
                  menuItems[index],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: selectedIndex == index
                        ? FontWeight.bold
                        : FontWeight.w500,
                    color: selectedIndex == index ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 🔵 Search Bar
  Padding mySearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: searchBarColor,
        ),
        child: const TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: Colors.black45),
            hintText: "Search",
            hintStyle: TextStyle(color: Colors.black26),
            contentPadding: EdgeInsets.symmetric(vertical: 10),
          ),
        ),
      ),
    );
  }

  // 🔵 Header Section
  Padding headerParts() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          const Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "Hello Peter,\n",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: "What do you want to eat today?",
                  style: TextStyle(fontSize: 13, color: Colors.black45),
                ),
              ],
            ),
          ),
          const Spacer(),
          Stack(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  'https://thumbs.dreamstime.com/b/profile-picture-caucasian-male-employee-posing-office-happy-young-worker-look-camera-workplace-headshot-portrait-smiling-190186649.jpg',
                ),
              ),
              Positioned(
                right: 1,
                top: 1,
                child: Container(
                  height: 9,
                  width: 9,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                    border: Border.all(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
