import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ecoscan_app/core/theme/app_colors.dart';
import 'package:ecoscan_app/widgets/bottom_nav_bar.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? _mapController;
  int _selectedIndex = 0;
  Position? _currentPosition;

  final CameraPosition _initialCameraPosition = const CameraPosition(
    target: LatLng(43.238949, 76.889709),
    zoom: 12,
  );

  final List<Map<String, dynamic>> _fandomats = [
    {
      'id': 'mega',
      'title': 'ТРЦ “Mega Center”',
      'address': 'ул. Розыбакиева, 247А',
      'position': const LatLng(43.2015, 76.8927),
    },
    {
      'id': 'dostyk',
      'title': 'пр. Достык',
      'address': 'пр. Достык, 109Б',
      'position': const LatLng(43.2334, 76.9569),
    },
    {
      'id': 'abay',
      'title': 'ул. Абая',
      'address': 'ул. Абая, 150',
      'position': const LatLng(43.2402, 76.8668),
    },
  ];

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return;
    }

    final position = await Geolocator.getCurrentPosition();

    if (mounted) {
      setState(() {
        _currentPosition = position;
      });
    }
  }

  Set<Marker> _buildMarkers() {
    return _fandomats.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;
      final LatLng pos = item['position'] as LatLng;

      return Marker(
        markerId: MarkerId(item['id'] as String),
        position: pos,
        infoWindow: InfoWindow(
          title: item['title'] as String,
          snippet: item['address'] as String,
        ),
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
      );
    }).toSet();
  }

  String _distanceText(LatLng target) {
    if (_currentPosition == null) return '— км';

    final meters = Geolocator.distanceBetween(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
      target.latitude,
      target.longitude,
    );

    final km = meters / 1000;

    return '${km.toStringAsFixed(1)} км';
  }

  Future<void> _moveToCard(int index) async {
    final LatLng target = _fandomats[index]['position'] as LatLng;

    setState(() {
      _selectedIndex = index;
    });

    await _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(target: target, zoom: 14)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selected = _fandomats[_selectedIndex];
    final selectedPosition = selected['position'] as LatLng;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          Positioned.fill(
            top: 165,
            child: GoogleMap(
              initialCameraPosition: _initialCameraPosition,
              markers: _buildMarkers(),
              myLocationEnabled: _currentPosition != null,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              onMapCreated: (controller) {
                _mapController = controller;
              },
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: AppColors.white,
              child: SafeArea(
                bottom: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 63),
                    const Padding(
                      padding: EdgeInsets.only(left: 29),
                      child: Text(
                        'Точки фандоматов',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          color: AppColors.brandGreen,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.only(left: 29),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 82,
                            height: 26,
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: AppColors.btn,
                                  width: 1,
                                ),
                                foregroundColor: Colors.black,
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                textStyle: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                ),
                                backgroundColor: Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    'assets/mark-icon.png',
                                    width: 10,
                                    height: 14,
                                  ),
                                  const SizedBox(width: 4),
                                  const Text(
                                    'Алматы',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 82,
                            height: 26,
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: AppColors.btn,
                                  width: 1,
                                ),
                                foregroundColor: Colors.black,
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                textStyle: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                ),
                                backgroundColor: Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/filter-green.png',
                                    width: 10,
                                    height: 14,
                                  ),
                                  const SizedBox(width: 4),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 6, bottom: 8),
                                    child: Text(
                                      'Фильтр',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 16,
            child: SizedBox(
              height: 102,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _fandomats.length,
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final item = _fandomats[index];
                  final LatLng pos = item['position'] as LatLng;

                  return GestureDetector(
                    onTap: () => _moveToCard(index),
                    child: Container(
                      width: 299,
                      height: 102,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            offset: Offset(0, 0),
                            blurRadius: 4,
                            spreadRadius: 3,
                          ),
                        ],
                        border: Border.all(
                          color: _selectedIndex == index
                              ? AppColors.btn
                              : Colors.transparent,
                          width: 1.2,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 19,
                          left: 22,
                          right: 22,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['address'] as String,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              item['title'] as String,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: AppColors.theGrey,
                              ),
                            ),
                            const SizedBox(height: 29),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/route-icon.png',
                                  width: 12,
                                  height: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  _distanceText(pos),
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.theGrey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const EcoBottomNavBar(active: BottomNavItem.map),
    );
  }
}
