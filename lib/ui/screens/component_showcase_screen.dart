import 'package:flutter/material.dart';
import 'package:zinapp_v2/ui/components/zin_button.dart';
import 'package:zinapp_v2/ui/components/zin_card.dart';
import 'package:zinapp_v2/ui/components/zin_text_field.dart';

/// A showcase screen for the new three-layer architecture UI components.
///
/// This screen displays all the components built as part of the new UI layer,
/// which strictly separates presentation from business logic.
class UIComponentShowcaseScreen extends StatefulWidget {
  const UIComponentShowcaseScreen({Key? key}) : super(key: key);

  @override
  State<UIComponentShowcaseScreen> createState() => _UIComponentShowcaseScreenState();
}

class _UIComponentShowcaseScreenState extends State<UIComponentShowcaseScreen> {
  bool _isButtonPressed = false;
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _darkTextController = TextEditingController();
  final TextEditingController _minimalTextController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _textController.text = 'Sample text';
    _darkTextController.text = 'Dark variant';
    _minimalTextController.text = 'Minimal variant';
    _passwordController.text = 'password123';
  }
  
  @override
  void dispose() {
    _textController.dispose();
    _darkTextController.dispose();
    _minimalTextController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _toggleButtonState() {
    setState(() {
      _isButtonPressed = !_isButtonPressed;
    });
  }
  
  void _toggleError() {
    setState(() {
      _errorText = _errorText == null ? 'This field has an error' : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF232D30), // Dark slate
      appBar: AppBar(
        title: const Text('UI Layer Components'),
        backgroundColor: const Color(0xFF232D30),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildArchitectureIntro(),
            const SizedBox(height: 32),
            
            _buildSectionTitle('ZinButton Variants'),
            _buildButtonVariantsShowcase(),
            
            const SizedBox(height: 32),
            _buildSectionTitle('ZinButton with Icons'),
            _buildButtonWithIconsShowcase(),
            
            const SizedBox(height: 32),
            _buildSectionTitle('ZinButton States'),
            _buildButtonStatesShowcase(),
            
            const SizedBox(height: 40),
            _buildSectionTitle('ZinTextField Variants'),
            _buildTextFieldVariantsShowcase(),
            
            const SizedBox(height: 32),
            _buildSectionTitle('ZinTextField States'),
            _buildTextFieldStatesShowcase(),
            
            const SizedBox(height: 40),
            _buildSectionTitle('ZinCard Variants'),
            _buildCardShowcase(),
            
            const SizedBox(height: 64),
          ],
        ),
      ),
    );
  }

  Widget _buildArchitectureIntro() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF232D30), // Dark slate
            const Color(0xFF232D30).withOpacity(0.8), // Transparent dark slate
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFD2FF4D).withOpacity(0.3), // Brand color with transparency
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Three-Layer Architecture',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFFD2FF4D), // Brand yellow
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'These components are part of the new UI layer, featuring strict separation between:',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          _buildArchitectureLayerInfo(
            icon: Icons.palette_outlined,
            layerName: 'UI Layer',
            description: 'Pure presentation components with no business logic',
            color: const Color(0xFFD2FF4D), // Brand yellow
          ),
          const SizedBox(height: 8),
          _buildArchitectureLayerInfo(
            icon: Icons.auto_awesome,
            layerName: 'Simulation Layer',
            description: 'Business logic, token economy, and gamification engine',
            color: Colors.lightBlue,
          ),
          const SizedBox(height: 8),
          _buildArchitectureLayerInfo(
            icon: Icons.storage_outlined,
            layerName: 'Data Layer',
            description: 'Data models, repositories, and sources',
            color: Colors.deepPurple[200]!,
          ),
        ],
      ),
    );
  }

  Widget _buildArchitectureLayerInfo({
    required IconData icon,
    required String layerName,
    required String description,
    required Color color,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                layerName,
                style: TextStyle(
                  color: color,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildButtonVariantsShowcase() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        ZinButton(
          label: 'Primary Button',
          onPressed: () {},
        ),
        ZinButton.secondary(
          label: 'Secondary Button',
          onPressed: () {},
        ),
        ZinButton.reward(
          label: 'Reward Button',
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildButtonWithIconsShowcase() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        ZinButton(
          label: 'With Icon',
          icon: Icons.add,
          onPressed: () {},
        ),
        ZinButton.secondary(
          label: 'With Icon',
          icon: Icons.arrow_forward,
          onPressed: () {},
        ),
        ZinButton.reward(
          label: 'With Icon',
          icon: Icons.emoji_events,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildButtonStatesShowcase() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            ZinButton(
              label: _isButtonPressed ? 'Pressed' : 'Click Me',
              onPressed: _toggleButtonState,
            ),
            ZinButton(
              label: 'Disabled Button',
              onPressed: null,
            ),
          ],
        ),
        const SizedBox(height: 16),
        ZinButton(
          label: 'Full Width Button',
          fullWidth: true,
          onPressed: () {},
        ),
        const SizedBox(height: 8),
        ZinButton.secondary(
          label: 'Full Width Secondary',
          fullWidth: true,
          onPressed: () {},
        ),
      ],
    );
  }
  
  Widget _buildTextFieldVariantsShowcase() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Standard variant
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ZinTextField(
            controller: _textController,
            labelText: 'Standard Variant',
            hintText: 'Enter text here',
            helperText: 'Helper text',
            showClearButton: true,
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Dark variant
        ZinTextField.dark(
          controller: _darkTextController,
          labelText: 'Dark Variant',
          hintText: 'For dark backgrounds',
          helperText: 'Helper text for dark variant',
          showClearButton: true,
        ),
        
        const SizedBox(height: 16),
        
        // Minimal variant
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ZinTextField.minimal(
            controller: _minimalTextController,
            labelText: 'Minimal Variant',
            hintText: 'Borderless until focused',
            helperText: 'Helper text for minimal style',
          ),
        ),
      ],
    );
  }
  
  Widget _buildTextFieldStatesShowcase() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // With icons
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ZinTextField(
            labelText: 'With Icons',
            prefixIcon: Icons.search,
            suffixIcon: Icons.mic,
            onSuffixIconTap: () {},
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Password field
        ZinTextField.dark(
          controller: _passwordController,
          labelText: 'Password Field',
          obscureText: true,
          prefixIcon: Icons.lock,
          suffixIcon: Icons.visibility,
          onSuffixIconTap: () {},
        ),
        
        const SizedBox(height: 16),
        
        // With error
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ZinTextField(
                labelText: 'Validation Example',
                errorText: _errorText,
              ),
              const SizedBox(height: 8),
              ZinButton(
                label: _errorText == null ? 'Show Error' : 'Clear Error',
                onPressed: _toggleError,
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Disabled field
        ZinTextField.dark(
          labelText: 'Disabled Field',
          hintText: 'This field is disabled',
          enabled: false,
        ),
      ],
    );
  }

  Widget _buildCardShowcase() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 16,
          runSpacing: 24,
          children: [
            SizedBox(
              width: 300,
              child: ZinCard(
                title: 'Standard Card',
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'This is a standard card with a title.',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
                onTap: () {},
              ),
            ),
            SizedBox(
              width: 300,
              child: ZinCard.elevated(
                title: 'Elevated Card',
                subtitle: 'With subtitle',
                trailing: IconButton(
                  icon: const Icon(Icons.more_vert, color: Colors.white),
                  onPressed: () {},
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'This card has higher elevation and a subtitle.',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 16,
          runSpacing: 24,
          children: [
            SizedBox(
              width: 300,
              child: ZinCard.outlined(
                title: 'Outlined Card',
                showHeaderDivider: true,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'This card has an outline instead of elevation.',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
                footer: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ZinButton.secondary(
                        label: 'Cancel',
                        onPressed: () {},
                      ),
                      const SizedBox(width: 8),
                      ZinButton(
                        label: 'Save',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                showFooterDivider: true,
              ),
            ),
            SizedBox(
              width: 300,
              child: ZinCard.light(
                title: 'Light Card',
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'This card has a light background.',
                    style: TextStyle(color: Color(0xFF232D30)),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: 300,
          child: ZinCard.reward(
            title: 'Reward Card',
            subtitle: 'Special styling for rewards',
            showHeaderDivider: true,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'This card has special styling for rewards and achievements.',
                style: TextStyle(color: Colors.white70),
              ),
            ),
            footer: Container(
              padding: const EdgeInsets.all(16.0),
              child: ZinButton.reward(
                label: 'Claim Reward',
                icon: Icons.emoji_events,
                fullWidth: true,
                onPressed: () {},
              ),
            ),
            showFooterDivider: true,
          ),
        ),
      ],
    );
  }
}
