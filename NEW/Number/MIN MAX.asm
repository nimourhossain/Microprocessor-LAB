include 'emu8086.inc'       ; EMU8086 লাইব্রেরি যুক্ত করা হয়েছে
org 100h                   ; .COM প্রোগ্রামের শুরু ঠিকানা নির্ধারণ

jmp start                  ; সরাসরি start লেবেলে যাবে

start:
    print "Enter n numbers: " ; ইউজারকে কতগুলো সংখ্যা ইনপুট দিতে বলছে
    call scan_num             ; ইউজার থেকে সংখ্যা পড়বে, CX-এ রাখা হবে
    mov si, cx                ; SI-তে n (সংখ্যার পরিমাণ) কপি করলো
    mov bx, 0                 ; BX কে 0 দিয়ে min হিসেবে শুরু করলো
    mov dx, 0                 ; DX কে 0 দিয়ে max হিসেবে শুরু করলো

printn
    print "Input the numbers:" ; ইউজারকে ইনপুট দিতে বলছে
    printn

input_loop:
    call scan_num             ; ইউজারের পরবর্তী সংখ্যা নেবে, CX-এ যাবে
    mov al, cl                ; AL-এ ইনপুট সংখ্যা কপি করলো
    print "Num: "             ; "Num:" টেক্সট প্রিন্ট করবে
    mov ah, 0
    call print_num            ; AL-এ থাকা সংখ্যা প্রিন্ট করবে
    printn

    cmp bx, 0                 ; BX=0 কিনা চেক করছে (প্রথম ইনপুট কি না)
    je init_min_max           ; প্রথম ইনপুট হলে min ও max সেট করবে

    cmp al, bl                ; AL (নতুন ইনপুট) কি min (BL) থেকে ছোট?
    jl set_min                ; ছোট হলে min আপডেট করবে
    cmp al, dh                ; AL কি max (DH) থেকে বড়?
    jg set_max                ; বড় হলে max আপডেট করবে
    jmp cont                  ; না হলে পরবর্তী ধাপে যাবে

init_min_max:
    mov bl, al                ; প্রথম ইনপুট min হিসেবে রাখলো
    mov dh, al                ; প্রথম ইনপুট max হিসেবেও রাখলো
    jmp cont

set_min:
    mov bl, al                ; নতুন min আপডেট করলো
    jmp cont

set_max:
    mov dh, al                ; নতুন max আপডেট করলো

cont:
    dec si                    ; n এক কমালো
    jnz input_loop            ; n>0 হলে আবার লুপে যাবে

print "Min="                  ; "Min=" প্রিন্ট করবে
    mov ah, 0
    mov al, bl                ; min সংখ্যা AL-এ নিলো
    call print_num            ; min প্রিন্ট করলো

print " Max="                 ; "Max=" প্রিন্ট করবে
    mov ah, 0
    mov al, dh                ; max সংখ্যা AL-এ নিলো
    call print_num            ; max প্রিন্ট করলো

printn                       ; নতুন লাইনে যাবে

    mov ah, 4Ch               ; প্রোগ্রাম শেষ করার DOS ইন্টারাপ্ট প্রস্তুত
    int 21h                   ; প্রোগ্রাম বন্ধ করবে

define_scan_num               ; ইনপুট নেওয়ার ফাংশন সংজ্ঞা
define_print_num              ; সংখ্যা প্রিন্ট করার ফাংশন সংজ্ঞা
define_print_num_uns          ; unsigned সংখ্যা প্রিন্ট করার ফাংশন (ব্যবহৃত হয়নি)
define_get_string             ; স্ট্রিং ইনপুট ফাংশন (ব্যবহৃত হয়নি)

end                         ; প্রোগ্রাম শেষ
