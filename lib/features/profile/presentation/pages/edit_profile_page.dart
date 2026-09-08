import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../widgets/gradient_button.dart';

/// SheShield – Edit Profile Page
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _nameController = TextEditingController(text: 'Priya Sharma');
  final _phoneController = TextEditingController(text: '+91 98765 43210');
  final _bloodController = TextEditingController(text: 'B+');
  final _medicalController = TextEditingController(text: 'No known allergies');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                size: 18, color: AppColors.textPrimary),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(AppStrings.editProfile,
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: AppColors.roseGoldGradient,
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Center(
                      child: Text('PS',
                          style: GoogleFonts.poppins(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: Colors.white)),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(Icons.camera_alt_rounded,
                          color: Colors.white, size: 16),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            _label('Full Name'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_rounded),
              ),
            ),

            const SizedBox(height: 20),

            _label('Phone Number'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.phone_rounded),
              ),
            ),

            const SizedBox(height: 20),

            _label('Blood Group'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _bloodController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.bloodtype_rounded),
                hintText: 'e.g., A+, B-, O+',
              ),
            ),

            const SizedBox(height: 20),

            _label('Medical Information'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _medicalController,
              maxLines: 3,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.medical_information_rounded),
                hintText: 'Allergies, conditions, medications...',
              ),
            ),

            const SizedBox(height: 32),

            GradientButton(
              text: AppStrings.saveChanges,
              icon: Icons.check_rounded,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _bloodController.dispose();
    _medicalController.dispose();
    super.dispose();
  }
}
