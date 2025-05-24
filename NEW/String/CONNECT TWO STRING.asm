include 'emu8086.inc'        ; EMU8086 লাইব্রেরি অন্তর্ভুক্ত
org 100h                    ; .COM প্রোগ্রামের জন্য শুরু ঠিকানা 100h
jmp start                   ; সরাসরি start লেবেলে যাবে

buf1 db 42 dup(0)           ; প্রথম স্ট্রিং এর জন্য জায়গা (২টি স্ট্রিং মিশানোর জন্য বড়)
buf2 db 21 dup(0)           ; দ্বিতীয় স্ট্রিং এর জন্য জায়গা (২০ ক্যারেক্টার + নাল)

start:
    printn "Enter first string (max 20):" ; প্রথম স্ট্রিং ইনপুটের নির্দেশনা দেখানো
    lea di, buf1            ; DI-তে buf1 এর ঠিকানা লোড করো
    mov dx, 20              ; সর্বোচ্চ ২০ ক্যারেক্টার ইনপুট নেওয়ার সীমা
    call get_string         ; ইউজার থেকে প্রথম স্ট্রিং ইনপুট নাও

    printn "Enter second string (max 20):" ; দ্বিতীয় স্ট্রিং ইনপুটের নির্দেশনা
    lea di, buf2            ; DI-তে buf2 এর ঠিকানা লোড করো
    mov dx, 20              ; সর্বোচ্চ ২০ ক্যারেক্টার ইনপুট নেওয়ার সীমা
    call get_string         ; ইউজার থেকে দ্বিতীয় স্ট্রিং ইনপুট নাও

    ; প্রথম স্ট্রিং এর শেষ খুঁজে বের করো (নাল টার্মিনেটর)
    lea si, buf1            ; SI-তে buf1 এর ঠিকানা লোড করো
find_end:
    mov al, [si]            ; SI এর অক্ষর AL-এ নাও
    cmp al, 0               ; যদি AL == 0 (স্ট্রিং শেষ)
    je start_concat         ; তাহলে স্ট্রিং যোগ করার অংশে যাও
    inc si                  ; অন্যথায় SI বাড়াও (পরবর্তী অক্ষর)
    jmp find_end            ; আবার লুপে ফিরে যাও

start_concat:
    ; SI এখন buf1 এর শেষের নাল পয়েন্টার দেখাচ্ছে
    lea di, buf2            ; DI-তে buf2 এর ঠিকানা লোড করো

concat_loop:
    mov al, [di]            ; DI থেকে অক্ষর AL-এ নাও
    mov [si], al            ; AL এর মান SI পয়েন্টারে লিখো (যোগ করা হচ্ছে)
    cmp al, 0               ; AL নাল কিনা চেক করো (স্ট্রিং শেষ)
    je done_concat          ; নাল হলে যোগ শেষ, done_concat এ যাও
    inc si                  ; SI বাড়াও (পরবর্তী পজিশনে যাও)
    inc di                  ; DI বাড়াও (buf2 এর পরবর্তী অক্ষরে যাও)
    jmp concat_loop         ; লুপ চালিয়ে যাও

done_concat:
    printn "Concatenated string: " ; যোগ করা স্ট্রিং এর মেসেজ দেখাও
    lea si, buf1            ; SI-তে buf1 এর ঠিকানা লোড করো (মিশ্রিত স্ট্রিং)
    call print_string       ; মিশ্রিত স্ট্রিং প্রিন্ট করো

    mov ah, 4Ch             ; প্রোগ্রাম শেষ করার জন্য DOS ইন্টারাপ্ট প্রস্তুত
    int 21h                 ; প্রোগ্রাম বন্ধ করো

DEFINE_GET_STRING           ; get_string ফাংশন সংজ্ঞা
DEFINE_PRINT_STRING         ; print_string ফাংশন সংজ্ঞা
end                        ; প্রোগ্রাম শেষ, শুরু পয়েন্ট start
