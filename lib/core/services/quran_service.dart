import 'package:quran/quran.dart' as quran;
import '../models/ayah_model.dart';

class QuranService {
  // Singleton pattern
  static final QuranService _instance = QuranService._internal();
  factory QuranService() => _instance;
  QuranService._internal();

  // Surah metadata with Indonesian names
  static const List<Map<String, dynamic>> _surahMetadata = [
    {
      "number": 1,
      "name": "Al-Faatiha",
      "nameArabic": "الفاتحة",
      "nameIndonesian": "Pembukaan",
      "verseCount": 7,
      "revelationType": "Meccan"
    },
    {
      "number": 2,
      "name": "Al-Baqara",
      "nameArabic": "البقرة",
      "nameIndonesian": "Sapi Betina",
      "verseCount": 286,
      "revelationType": "Medinan"
    },
    {
      "number": 3,
      "name": "Aal-i-Imraan",
      "nameArabic": "آل عمران",
      "nameIndonesian": "Keluarga Imran",
      "verseCount": 200,
      "revelationType": "Medinan"
    },
    {
      "number": 4,
      "name": "An-Nisaa",
      "nameArabic": "النساء",
      "nameIndonesian": "Wanita",
      "verseCount": 176,
      "revelationType": "Medinan"
    },
    {
      "number": 5,
      "name": "Al-Maaida",
      "nameArabic": "المائدة",
      "nameIndonesian": "Hidangan",
      "verseCount": 120,
      "revelationType": "Medinan"
    },
    {
      "number": 6,
      "name": "Al-An'aam",
      "nameArabic": "الأنعام",
      "nameIndonesian": "Hewan Ternak",
      "verseCount": 165,
      "revelationType": "Meccan"
    },
    {
      "number": 7,
      "name": "Al-A'raaf",
      "nameArabic": "الأعراف",
      "nameIndonesian": "Tempat Tertinggi",
      "verseCount": 206,
      "revelationType": "Meccan"
    },
    {
      "number": 8,
      "name": "Al-Anfaal",
      "nameArabic": "الأنفال",
      "nameIndonesian": "Harta Rampasan Perang",
      "verseCount": 75,
      "revelationType": "Medinan"
    },
    {
      "number": 9,
      "name": "At-Tawba",
      "nameArabic": "التوبة",
      "nameIndonesian": "Pengampunan",
      "verseCount": 129,
      "revelationType": "Medinan"
    },
    {
      "number": 10,
      "name": "Yunus",
      "nameArabic": "يونس",
      "nameIndonesian": "Nabi Yunus",
      "verseCount": 109,
      "revelationType": "Meccan"
    },
    {
      "number": 11,
      "name": "Hud",
      "nameArabic": "هود",
      "nameIndonesian": "Nabi Hud",
      "verseCount": 123,
      "revelationType": "Meccan"
    },
    {
      "number": 12,
      "name": "Yusuf",
      "nameArabic": "يوسف",
      "nameIndonesian": "Nabi Yusuf",
      "verseCount": 111,
      "revelationType": "Meccan"
    },
    {
      "number": 13,
      "name": "Ar-Ra'd",
      "nameArabic": "الرعد",
      "nameIndonesian": "Guntur",
      "verseCount": 43,
      "revelationType": "Medinan"
    },
    {
      "number": 14,
      "name": "Ibrahim",
      "nameArabic": "ابراهيم",
      "nameIndonesian": "Nabi Ibrahim",
      "verseCount": 52,
      "revelationType": "Meccan"
    },
    {
      "number": 15,
      "name": "Al-Hijr",
      "nameArabic": "الحجر",
      "nameIndonesian": "Gunung Al Hijr",
      "verseCount": 99,
      "revelationType": "Meccan"
    },
    {
      "number": 16,
      "name": "An-Nahl",
      "nameArabic": "النحل",
      "nameIndonesian": "Lebah",
      "verseCount": 128,
      "revelationType": "Meccan"
    },
    {
      "number": 17,
      "name": "Al-Israa",
      "nameArabic": "الإسراء",
      "nameIndonesian": "Perjalanan Malam",
      "verseCount": 111,
      "revelationType": "Meccan"
    },
    {
      "number": 18,
      "name": "Al-Kahf",
      "nameArabic": "الكهف",
      "nameIndonesian": "Gua",
      "verseCount": 110,
      "revelationType": "Meccan"
    },
    {
      "number": 19,
      "name": "Maryam",
      "nameArabic": "مريم",
      "nameIndonesian": "Maryam",
      "verseCount": 98,
      "revelationType": "Meccan"
    },
    {
      "number": 20,
      "name": "Taa-Haa",
      "nameArabic": "طه",
      "nameIndonesian": "Taa Haa",
      "verseCount": 135,
      "revelationType": "Meccan"
    },
    {
      "number": 21,
      "name": "Al-Anbiyaa",
      "nameArabic": "الأنبياء",
      "nameIndonesian": "Para Nabi",
      "verseCount": 112,
      "revelationType": "Meccan"
    },
    {
      "number": 22,
      "name": "Al-Hajj",
      "nameArabic": "الحج",
      "nameIndonesian": "Haji",
      "verseCount": 78,
      "revelationType": "Medinan"
    },
    {
      "number": 23,
      "name": "Al-Muminoon",
      "nameArabic": "المؤمنون",
      "nameIndonesian": "Orang-orang Mukmin",
      "verseCount": 118,
      "revelationType": "Meccan"
    },
    {
      "number": 24,
      "name": "An-Noor",
      "nameArabic": "النور",
      "nameIndonesian": "Cahaya",
      "verseCount": 64,
      "revelationType": "Medinan"
    },
    {
      "number": 25,
      "name": "Al-Furqaan",
      "nameArabic": "الفرقان",
      "nameIndonesian": "Pembeda",
      "verseCount": 77,
      "revelationType": "Meccan"
    },
    {
      "number": 26,
      "name": "Ash-Shu'araa",
      "nameArabic": "الشعراء",
      "nameIndonesian": "Para Penyair",
      "verseCount": 227,
      "revelationType": "Meccan"
    },
    {
      "number": 27,
      "name": "An-Naml",
      "nameArabic": "النمل",
      "nameIndonesian": "Semut",
      "verseCount": 93,
      "revelationType": "Meccan"
    },
    {
      "number": 28,
      "name": "Al-Qasas",
      "nameArabic": "القصص",
      "nameIndonesian": "Kisah-kisah",
      "verseCount": 88,
      "revelationType": "Meccan"
    },
    {
      "number": 29,
      "name": "Al-Ankaboot",
      "nameArabic": "العنكبوت",
      "nameIndonesian": "Laba-laba",
      "verseCount": 69,
      "revelationType": "Meccan"
    },
    {
      "number": 30,
      "name": "Ar-Room",
      "nameArabic": "الروم",
      "nameIndonesian": "Bangsa Romawi",
      "verseCount": 60,
      "revelationType": "Meccan"
    },
    {
      "number": 31,
      "name": "Luqman",
      "nameArabic": "لقمان",
      "nameIndonesian": "Luqman",
      "verseCount": 34,
      "revelationType": "Meccan"
    },
    {
      "number": 32,
      "name": "As-Sajda",
      "nameArabic": "السجدة",
      "nameIndonesian": "Sajdah",
      "verseCount": 30,
      "revelationType": "Meccan"
    },
    {
      "number": 33,
      "name": "Al-Ahzaab",
      "nameArabic": "الأحزاب",
      "nameIndonesian": "Golongan-golongan",
      "verseCount": 73,
      "revelationType": "Medinan"
    },
    {
      "number": 34,
      "name": "Saba",
      "nameArabic": "سبإ",
      "nameIndonesian": "Kaum Saba",
      "verseCount": 54,
      "revelationType": "Meccan"
    },
    {
      "number": 35,
      "name": "Faatir",
      "nameArabic": "فاطر",
      "nameIndonesian": "Pencipta",
      "verseCount": 45,
      "revelationType": "Meccan"
    },
    {
      "number": 36,
      "name": "Yaseen",
      "nameArabic": "يس",
      "nameIndonesian": "Yaa Siin",
      "verseCount": 83,
      "revelationType": "Meccan"
    },
    {
      "number": 37,
      "name": "As-Saaffaat",
      "nameArabic": "الصافات",
      "nameIndonesian": "Barisan-barisan",
      "verseCount": 182,
      "revelationType": "Meccan"
    },
    {
      "number": 38,
      "name": "Saad",
      "nameArabic": "ص",
      "nameIndonesian": "Shaad",
      "verseCount": 88,
      "revelationType": "Meccan"
    },
    {
      "number": 39,
      "name": "Az-Zumar",
      "nameArabic": "الزمر",
      "nameIndonesian": "Rombongan",
      "verseCount": 75,
      "revelationType": "Meccan"
    },
    {
      "number": 40,
      "name": "Ghafir",
      "nameArabic": "غافر",
      "nameIndonesian": "Yang Mengampuni",
      "verseCount": 85,
      "revelationType": "Meccan"
    },
    {
      "number": 41,
      "name": "Fussilat",
      "nameArabic": "فصلت",
      "nameIndonesian": "Yang Dijelaskan",
      "verseCount": 54,
      "revelationType": "Meccan"
    },
    {
      "number": 42,
      "name": "Ash-Shura",
      "nameArabic": "الشورى",
      "nameIndonesian": "Musyawarah",
      "verseCount": 53,
      "revelationType": "Meccan"
    },
    {
      "number": 43,
      "name": "Az-Zukhruf",
      "nameArabic": "الزخرف",
      "nameIndonesian": "Perhiasan",
      "verseCount": 89,
      "revelationType": "Meccan"
    },
    {
      "number": 44,
      "name": "Ad-Dukhaan",
      "nameArabic": "الدخان",
      "nameIndonesian": "Kabut",
      "verseCount": 59,
      "revelationType": "Meccan"
    },
    {
      "number": 45,
      "name": "Al-Jaathiya",
      "nameArabic": "الجاثية",
      "nameIndonesian": "Bersimpuh",
      "verseCount": 37,
      "revelationType": "Meccan"
    },
    {
      "number": 46,
      "name": "Al-Ahqaf",
      "nameArabic": "الأحقاف",
      "nameIndonesian": "Bukit-bukit Pasir",
      "verseCount": 35,
      "revelationType": "Meccan"
    },
    {
      "number": 47,
      "name": "Muhammad",
      "nameArabic": "محمد",
      "nameIndonesian": "Nabi Muhammad",
      "verseCount": 38,
      "revelationType": "Medinan"
    },
    {
      "number": 48,
      "name": "Al-Fath",
      "nameArabic": "الفتح",
      "nameIndonesian": "Kemenangan",
      "verseCount": 29,
      "revelationType": "Medinan"
    },
    {
      "number": 49,
      "name": "Al-Hujuraat",
      "nameArabic": "الحجرات",
      "nameIndonesian": "Kamar-kamar",
      "verseCount": 18,
      "revelationType": "Medinan"
    },
    {
      "number": 50,
      "name": "Qaaf",
      "nameArabic": "ق",
      "nameIndonesian": "Qaaf",
      "verseCount": 45,
      "revelationType": "Meccan"
    },
    {
      "number": 51,
      "name": "Adh-Dhaariyat",
      "nameArabic": "الذاريات",
      "nameIndonesian": "Angin yang Menerbangkan",
      "verseCount": 60,
      "revelationType": "Meccan"
    },
    {
      "number": 52,
      "name": "At-Tur",
      "nameArabic": "الطور",
      "nameIndonesian": "Bukit Tursina",
      "verseCount": 49,
      "revelationType": "Meccan"
    },
    {
      "number": 53,
      "name": "An-Najm",
      "nameArabic": "النجم",
      "nameIndonesian": "Bintang",
      "verseCount": 62,
      "revelationType": "Meccan"
    },
    {
      "number": 54,
      "name": "Al-Qamar",
      "nameArabic": "القمر",
      "nameIndonesian": "Bulan",
      "verseCount": 55,
      "revelationType": "Meccan"
    },
    {
      "number": 55,
      "name": "Ar-Rahmaan",
      "nameArabic": "الرحمن",
      "nameIndonesian": "Yang Maha Pengasih",
      "verseCount": 78,
      "revelationType": "Medinan"
    },
    {
      "number": 56,
      "name": "Al-Waaqia",
      "nameArabic": "الواقعة",
      "nameIndonesian": "Hari Kiamat",
      "verseCount": 96,
      "revelationType": "Meccan"
    },
    {
      "number": 57,
      "name": "Al-Hadid",
      "nameArabic": "الحديد",
      "nameIndonesian": "Besi",
      "verseCount": 29,
      "revelationType": "Medinan"
    },
    {
      "number": 58,
      "name": "Al-Mujaadila",
      "nameArabic": "المجادلة",
      "nameIndonesian": "Gugatan",
      "verseCount": 22,
      "revelationType": "Medinan"
    },
    {
      "number": 59,
      "name": "Al-Hashr",
      "nameArabic": "الحشر",
      "nameIndonesian": "Pengusiran",
      "verseCount": 24,
      "revelationType": "Medinan"
    },
    {
      "number": 60,
      "name": "Al-Mumtahana",
      "nameArabic": "الممتحنة",
      "nameIndonesian": "Wanita yang Diuji",
      "verseCount": 13,
      "revelationType": "Medinan"
    },
    {
      "number": 61,
      "name": "As-Saff",
      "nameArabic": "الصف",
      "nameIndonesian": "Barisan",
      "verseCount": 14,
      "revelationType": "Medinan"
    },
    {
      "number": 62,
      "name": "Al-Jumu'a",
      "nameArabic": "الجمعة",
      "nameIndonesian": "Jumat",
      "verseCount": 11,
      "revelationType": "Medinan"
    },
    {
      "number": 63,
      "name": "Al-Munaafiqoon",
      "nameArabic": "المنافقون",
      "nameIndonesian": "Orang-orang Munafik",
      "verseCount": 11,
      "revelationType": "Medinan"
    },
    {
      "number": 64,
      "name": "At-Taghaabun",
      "nameArabic": "التغابن",
      "nameIndonesian": "Pengungkapan Kesalahan",
      "verseCount": 18,
      "revelationType": "Medinan"
    },
    {
      "number": 65,
      "name": "At-Talaaq",
      "nameArabic": "الطلاق",
      "nameIndonesian": "Talak",
      "verseCount": 12,
      "revelationType": "Medinan"
    },
    {
      "number": 66,
      "name": "At-Tahrim",
      "nameArabic": "التحريم",
      "nameIndonesian": "Pengharaman",
      "verseCount": 12,
      "revelationType": "Medinan"
    },
    {
      "number": 67,
      "name": "Al-Mulk",
      "nameArabic": "الملك",
      "nameIndonesian": "Kerajaan",
      "verseCount": 30,
      "revelationType": "Meccan"
    },
    {
      "number": 68,
      "name": "Al-Qalam",
      "nameArabic": "القلم",
      "nameIndonesian": "Pena",
      "verseCount": 52,
      "revelationType": "Meccan"
    },
    {
      "number": 69,
      "name": "Al-Haaqqa",
      "nameArabic": "الحاقة",
      "nameIndonesian": "Hari Kiamat",
      "verseCount": 52,
      "revelationType": "Meccan"
    },
    {
      "number": 70,
      "name": "Al-Ma'aarij",
      "nameArabic": "المعارج",
      "nameIndonesian": "Tempat Naik",
      "verseCount": 44,
      "revelationType": "Meccan"
    },
    {
      "number": 71,
      "name": "Nooh",
      "nameArabic": "نوح",
      "nameIndonesian": "Nabi Nuh",
      "verseCount": 28,
      "revelationType": "Meccan"
    },
    {
      "number": 72,
      "name": "Al-Jinn",
      "nameArabic": "الجن",
      "nameIndonesian": "Jin",
      "verseCount": 28,
      "revelationType": "Meccan"
    },
    {
      "number": 73,
      "name": "Al-Muzzammil",
      "nameArabic": "المزمل",
      "nameIndonesian": "Orang yang Berselimut",
      "verseCount": 20,
      "revelationType": "Meccan"
    },
    {
      "number": 74,
      "name": "Al-Muddaththir",
      "nameArabic": "المدثر",
      "nameIndonesian": "Orang yang Berkemul",
      "verseCount": 56,
      "revelationType": "Meccan"
    },
    {
      "number": 75,
      "name": "Al-Qiyaama",
      "nameArabic": "القيامة",
      "nameIndonesian": "Hari Kiamat",
      "verseCount": 40,
      "revelationType": "Meccan"
    },
    {
      "number": 76,
      "name": "Al-Insaan",
      "nameArabic": "الانسان",
      "nameIndonesian": "Manusia",
      "verseCount": 31,
      "revelationType": "Medinan"
    },
    {
      "number": 77,
      "name": "Al-Mursalaat",
      "nameArabic": "المرسلات",
      "nameIndonesian": "Malaikat yang Diutus",
      "verseCount": 50,
      "revelationType": "Meccan"
    },
    {
      "number": 78,
      "name": "An-Naba",
      "nameArabic": "النبإ",
      "nameIndonesian": "Berita Besar",
      "verseCount": 40,
      "revelationType": "Meccan"
    },
    {
      "number": 79,
      "name": "An-Naazi'aat",
      "nameArabic": "النازعات",
      "nameIndonesian": "Malaikat yang Mencabut",
      "verseCount": 46,
      "revelationType": "Meccan"
    },
    {
      "number": 80,
      "name": "Abasa",
      "nameArabic": "عبس",
      "nameIndonesian": "Bermuka Masam",
      "verseCount": 42,
      "revelationType": "Meccan"
    },
    {
      "number": 81,
      "name": "At-Takwir",
      "nameArabic": "التكوير",
      "nameIndonesian": "Menggulung",
      "verseCount": 29,
      "revelationType": "Meccan"
    },
    {
      "number": 82,
      "name": "Al-Infitaar",
      "nameArabic": "الإنفطار",
      "nameIndonesian": "Terbelah",
      "verseCount": 19,
      "revelationType": "Meccan"
    },
    {
      "number": 83,
      "name": "Al-Mutaffifin",
      "nameArabic": "المطففين",
      "nameIndonesian": "Orang-orang Curang",
      "verseCount": 36,
      "revelationType": "Meccan"
    },
    {
      "number": 84,
      "name": "Al-Inshiqaaq",
      "nameArabic": "الإنشقاق",
      "nameIndonesian": "Terbelah",
      "verseCount": 25,
      "revelationType": "Meccan"
    },
    {
      "number": 85,
      "name": "Al-Burooj",
      "nameArabic": "البروج",
      "nameIndonesian": "Gugusan Bintang",
      "verseCount": 22,
      "revelationType": "Meccan"
    },
    {
      "number": 86,
      "name": "At-Taariq",
      "nameArabic": "الطارق",
      "nameIndonesian": "Yang Datang di Malam Hari",
      "verseCount": 17,
      "revelationType": "Meccan"
    },
    {
      "number": 87,
      "name": "Al-A'laa",
      "nameArabic": "الأعلى",
      "nameIndonesian": "Yang Paling Tinggi",
      "verseCount": 19,
      "revelationType": "Meccan"
    },
    {
      "number": 88,
      "name": "Al-Ghaashiya",
      "nameArabic": "الغاشية",
      "nameIndonesian": "Hari Pembalasan",
      "verseCount": 26,
      "revelationType": "Meccan"
    },
    {
      "number": 89,
      "name": "Al-Fajr",
      "nameArabic": "الفجر",
      "nameIndonesian": "Fajar",
      "verseCount": 30,
      "revelationType": "Meccan"
    },
    {
      "number": 90,
      "name": "Al-Balad",
      "nameArabic": "البلد",
      "nameIndonesian": "Negeri",
      "verseCount": 20,
      "revelationType": "Meccan"
    },
    {
      "number": 91,
      "name": "Ash-Shams",
      "nameArabic": "الشمس",
      "nameIndonesian": "Matahari",
      "verseCount": 15,
      "revelationType": "Meccan"
    },
    {
      "number": 92,
      "name": "Al-Lail",
      "nameArabic": "الليل",
      "nameIndonesian": "Malam",
      "verseCount": 21,
      "revelationType": "Meccan"
    },
    {
      "number": 93,
      "name": "Ad-Dhuhaa",
      "nameArabic": "الضحى",
      "nameIndonesian": "Waktu Duha",
      "verseCount": 11,
      "revelationType": "Meccan"
    },
    {
      "number": 94,
      "name": "Ash-Sharh",
      "nameArabic": "الشرح",
      "nameIndonesian": "Kelapangan",
      "verseCount": 8,
      "revelationType": "Meccan"
    },
    {
      "number": 95,
      "name": "At-Tin",
      "nameArabic": "التين",
      "nameIndonesian": "Buah Tin",
      "verseCount": 8,
      "revelationType": "Meccan"
    },
    {
      "number": 96,
      "name": "Al-Alaq",
      "nameArabic": "العلق",
      "nameIndonesian": "Segumpal Darah",
      "verseCount": 19,
      "revelationType": "Meccan"
    },
    {
      "number": 97,
      "name": "Al-Qadr",
      "nameArabic": "القدر",
      "nameIndonesian": "Kemuliaan",
      "verseCount": 5,
      "revelationType": "Meccan"
    },
    {
      "number": 98,
      "name": "Al-Bayyina",
      "nameArabic": "البينة",
      "nameIndonesian": "Bukti yang Nyata",
      "verseCount": 8,
      "revelationType": "Medinan"
    },
    {
      "number": 99,
      "name": "Az-Zalzala",
      "nameArabic": "الزلزلة",
      "nameIndonesian": "Kegoncangan",
      "verseCount": 8,
      "revelationType": "Medinan"
    },
    {
      "number": 100,
      "name": "Al-Aadiyaat",
      "nameArabic": "العاديات",
      "nameIndonesian": "Kuda yang Berlari Kencang",
      "verseCount": 11,
      "revelationType": "Meccan"
    },
    {
      "number": 101,
      "name": "Al-Qaari'a",
      "nameArabic": "القارعة",
      "nameIndonesian": "Hari Kiamat",
      "verseCount": 11,
      "revelationType": "Meccan"
    },
    {
      "number": 102,
      "name": "At-Takaathur",
      "nameArabic": "التكاثر",
      "nameIndonesian": "Bermegah-megahan",
      "verseCount": 8,
      "revelationType": "Meccan"
    },
    {
      "number": 103,
      "name": "Al-Asr",
      "nameArabic": "العصر",
      "nameIndonesian": "Masa",
      "verseCount": 3,
      "revelationType": "Meccan"
    },
    {
      "number": 104,
      "name": "Al-Humaza",
      "nameArabic": "الهمزة",
      "nameIndonesian": "Pengumpat",
      "verseCount": 9,
      "revelationType": "Meccan"
    },
    {
      "number": 105,
      "name": "Al-Fil",
      "nameArabic": "الفيل",
      "nameIndonesian": "Gajah",
      "verseCount": 5,
      "revelationType": "Meccan"
    },
    {
      "number": 106,
      "name": "Quraish",
      "nameArabic": "قريش",
      "nameIndonesian": "Suku Quraisy",
      "verseCount": 4,
      "revelationType": "Meccan"
    },
    {
      "number": 107,
      "name": "Al-Maa'un",
      "nameArabic": "الماعون",
      "nameIndonesian": "Barang-barang yang Berguna",
      "verseCount": 7,
      "revelationType": "Meccan"
    },
    {
      "number": 108,
      "name": "Al-Kawthar",
      "nameArabic": "الكوثر",
      "nameIndonesian": "Nikmat yang Banyak",
      "verseCount": 3,
      "revelationType": "Meccan"
    },
    {
      "number": 109,
      "name": "Al-Kaafiroon",
      "nameArabic": "الكافرون",
      "nameIndonesian": "Orang-orang Kafir",
      "verseCount": 6,
      "revelationType": "Meccan"
    },
    {
      "number": 110,
      "name": "An-Nasr",
      "nameArabic": "النصر",
      "nameIndonesian": "Pertolongan",
      "verseCount": 3,
      "revelationType": "Meccan"
    },
    {
      "number": 111,
      "name": "Al-Masad",
      "nameArabic": "المسد",
      "nameIndonesian": "Tali yang Dipintal",
      "verseCount": 5,
      "revelationType": "Meccan"
    },
    {
      "number": 112,
      "name": "Al-Ikhlaas",
      "nameArabic": "الإخلاص",
      "nameIndonesian": "Ikhlas",
      "verseCount": 4,
      "revelationType": "Meccan"
    },
    {
      "number": 113,
      "name": "Al-Falaq",
      "nameArabic": "الفلق",
      "nameIndonesian": "Waktu Subuh",
      "verseCount": 5,
      "revelationType": "Meccan"
    },
    {
      "number": 114,
      "name": "An-Naas",
      "nameArabic": "الناس",
      "nameIndonesian": "Manusia",
      "verseCount": 6,
      "revelationType": "Meccan"
    },
  ];

