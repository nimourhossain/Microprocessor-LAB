include 'emu8086.inc'        ; EMU8086 লাইব্রেরি যোগ করা
org 100h                    ; প্রোগ্রাম শুরু ঠিকানা 100h
jmp start                   ; সরাসরি start লেবেলে যাবে

buf1 db 21 dup(0)           ; প্রথম স্ট্রিং রাখার জন্য ২১ বাইট বাফার
buf2 db 21 dup(0)           ; দ্বিতীয় স্ট্রিং রাখার জন্য ২১ বাইট বাফার

start:
    printn "Enter first string (max 20):" ; প্রথম স্ট্রিং ইনপুটের জন্য মেসেজ
    lea di, buf1            ; DI-তে buf1 এর ঠিকানা লোড
    mov dx, 20              ; সর্বোচ্চ ২০ ক্যারেক্টার ইনপুট নেওয়া হবে
    call get_string         ; ইনপুট নেবে

    printn "Enter second string (max 20):" ; দ্বিতীয় স্ট্রিং ইনপুটের মেসেজ
    lea di, buf2            ; DI-তে buf2 এর ঠিকানা লোড
    mov dx, 20              ; সর্বোচ্চ ২০ ক্যারেক্টার ইনপুট
    call get_string         ; ইনপুট নেবে

    lea si, buf1            ; SI-তে প্রথম স্ট্রিংয়ের ঠিকানা
    lea di, buf2            ; DI-তে দ্বিতীয় স্ট্রিংয়ের ঠিকানা

compare_loop:
    mov al, [si]            ; প্রথম স্ট্রিং থেকে একটি ক্যারেক্টার AL-এ নিন
    mov bl, [di]            ; দ্বিতীয় স্ট্রিং থেকে ক্যারেক্টার BL-এ নিন
    cmp al, bl              ; দুই ক্যারেক্টার তুলনা করো
    jne not_equal           ; যদি আলাদা হয়, not_equal এ যাও
    cmp al, 0               ; যদি ক্যারেক্টার শূন্য হয় (স্ট্রিং শেষ)
    je equal                ; তাহলে স্ট্রিং সমান, equal এ যাও
    inc si                  ; SI বাড়াও (পরের ক্যারেক্টার)
    inc di                  ; DI বাড়াও (পরের ক্যারেক্টার)
    jmp compare_loop        ; আবার লুপ শুরু করো

equal:
    printn "Strings are equal." ; স্ট্রিং সমান হলে মেসেজ দেখাও
    jmp done

not_equal:
    printn "Strings are not equal." ; স্ট্রিং আলাদা হলে মেসেজ দেখাও

done:
    mov ah, 4Ch             ; প্রোগ্রাম শেষ করার DOS ইন্টারাপ্ট
    int 21h

DEFINE_GET_STRING           ; get_string ফাংশন সংজ্ঞা

end
