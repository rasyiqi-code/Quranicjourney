import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class AppStrings {
  static const Map<String, Map<String, String>> _strings = {
    'id': {
      'appTitle': 'Quranic Journey',
      'surahList': 'Daftar Surah',
      'translation': 'Terjemahan',
      'markRead': 'Tandai Dibaca',
      'pointsAdded': '+5 pahala! Ayat telah dibaca',
      'bookmarkAdded': 'Bookmark ditambahkan',
      'bookmarkRemoved': 'Bookmark dihapus',
      'autoPlayOn': 'Auto-Play Aktif',
      'autoPlayOff': 'Auto-Play Non-Aktif',
      'playAudio': 'Putar Audio',
      'pauseAudio': 'Jeda Audio',
      'prevAyah': 'Ayat Sebelumnya',
      'nextAyah': 'Ayat Selanjutnya',
      'settings': 'Pengaturan',
      'language': 'Bahasa',
      'selectLanguage': 'Pilih Bahasa',
      'cancel': 'Batal',
      // Home Screen
      'greetingMorning': 'Selamat Pagi',
      'greetingAfternoon': 'Selamat Siang',
      'greetingEvening': 'Selamat Sore',
      'greetingNight': 'Selamat Malam',
      // Features
      'featureReadQuran': 'Quran',
      'featureSurahList': 'Surah',
      'featureTadabbur': 'Tadabbur',
      'featureFunfact': 'Funfact',
      'featureSearch': 'Cari',
      'featureBookmark': 'Bookmark',
      'learningPath': 'Jalur Pembelajaran',
      'startSetup': 'Mulai Setup',
      'createPath': 'Buat jalur pembelajaran personal Anda',
      'level': 'Level',
      // Progress Card
      'yourProgress': 'Progress Anda',
      'keepLearning': 'Terus semangat belajar!',
      'ayah': 'Ayat',
      'streak': 'Streak',
      'points': 'Pahala',
      'progressToLevel': 'Target',
      // Donation
      'donation': 'Donasi',
      'donationDesc': 'Dukung pengembangan aplikasi ini',
      'donationDialogTitle': 'Dukung Kami',
      'donationDialogBody':
          'Aplikasi ini dibuat untuk umat. Dukungan Anda membantu kami terus mengembangkan fitur-fitur bermanfaat lainnya.',
      'donateNow': 'Donasi Sekarang',
      // Donation Tiers
      'donationScreenTitle': 'Dukung Quranic Journey',
      'donationScreenSubtitle': 'Pilih tier donasi Anda',
      'selectTier': 'Pilih Tier',
      'processing': 'Memproses...',
      'donationSuccess': 'Terima Kasih!',
      'donationSuccessMessage':
          'Jazakumullah khairan katsiran atas dukungan Anda. Semoga Allah membalas kebaikan Anda.',
      'donationFailed': 'Donasi Gagal',
      'donationFailedMessage': 'Maaf, terjadi kesalahan. Silakan coba lagi.',
      'tryAgain': 'Coba Lagi',
      'close': 'Tutup',
      'features': 'Benefit',
      // Tadabbur content (Indonesian)
      // Connection strings
      'connection_sedih':
          'Kesedihan adalah hal manusiawi, namun Allah menjanjikan bahwa setiap beban yang dipikul sesuai dengan kesanggupan hamba-Nya.',
      'connection_bingung':
          'Di saat bingung dan tidak tahu arah, ketakwaan adalah kompas yang akan membukakan jalan keluar dari arah yang tak disangka.',
      'connection_bersyukur':
          'Rasa syukur adalah kunci untuk membuka pintu nikmat yang lebih besar. Allah berjanji akan menambah nikmat bagi mereka yang bersyukur.',
      'connection_takut':
          'Rasa takut seringkali muncul dari ketidakpastian. Namun, cukuplah Allah sebagai penolong dan pelindung terbaik bagi orang beriman.',
      'connection_marah':
          'Kemarahan adalah api yang bisa memadamkan pahala. Orang yang kuat adalah yang mampu menahan amarahnya dan memaafkan orang lain.',
      'connection_bahagia':
          'Kebahagiaan sejati bukanlah dari harta duniawi, melainkan dari rahmat dan karunia Allah yang harus disyukuri.',
      'connection_khawatir':
          'Kekhawatiran hanya akan membebani pikiran. Obat hati yang paling ampuh adalah dengan mengingat Allah (Zikir).',
      'connection_putusAsa':
          'Putus asa bukanlah sifat orang beriman. Rahmat Allah jauh lebih luas daripada masalah yang sedang dihadapi.',
      'connection_bangga':
          'Kesombongan hanya akan menjauhkan diri dari manusia dan Allah. Ingatlah bahwa semua kelebihan adalah titipan-Nya.',
      'connection_cemas':
          'Kecemasan hilang saat kita menyadari bahwa Allah selalu mengingat hamba-Nya yang mengingat-Nya.',
      'connection_sakit':
          'Sakit adalah ujian sekaligus penggugur dosa. Allah menyembuhkan siapa yang Dia kehendaki.',
      'connection_kehilanganOrang':
          'Kehilangan itu berat, namun ketahuilah bahwa segala sesuatu adalah milik Allah dan akan kembali kepada-Nya.',
      'connection_stress':
          'Beban hidup terasa berat hingga dada terasa sesak. Namun ingatlah, bersama kesulitan pasti ada kemudahan.',
      'connection_sendiri':
          'Merasa kesepian di tengah keramaian? Ingatlah Allah lebih dekat kepadamu daripada urat lehermu sendiri.',
      'connection_sukses':
          'Kesuksesan adalah ujian syukur. Jangan sampai nikmat membuatmu lupa pada Sang Pemberi Nikmat.',
      'connection_gagal':
          'Kegagalan bukan akhir segalanya, melainkan cara Allah membelokkanmu ke jalan yang lebih baik.',
      'connection_iri':
          'Iri hati memakan kebaikan seperti api memakan kayu bakar. Janganlah iri pada karunia yang Allah berikan pada orang lain.',
      'connection_berdosa':
          'Sebesar apapun dosamu, ampunan Allah jauh lebih besar. Jangan pernah berputus asa dari rahmat-Nya.',
      'connection_tobat':
          'Keinginan untuk bertaubat adalah hidayah. Allah mencintai orang-orang yang bertaubat dan mensucikan diri.',
      'connection_lemah':
          'Manusia diciptakan bersifat lemah. Hanya dengan pertolongan Allah kita menjadi kuat.',
      'connection_kuat':
          'Kekuatan fisik dan mental adalah amanah. Gunakanlah untuk membela kebenaran dan menolong sesama.',
      'connection_ragu':
          'Keraguan datang dari setan. Kebenaran itu datangnya dari Tuhanmu, maka janganlah kamu termasuk orang yang ragu.',
      'connection_yakin':
          'Keyakinan yang teguh (Istiqomah) akan mendatangkan pertolongan malaikat dan kabar gembira.',
      'connection_gelisah':
          'Hati yang gelisah butuh sandaran. Tidak ada Tuhan selain Engkau, Maha Suci Engkau, sesungguhnya aku termasuk orang zalim.',
      'connection_tenang':
          'Wahai jiwa yang tenang, kembalilah kepada Tuhanmu dengan hati yang puas lagi diridhai-Nya.',
      'connection_lelah':
          'Rasa lelah adalah penghapus dosa. Istirahatlah, namun jangan menyerah. Allah bersama orang-orang yang sabar.',
      'connection_kecewa':
          'Boleh jadi kamu membenci sesuatu, padahal ia amat baik bagimu. Allah lebih tahu apa yang terbaik untukmu.',
      'connection_rindu':
          'Rindu itu berat, namun doa adalah jembatan terbaik. Curahkan kerinduanmu kepada Allah, Dia Maha Mendengar.',
      'connection_hutang':
          'Hutang adalah beban siang dan malam. Allah berjanji menolong hamba yang berniat kuat untuk melunasinya.',
      'connection_difitnah':
          'Fitnah itu kejam, namun Allah Maha Mengetahui. Bersabarlah, karena pembelaan Allah itu nyata.',
      // Reflection strings
      'reflection_sedih':
          'Tarik napas dalam-dalam. Ingatlah bahwa Allah tidak pernah menzalimi hamba-Nya. Ujian ini adalah tanda kasih sayang-Nya untuk mengangkat derajatmu.',
      'reflection_bingung':
          'Serahkan segala urusan kepada Allah setelah berusaha. Percayalah, Dia sedang mempersiapkan skenario terbaik untukmu.',
      'reflection_bersyukur':
          'Lihatlah sekelilingmu, betapa banyak nikmat yang sering terlupakan. Ucapkan Alhamdulillah dengan sepenuh hati.',
      'reflection_takut':
          'Ubah rasa takutmu menjadi rasa harap kepada Allah. Tidak ada yang bisa memberi manfaat atau mudharat kecuali atas izin-Nya.',
      'reflection_marah':
          'Saat amarah memuncak, ubahlah posisimu, berwudhulah. Memaafkan memang berat, tapi pahalanya surga seluas langit dan bumi.',
      'reflection_bahagia':
          'Jangan sampai kebahagiaan membuatmu lalai. Jadikan kebahagiaan ini sebagai sarana untuk lebih dekat dan taat kepada-Nya.',
      'reflection_khawatir':
          'Fokuslah pada apa yang bisa kamu kendalikan, dan serahkan sisanya pada Allah. Hati yang tenang lahir dari kepasrahan total.',
      'reflection_putusAsa':
          'Bangkitlah! Kegelapan malam akan selalu berganti dengan terangnya pagi. Pertolongan Allah sangat dekat bagi orang yang sabar.',
      'reflection_bangga':
          'Tundukkan hatimu. Apa yang kamu banggakan hari ini bisa diambil seketika. Jadilah padi, semakin berisi semakin merunduk.',
      'reflection_cemas':
          'Basahi lisanmu dengan zikir. Setiap kali kecemasan datang, lawan dengan "Hasbunallah Wanikmal Wakil".',
      'reflection_sakit':
          'Bersabarlah. Setiap rasa sakit yang menimpamu, bahkan tertusuk duri sekalipun, Allah hapuskan sebagian kesalahanmu.',
      'reflection_kehilanganOrang':
          'Ikhlaskanlah. Apa yang diambil darimu akan Allah ganti dengan yang lebih baik jika kamu bersabar dan ridha.',
      'reflection_stress':
          'Lapangkan dadamu dengan istighfar. Masalahmu tidak lebih besar dari kuasa Allah untuk menyelesaikannya.',
      'reflection_sendiri':
          'Jadikan kesendirianmu sebagai waktu eksklusif (Khalwat) bersama Allah. Curahkan semua isi hatimu pada-Nya.',
      'reflection_sukses':
          'Gunakan kesuksesanmu untuk memberi manfaat. Semakin tinggi pohon, semakin kencang angin, maka perkuat akarmu dengan sedekah.',
      'reflection_gagal':
          'Evaluasi dirimu, perbaiki niatmu. Mungkin Allah menundanya karena kamu belum siap menerima keberhasilan itu.',
      'reflection_iri':
          'Fokuslah pada nikmat yang kamu miliki. Rezeki sudah tertakar, tidak akan tertukar. Iri hanya menyiksa diri sendiri.',
      'reflection_berdosa':
          'Segeralah berwudhu dan shalat taubat. Air mata penyesalan adalah pemadam api neraka yang paling ampuh.',
      'reflection_tobat':
          'Mulailah lembaran baru hari ini. Allah tidak melihat masa lalumu, tapi melihat kesungguhanmu hari ini.',
      'reflection_lemah':
          'Akui kelemahanmu di hadapan Allah. Saat kamu merasa lemah, saat itulah kamu paling dekat dengan pertolongan-Nya.',
      'reflection_kuat':
          'Jangan sombong dengan kekuatanmu. Ingatlah Firaun dan Qarun hancur karena merasa kuat dan kaya.',
      'reflection_ragu':
          'Pelajari Al-Quran, bertanyalah pada ahli ilmu. Ilmu adalah obat dari keraguan.',
      'reflection_yakin':
          'Pertahankan keyakinanmu meski dunia menggoyahkan. Surga adalah balasan bagi mereka yang teguh pendirian.',
      'reflection_gelisah':
          'Perbanyak doa Nabi Yunus. Kegelapan perut ikan pun bisa sirna dengan doa ini, apalagi kegelisahan hatimu.',
      'reflection_tenang':
          'Pertahankan ketenangan ini dengan menjaga shalat dan tilawah. Inilah rasa surga sebelum surga yang sesungguhnya.',
      'reflection_lelah':
          'Dunia adalah tempat berlelah-lelah. Istirahat sejati hanya ada di Surga. Jadikan lelahmu sebagai Lillah.',
      'reflection_kecewa':
          'Kekecewaan hadir karena berharap pada manusia. Gantungkan harapanmu hanya pada Allah, niscaya hatimu takkan patah.',
      'reflection_rindu':
          'Setiap perpisahan pasti menyakitkan. Namun ingatlah, pertemuan terindah adalah pertemuan di Surga-Nya kelak.',
      'reflection_hutang':
          'Niatkan kuat untuk melunasi dan jauhi riba. Allah akan membukakan jalan keluar dari arah yang tak disangka.',
      'reflection_difitnah':
          'Jangan sibuk klarifikasi pada pembencimu. Cukup Allah yang menjadi Saksi dan Pembelamu.',
      // Brief Tafsir strings
      'tafsir_sedih':
          'Allah menegaskan tidak membebani di luar kemampuan. Setiap kesulitan ada kemudahan.',
      'tafsir_bingung':
          'Janji Allah: Takwa adalah kunci solusi dan rezeki tak terduga.',
      'tafsir_bersyukur':
          'Hukum kepastian Allah: Syukur pasti menambah nikmat, kufur mengundang azab.',
      'tafsir_takut':
          'Kisah para sahabat yang hanya takut pada Allah, maka Allah cukupkan urusan mereka.',
      'tafsir_marah':
          'Ciri penghuni surga: Menahan amarah dan memaafkan, meski mampu membalas.',
      'tafsir_bahagia':
          'Karunia Allah lebih baik dari segala harta yang dikumpulkan manusia.',
      'tafsir_khawatir':
          'Hanya dengan mengingat Allah (Zikrullah) hati menjadi tenang dan damai.',
      'tafsir_putusAsa':
          'Larangan berputus asa, karena itu sifat orang yang tidak mengenal kebesaran Allah.',
      'tafsir_bangga':
          'Nasihat Luqman: Jangan memalingkan muka dan berjalan angkuh. Allah tidak suka kesombongan.',
      'tafsir_cemas':
          'Ingatlah Allah dalam senang dan susah, niscaya Allah akan mengingatmu dengan pertolongan-Nya.',
      'tafsir_sakit':
          'Doa Nabi Ibrahim: "Dan apabila aku sakit, Dialah yang menyembuhkan aku."',
      'tafsir_kehilanganOrang':
          'Ujian kesabaran: "Inna lillahi wa inna ilaihi raji\'un" saat tertimpa musibah.',
      'tafsir_stress':
          'Surah Al-Insyirah: Allah melapangkan dada dan meringankan beban Nabi Muhammad SAW.',
      'tafsir_sendiri':
          'Allah Maha Dekat: Dia mengetahui apa yang dibisikkan hati manusia.',
      'tafsir_sukses':
          'Kisah Nabi Sulaiman yang bersyukur: "Ini adalah karunia Tuhanku untuk mengujiku."',
      'tafsir_gagal':
          'Jangan bersedih: Jika kamu beriman, kamu adalah orang yang paling tinggi derajatnya.',
      'tafsir_iri':
          'Larangan Iri: Janganlah kamu iri hati terhadap karunia yang Allah berikan kepada sebagian kamu.',
      'tafsir_berdosa':
          'Seruan Harapan: Wahai hamba-Ku yang melampaui batas, jangan putus asa dari rahmat Allah.',
      'tafsir_tobat':
          'Perintah Taubat: Bertaubatlah kepada Allah dengan taubat yang semurni-murninya (Taubatan Nasuha).',
      'tafsir_lemah':
          'Hakikat Manusia: Allah hendak memberikan keringanan, karena manusia diciptakan bersifat lemah.',
      'tafsir_kuat':
          'Sumber Kekuatan: Allah-lah yang menguatkanmu dengan pertolongan-Nya.',
      'tafsir_ragu':
          'Kebenaran Mutlak: Kebenaran itu dari Tuhanmu, janganlah sekali-kali kamu ragu.',
      'tafsir_yakin':
          'Janji Istiqomah: Malaikat akan turun menenangkan mereka yang berkata "Tuhan kami adalah Allah" lalu istiqomah.',
      'tafsir_gelisah':
          'Doa Nabi Yunus: Pengakuan tauhid dan dosa sebagai jalan keluar dari kesulitan.',
      'tafsir_tenang':
          'Panggilan Terindah: Panggilan Allah kepada jiwa yang tenang untuk masuk ke dalam surga-Nya.',
      'tafsir_lelah':
          'Perintah Sabar: Jadikan sabar dan shalat sebagai penolongmu dalam menghadapi kelelahan hidup.',
      'tafsir_kecewa':
          'Hikmah di balik takdir: Apa yang luput darimu tidak akan pernah mengenaimu.',
      'tafsir_rindu':
          'Kisah Nabi Yaqub: "Hanya kepada Allah aku mengadukan kesusahan dan kesedihanku."',
      'tafsir_hutang':
          'Ayat hutang adalah yang terpanjang, menunjukkan pentingnya pencatatan dan niat melunasi.',
      'tafsir_difitnah':
          'Kisah Aisyah RA: Jangan mengira fitnah itu buruk bagimu, bahkan itu baik bagimu (penggugur dosa).',
      // Key Points (Indonesian)
      // Sedih
      'kp_sedih_1': 'Allah tidak membebani di luar kemampuan',
      'kp_sedih_2': 'Kesulitan selalu disertai kemudahan',
      'kp_sedih_3': 'Sabar akan berbuah pahala tanpa batas',
      // Bingung
      'kp_bingung_1': 'Takwa adalah jalan keluar masalah',
      'kp_bingung_2': 'Rezeki datang dari arah tak disangka',
      'kp_bingung_3': 'Tawakkal setelah berusaha maksimal',
      // Bersyukur
      'kp_bersyukur_1': 'Syukur menambah nikmat',
      'kp_bersyukur_2': 'Kufur nikmat mengundang azab',
      'kp_bersyukur_3': 'Syukur hati, lisan, dan perbuatan',
      // Takut
      'kp_takut_1': 'Cukuplah Allah sebagai Penolong',
      'kp_takut_2': 'Rasa takut hanya kepada Allah',
      'kp_takut_3': 'Iman mengusir rasa takut duniawi',
      // Marah
      'kp_marah_1': 'Menahan amarah ciri orang bertakwa',
      'kp_marah_2': 'Memaafkan lebih mulia dari membalas',
      'kp_marah_3': 'Allah menyukai orang yang berbuat baik',
      // Bahagia
      'kp_bahagia_1': 'Rahmat Allah lebih baik dari harta',
      'kp_bahagia_2': 'Bahagia harus mendekatkan pada Allah',
      'kp_bahagia_3': 'Berbagi kebahagiaan dengan sesama',
      // Khawatir
      'kp_khawatir_1': 'Hati tenang dengan mengingat Allah',
      'kp_khawatir_2': 'Fokus pada janji Allah, bukan ketakutan',
      'kp_khawatir_3': 'Zikir adalah obat kegelisahan',
      // Putus Asa
      'kp_putusAsa_1': 'Rahmat Allah meliputi segala sesuatu',
      'kp_putusAsa_2': 'Jangan berputus asa dari rahmat-Nya',
      'kp_putusAsa_3': 'Harapan selalu ada bagi orang beriman',
      // Bangga
      'kp_bangga_1': 'Jangan memalingkan muka (sombong)',
      'kp_bangga_2': 'Allah tidak suka orang angkuh',
      'kp_bangga_3': 'Rendah hati (Tawadhu)',
      // Cemas
      'kp_cemas_1': 'Ingat Allah, Allah ingat kamu',
      'kp_cemas_2': 'Syukur menambah nikmat',
      'kp_cemas_3': 'Sabar dalam ujian',
      // Sakit
      'kp_sakit_1': 'Allah yang menyembuhkan',
      'kp_sakit_2': 'Sakit penggugur dosa',
      'kp_sakit_3': 'Tawakkal pada kesembuhan',
      // Kehilangan Orang
      'kp_kehilanganOrang_1': 'Semua milik Allah',
      'kp_kehilanganOrang_2': 'Sabar saat musibah pertama',
      'kp_kehilanganOrang_3': 'Allah ganti yang lebih baik',
      // Stress
      'kp_stress_1': 'Kelapangan dada adalah anugerah',
      'kp_stress_2': 'Kesulitan bersama kemudahan',
      'kp_stress_3': 'Fokus akhirat meringankan dunia',
      // Sendiri
      'kp_sendiri_1': 'Allah lebih dekat dari urat leher',
      'kp_sendiri_2': 'Allah tahu isi hati',
      'kp_sendiri_3': 'Manfaatkan kesendirian untuk doa',
      // Sukses
      'kp_sukses_1': 'Sukses adalah ujian',
      'kp_sukses_2': 'Syukur menjaga nikmat',
      'kp_sukses_3': 'Jangan lalai karena harta',
      // Gagal
      'kp_gagal_1': 'Jangan lemah dan bersedih',
      'kp_gagal_2': 'Orang beriman paling tinggi derajatnya',
      'kp_gagal_3': 'Gagal adalah pelajaran berharga',
      // Iri
      'kp_iri_1': 'Jangan iri rezeki orang lain',
      'kp_iri_2': 'Setiap orang punya bagiannya',
      'kp_iri_3': 'Minta karunia pada Allah',
      // Berdosa
      'kp_berdosa_1': 'Jangan putus asa rahmat Allah',
      'kp_berdosa_2': 'Allah mengampuni semua dosa',
      'kp_berdosa_3': 'Taubat menghapus kesalahan',
      // Tobat
      'kp_tobat_1': 'Taubat nasuha diterima',
      'kp_tobat_2': 'Jaga diri dan keluarga dari api neraka',
      'kp_tobat_3': 'Istiqomah setelah taubat',
      // Lemah
      'kp_lemah_1': 'Manusia diciptakan lemah',
      'kp_lemah_2': 'Allah meringankan beban hamba-Nya',
      'kp_lemah_3': 'Kekuatan datang dari ketaatan',
      // Kuat
      'kp_kuat_1': 'Allah menguatkan orang beriman',
      'kp_kuat_2': 'Kekuatan untuk berjuang di jalan Allah',
      'kp_kuat_3': 'Jangan sombong dengan fisik',
      // Ragu
      'kp_ragu_1': 'Kebenaran datang dari Tuhanmu',
      'kp_ragu_2': 'Jangan termasuk orang ragu',
      'kp_ragu_3': 'Yakin adalah kunci ketenangan',
      // Yakin
      'kp_yakin_1': 'Teguh pendirian (Istiqomah)',
      'kp_yakin_2': 'Malaikat turun membawa kabar gembira',
      'kp_yakin_3': 'Jangan takut dan sedih',
      // Gelisah
      'kp_gelisah_1': 'Tiada Tuhan selain Allah',
      'kp_gelisah_2': 'Akui kesalahan diri',
      'kp_gelisah_3': 'Doa senjata orang mukmin',
      // Tenang
      'kp_tenang_1': 'Jiwa tenang diridhai Allah',
      'kp_tenang_2': 'Kembali pada Tuhan dengan puas',
      'kp_tenang_3': 'Masuk ke dalam Surga-Nya',
      // Lelah
      'kp_lelah_1': 'Lelah jadi Lillah',
      'kp_lelah_2': 'Sabar dan Shalat',
      'kp_lelah_3': 'Istirahat secukupnya',
      // Kecewa
      'kp_kecewa_1': 'Allah Maha Tahu',
      'kp_kecewa_2': 'Hikmah Tersembunyi',
      'kp_kecewa_3': 'Ridha pada Takdir',
      // Rindu
      'kp_rindu_1': 'Doa obat rindu',
      'kp_rindu_2': 'Pertemuan di Surga',
      'kp_rindu_3': 'Curhat pada Allah',
      // Hutang
      'kp_hutang_1': 'Niat Lunas',
      'kp_hutang_2': 'Usaha',
      'kp_hutang_3': 'Doa',
      // Difitnah
      'kp_difitnah_1': 'Allah Pembela',
      'kp_difitnah_2': 'Diam itu Emas',
      'kp_difitnah_3': 'Penggugur Dosa',
    },
    'en': {
      'appTitle': 'Quranic Journey',
      'surahList': 'Surah List',
      'translation': 'Translation',
      'markRead': 'Mark as Read',
      'pointsAdded': '+5 rewards! Ayah marked as read',
      'bookmarkAdded': 'Bookmark added',
      'bookmarkRemoved': 'Bookmark removed',
      'autoPlayOn': 'Auto-Play On',
      'autoPlayOff': 'Auto-Play Off',
      'playAudio': 'Play Audio',
      'pauseAudio': 'Pause Audio',
      'prevAyah': 'Previous Ayah',
      'nextAyah': 'Next Ayah',
      'settings': 'Settings',
      'language': 'Language',
      'selectLanguage': 'Select Language',
      'cancel': 'Cancel',
      // Home Screen
      'greetingMorning': 'Good Morning',
      'greetingAfternoon': 'Good Afternoon',
      'greetingEvening': 'Good Evening',
      'greetingNight': 'Good Night',
      // Features
      'featureReadQuran': 'Quran',
      'featureSurahList': 'Surah',
      'featureTadabbur': 'Tadabbur',
      'featureFunfact': 'Funfact',
      'featureSearch': 'Search',
      'featureBookmark': 'Bookmark',
      'learningPath': 'Learning Path',
      'startSetup': 'Start Setup',
      'createPath': 'Create your personal learning path',
      'level': 'Level',
      // Progress Card
      'yourProgress': 'Your Progress',
      'keepLearning': 'Keep learning!',
      'ayah': 'Ayah',
      'streak': 'Streak',
      'points': 'Rewards',
      'progressToLevel': 'Target',
      // Donation
      'donation': 'Donation',
      'donationDesc': 'Support app development',
      'donationDialogTitle': 'Support Us',
      'donationDialogBody':
          'This app is built for the Ummah. Your support helps us continue developing useful features.',
      'donateNow': 'Donate Now',
      // Donation Tiers
      'donationScreenTitle': 'Support Quranic Journey',
      'donationScreenSubtitle': 'Choose your donation tier',
      'selectTier': 'Select Tier',
      'processing': 'Processing...',
      'donationSuccess': 'Thank You!',
      'donationSuccessMessage':
          'Jazakumullah khairan katsiran for your support. May Allah reward you.',
      'donationFailed': 'Donation Failed',
      'donationFailedMessage': 'Sorry, an error occurred. Please try again.',
      'tryAgain': 'Try Again',
      'close': 'Close',
      'features': 'Benefits',
      // Tadabbur content (English)
      // Connection strings
      'connection_sedih':
          'Sadness is human, but Allah promises that every burden is within His servant\'s capacity.',
      'connection_bingung':
          'When confused and lost, Taqwa is the compass that opens a way out from unexpected directions.',
      'connection_bersyukur':
          'Gratitude is the key to unlocking greater blessings. Allah promises to increase favors for those who are grateful.',
      'connection_takut':
          'Fear often stems from uncertainty. However, Allah is sufficient as the best Helper and Protector for believers.',
      'connection_marah':
          'Anger is a fire that can extinguish rewards. The strong person is one who can control their anger and forgive others.',
      'connection_bahagia':
          'True happiness is not from worldly wealth, but from Allah\'s mercy and grace which must be appreciated.',
      'connection_khawatir':
          'Worry only burdens the mind. The most effective medicine for the heart is remembering Allah (Dhikr).',
      'connection_putusAsa':
          'Despair is not a trait of a believer. Allah\'s mercy is far wider than any problem being faced.',
      'connection_bangga':
          'Arrogance only distances oneself from people and Allah. Remember that all advantages are His trust.',
      'connection_cemas':
          'Anxiety disappears when we realize that Allah always remembers His servants who remember Him.',
      'connection_sakit':
          'Illness is a test and a purifier of sins. Allah heals whom He wills.',
      'connection_kehilanganOrang':
          'Loss is heavy, but know that everything belongs to Allah and will return to Him.',
      'connection_stress':
          'Life\'s burdens feel heavy until the chest feels tight. But remember, with hardship comes ease.',
      'connection_sendiri':
          'Feeling lonely in a crowd? Remember Allah is closer to you than your jugular vein.',
      'connection_sukses':
          'Success is a test of gratitude. Do not let blessings make you forget the Giver of Blessings.',
      'connection_gagal':
          'Failure is not the end, but Allah\'s way of redirecting you to a better path.',
      'connection_iri':
          'Envy consumes goodness like fire consumes wood. Do not envy the gifts Allah has given to others.',
      'connection_berdosa':
          'No matter how great your sin, Allah\'s forgiveness is greater. Never despair of His mercy.',
      'connection_tobat':
          'The desire to repent is guidance. Allah loves those who repent and purify themselves.',
      'connection_lemah':
          'Humans are created weak. Only with Allah\'s help do we become strong.',
      'connection_kuat':
          'Physical and mental strength is a trust. Use it to defend truth and help others.',
      'connection_ragu':
          'Doubt comes from Satan. Truth comes from your Lord, so do not be among those who doubt.',
      'connection_yakin':
          'Firm belief (Istiqomah) will bring the help of angels and good tidings.',
      'connection_gelisah':
          'A restless heart needs a support. There is no deity except You, Exalted are You, indeed I have been of the wrongdoers.',
      'connection_tenang':
          'O reassured soul, return to your Lord, well-pleased and pleasing [to Him].',
      'connection_lelah':
          'Fatigue is a cleanser of sins. Rest, but do not give up. Allah is with the patient.',
      'connection_kecewa':
          'Perhaps you dislike a thing and it is good for you. Allah knows best what is good for you.',
      'connection_rindu':
          'Longing is heavy, but prayer is the best bridge. Pour out your longing to Allah, He is All-Hearing.',
      'connection_hutang':
          'Debt is a burden day and night. Allah promises to help the servant who intends to pay it off.',
      'connection_difitnah':
          'Slander is cruel, but Allah is All-Knowing. Be patient, for your silence is gold and Allah\'s defense is real.',
      // Reflection strings
      'reflection_sedih':
          'Take a deep breath. Remember that Allah never wrongs His servants. This test is a sign of His love to raise your rank.',
      'reflection_bingung':
          'Surrender all affairs to Allah after striving. Trust that He is preparing the best scenario for you.',
      'reflection_bersyukur':
          'Look around you, how many blessings are often forgotten. Say Alhamdulillah with all your heart.',
      'reflection_takut':
          'Turn your fear into hope in Allah. Nothing can benefit or harm except by His permission.',
      'reflection_marah':
          'When anger peaks, change your position, perform wudu. Forgiving is hard, but the reward is Paradise as wide as heavens and earth.',
      'reflection_bahagia':
          'Do not let happiness make you negligent. Make this happiness a means to be closer and obedient to Him.',
      'reflection_khawatir':
          'Focus on what you can control, and leave the rest to Allah. A calm heart is born from total surrender.',
      'reflection_putusAsa':
          'Rise up! The darkness of night will always be replaced by the brightness of morning. Allah\'s help is very near for the patient.',
      'reflection_bangga':
          'Humble your heart. What you boast of today can be taken instantly. Be like rice, the fuller it gets, the more it bows.',
      'reflection_cemas':
          'Moisten your tongue with dhikr. Whenever anxiety comes, fight it with "Hasbunallah Wanikmal Wakil".',
      'reflection_sakit':
          'Be patient. Every pain that befalls you, even a prick of a thorn, Allah erases some of your mistakes.',
      'reflection_kehilanganOrang':
          'Let it go. What is taken from you, Allah will replace with something better if you are patient and pleased.',
      'reflection_stress':
          'Expand your chest with Istighfar. Your problem is not bigger than Allah\'s power to solve it.',
      'reflection_sendiri':
          'Make your solitude an exclusive time (Khalwat) with Allah. Pour out all your heart\'s content to Him.',
      'reflection_sukses':
          'Use your success to benefit others. The higher the tree, the stronger the wind, so strengthen your roots with charity.',
      'reflection_gagal':
          'Evaluate yourself, correct your intention. Maybe Allah delayed it because you were not ready to receive that success.',
      'reflection_iri':
          'Focus on the blessings you have. Provision is measured, it will not be swapped. Envy only tortures yourself.',
      'reflection_berdosa':
          'Immediately perform wudu and prayer of repentance. Tears of regret are the most effective extinguisher of Hellfire.',
      'reflection_tobat':
          'Start a new page today. Allah does not look at your past, but looks at your sincerity today.',
      'reflection_lemah':
          'Admit your weakness before Allah. When you feel weak, that is when you are closest to His help.',
      'reflection_kuat':
          'Do not be arrogant with your strength. Remember Pharaoh and Qarun were destroyed because they felt strong and rich.',
      'reflection_ragu':
          'Study the Quran, ask the people of knowledge. Knowledge is the cure for doubt.',
      'reflection_yakin':
          'Maintain your belief even if the world shakes it. Paradise is the reward for those who stand firm.',
      'reflection_gelisah':
          'Increase the prayer of Prophet Yunus. The darkness of the whale\'s belly could vanish with this prayer, let alone the restlessness of your heart.',
      'reflection_tenang':
          'Maintain this peace by guarding prayer and recitation. This is the taste of Paradise before the real Paradise.',
      'reflection_lelah':
          'The world is a place of fatigue. True rest is only in Paradise. Make your fatigue for Allah (Lillah).',
      'reflection_kecewa':
          'Disappointment comes from hoping in humans. Hang your hope only on Allah, and your heart will never break.',
      'reflection_rindu':
          'Every parting is painful. But remember, the most beautiful meeting is the meeting in His Paradise.',
      'reflection_hutang':
          'Intend strongly to pay off and stay away from usury (Riba). Allah will open a way out from unexpected directions.',
      'reflection_difitnah':
          'Do not be busy clarifying to those who hate you. Allah is enough as a Witness and your Defender.',
      // Brief Tafsir strings
      'tafsir_sedih':
          'Allah confirms He does not burden beyond capacity. With hardship comes ease.',
      'tafsir_bingung':
          'Allah\'s Promise: Taqwa is the key to solutions and unexpected provision.',
      'tafsir_bersyukur':
          'Allah\'s Law: Gratitude surely increases blessings, ingratitude invites punishment.',
      'tafsir_takut':
          'Story of companions who feared only Allah, so Allah sufficed their affairs.',
      'tafsir_marah':
          'Trait of Paradise dwellers: Restraining anger and forgiving, even when able to retaliate.',
      'tafsir_bahagia':
          'Allah\'s bounty is better than all wealth collected by humans.',
      'tafsir_khawatir':
          'Only by remembering Allah (Dhikr) do hearts find rest and peace.',
      'tafsir_putusAsa':
          'Prohibition of despair, as it is a trait of those who do not know Allah\'s greatness.',
      'tafsir_bangga':
          'Luqman\'s advice: Do not turn your cheek in contempt and walk insolently. Allah dislikes arrogance.',
      'tafsir_cemas':
          'Remember Allah in ease and hardship, surely Allah will remember you with His help.',
      'tafsir_sakit':
          'Prophet Ibrahim\'s prayer: "And when I am ill, it is He who cures me."',
      'tafsir_kehilanganOrang':
          'Test of patience: "Inna lillahi wa inna ilaihi raji\'un" when calamity strikes.',
      'tafsir_stress':
          'Surah Al-Insyirah: Allah expanded the chest and removed the burden of Prophet Muhammad SAW.',
      'tafsir_sendiri':
          'Allah is All-Near: He knows what the human heart whispers.',
      'tafsir_sukses':
          'Story of Prophet Sulaiman giving thanks: "This is from the favor of my Lord to test me."',
      'tafsir_gagal':
          'Do not grieve: If you are believers, you are superior in rank.',
      'tafsir_iri':
          'Prohibition of Envy: Do not wish for that by which Allah has preferred some of you over others.',
      'tafsir_berdosa':
          'Call of Hope: O My servants who have transgressed, do not despair of the mercy of Allah.',
      'tafsir_tobat':
          'Command to Repent: Repent to Allah with sincere repentance (Taubatan Nasuha).',
      'tafsir_lemah':
          'Human Nature: Allah intends to make things easy, for mankind was created weak.',
      'tafsir_kuat':
          'Source of Strength: It is Allah who strengthens you with His help.',
      'tafsir_ragu':
          'Absolute Truth: The truth is from your Lord, so never be among the doubters.',
      'tafsir_yakin':
          'Promise of Istiqomah: Angels will descend reassuring those who say "Our Lord is Allah" then remain steadfast.',
      'tafsir_gelisah':
          'Prophet Yunus\'s Prayer: Acknowledgment of Tawhid and sin as a way out of difficulty.',
      'tafsir_tenang':
          'Most Beautiful Call: Allah\'s call to the reassured soul to enter His Paradise.',
      'tafsir_lelah':
          'Command to be Patient: Seek help through patience and prayer in facing life\'s fatigue.',
      'tafsir_kecewa':
          'Wisdom behind destiny: What missed you was never meant to hit you.',
      'tafsir_rindu':
          'Story of Prophet Yaqub: "I only complain of my suffering and my grief to Allah."',
      'tafsir_hutang':
          'Verse on debt is the longest, showing importance of recording and intention to repay.',
      'tafsir_difitnah':
          'Story of Aisha RA: Do not think it bad for you, rather it is good for you (purifier of sins).',
      // Key Points (English)
      // Sad
      'kp_sedih_1': 'Allah does not burden beyond capacity',
      'kp_sedih_2': 'Hardship is always accompanied by ease',
      'kp_sedih_3': 'Patience yields limitless rewards',
      // Confused
      'kp_bingung_1': 'Taqwa is the way out of problems',
      'kp_bingung_2': 'Provision comes from unexpected directions',
      'kp_bingung_3': 'Tawakkul after striving your best',
      // Grateful
      'kp_bersyukur_1': 'Gratitude increases blessings',
      'kp_bersyukur_2': 'Ingratitude invites punishment',
      'kp_bersyukur_3': 'Gratitude of heart, tongue, and action',
      // Scared
      'kp_takut_1': 'Allah is sufficient as Helper',
      'kp_takut_2': 'Fear only Allah',
      'kp_takut_3': 'Faith drives away worldly fear',
      // Angry
      'kp_marah_1': 'Restraining anger is a sign of piety',
      'kp_marah_2': 'Forgiving is nobler than retaliating',
      'kp_marah_3': 'Allah loves those who do good',
      // Happy
      'kp_bahagia_1': 'Allah\'s mercy is better than wealth',
      'kp_bahagia_2': 'Happiness should draw you closer to Allah',
      'kp_bahagia_3': 'Share happiness with others',
      // Worried
      'kp_khawatir_1': 'Heart finds peace by remembering Allah',
      'kp_khawatir_2': 'Focus on Allah\'s promise, not fear',
      'kp_khawatir_3': 'Dhikr is the cure for restlessness',
      // Despair
      'kp_putusAsa_1': 'Allah\'s mercy encompasses all things',
      'kp_putusAsa_2': 'Do not despair of His mercy',
      'kp_putusAsa_3': 'Hope always exists for believers',
      // Proud
      'kp_bangga_1': 'Do not turn your cheek (arrogance)',
      'kp_bangga_2': 'Allah dislikes the arrogant',
      'kp_bangga_3': 'Be humble (Tawadhu)',
      // Anxious
      'kp_cemas_1': 'Remember Allah, Allah remembers you',
      'kp_cemas_2': 'Gratitude increases blessings',
      'kp_cemas_3': 'Patience in trials',
      // Sick
      'kp_sakit_1': 'It is Allah who cures',
      'kp_sakit_2': 'Illness purifies sins',
      'kp_sakit_3': 'Trust in Allah for healing',
      // Lost Someone
      'kp_kehilanganOrang_1': 'All belongs to Allah',
      'kp_kehilanganOrang_2': 'Patience at first stroke',
      'kp_kehilanganOrang_3': 'Allah replaces with better',
      // Stressed
      'kp_stress_1': 'Expansion of chest is a gift',
      'kp_stress_2': 'With hardship comes ease',
      'kp_stress_3': 'Focus on Hereafter lightens burden',
      // Lonely
      'kp_sendiri_1': 'Allah is closer than jugular vein',
      'kp_sendiri_2': 'Allah knows what is in heart',
      'kp_sendiri_3': 'Use solitude to pray',
      // Successful
      'kp_sukses_1': 'Success is a test',
      'kp_sukses_2': 'Gratitude preserves blessings',
      'kp_sukses_3': 'Do not be distracted by wealth',
      // Failed
      'kp_gagal_1': 'Do not weaken and grieve',
      'kp_gagal_2': 'Believers are superior',
      'kp_gagal_3': 'Failure is a lesson',
      // Envious
      'kp_iri_1': 'Do not envy others',
      'kp_iri_2': 'Everyone has their share',
      'kp_iri_3': 'Ask Allah for bounty',
      // Sinful
      'kp_berdosa_1': 'Do not despair of mercy',
      'kp_berdosa_2': 'Allah forgives all sins',
      'kp_berdosa_3': 'Repentance wipes mistakes',
      // Repentant
      'kp_tobat_1': 'Sincere repentance accepted',
      'kp_tobat_2': 'Protect from Fire',
      'kp_tobat_3': 'Steadfast after repenting',
      // Weak
      'kp_lemah_1': 'Humans created weak',
      'kp_lemah_2': 'Allah lightens burden',
      'kp_lemah_3': 'Strength from obedience',
      // Strong
      'kp_kuat_1': 'Allah strengthens believers',
      'kp_kuat_2': 'Strength for Allah\'s way',
      'kp_kuat_3': 'Do not be arrogant',
      // Doubtful
      'kp_ragu_1': 'Truth comes from Lord',
      'kp_ragu_2': 'Do not be a doubter',
      'kp_ragu_3': 'Certainty is key',
      // Confident
      'kp_yakin_1': 'Stand firm (Istiqomah)',
      'kp_yakin_2': 'Angels bring good tidings',
      'kp_yakin_3': 'Do not fear or grieve',
      // Restless
      'kp_gelisah_1': 'No deity except Allah',
      'kp_gelisah_2': 'Admit own mistakes',
      'kp_gelisah_3': 'Prayer is weapon',
      // Peaceful
      'kp_tenang_1': 'Peaceful soul pleasing to Allah',
      'kp_tenang_2': 'Return to Lord well-pleased',
      'kp_tenang_3': 'Enter His Paradise',
      // Tired
      'kp_lelah_1': 'Fatigue for Allah',
      'kp_lelah_2': 'Patience and Prayer',
      'kp_lelah_3': 'Rest sufficiently',
      // Disappointed
      'kp_kecewa_1': 'Allah Knows Best',
      'kp_kecewa_2': 'Hidden Wisdom',
      'kp_kecewa_3': 'Content with Destiny',
      // Longing
      'kp_rindu_1': 'Prayer cures longing',
      'kp_rindu_2': 'Meeting in Paradise',
      'kp_rindu_3': 'Complain to Allah',
      // Debt
      'kp_hutang_1': 'Intention to Repay',
      'kp_hutang_2': 'Effort',
      'kp_hutang_3': 'Prayer',
      // Slandered
      'kp_difitnah_1': 'Allah is Defender',
      'kp_difitnah_2': 'Silence is Gold',
      'kp_difitnah_3': 'Purifier of Sins',
    },
  };

  static String get(BuildContext context, String key) {
    final languageCode =
        Provider.of<LanguageProvider>(context).currentLocale.languageCode;
    return _strings[languageCode]?[key] ?? _strings['id']?[key] ?? key;
  }
}
