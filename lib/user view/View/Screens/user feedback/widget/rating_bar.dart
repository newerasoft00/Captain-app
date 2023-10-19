import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

Widget ratingBarWidget(
    {required ValueSetter<double> onRatingUpdate,
    required double initialRating}) {
  return RatingBar.builder(
    initialRating: initialRating,
    minRating: 0.5,
    direction: Axis.horizontal,
    allowHalfRating: true,
    itemCount: 5,
    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
    itemBuilder: (context, _) => const Icon(
      Icons.star_rounded,
      color: Colors.amber,
    ),
    onRatingUpdate: onRatingUpdate,
  );
}
