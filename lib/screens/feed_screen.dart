import 'package:flutter/material.dart';
import '../theme.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';
import 'detail_screen.dart';
import 'chat_screen.dart';
import 'map_screen.dart';
import 'upload_screen.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});
  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final _search = TextEditingController();
  String _filter = 'الكل';
  List<FoundItem> _items = [];

  final _filters = ['الكل', '🗺️ قريب مني', 'دبي', 'الشارقة', 'أبوظبي', 'حقائب', 'مستندات'];

  @override
  void initState() {
    super.initState();
    _items = List.from(SampleData.items);
  }

  List<FoundItem> get _filtered {
    var list = _items;
    if (_filter == 'دبي') list = list.where((i) => i.emirate == 'دبي').toList();
    if (_filter == 'أبوظبي') list = list.where((i) => i.emirate == 'أبوظبي').toList();
    if (_filter == 'الشارقة') list = list.where((i) => i.emirate == 'الشارقة').toList();
    if (_filter == 'حقائب') list = list.where((i) => i.category.contains('حقيبة') || i.category.contains('محفظة')).toList();
    if (_filter == 'مستندات') list = list.where((i) => i.category.contains('مستند') || i.category.contains('جواز')).toList();
    if (_filter == '🗺️ قريب مني') list = List.from(list)..sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
    final q = _search.text.toLowerCase();
    if (q.isNotEmpty) list = list.where((i) => i.title.contains(q) || i.description.contains(q) || i.location.contains(q)).toList();
    return list;
  }

  void _addItem(FoundItem item) {
    setState(() => _items.insert(0, item));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navy,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 14, 18, 10),
              child: Row(
                children: [
                  const AppLogo(),
                  const Spacer(),
                  Stack(
                    children: [
                      IconButton(
                        icon: const Text('🔔', style: TextStyle(fontSize: 18)),
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotifScreen())),
                      ),
                      Positioned(
                        top: 6, right: 6,
                        child: Container(
                          width: 14, height: 14,
                          decoration: BoxDecoration(color: AppColors.red, shape: BoxShape.circle, border: Border.all(color: AppColors.navy, width: 1.5)),
                          child: const Center(child: Text('3', style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.white))),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Text('👤', style: TextStyle(fontSize: 18)),
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen())),
                  ),
                ],
              ),
            ),
            // Divider
            Divider(color: AppColors.gold.withOpacity(0.1), height: 1),

            // Search
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.gold.withOpacity(0.15)),
                ),
                child: TextField(
                  controller: _search,
                  textDirection: TextDirection.rtl,
                  onChanged: (_) => setState(() {}),
                  style: const TextStyle(color: AppColors.textPrimary, fontFamily: 'Tajawal', fontSize: 13),
                  decoration: const InputDecoration(
                    hintText: 'ابحث عن مفقود...',
                    hintStyle: TextStyle(color: AppColors.textMuted, fontFamily: 'Tajawal'),
                    prefixIcon: Icon(Icons.search, color: AppColors.textMuted, size: 20),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ),

            // Filters
            SizedBox(
              height: 44,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                itemCount: _filters.length,
                separatorBuilder: (_, __) => const SizedBox(width: 6),
                itemBuilder: (_, i) {
                  final f = _filters[i];
                  final on = _filter == f;
                  return GestureDetector(
                    onTap: () {
                      setState(() => _filter = f);
                      if (f.contains('قريب')) {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const MapScreen()));
                      }
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: on ? AppColors.gold.withOpacity(0.15) : AppColors.card,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: on ? AppColors.gold : AppColors.gold.withOpacity(0.2)),
                      ),
                      child: Center(child: Text(f, style: TextStyle(
                        fontSize: 11, fontWeight: FontWeight.w500,
                        color: on ? AppColors.gold : AppColors.textMuted,
                        fontFamily: 'Tajawal',
                      ))),
                    ),
                  );
                },
              ),
            ),

            // Feed
            Expanded(
              child: _filtered.isEmpty
                ? Center(child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('🔍', style: TextStyle(fontSize: 40)),
                      const SizedBox(height: 12),
                      Text('لا توجد نتائج', style: TextStyle(color: AppColors.textMuted, fontFamily: 'Tajawal', fontSize: 14)),
                    ],
                  ))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    itemCount: _filtered.length,
                    itemBuilder: (_, i) {
                      final item = _filtered[i];
                      return FoundItemCard(
                        item: item,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailScreen(item: item))),
                        onContact: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(item: item))),
                        onMap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MapScreen(focusItem: item))),
                      );
                    },
                  ),
            ),
          ],
        ),
      ),

      // FAB
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push<FoundItem>(
            context, MaterialPageRoute(builder: (_) => const UploadScreen()),
          );
          if (result != null) _addItem(result);
        },
        backgroundColor: AppColors.gold,
        foregroundColor: AppColors.navy,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Text('📷', style: TextStyle(fontSize: 22)),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (i) {
          if (i == 1) Navigator.push(context, MaterialPageRoute(builder: (_) => const MapScreen()));
          if (i == 2) Navigator.push(context, MaterialPageRoute(builder: (_) => const UploadScreen()));
          if (i == 3) Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(item: SampleData.items[0])));
          if (i == 4) Navigator.push(context, MaterialPageRoute(builder: (_) => const NotifScreen()));
        },
        items: const [
          BottomNavigationBarItem(icon: Text('🏠', style: TextStyle(fontSize: 20)), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Text('🗺️', style: TextStyle(fontSize: 20)), label: 'الخريطة'),
          BottomNavigationBarItem(icon: Text('➕', style: TextStyle(fontSize: 20)), label: 'أضف'),
          BottomNavigationBarItem(icon: Text('💬', style: TextStyle(fontSize: 20)), label: 'رسائل'),
          BottomNavigationBarItem(icon: Text('🔔', style: TextStyle(fontSize: 20)), label: 'إشعارات'),
        ],
      ),
    );
  }
}

