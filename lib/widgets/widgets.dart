import 'package:flutter/material.dart';
import '../theme.dart';
import '../models/models.dart';
import 'package:intl/intl.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 32, height: 32,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.gold, AppColors.gold2],
              begin: Alignment.topLeft, end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(9),
          ),
          child: const Center(
            child: Text('م', style: TextStyle(
              fontFamily: 'Tajawal', fontWeight: FontWeight.w900,
              fontSize: 16, color: AppColors.navy,
            )),
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('مفقود', style: TextStyle(
              fontFamily: 'Tajawal', fontSize: 18,
              fontWeight: FontWeight.w700, color: AppColors.gold,
            )),
            Text('MAFQOOD', style: TextStyle(
              fontFamily: 'Tajawal', fontSize: 8,
              letterSpacing: 1.5, color: AppColors.textMuted,
            )),
          ],
        ),
      ],
    );
  }
}

class CategoryBadge extends StatelessWidget {
  final String label;
  final bool isFound;
  const CategoryBadge({super.key, required this.label, this.isFound = true});

  @override
  Widget build(BuildContext context) {
    final color = isFound ? AppColors.green : AppColors.red;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(label, style: TextStyle(
        fontSize: 10, fontWeight: FontWeight.w600,
        color: color, fontFamily: 'Tajawal',
      )),
    );
  }
}

class TagChip extends StatelessWidget {
  final String label;
  const TagChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.blue.withOpacity(0.25)),
      ),
      child: Text(label, style: const TextStyle(
        fontSize: 10, color: AppColors.blue2, fontFamily: 'Tajawal',
      )),
    );
  }
}

class GoldButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final double? width;
  const GoldButton({super.key, required this.label, required this.onTap, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          backgroundColor: AppColors.gold,
          foregroundColor: AppColors.navy,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        child: Text(label, style: const TextStyle(
          fontFamily: 'Tajawal', fontSize: 15, fontWeight: FontWeight.w700,
          color: AppColors.navy,
        )),
      ),
    );
  }
}

class BlueButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final double? width;
  const BlueButton({super.key, required this.label, required this.onTap, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          backgroundColor: AppColors.blue,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        child: Text(label, style: const TextStyle(
          fontFamily: 'Tajawal', fontSize: 14, fontWeight: FontWeight.w600,
        )),
      ),
    );
  }
}

class OutlineButton2 extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const OutlineButton2({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 13),
          side: BorderSide(color: AppColors.gold.withOpacity(0.4)),
          foregroundColor: AppColors.gold,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        child: Text(label, style: const TextStyle(
          fontFamily: 'Tajawal', fontSize: 13, fontWeight: FontWeight.w500,
        )),
      ),
    );
  }
}

class FoundItemCard extends StatelessWidget {
  final FoundItem item;
  final VoidCallback onTap;
  final VoidCallback onContact;
  final VoidCallback onMap;

  const FoundItemCard({
    super.key,
    required this.item,
    required this.onTap,
    required this.onContact,
    required this.onMap,
  });

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) return 'منذ ${diff.inMinutes} دقيقة';
    if (diff.inHours < 24) return 'منذ ${diff.inHours} ساعة';
    return 'منذ ${diff.inDays} يوم';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white.withOpacity(0.06)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 8),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 17,
                    backgroundColor: AppColors.blue.withOpacity(0.3),
                    child: Text(item.finderInitial, style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w700,
                      color: AppColors.blue2, fontFamily: 'Tajawal',
                    )),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.finderName, style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary, fontFamily: 'Tajawal',
                        )),
                        Text(_timeAgo(item.createdAt), style: const TextStyle(
                          fontSize: 10, color: AppColors.textMuted, fontFamily: 'Tajawal',
                        )),
                        GestureDetector(
                          onTap: onMap,
                          child: Text('📍 ${item.location} · ${item.distanceKm} كم ↗',
                            style: const TextStyle(fontSize: 10, color: AppColors.blue2, fontFamily: 'Tajawal'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const CategoryBadge(label: 'وجدت'),
                ],
              ),
            ),
            // Image
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.navy2, AppColors.card2],
                  begin: Alignment.topLeft, end: Alignment.bottomRight,
                ),
              ),
              child: item.localImage != null
                ? Image.file(item.localImage!, fit: BoxFit.cover)
                : Center(child: Text(item.emoji, style: const TextStyle(fontSize: 55))),
            ),
            // Body
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.description, style: const TextStyle(
                    fontSize: 12, color: AppColors.textMuted2,
                    height: 1.6, fontFamily: 'Tajawal',
                  )),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6, runSpacing: 4,
                    children: [
                      TagChip(label: item.category),
                      TagChip(label: item.emirate),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(color: Color(0x10FFFFFF), height: 1),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: onContact,
                          icon: const Text('💬', style: TextStyle(fontSize: 13)),
                          label: const Text('تواصل', style: TextStyle(fontFamily: 'Tajawal', fontSize: 12, fontWeight: FontWeight.w600)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.blue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 9),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            elevation: 0,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: onMap,
                          icon: const Text('🗺️', style: TextStyle(fontSize: 13)),
                          label: const Text('الموقع', style: TextStyle(fontFamily: 'Tajawal', fontSize: 12, fontWeight: FontWeight.w600)),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.gold,
                            padding: const EdgeInsets.symmetric(vertical: 9),
                            side: BorderSide(color: AppColors.gold.withOpacity(0.3)),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
