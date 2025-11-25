import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/funfact_provider.dart';
import '../../core/providers/language_provider.dart';
import '../../core/models/funfact_model.dart';
import '../theme/app_theme.dart';
import '../widgets/page_transition.dart';
import 'funfact_screen.dart';

class FunfactListScreen extends StatefulWidget {
  const FunfactListScreen({super.key});

  @override
  State<FunfactListScreen> createState() => _FunfactListScreenState();
}

class _FunfactListScreenState extends State<FunfactListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final languageCode = Provider.of<LanguageProvider>(context, listen: false)
          .currentLocale
          .languageCode;
      final provider = context.read<FunfactProvider>();
      provider.loadDailyFunfact(languageCode: languageCode);
      provider.loadAllFunfacts();
    });
  }

  void _onSearchChanged() {
    context.read<FunfactProvider>().searchFunfacts(_searchController.text);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final languageCode =
        Provider.of<LanguageProvider>(context).currentLocale.languageCode;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppTheme.primaryGreen,
                AppTheme.darkGreen,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        toolbarHeight: 48,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          languageCode == 'en' ? 'Islamic Fun Facts' : 'Funfact Islam',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          // Search bar
          Container(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(fontSize: 16),
              decoration: InputDecoration(
                hintText: languageCode == 'en'
                    ? 'Search fun facts...'
                    : 'Cari funfact...',
                hintStyle: TextStyle(color: Colors.grey[400]),
                prefixIcon: Icon(Icons.search, color: AppTheme.primaryGreen),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 20),
                        onPressed: () => _searchController.clear(),
                      )
                    : null,
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
              ),
              onChanged: (value) => setState(() {}),
            ),
          ),
          // Filter chips
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Consumer<FunfactProvider>(
                builder: (context, provider, child) {
                  return Row(
                    children: [
                      _buildFilterChip(
                        languageCode == 'en' ? 'All' : 'Semua',
                        null,
                        provider,
                      ),
                      const SizedBox(width: 8),
                      _buildFilterChip('Funfact', 'funfact', provider),
                      const SizedBox(width: 8),
                      _buildFilterChip(
                        languageCode == 'en' ? 'Quran Facts' : 'Fakta Al-Quran',
                        'quran_fact',
                        provider,
                      ),
                      const SizedBox(width: 8),
                      _buildFilterChip('Hadith', 'hadith', provider),
                      const SizedBox(width: 8),
                      _buildFilterChip(
                        languageCode == 'en' ? 'Islamic Facts' : 'Fakta Islam',
                        'islam_fact',
                        provider,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          // Funfact list
          Expanded(
            child: Consumer<FunfactProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading && provider.funfacts.isEmpty) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppTheme.primaryGreen,
                    ),
                  );
                }

                final funfacts = provider.funfacts;

                if (funfacts.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.lightbulb_outline,
                          size: 80,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          languageCode == 'en'
                              ? 'No fun facts found'
                              : 'Belum ada funfact',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 20),
                  itemCount: funfacts.length,
                  itemBuilder: (context, index) {
                    return _buildFunfactCard(
                      context,
                      funfacts[index],
                      languageCode,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    String label,
    String? value,
    FunfactProvider provider,
  ) {
    final isSelected = provider.selectedCategory == value;
    return GestureDetector(
      onTap: () {
        provider.setCategory(value);
        provider.loadAllFunfacts();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          gradient: isSelected ? AppTheme.primaryGradient : null,
          color: isSelected ? null : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey[300]!,
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppTheme.primaryGreen.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[700],
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildFunfactCard(
    BuildContext context,
    FunfactModel funfact,
    String languageCode,
  ) {
    IconData categoryIcon;
    Color categoryColor;

    switch (funfact.category) {
      case 'funfact':
        categoryIcon = Icons.lightbulb_rounded;
        categoryColor = Colors.amber;
        break;
      case 'quran_fact':
        categoryIcon = Icons.menu_book_rounded;
        categoryColor = Colors.green;
        break;
      case 'hadith':
        categoryIcon = Icons.auto_stories_rounded;
        categoryColor = Colors.blue;
        break;
      case 'islam_fact':
        categoryIcon = Icons.mosque_rounded;
        categoryColor = Colors.purple;
        break;
      default:
        categoryIcon = Icons.info_rounded;
        categoryColor = Colors.grey;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            context.read<FunfactProvider>().setCurrentFunfact(funfact);
            Navigator.push(
              context,
              PageTransitions.slideRoute(const FunfactScreen()),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category icon
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: categoryColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    categoryIcon,
                    color: categoryColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        funfact.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        funfact.content.length > 100
                            ? '${funfact.content.substring(0, 100)}...'
                            : funfact.content,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                          height: 1.5,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: AppTheme.primaryGreen,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
