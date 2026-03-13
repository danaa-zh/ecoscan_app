import 'dart:io';
import 'package:ecoscan_app/core/services/firestore_service.dart';
import 'package:ecoscan_app/features/auth/bloc/auth_bloc.dart';
import 'package:ecoscan_app/features/profile/bloc/profile_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ecoscan_app/core/theme/app_colors.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _nameCtrl = TextEditingController();
  final _usernameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  File? _avatar;
  String? _currentAvatarUrl;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadCurrentProfile();
  }

  Future<void> _loadCurrentProfile() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final firestore = context.read<FirestoreService>();
    final user = await firestore.getUser(uid);

    if (user == null) return;

    _nameCtrl.text = user['name'] ?? '';
    _usernameCtrl.text = user['username'] ?? '';
    _emailCtrl.text = user['email'] ?? '';
    _currentAvatarUrl = user['avatarUrl'];

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        _avatar = File(picked.path);
      });
    }
  }

  Future<String?> _uploadAvatar(String uid) async {
    if (_avatar == null) return _currentAvatarUrl;

    final ref = FirebaseStorage.instance.ref().child('avatars/$uid.jpg');
    await ref.putFile(_avatar!);
    return await ref.getDownloadURL();
  }

  Future<void> _saveProfile() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final currentUser = FirebaseAuth.instance.currentUser;
    if (uid == null || currentUser == null) return;

    setState(() {
      _isSaving = true;
    });

    try {
      final firestore = context.read<FirestoreService>();
      final avatarUrl = await _uploadAvatar(uid);

      await firestore.updateUser(uid, {
        'name': _nameCtrl.text.trim(),
        'username': _usernameCtrl.text.trim(),
        'email': _emailCtrl.text.trim(),
        'avatarUrl': avatarUrl ?? '',
      });

      if (_emailCtrl.text.trim().isNotEmpty &&
          _emailCtrl.text.trim() != currentUser.email) {
        await currentUser.verifyBeforeUpdateEmail(_emailCtrl.text.trim());
      }

      if (_passwordCtrl.text.trim().isNotEmpty) {
        await currentUser.updatePassword(_passwordCtrl.text.trim());
      }

      await context.read<ProfileBloc>().loadProfile(uid);

      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Ошибка сохранения: $e')));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _usernameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider = _avatar != null
        ? FileImage(_avatar!)
        : (_currentAvatarUrl != null && _currentAvatarUrl!.isNotEmpty
              ? NetworkImage(_currentAvatarUrl!)
              : null);

    return Scaffold(
      appBar: AppBar(title: const Text('Редактировать профиль')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: imageProvider as ImageProvider<Object>?,
                child: imageProvider == null
                    ? const Icon(Icons.add_a_photo, size: 28)
                    : null,
              ),
            ),
            const SizedBox(height: 12),
            const Text('Нажмите, чтобы изменить аватарку'),
            const SizedBox(height: 24),

            TextField(
              controller: _nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Имя',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _usernameCtrl,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _emailCtrl,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _passwordCtrl,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Новый пароль',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.btn, 
                  side: const BorderSide(color: AppColors.btn, width: 1),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _isSaving ? null : _saveProfile,
                child: _isSaving
                    ? const CircularProgressIndicator()
                    : const Text('Сохранить'),
              ),
            ),
            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  context.read<AuthBloc>().add(const AuthSignOutRequested());
                },
                child: const Text(
                  'Выйти из аккаунта',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
