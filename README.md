# ERPNext v16 Custom Build for EasyPanel

Repositori ini menyediakan konfigurasi lengkap untuk men-deploy **ERPNext v16** dengan tambahan 8 aplikasi custom secara langsung melalui **EasyPanel** menggunakan mode *Docker Compose*.

## 📦 Custom Apps yang Berada di dalam Build

Image yang dikonfigurasi di repo ini adalah versi custom dari **Frappe/ERPNext v16.13.3** yang menggabungkan beberapa modul. Berikut aplikasi yang pre-installed:

1. **HRMS** (`v16.4.8`) - Frappe HR Ecosystem
2. **CRM** (`v1.66.2`) - Frappe Customer Relationship Management
3. **LMS** (`v2.52.0`) - Frappe Learning Management System
4. **Helpdesk** (`v1.22.1`) - Customer Service & Ticketing
5. **Meet** (`main`) - Video Conferencing App
6. **Drive** (`v0.3.0`) - File Sharing / Cloud Storage App
7. **WABA Integration** (`main`) - WhatsApp Business API Integration
8. **ChangAI** (`main`) - ERPGulf AI Integrations

## ⚙️ Cara Deploy ke EasyPanel

Pendekatan docker-compose ini didesain agar *plug-and-play* untuk EasyPanel karena repositori sudah menyertakan `Dockerfile` mandiri yang akan membangun keseluruh custom apps tanpa tool eksternal.

1. Buka dashboard **EasyPanel** dan buat **Service** baru.
2. Saat ditanya *App Type*, pilih opsi **Docker Compose** (bukan opsi App/Github standard karena arsitektur ERPNext multi-container).
3. Hubungkan ke repositori GitHub `brainplusplus/erpnext-16` ini.
4. Klik **Deploy**!

### Apa yang Terjadi Saat Deploy?
EasyPanel secara pintar akan:
- Mendeteksi root `docker-compose.yml`.
- Mengeksekusi instruksi `build: .` pada bagian service dan membaca `Dockerfile` yang ada di sini.
- Menjalankan instalasi node/python dependencies `bench get-app` serta asset binding JS/CSS `bench build` saat stage build secara otomatis.
- Berjalan sesuai service requirements (Redis/MariaDB/Queue/SocketIO).
- Node `create-site` otomatis meregistrasi seluruh modul (8 modul custom) ke tabel database Anda di awal start-up deployment.

> **Catatan Waktu Deploy:** Karena Frappe Framework memerlukan proses cloning, pip packages, dan compiling aset UI, deployment startup Docker build untuk yang pertama kalinya dapat memakan waktu hingga **10-20 Menit** bergantung pada resource EasyPanel Anda.

## 🚀 Opsi Deployment Cepat (Pre-built Image)

Jika Anda tidak ingin melakukan proses *build image* dari awal yang memakan waktu (baik di server lokal, VPS lain, maupun EasyPanel), Anda bisa menggunakan konfigurasi spesifik yaitu `docker-compose.hub.yml`.

File komposisi alternatif ini tidak menggunakan instruksi `build`, melainkan akan langsung melakukan proses *pull image* terbaru dari registry public / private.

**Cara Menjalankan Secara Cepat:**
```bash
# Secara otomatis pull dari registry (brainplusplus/erpnext-16:latest)
docker-compose -f docker-compose.hub.yml -p asahi_erp up -d
```
Jika Anda ingin menentukan tag versi khusus, Anda dapat mengekspor environment *(Universal Build)*:
```bash
$env:IMAGE_TAG="v2" # Pada Powershell
docker-compose -f docker-compose.hub.yml -p asahi_erp up -d
```

## 🛠 File Struktur Repositori

- `Dockerfile`: File arsitektur custom build berbasis pada custom apps.
- `docker-compose.yml`: (Opsi Build Lokal) Definisi service yang membuild custom infrastruktur dari source code.
- `docker-compose.hub.yml`: (Opsi Siap Pakai) Definisi service yang mengambil *image* ditarik langsung dari Docker Hub.
- `apps.json`/`build.sh`: File helper opsional jika Anda ingin me-rebuild secara lokal (tidak digunakan langsung oleh EasyPanel auto-builder, tapi berguna sebagai track list dependency).
- `fix/`: Catatan rekam jejak revisi setup.

---
*Built with ❤️ for BrainPlusPlus.*
