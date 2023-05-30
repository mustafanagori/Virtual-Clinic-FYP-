import 'package:doctorandpatient/core/size_configuration.dart';
import 'package:doctorandpatient/templetes/patient_screen/take_appointment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Rating extends StatefulWidget {
  const Rating({super.key, required this.doctorID, required this.rating});
  final String doctorID;
  final List rating;

  @override
  State<Rating> createState() => _RatingState();
}

double _rating(List<dynamic>? rating) {
  List<double> doubleList = [];

  rating?.forEach((element) {
    doubleList.add(double.parse(element.toString()));
  });

  double sum = 0;
  for (double r in doubleList) {
    sum += r;
  }
  return sum / doubleList.length;
}

double selectedRating = 0;

class _RatingState extends State<Rating> {
  @override
  Widget build(BuildContext context) {
    final initialRating = _rating(widget.rating);
    return Center(
      child: SizedBox(
        height: getProportionateScreenHeight(250),
        width: getProportionateScreenWidth(300),
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RatingBar.builder(
                initialRating: initialRating,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                updateOnDrag: true,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  selectedRating = rating;
                },
              ),
              // SizedBox(height: getProportionateScreenHeight(20)),
              SizedBox(
                  height: getProportionateScreenHeight(50),
                  width: getProportionateScreenWidth(150),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      ),
                      onPressed: () async {
                        CircularProgressIndicator();
                        List newList = widget.rating;
                        newList.add(selectedRating);
                        await docController.updateRating(
                            doctorID: widget.doctorID, rating: newList);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        docController.fetchData();
                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
