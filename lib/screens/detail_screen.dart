import 'package:flutter/material.dart';
import '../theme.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';
import 'chat_screen.dart';
import 'map_screen.dart';

class DetailScreen extends StatelessWidget {
  final FoundItem item;
  const DetailScreen({super.key, required this.item});

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) return 'منذ ${diff.inMinutes} دقيقة';
    if (diff.inHours < 24) return 'منذ ${diff.inHours} ساعة';
    return 'منذ ${diff.inDays} يوم';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navy,
      body: SafeArea(
        child: Column(
          children: [
            // App bar
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 10),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.gold),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text('تفاصيل المفقود', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary, fontFamily: 'Tajawal')),
                  const Spacer(),
                  IconButton(
                    icon: const Text('🔖', style: TextStyle(fontSize: 18)),
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تم الحفظ في المفضلة', style: TextStyle(fontFamily: 'Tajawal')), backgroundColor: AppColors.card),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image
                    Container(
                      height: 220,
                      width: double.infinity,
                      color: AppColors.navy2,
                      child: item.localImage != null
                        ? Image.file(item.localImage!, fit: BoxFit.cover)
                        : Center(child: Text(item.emoji, style: const TextStyle(fontSize: 80))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary, fontFamily: 'Tajawal')),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const CategoryBadge(label: 'وجدت'),
                              const SizedBox(width: 8),
                              Text('📍 ${item.location}', style: const TextStyle(fontSize: 11, color: AppColors.blue2, fontFamily: 'Tajawal')),
                            ],
                          ),
                          const SizedBox(height: 14),
                          // Info grid
                          GridView.count(
                            crossAxisCount: 2, shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisSpacing: 8, mainAxisSpacing: 8,
                            childAspectRatio: 2.5,
                            children: [
                              _infoBox('النوع', item.category),
                              _infoBox('الوقت', _timeAgo(item.createdAt)),
                              _infoBox('العاثر', item.finderName),
                              _infoBox('الحالة', '✓ محفوظة', valueColor: AppColors.green),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Text(item.description, style: const TextStyle(fontSize: 13, color: AppColors.textMuted2, height: 1.7, fontFamily: 'Tajawal')),
                          const SizedBox(height: 20),
                          BlueButton(
                            label: '💬 تواصل مع العاثر',
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(item: item))),
                          ),
                          const SizedBox(height: 10),
                          OutlineButton2(
                            label: '🗺️ عرض على الخريطة',
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MapScreen(focusItem: item))),
                          ),
                          const SizedBox(height: 10),
                          OutlineButton2(
                            label: '↗ مشاركة البلاغ',
                            onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('تم مشاركة البلاغ', style: TextStyle(fontFamily: 'Tajawal')), backgroundColor: AppColors.card),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoBox(String key, String val, {Color? valueColor}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(key, style: const TextStyle(fontSize: 10, color: AppColors.textMuted, fontFamily: 'Tajawal')),
          const SizedBox(height: 2),
          Text(val, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: valueColor ?? AppColors.textPrimary, fontFamily: 'Tajawal')),
        ],
      ),
    );
  }
}