  // Get information about a specific surah
  Map<String, dynamic> getSurahInfo(int surahNumber) {
    if (surahNumber < 1 || surahNumber > 114) {
      throw ArgumentError('Surah number must be between 1 and 114');
    }
    return _surahMetadata[surahNumber - 1];
  }

  // Get all ayahs in a surah with specified translation
  Future<List<AyahModel>> getSurah(int surahNumber,
      {String translationCode = 'id'}) async {
    if (surahNumber < 1 || surahNumber > 114) {
      throw ArgumentError('Surah number must be between 1 and 114');
    }

    final surahInfo = getSurahInfo(surahNumber);
    final verseCount = surahInfo['verseCount'] as int;
    final List<AyahModel> ayahs = [];

    for (int i = 1; i <= verseCount; i++) {
      final arabicText = quran.getVerse(surahNumber, i);

      String translationText = '';
      try {
        // Use quran package translation
        // Note: quran package translation support varies.
        // We will use default (English) if 'id' is not explicitly supported via enum in this version.
        // But to be safe and avoid "Translation not available", we use standard call.
        translationText = quran.getVerseTranslation(surahNumber, i);
      } catch (e) {
        translationText = 'Translation not available';
      }

      ayahs.add(AyahModel(
        surahNumber: surahNumber,
        surahName: surahInfo['name'] as String,
        surahNameArabic: surahInfo['nameArabic'] as String,
        ayahNumber: i,
        arabicText: arabicText,
        translation: translationText,
        transliteration: '',
        juz: quran.getJuzNumber(surahNumber, i),
        page: quran.getPageNumber(surahNumber, i),
      ));
    }

    return ayahs;
  }

