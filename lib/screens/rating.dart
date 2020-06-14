import 'package:flutter/material.dart';

class RatingBox extends StatefulWidget {
  @override
  _RatingBoxState createState() => _RatingBoxState();
}

class _RatingBoxState extends State<RatingBox> {
  int _rating = 0;

  void _setRatingAsOne() {
    setState(() {
      _rating = 1;
    });
  }

  void _setRatingAsTwo() {
    setState(() {
      _rating = 2;
    });
  }

  void _setRatingAsThree() {
    setState(() {
      _rating = 3;
    });
  }

  void _setRatingAsFour() {
    setState(() {
      _rating = 4;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_rating);

    double _size = 25.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          child: IconButton(
            iconSize: _size,
            icon: (_rating >= 1
                ? Icon(
                    Icons.star,
                    size: _size,
                  )
                : Icon(Icons.star_border, size: _size)),
            onPressed: _setRatingAsOne,
            color: Colors.orange[500],
          ),
        ),
        Container(
          child: IconButton(
            iconSize: _size,
            icon: (_rating >= 2
                ? Icon(
                    Icons.star,
                    size: _size,
                  )
                : Icon(Icons.star_border, size: _size)),
            onPressed: _setRatingAsTwo,
            color: Colors.orange[500],
          ),
        ),
        Container(
          child: IconButton(
            iconSize: _size,
            icon: (_rating >= 3
                ? Icon(
                    Icons.star,
                    size: _size,
                  )
                : Icon(Icons.star_border, size: _size)),
            onPressed: _setRatingAsThree,
            color: Colors.orange[500],
          ),
        ),
        Container(
          child: IconButton(
            iconSize: _size,
            icon: (_rating >= 4
                ? Icon(
                    Icons.star,
                    size: _size,
                  )
                : Icon(Icons.star_border, size: _size)),
            onPressed: _setRatingAsFour,
            color: Colors.orange[500],
          ),
        ),
      ],
    );
  }
}
