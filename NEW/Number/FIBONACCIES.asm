include 'emu8086.inc'       ; EMU8086 লাইব্রেরি যুক্ত করা হয়েছে
org 100h                   ; .COM প্রোগ্রামের শুরু ঠিকানা নির্ধারণ

jmp start                  ; সরাসরি start লেবেলে যাবে

start:
    call scan_num          ; ইউজার থেকে কতটি Fibonacci সংখ্যা চাই সেটি ইনপুট নেবে (CX-এ থাকবে)
    mov bx, 0              ; প্রথম Fibonacci সংখ্যা 0 হিসেবে সেট করলো
    mov dx, 1              ; দ্বিতীয় Fibonacci সংখ্যা 1 হিসেবে সেট করলো
    mov cx, cx             ; CX-তে ইনপুট থাকা সংখ্যা রাখলো (টার্ম সংখ্যা)

print_loop:
    cmp cx, 0              ; CX == 0 হয়েছে কিনা চেক করছে
    je done                ; যদি 0 হয়, প্রোগ্রাম শেষ করবে

    mov ax, bx             ; বর্তমান Fibonacci সংখ্যা AX-এ কপি করলো
    call print_num         ; AX-এর সংখ্যা প্রিন্ট করলো
    print " "              ; একটি স্পেস প্রিন্ট করলো

    add bx, dx             ; bx = bx + dx (নতুন Fibonacci সংখ্যা)
    xchg bx, dx            ; bx আর dx এর মান অদলবদল করলো (পরবর্তী টার্মের জন্য)
    dec cx                 ; CX থেকে ১ কমালো (একটি সংখ্যা প্রিন্ট হয়েছে)
    jmp print_loop         ; আবার লুপে ফিরে গেলো

done:
    printn                 ; নতুন লাইন প্রিন্ট করলো
    mov ah, 4ch            ; DOS ইন্টারাপ্টের মাধ্যমে প্রোগ্রাম শেষ করার জন্য প্রস্তুত
    int 21h                ; প্রোগ্রাম শেষ করলো

define_scan_num            ; ইনপুট নেওয়ার ফাংশন সংজ্ঞা
define_print_num           ; সংখ্যা প্রিন্ট করার ফাংশন সংজ্ঞা
define_print_num_uns       ; unsigned সংখ্যা প্রিন্ট ফাংশন (ব্যবহৃত হয়নি)
define_get_string          ; স্ট্রিং ইনপুট নেওয়ার ফাংশন (ব্যবহৃত হয়নি)

end start                 ; প্রোগ্রামের শেষ, শুরু পয়েন্ট start