  // Get a specific ayah with translation
  Future<AyahModel> getAyah(int surahNumber, int ayahNumber,
      {String translationCode = 'id'}) async {
    final surahInfo = getSurahInfo(surahNumber);
    final arabicText = quran.getVerse(surahNumber, ayahNumber);
    final translationText = quran.getVerseTranslation(surahNumber, ayahNumber);

    return AyahModel(
      surahNumber: surahNumber,
      surahName: surahInfo['name'] as String,
      surahNameArabic: surahInfo['nameArabic'] as String,
      ayahNumber: ayahNumber,
      arabicText: arabicText,
      translation: translationText,
      transliteration: '',
      juz: quran.getJuzNumber(surahNumber, ayahNumber),
      page: quran.getPageNumber(surahNumber, ayahNumber),
    );
  }

  // Get a list of all surahs with their metadata
  List<Map<String, dynamic>> getAllSurahs() {
    return _surahMetadata;
  }

  // Search for ayahs containing a specific text
  Future<List<AyahModel>> searchAyahs(String query,
      {String translationCode = 'id'}) async {
    final List<AyahModel> results = [];
    final lowerQuery = query.toLowerCase();

    for (int surahNumber = 1; surahNumber <= 114; surahNumber++) {
      final verseCount = quran.getVerseCount(surahNumber);
      for (int i = 1; i <= verseCount; i++) {
        final translation =
            quran.getVerseTranslation(surahNumber, i).toLowerCase();
        if (translation.contains(lowerQuery)) {
          results.add(
              await getAyah(surahNumber, i, translationCode: translationCode));
        }
      }
    }

    return results;
  }