// Notifications screen
class NotifScreen extends StatefulWidget {
  const NotifScreen({super.key});
  @override
  State<NotifScreen> createState() => _NotifScreenState();
}

class _NotifScreenState extends State<NotifScreen> {
  late List<AppNotification> _notifs;

  @override
  void initState() {
    super.initState();
    _notifs = List.from(SampleData.notifications);
  }

  int get _unread => _notifs.where((n) => !n.isRead).length;

  @override
  Widget build(BuildContext context) {
    final newNotifs = _notifs.where((n) => !n.isRead).toList();
    final oldNotifs = _notifs.where((n) => n.isRead).toList();

    return Scaffold(
      backgroundColor: AppColors.navy,
      appBar: AppBar(
        title: const Text('الإشعارات'),
        leading: IconButton(icon: const Icon(Icons.arrow_forward_ios, size: 16), onPressed: () => Navigator.pop(context)),
        actions: [
          if (_unread > 0)
            TextButton(
              onPressed: () => setState(() { for (var n in _notifs) n.isRead = true; }),
              child: const Text('✓ كل', style: TextStyle(color: AppColors.gold, fontFamily: 'Tajawal', fontSize: 13)),
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          if (newNotifs.isNotEmpty) ...[
            _sectionLabel('جديد'),
            ...newNotifs.map((n) => _notifCard(n, true)),
          ],
          if (oldNotifs.isNotEmpty) ...[
            _sectionLabel('السابق'),
            ...oldNotifs.map((n) => _notifCard(n, false)),
          ],
        ],
      ),
    );
  }

  Widget _sectionLabel(String label) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.gold, letterSpacing: 1, fontFamily: 'Tajawal')),
  );

  Widget _notifCard(AppNotification n, bool isNew) {
    return GestureDetector(
      onTap: () => setState(() => n.isRead = true),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isNew ? AppColors.blue.withOpacity(0.05) : AppColors.card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isNew ? AppColors.blue.withOpacity(0.3) : Colors.white.withOpacity(0.05)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 38, height: 38,
              decoration: BoxDecoration(
                color: AppColors.blue.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(child: Text(n.icon, style: const TextStyle(fontSize: 18))),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(n.title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary, fontFamily: 'Tajawal')),
                  const SizedBox(height: 3),
                  Text(n.body, style: const TextStyle(fontSize: 11, color: AppColors.textMuted2, height: 1.5, fontFamily: 'Tajawal')),
                  const SizedBox(height: 4),
                  Text(_timeAgo(n.time), style: const TextStyle(fontSize: 10, color: AppColors.textMuted, fontFamily: 'Tajawal')),
                ],
              ),
            ),
            if (isNew)
              Container(width: 8, height: 8, margin: const EdgeInsets.only(top: 4), decoration: const BoxDecoration(color: AppColors.blue, shape: BoxShape.circle)),
          ],
        ),
      ),
    );
  }

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) return 'منذ ${diff.inMinutes} دقيقة';
    if (diff.inHours < 24) return 'منذ ${diff.inHours} ساعة';
    return 'منذ ${diff.inDays} يوم';
  }
}

// Profile screen
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navy,
      appBar: AppBar(
        title: const Text('حسابي'),
        leading: IconButton(icon: const Icon(Icons.arrow_forward_ios, size: 16), onPressed: () => Navigator.pop(context)),
      ),
      body: ListView(
        children: [
          // Hero
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: AppColors.blue.withOpacity(0.3),
                  child: const Text('😊', style: TextStyle(fontSize: 32)),
                ),
                const SizedBox(height: 10),
                const Text('مستخدم مفقود', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary, fontFamily: 'Tajawal')),
                const SizedBox(height: 4),
                const Text('دبي، الإمارات · عضو منذ يناير 2026', style: TextStyle(fontSize: 11, color: AppColors.textMuted, fontFamily: 'Tajawal')),
              ],
            ),
          ),
          // Stats
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                _stat('7', 'بلاغات رفعتها'),
                const SizedBox(width: 8),
                _stat('3', 'أشياء أُعيدت'),
                const SizedBox(width: 8),
                _stat('⭐4.9', 'تقييمي'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Menu
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              children: [
                _menuItem('🔔', 'الإشعارات', badge: '3 جديد', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotifScreen()))),
                _menuItem('🗺️', 'الخريطة', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MapScreen()))),
                _menuItem('💬', 'رسائلي', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(item: SampleData.items[0])))),
                _menuItem('📍', 'إعدادات الموقع', onTap: () {}),
                _menuItem('🚪', 'تسجيل خروج', color: AppColors.red, onTap: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _stat(String num, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          children: [
            Text(num, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.gold, fontFamily: 'Tajawal')),
            const SizedBox(height: 2),
            Text(label, style: const TextStyle(fontSize: 9, color: AppColors.textMuted, fontFamily: 'Tajawal'), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _menuItem(String icon, String label, {String? badge, Color? color, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.04)))),
        child: Row(
          children: [
            Text(icon, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 12),
            Text(label, style: TextStyle(fontSize: 13, color: color ?? AppColors.textPrimary, fontFamily: 'Tajawal')),
            const Spacer(),
            if (badge != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: AppColors.red.withOpacity(0.15), borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.red.withOpacity(0.3))),
                child: Text(badge, style: const TextStyle(fontSize: 9, color: AppColors.red, fontFamily: 'Tajawal')),
              )
            else
              const Icon(Icons.chevron_left, color: AppColors.textMuted, size: 18),
          ],
        ),
      ),
    );
  }
}
