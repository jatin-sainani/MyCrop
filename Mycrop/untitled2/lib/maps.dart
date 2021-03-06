import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dart:async';


class maps extends StatefulWidget
{
  _mapsstate createState() => _mapsstate();

}

class _mapsstate extends State<maps>
{
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController _mapController;

  static  LatLng _center = const LatLng(26.8679438, 73.8183076);
  CameraPosition newPosition=CameraPosition(
    target: _center,
    zoom: 11.0,
  );
  List<Marker> markers=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    markers.add(Tom);
    markers.add(Pot);
    markers.add(Onion);
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    _mapController = controller;
  }

  void _onTap(int index)
  {
    setState(() {
      print('inside ontap');
      newPosition = CameraPosition(
        target: sellers[index],
        zoom: 11,
      );
      _goToPosition(newPosition);
    });
  }



    @override
  Widget build(BuildContext context) {
    double defaultScreenWidth = 375.0;
    double defaultScreenHeight = 830.0;
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('MyCrop'),actions: <Widget>[
          IconButton(icon: Icon(Icons.add,color: Colors.white), onPressed: (){Navigator.of(context).pushReplacementNamed('add');})
        ],),

          body: Stack(
            children: <Widget>[
              GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: newPosition,
                /*CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),*/
                markers: Set.from(markers),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  margin: EdgeInsets.only(bottom:ScreenUtil.instance.setHeight(20)),
                  height: ScreenUtil.instance.setHeight(150),
                  //width: ScreenUtil.instance.setWidth(150),
                  color: Colors.white,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      SizedBox(width: 5,),
                      box("Tomatoes",'25/Kilo',0,'Jatin','+917777889167'),
                      SizedBox(width: 10,),
                      box('Potatoes','20/kilo',1,'Rachit','+919039112290'),
                      SizedBox(width: 10,),
                      box('Onion','70/Kilo',2,'Aman','+919826293923'),
                      SizedBox(width: 10,),


                    ],
                  ),
                ),
              )
            ],
          )
      ),
    );
  }

  Widget box(String veg,String price,int index,String name,String contact)
  {
    return InkWell(
      onTap:(){ _onTap(index);},
      child: FittedBox(
        child: Material(
          color: Colors.blue,
          elevation: 11.0,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Stack(
            children: <Widget>[
              Image.asset('assets/cardbg.png'),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  height: ScreenUtil.instance.setHeight(39),
                  width: ScreenUtil.instance.setWidth(50),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.instance.setHeight(8))),

                  ),
                  child: Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Center(
                            child: Text(veg,
                              style: TextStyle(
                                fontFamily: 'Gothic',
                                fontSize: ScreenUtil.instance.setSp(9),
                              ),
                            ),
                          ),
                          //Padding(padding: EdgeInsets.only(top: 10)),
                          Text(name,
                            style: TextStyle(
                              fontFamily: 'Gothic',
                              fontSize: ScreenUtil.instance.setSp(7),
                            ),
                          ),

                          Text(contact,
                            style: TextStyle(
                              fontFamily: 'Gothic',
                              fontSize: ScreenUtil.instance.setSp(5),
                            ),
                          ),
                          Text(price,
                            style: TextStyle(
                              fontFamily: 'Gothic',
                              fontSize: ScreenUtil.instance.setSp(7),
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _goToPosition(CameraPosition newPosition) {
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(newPosition),
    );


    //_mapController
    //  ?.moveCamera(CameraUpdate.newLatLng(LatLng(newPosition.target.latitude, newPosition.target.longitude)));
  }

  List<LatLng> sellers=[
    LatLng(26.8679438, 73.8183076),
    LatLng(26.4679438, 74.1183076),
    LatLng(26.8679438, 73.1183076)
  ];
  Marker Tom = Marker(
    markerId: MarkerId('Tomatoes'),
    position: LatLng(26.8679438, 73.8183076),
    infoWindow: InfoWindow(title: 'Tomatoes'),
    icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueViolet,
    ),
  );

  Marker Pot = Marker(
    markerId: MarkerId('Potatoes'),
    position: LatLng(26.4679438, 74.1183076),
    infoWindow: InfoWindow(title: 'Potatoes'),
    icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueViolet,
    ),
  );

  Marker Onion = Marker(
    markerId: MarkerId('Onion'),
    position: LatLng(26.8679438, 73.1183076),
    infoWindow: InfoWindow(title: 'Onion'),
    icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueViolet,
    ),
  );

}


class add extends StatefulWidget
{
  _addstate createState() => _addstate();

}

class _addstate extends State<add>
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Add Marker'),),
      body: Column(
        children: <Widget>[
          Text('Name'),
          TextField(),
          Text('Lat,Long'),
          TextField(),
          Text('Vegetable'),
          TextField(),
          Text('Contact'),
          TextField()
        ],
      ),
    );
  }
}
