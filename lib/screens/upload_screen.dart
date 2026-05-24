import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../theme.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});
  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  File? _image;
  String _category = 'حقيبة سفر';
  final _descCtrl = TextEditingController();
  final _locCtrl = TextEditingController();
  String _emirate = 'دبي';
  bool _loading = false;

  final _categories = ['حقيبة سفر', 'محفظة', 'مستند رسمي', 'مفاتيح', 'هاتف', 'بطاقة بنكية', 'أخرى'];
  final _emirates = ['دبي', 'أبوظبي', 'الشارقة', 'عجمان', 'رأس الخيمة', 'الفجيرة', 'أم القيوين'];

  String _emoji(String cat) {
    switch (cat) {
      case 'حقيبة سفر': return '🎒';
      case 'محفظة': return '👜';
      case 'مستند رسمي': return '📄';
      case 'مفاتيح': return '🔑';
      case 'هاتف': return '📱';
      case 'بطاقة بنكية': return '💳';
      default: return '📦';
    }
  }

  Future<void> _pickImage(ImageSource src) async {
    final picker = ImagePicker();
    final xf = await picker.pickImage(source: src, imageQuality: 80);
    if (xf != null) setState(() => _image = File(xf.path));
  }

  void _showImageOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.card,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 40, height: 4, margin: const EdgeInsets.only(bottom: 16), decoration: BoxDecoration(color: AppColors.textMuted, borderRadius: BorderRadius.circular(2))),
            ListTile(
              leading: const Text('📷', style: TextStyle(fontSize: 22)),
              title: const Text('الكاميرا', style: TextStyle(color: AppColors.textPrimary, fontFamily: 'Tajawal')),
              onTap: () { Navigator.pop(context); _pickImage(ImageSource.camera); },
            ),
            ListTile(
              leading: const Text('🖼️', style: TextStyle(fontSize: 22)),
              title: const Text('معرض الصور', style: TextStyle(color: AppColors.textPrimary, fontFamily: 'Tajawal')),
              onTap: () { Navigator.pop(context); _pickImage(ImageSource.gallery); },
            ),
          ],
        ),
      ),
    );
  }

  void _submit() async {
    if (_descCtrl.text.trim().isEmpty || _locCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى تعبئة الوصف والموقع', style: TextStyle(fontFamily: 'Tajawal')), backgroundColor: AppColors.red),
      );
      return;
    }
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 800));
    final item = FoundItem(
      id: const Uuid().v4(),
      finderName: 'أنت',
      finderInitial: 'أ',
      title: '${_emoji(_category)} ${_category} — ${_locCtrl.text.trim()}',
      description: _descCtrl.text.trim(),
      location: _locCtrl.text.trim(),
      emirate: _emirate,
      category: _category,
      emoji: _emoji(_category),
      createdAt: DateTime.now(),
      distanceKm: 0,
      localImage: _image,
    );
    if (mounted) {
      setState(() => _loading = false);
      Navigator.pop(context, item);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navy,
      appBar: AppBar(
        title: const Text('رفع مفقود وجدته'),
        leading: IconButton(icon: const Icon(Icons.arrow_forward_ios, size: 16), onPressed: () => Navigator.pop(context)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Photo upload
            GestureDetector(
              onTap: _showImageOptions,
              child: Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: _image != null ? AppColors.gold : AppColors.gold.withOpacity(0.3),
                    width: _image != null ? 2 : 1.5,
                    style: BorderStyle.solid,
                  ),
                ),
                child: _image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(17),
                      child: Image.file(_image!, fit: BoxFit.cover),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('📷', style: TextStyle(fontSize: 40)),
                        const SizedBox(height: 10),
                        const Text('صوّر الشيء المفقود', style: TextStyle(fontSize: 14, color: AppColors.textMuted2, fontFamily: 'Tajawal')),
                        const SizedBox(height: 4),
                        Text('أو اختر من المعرض', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                      ],
                    ),
              ),
            ),
            const SizedBox(height: 20),

            // Category
            _label('نوع المفقود'),
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 6),
                itemBuilder: (_, i) {
                  final cat = _categories[i];
                  final on = _category == cat;
                  return GestureDetector(
                    onTap: () => setState(() => _category = cat),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: on ? AppColors.gold.withOpacity(0.15) : AppColors.card,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: on ? AppColors.gold : AppColors.gold.withOpacity(0.2)),
                      ),
                      child: Center(child: Text(cat, style: TextStyle(
                        fontSize: 11, fontWeight: FontWeight.w500,
                        color: on ? AppColors.gold : AppColors.textMuted,
                        fontFamily: 'Tajawal',
                      ))),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // Description
            _label('وصف الشيء المفقود'),
            TextField(
              controller: _descCtrl,
              textDirection: TextDirection.rtl,
              maxLines: 3,
              style: const TextStyle(color: AppColors.textPrimary, fontFamily: 'Tajawal', fontSize: 13),
              decoration: const InputDecoration(hintText: 'اللون، الشكل، أي تفاصيل مميزة...'),
            ),
            const SizedBox(height: 14),

            // Location
            _label('موقع الاكتشاف'),
            TextField(
              controller: _locCtrl,
              textDirection: TextDirection.rtl,
              style: const TextStyle(color: AppColors.textPrimary, fontFamily: 'Tajawal', fontSize: 13),
              decoration: const InputDecoration(hintText: 'مثال: مطار دبي — بوابة B12'),
            ),
            const SizedBox(height: 14),

            // Emirate
            _label('الإمارة'),
            DropdownButtonFormField<String>(
              value: _emirate,
              dropdownColor: AppColors.card,
              style: const TextStyle(color: AppColors.textPrimary, fontFamily: 'Tajawal', fontSize: 13),
              decoration: InputDecoration(
                filled: true, fillColor: AppColors.card,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: AppColors.gold.withOpacity(0.2))),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: AppColors.gold.withOpacity(0.2))),
              ),
              items: _emirates.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => setState(() => _emirate = v!),
            ),
            const SizedBox(height: 24),

            // Submit
            _loading
              ? const Center(child: CircularProgressIndicator(color: AppColors.gold))
              : GoldButton(label: '✓ نشر البلاغ الآن', onTap: _submit),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(text, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.gold, letterSpacing: 0.5, fontFamily: 'Tajawal')),
  );
}
