import 'package:flutter/material.dart';
import 'package:weather_app/handle.dart';


class Search extends StatefulWidget{
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Row(
          children: [
            SizedBox(width: 16,),
            Expanded(
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Search By City Name"
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.search), onPressed: () async {
                var cityName = searchController.text;
                var city = await  Handle.searchByCity(cityName);
                Navigator.pop(context, city);
            },
            )
          ],
        ),
      ),
    );
  }
}