import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/models/contact_model.dart';
import '../../../../widgets/gradient_button.dart';

/// SheShield – Add/Edit Contact Page
class AddContactPage extends StatefulWidget {
  final String? contactId;
  const AddContactPage({super.key, this.contactId});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  String _selectedRelationship = Relationships.types.first;
  bool _isPrimary = false;
  bool get isEditing => widget.contactId != null;

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
        title: Text(
          isEditing ? AppStrings.editContact : AppStrings.addContact,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name
              _label('Contact Name'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _nameController,
                validator: Validators.name,
                decoration: const InputDecoration(
                  hintText: 'Enter full name',
                  prefixIcon: Icon(Icons.person_rounded),
                ),
              ),

              const SizedBox(height: 20),

              // Phone
              _label('Phone Number'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _phoneController,
                validator: Validators.phone,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: '+91 98765 43210',
                  prefixIcon: Icon(Icons.phone_rounded),
                ),
              ),

              const SizedBox(height: 20),

              // Relationship
              _label('Relationship'),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedRelationship,
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    items: Relationships.types
                        .map((r) => DropdownMenuItem(
                              value: r,
                              child: Text(r, style: GoogleFonts.outfit()),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() => _selectedRelationship = value!);
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Primary toggle
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: _isPrimary
                      ? AppColors.roseGoldShimmer.withValues(alpha: 0.2)
                      : AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _isPrimary
                        ? AppColors.roseGold.withValues(alpha: 0.4)
                        : AppColors.borderLight,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: _isPrimary
                          ? AppColors.roseGold
                          : AppColors.textTertiary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.primaryGuardian,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'First person to be notified in emergencies',
                            style: GoogleFonts.outfit(
                              fontSize: 12,
                              color: AppColors.textTertiary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: _isPrimary,
                      onChanged: (v) => setState(() => _isPrimary = v),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Save button
              GradientButton(
                text: isEditing ? AppStrings.saveChanges : AppStrings.addContact,
                icon: Icons.check_rounded,
                onPressed: _save,
              ),
            ],
          ),
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

  void _save() {
    if (_formKey.currentState!.validate()) {
      // TODO: Save to Firestore
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
