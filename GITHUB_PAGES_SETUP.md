# 🌐 GitHub Pages Setup Guide

Panduan lengkap untuk hosting Privacy Policy menggunakan GitHub Pages (GRATIS!)

## ✨ Keuntungan GitHub Pages

✅ **Gratis selamanya**  
✅ **SSL/HTTPS otomatis** (dipercaya Play Store)  
✅ **Mudah di-update** (tinggal push ke GitHub)  
✅ **Professional URL**  
✅ **Tidak perlu domain**

## 📋 Langkah-Langkah Setup

### 1️⃣ Push File ke GitHub

Pertama, push semua file termasuk folder `docs/` ke repository GitHub:

```powershell
# Di terminal, dari root project
git add docs/
git add PRIVACY_POLICY.md
git add GITHUB_PAGES_SETUP.md
git commit -m "Add privacy policy and GitHub Pages setup"
git push origin main
```

### 2️⃣ Enable GitHub Pages

1. Buka repository Anda di GitHub:
   ```
   https://github.com/rasyiqi-code/Quranicjourney
   ```

2. Klik **Settings** (tab paling kanan atas)

3. Scroll ke bawah, cari menu **Pages** di sidebar kiri

4. Di bagian **Source**:
   - Branch: Pilih **main** (atau **master**)
   - Folder: Pilih **/docs**
   - Klik **Save**

5. Tunggu beberapa menit (biasanya 1-5 menit)

### 3️⃣ Akses Privacy Policy

Setelah beberapa menit, Privacy Policy Anda akan tersedia di:

```
https://rasyiqi-code.github.io/Quranicjourney/privacy-policy.html
```

**URL ini yang akan Anda masukkan ke Google Play Console!**

### 4️⃣ Verifikasi

Buka URL di browser untuk memastikan halaman sudah live:
- Seharusnya tampil halaman Privacy Policy yang indah dengan toggle Bahasa Indonesia/English
- Responsive untuk mobile
- Memiliki SSL (HTTPS) otomatis

## 📱 Cara Menggunakan di Play Store

### Google Play Console

1. Login ke **Google Play Console**
2. Pilih aplikasi **Quranic Journey**
3. Ke **App content** → **Privacy Policy**
4. Masukkan URL:
   ```
   https://rasyiqi-code.github.io/Quranicjourney/privacy-policy.html
   ```
5. Klik **Save**

### Apple App Store (jika deploy ke iOS)

1. Di **App Store Connect**
2. **App Information** → **Privacy Policy URL**
3. Masukkan URL yang sama
4. Klik **Save**

## 🔄 Update Privacy Policy di Masa Depan

Jika ingin update Privacy Policy:

1. Edit file `docs/privacy-policy.html`
2. Commit dan push ke GitHub:
   ```powershell
   git add docs/privacy-policy.html
   git commit -m "Update privacy policy"
   git push origin main
   ```
3. GitHub Pages akan otomatis update dalam beberapa menit
4. URL tetap sama, tidak perlu update di Play Store!

## 🎨 Fitur Privacy Policy Page

✨ **Modern Design** dengan gradient dan animasi  
🌍 **Bilingual** - Toggle between English & Indonesian  
📱 **Responsive** - Perfect di mobile & desktop  
🔒 **HTTPS** - Secure & trusted oleh Play Store  
⚡ **Fast Loading** - Static HTML, no database  

## ❓ Troubleshooting

### "404 Page Not Found"
- Tunggu 5-10 menit setelah enable GitHub Pages
- Pastikan folder `docs/` sudah ter-push ke GitHub
- Check Settings → Pages apakah sudah tercentang hijau

### "Changes not showing"
- GitHub Pages bisa butuh 1-5 menit untuk update
- Clear browser cache (Ctrl + F5)
- Check commit sudah ter-push: `git log`

### "SSL/HTTPS not working"
- GitHub Pages otomatis menyediakan HTTPS
- Jika belum aktif, tunggu 24 jam pertama setelah setup
- Check di Settings → Pages, ada opsi "Enforce HTTPS"

## 📞 Support

Jika ada masalah, bisa:
- Check [GitHub Pages Documentation](https://docs.github.com/en/pages)
- Open issue di repository ini
- Contact: [GitHub Profile](https://github.com/rasyiqi-code)

---

## 🎯 Alternatif Lain (Jika Tidak Mau GitHub Pages)

Jika tidak ingin pakai GitHub Pages, ada alternatif gratis lain:

### Option 2: App Privacy Policy Generator
Website: https://app-privacy-policy-generator.nisrulz.com/
- Gratis
- Otomatis generate & host
- Dapat shareable link

### Option 3: Google Docs (Public)
- Upload `PRIVACY_POLICY.md` ke Google Docs
- Set "Anyone with the link can view"
- Share link public-nya
- **Cons**: Kurang professional

### Option 4: Termly
Website: https://termly.io/
- Generate privacy policy gratis
- Hosting gratis
- Professional looking

**Recommendation**: Tetap pakai **GitHub Pages** karena paling professional dan mudah di-update! ✨

---

*Built with ❤️ for the Ummah*