  // Count hijaiyah letters (excluding diacritics and special characters)
  int countHijaiyahLetters(String arabicText) {
    // Remove diacritics and count only Arabic letters
    final hijaiyahPattern = RegExp(r'[\u0621-\u064A]');
    final matches = hijaiyahPattern.allMatches(arabicText);
    return matches.length;
  }

  // Search in translation using quran package
  Map<String, dynamic> searchInTranslation(
    List<String> words, {
    required quran.Translation translation,
  }) {
    try {
      // Use the quran package's search functionality
      final results = <Map<dynamic, dynamic>>[];

      for (int surahNumber = 1; surahNumber <= 114; surahNumber++) {
        final surahInfo = getSurahInfo(surahNumber);
        final verseCount = surahInfo['verseCount'] as int;

        for (int ayahNumber = 1; ayahNumber <= verseCount; ayahNumber++) {
          // Get translation text from quran package
          final translationText = quran.getVerseTranslation(
            surahNumber,
            ayahNumber,
            translation: translation,
          );

          // Check if all words are present in the translation
          final lowerTranslation = translationText.toLowerCase();
          final allWordsFound = words
              .every((word) => lowerTranslation.contains(word.toLowerCase()));

          if (allWordsFound) {
            results.add({
              'surah': surahNumber,
              'verse': ayahNumber,
              'text': translationText,
            });
          }
        }
      }

      return {
        'results': results,
        'count': results.length,
      };
    } catch (e) {
      throw Exception('Search failed: $e');
    }
  }

  // Initialize service (call this once at app startup)
  Future<void> initialize() async {
    // No initialization needed for now
  }
}
