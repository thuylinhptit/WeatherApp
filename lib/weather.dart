import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/handle.dart';
import 'package:weather_app/search.dart';

import 'city.dart';
import 'json.dart';

class Weather extends StatefulWidget{
  @override
  _Weather createState() => _Weather();

}

class _Weather extends State<Weather>{
  ConsolidatedWeather weatherState;

  @override
  void initState() {
    super.initState();
    Handle.getDataById(1236594).then((value) {
      if(value is ConsolidatedWeather) {
        print(value.title);
          setState(() {
            weatherState = value;
          });
      }
    });
  }

  Widget _buildImage() {
    if(weatherState.weatherStateName == "Heavy Rain" || weatherState.weatherStateName == "Light Rain" || weatherState.weatherStateName == "Showers") {
      return  Image.asset(
          'assets/rainy.png'
      );
    }
    else if(weatherState.weatherStateName == "Thunderstorm") {
        return  Image.asset(
          'assets/thunderstorm.png'
      );
    }
    else if(weatherState.weatherStateName == "Heavy Cloud") {
      return  Image.asset(
          'assets/cloudy.png'
      );
    }
    else if(weatherState.weatherStateName == "Unknown" || weatherState.weatherStateName == "Clear" || weatherState.weatherStateName == "Light Cloud") {
      return  Image.asset(
          'assets/sun.png'
      );
    }
    else{
      return Image.asset(
        'assets/snow.png'
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Weather', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: ""),
        ),
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: onPressButton,
          )
        ],
      ),
      body: Container(
        color: Colors.indigo,
        child: weatherState == null ? Center(child: CircularProgressIndicator(),) : Column(
          children: <Widget> [

            Padding(
              padding: const EdgeInsets.fromLTRB(0, 130, 0, 0),
              child: Text(
                weatherState.title,
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.w400, color: Colors.white)
              ),
            ),
             Padding(
              padding: const EdgeInsets.fromLTRB(70, 40, 0, 0),
              child: Row(
                children: <Widget>[
                  _buildImage(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(70, 0, 20, 0),
                    child: Text(
                      weatherState.theTemp.round().toString() +'°', style: TextStyle(fontSize: 66, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 60, 0, 0),
              child: Row(
                children: [
                   Text(
                    weatherState.weatherStateName, style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(60, 0, 0, 0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                          child: Text(
                              'min : ${weatherState.minTemp.round()}°', style: TextStyle(fontSize: 25, color: Colors.white)
                          ),
                        ),
                        Text(
                            'max : ${weatherState.maxTemp.round()}°', style: TextStyle(fontSize: 25, color: Colors.white)
                        )
                      ],
                    ),
                  )
                ],
              ),
            )

          ],
        ),
      )
    );
  }
  void onPressButton() {
    Navigator.push(context, MaterialPageRoute(builder: goSearch))
    .then(( value) async {
      if(value is City) {
        var todayWeather = await Handle.getDataById(value.woeid);
        if(todayWeather is ConsolidatedWeather) {
          setState(() {
            weatherState = todayWeather;
          });
        }
      }
    });
    ;
  }

  Widget goSearch(BuildContext context){
    return Search();
  }

}