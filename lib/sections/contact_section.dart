// // lib/sections/contact_section.dart
// import 'package:flutter/material.dart';
// import 'dart:ui';
// import 'package:flutter_animate/flutter_animate.dart';
//
// class ContactSection extends StatefulWidget {
//   const ContactSection({Key? key}) : super(key: key);
//
//   @override
//   State<ContactSection> createState() => _ContactSectionState();
// }
//
// class _ContactSectionState extends State<ContactSection> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _messageController = TextEditingController();
//   bool _isSubmitting = false;
//   bool _isSuccess = false;
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _messageController.dispose();
//     super.dispose();
//   }
//
//   void _submitForm() {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _isSubmitting = true;
//       });
//
//       // Simulate API call
//       Future.delayed(const Duration(seconds: 2), () {
//         setState(() {
//           _isSubmitting = false;
//           _isSuccess = true;
//
//           // Reset form
//           _nameController.clear();
//           _emailController.clear();
//           _messageController.clear();
//         });
//
//         // Reset success message after some time
//         Future.delayed(const Duration(seconds: 3), () {
//           if (mounted) {
//             setState(() {
//               _isSuccess = false;
//             });
//           }
//         });
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final isDesktop = size.width >= 1024;
//     final isTablet = size.width >= 768 && size.width < 1024;
//     final isMobile = size.width < 768;
//
//     return Container(
//       padding: EdgeInsets.symmetric(
//         horizontal: isDesktop ? 80 : (isTablet ? 40 : 20),
//         vertical: 80,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Section header with glassmorphic effect
//           Center(
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(16),
//               child: BackdropFilter(
//                 filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                   decoration: BoxDecoration(
//                     color: Theme.of(context).colorScheme.tertiary.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(16),
//                     border: Border.all(
//                       color: Theme.of(context).colorScheme.tertiary.withOpacity(0.2),
//                       width: 1,
//                     ),
//                   ),
//                   child: Text(
//                     '📨 Get In Touch',
//                     style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                       color: Theme.of(context).colorScheme.tertiary,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 24),
//
//           // Section title
//           Center(
//             child: Text(
//               'Contact Me',
//               style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//                 fontWeight: FontWeight.bold,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//           const SizedBox(height: 16),
//
//           // Section description
//           Center(
//             child: SizedBox(
//               width: isDesktop ? 700 : double.infinity,
//               child: Text(
//                 "Let's collaborate on your next project. Feel free to reach out for freelance opportunities, job inquiries, or just to say hello!",
//                 style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                   color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
//                   height: 1.6,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),
//           const SizedBox(height: 64),
//
//           // Contact content
//           isMobile
//               ? _buildMobileContactContent(context)
//               : _buildDesktopContactContent(context),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDesktopContactContent(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Left side - contact info
//         Expanded(
//           flex: 5,
//           child: _buildContactInfo(context),
//         ),
//
//         const SizedBox(width: 48),
//
//         // Right side - contact form
//         Expanded(
//           flex: 7,
//           child: _buildContactForm(context),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildMobileContactContent(BuildContext context) {
//     return Column(
//       children: [
//         _buildContactInfo(context),
//         const SizedBox(height: 48),
//         _buildContactForm(context),
//       ],
//     );
//   }
//
//   Widget _buildContactInfo(BuildContext context) {
//     final contactItems = [
//       {
//         'icon': Icons.email_outlined,
//         'title': 'Email',
//         'content': 'hello@alexmorgan.dev',
//       },
//       {
//         'icon': Icons.phone_outlined,
//         'title': 'Phone',
//         'content': '+1 (555) 123-4567',
//       },
//       {
//         'icon': Icons.location_on_outlined,
//         'title': 'Location',
//         'content': 'San Francisco, CA',
//       },
//     ];
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Contact Information',
//           style: Theme.of(context).textTheme.titleLarge?.copyWith(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 24),
//         ...contactItems.asMap().entries.map((entry) {
//           final index = entry.key;
//           final item = entry.value;
//
//           return Padding(
//             padding: const EdgeInsets.only(bottom: 32),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Theme.of(context).colorScheme.tertiary.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Icon(
//                     item['icon'] as IconData,
//                     color: Theme.of(context).colorScheme.tertiary,
//                     size: 24,
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       item['title'] as String,
//                       style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       item['content'] as String,
//                       style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                         color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ).animate()
//               .fadeIn(duration: 600.ms, delay: (200 + index * 100).ms)
//               .slideX(begin: -30, end: 0, duration: 600.ms, curve: Curves.easeOutQuint);
//         }),
//         const SizedBox(height: 32),
//         Text(
//           'Follow Me',
//           style: Theme.of(context).textTheme.titleMedium?.copyWith(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 16),
//         Row(
//           children: [
//             _buildSocialButton(context, Icons.facebook, () {}),
//             const SizedBox(width: 16),
//             _buildSocialButton(context, Icons.photo_camera, () {}),
//             const SizedBox(width: 16),
//             _buildSocialButton(context, Icons.public, () {}),
//             const SizedBox(width: 16),
//             _buildSocialButton(context, Icons.messenger_outline, () {}),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _buildSocialButton(BuildContext context, IconData icon, VoidCallback onTap) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(12),
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Theme.of(context).colorScheme.surface,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 10,
//               spreadRadius: 2,
//             ),
//           ],
//         ),
//         child: Icon(
//           icon,
//           color: Theme.of(context).colorScheme.tertiary,
//           size: 24,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildContactForm(BuildContext context) {
//     return GlassmorphicContainer(
//       child: Padding(
//         padding: const EdgeInsets.all(32),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Send Me a Message',
//                 style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 32),
//               _buildTextField(
//                 context,
//                 controller: _nameController,
//                 label: 'Name',
//                 prefixIcon: Icons.person_outline,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your name';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 24),
//               _buildTextField(
//                 context,
//                 controller: _emailController,
//                 label: 'Email',
//                 prefixIcon: Icons.email_outlined,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your email';
//                   }
//                   if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
//                     return 'Please enter a valid email';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 24),
//               _buildTextField(
//                 context,
//                 controller: _messageController,
//                 label: 'Message',
//                 prefixIcon: Icons.message_outlined,
//                 maxLines: 5,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your message';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 32),
//               SizedBox(
//                 width: double.infinity,
//                 child: _buildSubmitButton(context),
//               ),
//               if (_isSuccess) ...[
//                 const SizedBox(height: 16),
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.green.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(
//                       color: Colors.green.withOpacity(0.3),
//                     ),
//                   ),
//                   child: Row(
//                     children: [
//                       const Icon(
//                         Icons.check_circle,
//                         color: Colors.green,
//                       ),
//                       const SizedBox(width: 16),
//                       Expanded(
//                         child: Text(
//                           'Your message has been sent successfully!',
//                           style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                             color: Colors.green,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ],
//           ),
//         ),
//       ),
//     ).animate()
//         .fadeIn(duration: 600.ms, delay: 300.ms)
//         .slideY(begin: 30, end: 0, duration: 600.ms, curve: Curves.easeOutQuint);
//   }
//
//   Widget _buildTextField(
//       BuildContext context, {
//         required TextEditingController controller,
//         required String label,
//         required IconData prefixIcon,
//         int maxLines = 1,
//         String? Function(String?)? validator,
//       }) {
//     return TextFormField(
//         controller: controller,
//         decoration: InputDecoration(
//         labelText: label,
//         prefixIcon: Icon(prefixIcon),
//     border: OutlineInputBorder(
//     borderRadius: BorderRadius.circular(12),
//     borderSide: BorderSide(
//     color: Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
//     ),
//     ),
//     enabledBorder: OutlineInputBorder(
//     borderRadius: BorderRadius.circular(12),
//     borderSide: BorderSide(
//     color: Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
//     ),
//     ),
//     focusedBorder: OutlineInputBorder(
//     borderRadius: BorderRadius.circular(12),
//     borderSide: BorderSide(
//     color: Theme.of(context).colorScheme.tertiary,
//     width: 2,
//     ),
//     ),
//     errorBorder: OutlineInputBorder(
//     borderRadius: BorderRadius.circular(12),
//     borderSide: BorderSide(
//     color: Theme.of(context).colorScheme.error,
//     ),
//     ),
//     filled: true,
//     fillColor: Theme.of(context).colorScheme.surface,
//     ),
//     style: Theme.of(context).textTheme.bodyLarge,