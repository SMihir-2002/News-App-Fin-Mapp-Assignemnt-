import "package:flutter/material.dart";

class NewsTile extends StatelessWidget {
  const NewsTile(
      {super.key,
      required this.size,
      required this.title,
      required this.imgUrl,
      required this.description});

  final Size size;
  final String title;
  final String imgUrl;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: size.height * 0.3,
          width: double.infinity,
          child: Image.network(
            imgUrl,
            fit: BoxFit.fill,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
                height: 1,
                width: double.infinity,
                color: Colors.black.withOpacity(0.8),
              ),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 18,
                ),
                maxLines: 7,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ],
    );
    
  }
}
