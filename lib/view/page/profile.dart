import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '/viewmodel/home_view_model.dart';

class ProfilePage extends StatefulWidget {
  final HomeViewModel vm;

  const ProfilePage({super.key, required this.vm});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _usernameController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  File? _image;
  Uint8List? _webImage;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _usernameController.text = widget.vm.userName;
    _image = widget.vm.profileImage;
  }

  // ✅ PICK IMAGE (WEB & ANDROID)
  Future<void> _pickImage(ImageSource source) async {
    final picked = await _picker.pickImage(source: source);
    if (picked == null) return;

    if (kIsWeb) {
      final bytes = await picked.readAsBytes();
      setState(() {
        _webImage = bytes;
        _image = null;
      });
    } else {
      setState(() {
        _image = File(picked.path);
        _webImage = null;
      });
    }
  }

  // ✅ HAPUS FOTO
  void _removeImage() {
    setState(() {
      _image = null;
      _webImage = null;
    });
  }

  // ✅ BOTTOM SHEET PILIHAN
  void _showPicker() {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Kamera"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text("Galeri"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text(
                "Hapus Foto",
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                Navigator.pop(context);
                _removeImage();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _save() {
    widget.vm.updateProfile(
      _usernameController.text.trim(),
      _image,
    );
    Navigator.pop(context);
  }

  // ✅ AVATAR UNIVERSAL
  Widget _buildAvatar() {
    ImageProvider? provider;

    if (kIsWeb && _webImage != null) {
      provider = MemoryImage(_webImage!);
    } else if (!kIsWeb && _image != null) {
      provider = FileImage(_image!);
    }

    return ClipOval(
      child: Container(
        width: 110,
        height: 110,
        color: Colors.white,
        child: provider != null
            ? Image(image: provider, fit: BoxFit.cover)
            : const Icon(Icons.person, size: 50),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Column(
          children: [
            /// ================= HEADER =================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 30),
              decoration: const BoxDecoration(
                color: Color(0xffC3CDDE),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  /// 🔙 BACK + TITLE
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios_new),
                      ),
                      const Expanded(
                        child: Text(
                          "Profile",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'IrishGrover',
                            color: Color(0xFF949DA6)
                          ),
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),

                  const SizedBox(height: 10),

                  /// 🔥 FOTO PROFILE
                  Column(
                    children: [
                      _buildAvatar(),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: _showPicker,
                        child: const Text(
                          "Edit",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'IrishGrover',
                            color: Color(0xFF949DA6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            /// ================= FORM =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Username",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: 'IrishGrover',
                      color: Color(0xff98A1BC),
                    ),
                  ),
                  const SizedBox(height: 8),

                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffC3CDDE),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    "Password",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: 'IrishGrover',
                      color: Color(0xff98A1BC),
                    ),
                  ),
                  const SizedBox(height: 8),

                  TextField(
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffC3CDDE),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            /// ================= BUTTON =================
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff98A1BC),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    "Simpan",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'IrishGrover',
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}