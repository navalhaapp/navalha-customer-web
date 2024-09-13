// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/colors.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_webservice/places.dart' hide Location;
import 'package:navalha/shared/model/location_model.dart';
import 'package:navalha/shared/widgets/widget_empty.dart';
import '../home/home_page.dart';
import '../../shared/animation/page_trasition.dart';
import '../../shared/providers.dart';
import 'package:easy_debounce/easy_debounce.dart';

class ChangeLocations extends StatefulWidget {
  static const route = '/search-page';

  const ChangeLocations({super.key});
  @override
  ChangeLocationsState createState() => ChangeLocationsState();
}

class ChangeLocationsState extends State<ChangeLocations> {
  Prediction? _selectedAddress;
  final TextEditingController _searchController = TextEditingController();
  List<Prediction> _searchResults = [];

  Future<LocationModel> _selectAddress(Prediction prediction) async {
    _selectedAddress = prediction;
    _searchController.text = '';
    _searchResults = [];

    String description = prediction.description!;
    List<Location> locations =
        await GeocodingPlatform.instance
        !.locationFromAddress(description);

    if (locations.isNotEmpty) {
      Location location = locations.first;
      double latitude = location.latitude;
      double longitude = location.longitude;

      return LocationModel(
          latitude: latitude.toString(), longitude: longitude.toString());
    }
    return LocationModel(latitude: '', longitude: '');
  }

  void checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      navigationWithFadeAnimation(const HomePage(), context);
    } else {
      var newPermission = await Geolocator.requestPermission();
      if (newPermission == LocationPermission.always ||
          newPermission == LocationPermission.whileInUse) {
        navigationWithFadeAnimation(const HomePage(), context);
      } else {
        navigationWithFadeAnimation(const ChangeLocations(), context);
      }
    }
  }

  Future<void> _searchPlaces(String query) async {
    if (query.isNotEmpty) {
      final places =
          GoogleMapsPlaces(apiKey: 'AIzaSyDG5nAk3NL_Xy6o9ai_jEuzdlfkEjO1Eb8');
      final response = await places.autocomplete(
        query,
        components: [
          Component(Component.country, "br"),
        ],
        language: "pt_BR",
      );
      if (response.isOkay) {
        setState(() {
          _searchResults = response.predictions;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colorBackground181818,
      appBar: AppBar(
        backgroundColor: colorContainers242424,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            size: 20,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _searchController.text = '';
              _searchResults = [];
              setState(() {});
            },
            icon: const Icon(Icons.close),
          ),
        ],
        title: TextField(
          cursorColor: Colors.white,
          controller: _searchController,
          decoration: InputDecoration(
              hintText: 'Pesquisar endereço',
              hintStyle: TextStyle(color: colorFontUnable116116116),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              filled: true,
              labelStyle: const TextStyle(
                color: Colors.white,
              ),
              fillColor: Colors.transparent),
          style: const TextStyle(
            color: Colors.white,
          ),
          onChanged: (query) {
            EasyDebounce.debounce(
              'change-location',
              const Duration(milliseconds: 500),
              () async {
                _searchPlaces(query);
              },
            );
          },
        ),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final locationModel = ref.watch(locationProvider.state);
          return _searchResults.isNotEmpty
              ? ListView.builder(
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    Prediction prediction = _searchResults[index];
                    return GestureDetector(
                      onTap: () async {
                        LocationModel location =
                            await _selectAddress(prediction);
                        locationModel.state.latitude = location.latitude;
                        locationModel.state.longitude = location.longitude;
                        navigationWithFadeAnimation(const HomePage(), context);
                      },
                      child: ListTile(
                        title: Text(
                          prediction.description!,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: WidgetEmpty(
                    havebutton: false,
                    haveIcon: false,
                    title: 'Procure por um endereço',
                    subTitle: 'Localize barbearias próximas ao seu destino.',
                    text: 'Atualizar',
                    topSpace: size.height * 0.01,
                    onPressed: () {},
                  ),
                );
        },
      ),
      persistentFooterButtons: [
        Consumer(
          builder: (context, ref, child) {
            final locationModel = ref.watch(locationProvider.state);
            return Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: size.height * 0.01),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17),
                  ),
                  minWidth: size.width * 0.9,
                  height: 50,
                  color: colorContainers242424,
                  onPressed: () async {
                    LocationPermission permission =
                        await Geolocator.checkPermission();
                    if (permission == LocationPermission.always ||
                        permission == LocationPermission.whileInUse) {
                      navigationWithFadeAnimation(const HomePage(), context);
                      locationModel.state.latitude = '';
                      locationModel.state.longitude = '';
                    } else if (permission == LocationPermission.deniedForever) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Você negou as permissões de localização permanentemente, mude isso nas configurações do seu dispositivo.',
                          ),
                        ),
                      );
                    } else {
                      var newPermission = await Geolocator.requestPermission();
                      if (newPermission == LocationPermission.always ||
                          newPermission == LocationPermission.whileInUse) {
                        locationModel.state.latitude = '';
                        locationModel.state.longitude = '';
                        navigationWithFadeAnimation(const HomePage(), context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'O acesso à localização é necessário para que o aplicativo funcione corretamente.',
                            ),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text(
                    'Usar a minha localização atual',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
