class RewardInfo {
  final String title;
  final String subtitle;
  final String description;
  final String niatTitle;
  final String niatDescription;
  final String pahalaTitle;
  final String pahalaDescription;

  const RewardInfo({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.niatTitle,
    required this.niatDescription,
    required this.pahalaTitle,
    required this.pahalaDescription,
  });
}

class RewardInfoData {
  static const RewardInfo indonesian = RewardInfo(
    title: 'Tentang Pahala Kebaikan',
    subtitle: 'Simulasi Motivasi',
    description:
        'Pahala yang ditampilkan adalah representasi visual untuk memotivasi '
        'Anda (1 huruf = 10 pahala simbolis), bukan nilai pahala pasti di sisi Allah SWT.',
    niatTitle: 'Niat Ibadah',
    niatDescription:
        'Jadikan ridha Allah sebagai tujuan utama membaca Al-Qur\'an, bukan '
        'sekadar mengumpulkan pahala simbolis aplikasi.',
    pahalaTitle: 'Pahala Sesungguhnya',
    pahalaDescription:
        'Pahala yang sebenarnya hanya diketahui Allah dan bisa berlipat ganda '
        'tergantung keikhlasan dan kekhusyukan.',
  );

  static const RewardInfo english = RewardInfo(
    title: 'About Good Deeds Rewards',
    subtitle: 'Motivational Simulation',
    description:
        'The displayed rewards are visual representations to motivate you. '
        'This feature is not the actual reward value in the sight of Allah SWT.',
    niatTitle: 'Intention of Worship',
    niatDescription:
        'Make Allah\'s pleasure your ultimate goal. Understanding the Qur\'an '
        'is not merely about collecting symbolic app rewards.',
    pahalaTitle: 'True Rewards',
    pahalaDescription:
        'True rewards are known only to Allah and can be multiplied '
        'depending on sincerity and devotion.',
  );

  static RewardInfo getByLanguage(String languageCode) {
    return languageCode == 'id' ? indonesian : english;
  }
}
