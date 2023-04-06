import 'package:no_screenshot/no_screenshot.dart';
import 'package:sada_payra/constants.dart';

import '../../../models/trip_model.dart';
import '../../../controllers/trip_provider.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';


class DownTripBody extends StatefulWidget {
  static const routeName = 'down-trips';
  const DownTripBody({super.key});

  @override
  State<DownTripBody> createState() => _DownTripBodyState();
}

class _DownTripBodyState extends State<DownTripBody> {
  List<TripModel>? _downTripsList;
  final _noScreenshot = NoScreenshot.instance;

  @override
  void initState() {
    _noScreenshot.screenshotOn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isSigned = true;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: FutureBuilder(
        future: fetchDownTripList(),
        builder: (
          BuildContext context,
          AsyncSnapshot<dynamic> snapshot,
        ) {
          if (snapshot.hasData) {
            _downTripsList = snapshot.data;
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                  itemCount: _downTripsList?.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ExpansionTileCard(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15.0)),
                        baseColor: const Color.fromARGB(255, 151, 173, 152),
                        elevation: 10,
                        initialElevation: 10.0,
                        shadowColor: Colors.black,
                        leading: Text(
                          _downTripsList![index].startTime,
                          style: const TextStyle(fontSize: 20.0),
                        ),
                        title: Text(
                          _downTripsList![index].startPoint,
                          style: const TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          _downTripsList![index].remarks,
                          style: const TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        children: <Widget>[
                          const Divider(
                            thickness: 1,
                            height: 2.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                children: [
                                  Text(
                                    "Route: ${_downTripsList![index].route}",
                                  ),
                                  Text(
                                    "Mode: ${_downTripsList![index].mode}",
                                  ),
                                ],
                              ),
                            ),
                          ),
                          isSigned
                              ? ButtonBar(
                                  alignment: MainAxisAlignment.spaceAround,
                                  buttonHeight: 52.0,
                                  buttonMinWidth: 90.0,
                                  children: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        updateTripSheet(
                                          context,
                                          _downTripsList![index],
                                        );
                                      },
                                      child: Column(
                                        children: const <Widget>[
                                          Icon(Icons.edit_outlined),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 2.0),
                                          ),
                                          Text('Edit'),
                                        ],
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text('Deleting Data ....'),
                                          ),
                                        );
                                        deleteDownTrip(
                                          _downTripsList![index].id,
                                        );
                                        setState(() {
                                          fetchDownTripList();
                                        });
                                      },
                                      child: Column(
                                        children: const <Widget>[
                                          Icon(Icons.delete_forever_outlined),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 2.0),
                                          ),
                                          Text('Delete'),
                                        ],
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // todo add notifyAll(_downTripsList![index]);
                                      },
                                      child: Column(
                                        children: const <Widget>[
                                          Icon(Icons.notification_add_outlined),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 2.0),
                                          ),
                                          Text('Notify All'),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                        ],
                      ),
                    );
                  },
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTripSheet(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<dynamic> addTripSheet(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final startTimeController = TextEditingController(),
        startPointController = TextEditingController(),
        routeController = TextEditingController(),
        modeController = TextEditingController(),
        remarksController = TextEditingController();

    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Wrap(
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(40),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 5,
                            width: 50,
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Add Down Trip',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a start time';
                              } else if (value.length != 5) {
                                return 'Please enter a valid start time';
                              }
                              return null;
                            },
                            controller: startTimeController,
                            decoration:
                                kTextFieldDecoration('Start Time: 10:30/13:15'),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            validator: (value) => value!.isEmpty
                                ? 'Please enter a start point'
                                : null,
                            controller: startPointController,
                            decoration:
                                kTextFieldDecoration('Start Point: Campus'),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            validator: (value) =>
                                value!.isEmpty ? 'Please enter remarks' : null,
                            controller: remarksController,
                            decoration: kTextFieldDecoration(
                                'Remarks: Student, Faculty'),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            validator: (value) =>
                                value!.isEmpty ? 'Please enter route' : null,
                            controller: routeController,
                            decoration: kTextFieldDecoration(
                              'Route: Khandaker Food Palace - Block 2 - Alekhar Chor - Noapara - Flyover Ends - Race Course - Police Line - Jhawtala - Baduartala - Kandirpar - Zilla School Gate - Eidgah - Foujdari',
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            validator: (value) =>
                                value!.isEmpty ? 'Please enter mode' : null,
                            controller: modeController,
                            decoration: kTextFieldDecoration('Mode: 2 x Bus'),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Uploading Data ....'),
                                      ),
                                    );
                                    Navigator.pop(context);
                                    await addDownTrip(
                                      TripModel(
                                        id: DateTime.now().toString(),
                                        startTime: startTimeController.text,
                                        startPoint: startPointController.text,
                                        remarks: remarksController.text,
                                        route: routeController.text,
                                        mode: modeController.text,
                                        tripType: 'down',
                                      ),
                                    );
                                    setState(() {
                                      startTimeController.clear();
                                      startPointController.clear();
                                      remarksController.clear();
                                      routeController.clear();
                                      modeController.clear();
                                      fetchDownTripList();
                                    });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromRGBO(7, 128, 128, 1),
                                ),
                                child: const Text(
                                  'Add',
                                  style: TextStyle(fontSize: 22),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(fontSize: 22),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> updateTripSheet(BuildContext context, TripModel trip) {
    final formKey = GlobalKey<FormState>();
    final startTimeController = TextEditingController(),
        startPointController = TextEditingController(),
        routeController = TextEditingController(),
        modeController = TextEditingController(),
        remarksController = TextEditingController();

    startTimeController.text = trip.startTime;
    startPointController.text = trip.startPoint;
    routeController.text = trip.route;
    modeController.text = trip.mode;
    remarksController.text = trip.remarks;

    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Wrap(
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(40),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 5,
                            width: 50,
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Update Down Trip',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a start time';
                              } else if (value.length != 5) {
                                return 'Please enter a valid start time';
                              }
                              return null;
                            },
                            controller: startTimeController,
                            decoration:
                                kTextFieldDecoration('Start Time: 10:30/13:15'),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            validator: (value) => value!.isEmpty
                                ? 'Please enter a start point'
                                : null,
                            controller: startPointController,
                            decoration:
                                kTextFieldDecoration('Start Point: Campus'),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            validator: (value) =>
                                value!.isEmpty ? 'Please enter remarks' : null,
                            controller: remarksController,
                            decoration: kTextFieldDecoration(
                                'Remarks: Student, Faculty'),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            validator: (value) =>
                                value!.isEmpty ? 'Please enter route' : null,
                            controller: routeController,
                            decoration: kTextFieldDecoration(
                              'Route: Khandaker Food Palace - Block 2 - Alekhar Chor - Noapara - Flyover Ends - Race Course - Police Line - Jhawtala - Baduartala - Kandirpar - Zilla School Gate - Eidgah - Foujdari',
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            validator: (value) =>
                                value!.isEmpty ? 'Please enter mode' : null,
                            controller: modeController,
                            decoration: kTextFieldDecoration('Mode: 2 x Bus'),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    // If the form is valid, display a snackbar. In the real world,
                                    // you'd often call a server or save the information in a database.
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Updating Data .....'),
                                      ),
                                    );
                                    Navigator.pop(context);
                                    updateDownTrip(
                                      trip.id,
                                      TripModel(
                                        id: trip.id,
                                        startTime: startTimeController.text,
                                        startPoint: startPointController.text,
                                        remarks: remarksController.text,
                                        route: routeController.text,
                                        mode: modeController.text,
                                        tripType: 'down',
                                      ),
                                    );
                                    setState(() {
                                      startTimeController.clear();
                                      startPointController.clear();
                                      remarksController.clear();
                                      routeController.clear();
                                      modeController.clear();
                                      fetchDownTripList();
                                    });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromRGBO(7, 128, 128, 1),
                                ),
                                child: const Text(
                                  'Update',
                                  style: TextStyle(fontSize: 22),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(fontSize: 22),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
