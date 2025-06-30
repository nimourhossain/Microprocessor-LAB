include 'emu8086.inc'           ; EMU8086 লাইব্রেরি অন্তর্ভুক্ত করা হয়েছে
org 100h                        ; .COM প্রোগ্রামের জন্য শুরু ঠিকানা 100h
jmp start                       ; সরাসরি start লেবেলে যাবে

buffer1 db 20 dup(0)            ; প্রথম স্ট্রিং রাখার জন্য ২০ বাইট জায়গা
buffer2 db 20 dup(0)            ; দ্বিতীয় স্ট্রিং রাখার জন্য ২০ বাইট জায়গা

start:
    print "Enter first string: "    ; প্রথম স্ট্রিং ইনপুট নেওয়ার অনুরোধ
    lea di, buffer1                 ; DI রেজিস্টারে buffer1 এর ঠিকানা রাখা
    mov dx, 20                      ; সর্বোচ্চ ২০ ক্যারেক্টার ইনপুট নেওয়া যাবে
    call get_string                 ; স্ট্রিং ইনপুট নেওয়া হচ্ছে

    printn
    print "Enter second string: "   ; দ্বিতীয় স্ট্রিং ইনপুট নেওয়ার অনুরোধ
    lea di, buffer2                 ; DI রেজিস্টারে buffer2 এর ঠিকানা রাখা
    mov dx, 20                      ; সর্বোচ্চ ২০ ক্যারেক্টার ইনপুট নেওয়া যাবে
    call get_string                 ; স্ট্রিং ইনপুট নেওয়া হচ্ছে

    ; এখন স্ট্রিং দুটি তুলনা করা হবে
    lea si, buffer1                 ; SI রেজিস্টারে buffer1 এর ঠিকানা লোড
    lea di, buffer2                 ; DI রেজিস্টারে buffer2 এর ঠিকানা লোড

compare_loop:
    mov al, [si]                    ; buffer1 থেকে একটি ক্যারেক্টার AL-এ আনো
    mov bl, [di]                    ; buffer2 থেকে একটি ক্যারেক্টার BL-এ আনো
    cmp al, 0                       ; buffer1-এর অক্ষর শেষ কিনা যাচাই
    je equal                        ; যদি শেষ হয়, তাহলে স্ট্রিং সমান

    cmp al, bl                      ; দুটি অক্ষর সমান কিনা যাচাই
    jne not_equal                   ; যদি সমান না হয়, তাহলে ভিন্ন স্ট্রিং

    inc si                          ; SI বাড়াও (পরবর্তী অক্ষরে যাও)
    inc di                          ; DI বাড়াও (পরবর্তী অক্ষরে যাও)
    jmp compare_loop                ; আবার তুলনা করতে লুপে ফিরে যাও

equal:
    printn
    print "Strings are same."       ; স্ট্রিং দুটি সমান

    jmp done                        ; প্রোগ্রাম শেষ করতে done এ যাও

not_equal:
    printn
    print "Strings are different."  ; স্ট্রিং দুটি ভিন্ন

done:
    mov ah, 4ch                     ; প্রোগ্রাম শেষ করার জন্য DOS ইন্টারাপ্ট
    int 21h

DEFINE_GET_STRING                   ; get_string ফাংশনের সংজ্ঞা
DEFINE_PRINT_STRING                 ; print_string ফাংশনের সংজ্ঞা
end start                           ; প্রোগ্রাম শুরু হবে start থেকে
