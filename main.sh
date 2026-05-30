#!/bin/bash
# İsim: Salih TAŞKIN
# Öğrenci Numarası: 2420191019
# Sertifika 1: https://www.btkakademi.gov.tr/portal/certificate/validate?certificateId=bx1hL8ZZ7k
# Sertifika 2: https://www.btkakademi.gov.tr/portal/certificate/validate?certificateId=BozfxjnNwE
# Sertifika 3: https://credsverse.com/credentials/2030097c-c166-499d-9b5d-ffa2f49579bf

LOG="report.log"

# ISO formatında tarih/saat
echo "=== Rapor Başlangıcı: $(date -u +"%Y-%m-%dT%H:%M:%SZ") ===" > "$LOG"

# Donanım bilgileri (Windows - wmic & getmac)
echo -e "\n--- İşlemci ---" >> "$LOG"
wmic cpu get name >> "$LOG"

echo -e "\n--- RAM ---" >> "$LOG"
wmic memorychip get capacity >> "$LOG"

echo -e "\n--- Anakart ---" >> "$LOG"
wmic baseboard get product,manufacturer >> "$LOG"

echo -e "\n--- Disk UUID ---" >> "$LOG"
wmic diskdrive get serialnumber >> "$LOG"

echo -e "\n--- MAC Adresi ---" >> "$LOG"
getmac >> "$LOG"

# Parola alma
read -s -p "Parolayı giriniz (MYO+202): " PAROLA
echo ""

# GPG ile AES256 şifreleme
gpg --batch --yes \
    --passphrase "$PAROLA" \
    --symmetric \
    --cipher-algo AES256 \
    --output report.log.gpg \
    "$LOG"

# Orijinal log'u sil
rm -f "$LOG"

echo "Tamamlandı: report.log.gpg oluşturuldu."
