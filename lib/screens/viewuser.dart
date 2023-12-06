// ignore_for_file: must_be_immutable, type_literal_in_constant_pattern

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locate_me/bloc/pastlocation/bloc/pastlocation_bloc.dart';
import 'package:locate_me/models/currentlocationsmodel.dart';

class ViewUser extends StatefulWidget {
  const ViewUser({
    super.key,
  });

  @override
  State<ViewUser> createState() => _ViewUserState();
}

class _ViewUserState extends State<ViewUser> {
  bool isExpand = true;
  PastlocationBloc pastlocationBloc = PastlocationBloc();
  var selected;
  @override
  void initState() {
    super.initState();
    pastlocationBloc.add(InitialPastLocationEvent());
    isExpand = false;
  }

  @override
  Widget build(BuildContext context) {
    final location =
        ModalRoute.of(context)!.settings.arguments as CurrentLocation;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Handle back button click
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.all(16.0),
                ),
                child: const Icon(Icons.arrow_back_ios,
                    size: 20, color: Colors.black),
              ),
              Text(
                location.user,
                style: const TextStyle(
                  fontWeight: FontWeight.bold, // Make the text bold
                  fontSize: 20.0, // Adjust the font size as needed
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle send button click
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.all(16.0),
                ),
                child: const Icon(
                  Icons.send_outlined,
                  size: 20.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        CircleAvatar(
          radius: 70.0,
          backgroundColor: Colors.lime,
          child: ClipOval(
            child: Image.network(
              location.images,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
          child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle search button click
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor:
                          Colors.white, // Background color of the button
                      padding: const EdgeInsets.all(16.0),
                    ),
                    child: const Icon(
                      Icons.info,
                      size: 20.0, // Adjust the size as needed
                      color: Colors.black, // You can set the color as needed
                    ),
                  ),
                  Text(location.userId),
                  ElevatedButton(
                    onPressed: () {
                      // Handle search button click
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor:
                          Colors.white, // Background color of the button
                      padding: const EdgeInsets.all(16.0),
                    ),
                    child: const Icon(
                      Icons.chat_bubble_outline_sharp,
                      size: 25.0, // Adjust the size as needed
                      color: Colors.black, // You can set the color as needed
                    ),
                  ),
                ],
              )),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
          child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Now Is",
                          style: TextStyle(
                            fontWeight: FontWeight.bold, // Make the text bold
                            fontSize: 18.0, // Set the desired font size
                          ),
                        ),
                        Icon(
                          Icons
                              .add_location_outlined, // Use the outlined version of the icon
                          size: 24.0, // Adjust the size as needed
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          location.streetName,
                          style: const TextStyle(
                            fontSize:
                                16.0, // Set the desired font size for streetName
                          ),
                        ),
                        const SizedBox(
                            width:
                                8.0), // Adding some space between the two Text widgets
                        Text(
                          "Since ${_extractTime(location.timestamp)}", // Use a function to extract the time
                          style: const TextStyle(
                            fontSize:
                                16.0, // Set the desired font size for the timestamp
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "School",
                          style: TextStyle(
                            fontSize: 16.0, // Set the desired font size
                          ),
                        ),
                        Text(
                          "Updated ${_calculateTimeDifference(location.timestamp)} ago",
                          style: const TextStyle(
                            fontSize: 16.0, // Set the desired font size
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocConsumer<PastlocationBloc, PastlocationState>(
              listener: (context, state) {
                // TODO: implement listener
              },
               listenWhen: (previous, current) =>
                          current is PastLocationActionState,
                      buildWhen: (previous, current) =>
                          current is! PastLocationActionState,
              bloc: pastlocationBloc,
              
              builder: (context, state) {
                switch (state.runtimeType) {
                  case PastLocationLoading:
                  return const Center(child: CircularProgressIndicator(),);
                  case SuccessStatePastLocation:
                  var data = state as SuccessStatePastLocation;
                  return ExpansionTile(
                    iconColor: Colors.grey,
                    title: const Text(
                      'Last Updates',
                    ),
                    // ignore: sort_child_properties_last
                    children: <Widget>[
                      ListView.builder(
                        itemCount:data.pastloc.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  data.pastloc[index].name,
                                  style: const TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Updated ${_calculateTimeDifference(data.pastloc[index].timeUpdated)} ago",
                                  style: const TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    ],
                    onExpansionChanged: ((newState) {
                      isExpand = newState;

                      if (newState) {
                        setState(() {
                          const Duration(seconds: 20000);
                          // isExpand=newState;
                        });
                      } else {
                        setState(() {
                          selected = -1;
                          // isExpand=newState;
                        });
                      }
                    }));

                    
                    
                  default:
                  return Container();
                }
                
              },
            ),
          ),
        ),
      ]),
    );
  }

  String _extractTime(String timestampString) {
    // Convert the timestamp string to a DateTime object
    DateTime timestamp = DateTime.parse(timestampString);

    // Format the DateTime object to show only the time
    return "${timestamp.hour}:${timestamp.minute}";
  }

  String _calculateTimeDifference(String timestampString) {
    DateTime timestamp = DateTime.parse(timestampString);
    DateTime now = DateTime.now();

    Duration difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return "${difference.inDays}d";
    } else if (difference.inHours > 0) {
      return "${difference.inHours}h";
    } else if (difference.inMinutes > 0) {
      return "${difference.inMinutes}m";
    } else {
      return "Just now";
    }
  }

  final List<UpdateHistoryItem> _updateHistoryItems = [
    UpdateHistoryItem(
      location: "School",
      timestamp: "2023-01-01T12:34:56",
    ),
    UpdateHistoryItem(
      location: "Work",
      timestamp: "2023-01-02T09:45:00",
    ),
    // Add more items as needed
  ];
}

class UpdateHistoryItem {
  final String location;
  final String timestamp;
  bool isExpanded;

  UpdateHistoryItem({
    required this.location,
    required this.timestamp,
    this.isExpanded = false,
  });
}
