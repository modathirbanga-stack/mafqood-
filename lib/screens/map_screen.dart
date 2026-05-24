import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../theme.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';
import 'chat_screen.dart';

class MapScreen extends StatefulWidget {
  final FoundItem? focusItem;
  const MapScreen({super.key, this.focusItem});
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final _mapCtrl = MapController();
  FoundItem? _selected;

  @override
  void initState() {
    super.initState();
    if (widget.focusItem != null) {
      _selected = widget.focusItem;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (widget.focusItem!.lat != null) {
          _mapCtrl.move(LatLng(widget.focusItem!.lat!, widget.focusItem!.lng!), 14);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = SampleData.items.where((i) => i.lat != null).toList();

    return Scaffold(
      backgroundColor: AppColors.navy,
      appBar: AppBar(
        title: const Text('خريطة المفقودات'),
        leading: IconButton(icon: const Icon(Icons.arrow_forward_ios, size: 16), onPressed: () => Navigator.pop(context)),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location, size: 20),
            onPressed: () => _mapCtrl.move(const LatLng(25.2532, 55.3657), 12),
          ),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapCtrl,
            options: MapOptions(
              initialCenter: const LatLng(25.2048, 55.2708),
              initialZoom: 11,
              onTap: (_, __) => setState(() => _selected = null),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.mafqood.app',
              ),
              MarkerLayer(
                markers: [
                  // User location
                  Marker(
                    point: const LatLng(25.2200, 55.3000),
                    width: 24, height: 24,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.blue,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        boxShadow: [BoxShadow(color: AppColors.blue.withOpacity(0.5), blurRadius: 8, spreadRadius: 2)],
                      ),
                    ),
                  ),
                  // Item pins
                  ...items.map((item) => Marker(
                    point: LatLng(item.lat!, item.lng!),
                    width: 44, height: 44,
                    child: GestureDetector(
                      onTap: () => setState(() => _selected = item),
                      child: Column(
                        children: [
                          Container(
                            width: 36, height: 36,
                            decoration: BoxDecoration(
                              color: _selected?.id == item.id ? AppColors.gold : AppColors.green,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                              boxShadow: [BoxShadow(
                                color: (_selected?.id == item.id ? AppColors.gold : AppColors.green).withOpacity(0.4),
                                blurRadius: 8,
                              )],
                            ),
                            child: Center(child: Text(item.emoji, style: const TextStyle(fontSize: 16))),
                          ),
                          const SizedBox(height: 2),
                          Container(width: 2, height: 6, color: Colors.white.withOpacity(0.6)),
                        ],
                      ),
                    ),
                  )),
                ],
              ),
            ],
          ),

          // Legend
          Positioned(
            bottom: _selected != null ? 220 : 16,
            right: 12,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.navy2.withOpacity(0.95),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.gold.withOpacity(0.15)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _legendRow(AppColors.green, 'وجدت'),
                  const SizedBox(height: 5),
                  _legendRow(AppColors.orange, 'مفقود'),
                  const SizedBox(height: 5),
                  _legendRow(AppColors.blue, 'موقعك'),
                ],
              ),
            ),
          ),

          // Selected popup
          if (_selected != null)
            Positioned(
              bottom: 0, left: 0, right: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.navy2,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  border: Border(top: BorderSide(color: AppColors.gold.withOpacity(0.2))),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 20, spreadRadius: 0)],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(_selected!.emoji, style: const TextStyle(fontSize: 28)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_selected!.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary, fontFamily: 'Tajawal')),
                              Text('📍 ${_selected!.location}', style: const TextStyle(fontSize: 11, color: AppColors.blue2, fontFamily: 'Tajawal')),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: AppColors.textMuted, size: 18),
                          onPressed: () => setState(() => _selected = null),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(_selected!.description, maxLines: 2, overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12, color: AppColors.textMuted2, height: 1.5, fontFamily: 'Tajawal')),
                    const SizedBox(height: 12),
                    BlueButton(label: '💬 تواصل مع العاثر', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(item: _selected!)))),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _legendRow(Color color, String label) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
      const SizedBox(width: 6),
      Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textMuted2, fontFamily: 'Tajawal')),
    ],
  );
}
