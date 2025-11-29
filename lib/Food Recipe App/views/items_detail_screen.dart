import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:ui_practices/Food%20Recipe%20App/models/ingredients.dart';
import 'package:ui_practices/Food%20Recipe%20App/models/recipe_model.dart';

class ItemsDetailScreen extends StatefulWidget {
  final RecipeItems recipeItems;
  const ItemsDetailScreen({super.key, required this.recipeItems});

  @override
  State<ItemsDetailScreen> createState() => _ItemsDetailScreenState();
}

class _ItemsDetailScreenState extends State<ItemsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        child: Stack(
          children: [
            Container(
              height: size.height * 0.55,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.recipeItems.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 50,
              left: 20,
              child: CircleAvatar(
                backgroundColor: Colors.black38,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back_ios_new_sharp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: size.height * 0.5,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(60),
                  ),
                  color: Colors.white,
                ),
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundImage: NetworkImage(
                            widget.recipeItems.woner,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                widget.recipeItems.wonerName,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                '12 Recipes Shared',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black.withValues(alpha: 0.5),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${widget.recipeItems.rate}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 5),
                                RatingBar.builder(
                                  itemSize: 15,
                                  initialRating: widget.recipeItems.rate,
                                  unratedColor: Colors.grey.shade400,
                                  itemBuilder: (context, index) {
                                    return Icon(
                                      Icons.star,
                                      color: Colors.amberAccent,
                                    );
                                  },
                                  onRatingUpdate: (value) {},
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Text(
                              "${widget.recipeItems.reviews} Reviews",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              widget.recipeItems.name,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "${widget.recipeItems.weight}g",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black45,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Text(
                          "See details",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyProgressIndicatorValue(
                          name: 'Carbs',
                          amount: "${widget.recipeItems.carb} g",
                          percentage: "(56%)",
                          color: Colors.green,
                          data: 0.4,
                        ),
                        MyProgressIndicatorValue(
                          name: 'Fat',
                          amount: "${widget.recipeItems.fat} g",
                          percentage: "(72%)",
                          color: Colors.red,
                          data: 0.6,
                        ),
                        MyProgressIndicatorValue(
                          name: 'Protein',
                          amount: "${widget.recipeItems.carb} g",
                          percentage: "(8%)",
                          color: Colors.orange,
                          data: 0.2,
                        ),
                        MyProgressIndicatorValue(
                          color: Colors.green,
                          name: 'Calories',
                          amount: '${widget.recipeItems.calorie} kkal',
                          percentage: "",
                          data: 0.7,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    rowSectionDivider(
                      leftText: 'Ingredients',
                      rightText: 'See Details',
                    ),
                    SizedBox(height: 20),
                    ingredientsItems(),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: size.height * 0.5,
              child: ClipPath(
                clipper: MyClipper(),
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(color: Colors.white),
                ),
              ),
            ),
            Positioned(
              right: 30,
              bottom: size.height * 0.48,
              child: Container(
                padding: EdgeInsets.all(7),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.recipeItems.fav ? Colors.red : Colors.black38,
                  boxShadow: [
                    BoxShadow(color: Colors.grey.shade200, spreadRadius: 5),
                  ],
                ),
                child: Icon(Icons.favorite, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyProgressIndicatorValue extends StatelessWidget {
  final String? name, amount;
  final String percentage;
  final Color color;
  final double data;
  const MyProgressIndicatorValue({
    super.key,
    required this.name,
    required this.amount,
    required this.percentage,
    required this.color,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 20,
      circularStrokeCap: CircularStrokeCap.round,
      percent: data,
      lineWidth: 7,
      reverse: true,
      backgroundColor: color.withOpacity(0.2),
      animation: true,
      animationDuration: 500,
      restartAnimation: true,
      progressColor: color,
      header: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Text(
          name!,
          style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 12),
        ),
      ),
      footer: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '$amount ',
                style: const TextStyle(color: Colors.black, fontSize: 12),
              ),
              TextSpan(
                text: percentage,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.quadraticBezierTo(0, size.height, 0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

// 🔵 Popular Text Row
Padding rowSectionDivider({String? leftText, String? rightText}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          leftText!,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          rightText ?? '',
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

SingleChildScrollView ingredientsItems() {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: List.generate(
        ingredients.length,
        (index) => Padding(
          padding: index == 0
              ? EdgeInsetsGeometry.only(left: 20, right: 10)
              : EdgeInsetsGeometry.only(right: 20),
          child: Column(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: ingredients[index].color,
                child: Image.asset(
                  ingredients[index].image,
                  fit: BoxFit.cover,
                  height: 40,
                  width: 40,
                ),
              ),
              SizedBox(height: 5),
              Text(
                ingredients[index].name,
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
