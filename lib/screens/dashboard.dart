import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locate_me/bloc/bloc/location_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:locate_me/models/currentlocationsmodel.dart';
import 'package:locate_me/screens/viewuser.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
class MyDashBoard extends StatefulWidget {
  const MyDashBoard({super.key});

  @override
  State<MyDashBoard> createState() => _MyDashBoardState();
}

class _MyDashBoardState extends State<MyDashBoard> {
  LatLng customerLocation = const LatLng(1.291, 36.8189);
  LocationBloc locationBloc = LocationBloc();
  List<CurrentLocation> location = [];
late GoogleMapController mapController;
  @override
  void initState(){
    super.initState();
    locationBloc.add(InitialEvent());
  }
  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = CameraPosition(
      target: customerLocation,
      zoom: 16,
    );

    return Scaffold(
      body: BlocConsumer<LocationBloc, LocationState>(
        listener: (context, state) async{
          
        },
        bloc: locationBloc,
                      listenWhen: (previous, current) =>
                          current is LocationActionState,
                      buildWhen: (previous, current) =>
                          current is! LocationActionState,
        builder: (context, state) {
      

          switch (state.runtimeType) {
                          case const (SuccessState):
                            final locationsuccess = state as SuccessState;
                           
                               location =locationsuccess.location;
                              addMarkers();
                         
          
      return Stack(
  children: [
    GoogleMap(
      markers: markers,
        initialCameraPosition: initialCameraPosition,
        onMapCreated: (controller) {
          mapController = controller;
        },
       
        zoomControlsEnabled: false, // Disable default zoom controls
        myLocationEnabled: false, // Enable the "My Location" blue dot
        myLocationButtonEnabled: false, // Disable default "My Location" button
        compassEnabled: false, // Disable default compass

        // Add custom zoom controls to the center left
        
      ),

      Positioned(
            top: 200.0,
            left: 16.0,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: "hello",
                  onPressed: () {
                    mapController.animateCamera(CameraUpdate.zoomIn());
                  },
                  child: const Icon(Icons.add),
                ),
                const SizedBox(height: 8.0),
                FloatingActionButton(
                  heroTag: "send",
                  onPressed: () {
                    mapController.animateCamera(CameraUpdate.zoomOut());
                  },
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(height: 8.0),
                 FloatingActionButton(
                  heroTag: "send",
                  onPressed: () {
                    mapController.animateCamera(CameraUpdate.zoomOut());
                  },
                  child: const Icon(Icons.send_and_archive_rounded),
                ),
              ],
            ),
          ),
    Positioned(
      top: 45.0,
      left: 16.0,
      child: ElevatedButton(
        onPressed: () {
          // Handle search button click
        },
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(), backgroundColor: Colors.white, // Background color of the button
          padding: const EdgeInsets.all(16.0),
        ),
        child: const Icon(Icons.search, color: Colors.black),
      ),
    ),
    Positioned(
      
      top: 45.0,
      right: 16.0,
      child: ElevatedButton(
        onPressed: () {
          // Handle settings button click
        },
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(), backgroundColor: Colors.white, // Background color of the button
          padding: const EdgeInsets.all(16.0),
        ),
        child: const Icon(Icons.settings, color: Colors.black),
      ),
    ),
     Positioned(
            top: 400.0,
            left: 16.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 76, 255, 56),
                      child: IconButton(
                        onPressed: () {
                          // Handle 'Add New Tag' button click
                        },
                        icon: const Icon(Icons.add),
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 4.0),
                    const Text('Add New Tag', style: TextStyle(color: Colors.black)),
                  ],
                ),
                const SizedBox(width: 50.0),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 76, 255, 56),
                      child: IconButton(
                        onPressed: () {
                          // Handle 'Add New Item' button click
                        },
                        icon: const Icon(Icons.add),
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 4.0),
                    const Text('Add New Item', style: TextStyle(color: Colors.black)),
                  ],
                ),
              ],
            ),
          ),
      Positioned(
  top: 450,
  left: 16,
  child: Container(
    width: 320,
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 149, 255, 56),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _buildCategoryContainer("All"),
                const SizedBox(width: 8),
                _buildCategoryContainer("People"),
                const SizedBox(width: 8),
                _buildCategoryContainer("Items"),
              ],
            ),
            const CircleAvatar(
              backgroundColor: Color.fromARGB(255, 149, 255, 56),
              
              child: Icon(
                Icons.more_horiz,
                color: Colors.black,
              ),
            ),
          ],
        ),
       // Adjust the height here as needed
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 2,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ViewUser(),
                      settings: RouteSettings(
                        arguments: locationsuccess.location[index],
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundColor: Colors.lime,
                      child: ClipOval(
                        child: Image.network(
                          locationsuccess.location[index].images,
                          width: 50.0,
                          height: 50.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            locationsuccess.location[index].user,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(locationsuccess.location[index].streetName),
                        ],
                      ),
                    ),
                    const Icon(Icons.send),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    ),
  ),
),

  ],
);

          case const (LocationLoading):
          return const Center(child: CircularProgressIndicator(),);

          case const (ErrorState):
          final error = state as ErrorState;
          return Text(error.error);
           default:
                            return Container();
  
                            }
         
        },
      ),
    );
  }
   getMarkerIcon(String imageUrl) async {
  final response = await http.get(Uri.parse(imageUrl));
  if (response.statusCode == 200) {
    final bytes = response.bodyBytes;
    return BitmapDescriptor.fromBytes(bytes);
  } else {
    // Fallback to a default icon if image fetching fails
    return BitmapDescriptor.defaultMarker;
  }
}
Container _buildCategoryContainer(String text) {
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 165, 250, 17), // Slightly lighter color
      borderRadius: BorderRadius.circular(8), // Rounded edges
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: Colors.black, // Text color
        fontWeight: FontWeight.bold, // Bold text
      ),
    ),
  );
}
Set<Marker> markers = {};

  Future<void> addMarkers() async {
    for (int i = 0; i < location.length; i++) {
      BitmapDescriptor icon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(10, 10)), // Set the desired size
        'images/person.jpg', // Replace with your image asset path
      );
    
      markers.add(
        Marker(
          markerId: MarkerId('courier$i'),
          position: LatLng(
            double.parse(location[i].latitude.toString()),
            double.parse(location[i].longitude.toString()),
          ),
          infoWindow: InfoWindow(title: location[i].user),
          icon: icon,
        ),
      );
    
    
    }
  }

// Call the function to add markers



}
