include 'emu8086.inc'      ; EMU8086 এর লাইব্রেরি ইম্পোর্ট করা হয়েছে
org 100h                   ; প্রোগ্রামের শুরু 100h হেক্সা অ্যাড্রেস থেকে

jmp start                  ; সরাসরি start লেবেলে লাফ দেওয়া হয়েছে

start:
    print "Enter first number: " ; প্রথম সংখ্যা ইনপুট চাওয়া হচ্ছে
    printn                     ; নতুন লাইনে যাওয়া হচ্ছে
    call scan_num              ; সংখ্যা ইনপুট নেওয়া হচ্ছে, ফলাফল CX রেজিস্টারে
    mov ax, cx                 ; CX এর মান AX এ রাখা হচ্ছে (প্রথম সংখ্যা)
    mov si, cx                 ; SI রেজিস্টারে সংরক্ষণ (backup) করা হচ্ছে প্রথম সংখ্যা

    print "Enter second number: " ; দ্বিতীয় সংখ্যা ইনপুট চাওয়া হচ্ছে
    printn                     ; নতুন লাইনে যাওয়া হচ্ছে
    call scan_num              ; সংখ্যা ইনপুট নেওয়া হচ্ছে, ফলাফল CX রেজিস্টারে
    mov bx, cx                 ; CX এর মান BX এ রাখা হচ্ছে (দ্বিতীয় সংখ্যা)
    mov di, cx                 ; DI রেজিস্টারে সংরক্ষণ (backup) করা হচ্ছে দ্বিতীয় সংখ্যা

    ; যোগফল হিসাব
    mov ax, si                 ; প্রথম সংখ্যাটি পুনরায় AX এ নেওয়া
    mov bx, di                 ; দ্বিতীয় সংখ্যাটি পুনরায় BX এ নেওয়া
    mov cx, ax                 ; CX এ প্রথম সংখ্যা রাখা
    add cx, bx                 ; CX = CX + BX (যোগ)
    print "Sum: "              ; যোগফল লেখাটি দেখানো
    mov ax, cx                 ; ফলাফল AX এ রাখা
    call print_num             ; ফলাফল প্রিন্ট করা
    printn                     ; নতুন লাইন

    ; বিয়োগফল হিসাব
    mov ax, si                 ; প্রথম সংখ্যাটি পুনরায় AX এ নেওয়া
    mov bx, di                 ; দ্বিতীয় সংখ্যাটি পুনরায় BX এ নেওয়া
    mov cx, ax                 ; CX এ প্রথম সংখ্যা রাখা
    sub cx, bx                 ; CX = CX - BX (বিয়োগ)
    print "Difference: "       ; বিয়োগফল লেখাটি দেখানো
    mov ax, cx                 ; ফলাফল AX এ রাখা
    call print_num             ; ফলাফল প্রিন্ট করা
    printn                     ; নতুন লাইন

    ; গুণফল হিসাব
    mov ax, si                 ; প্রথম সংখ্যাটি AX এ নেওয়া
    mov bx, di                 ; দ্বিতীয় সংখ্যাটি BX এ নেওয়া
    mul bx                     ; AX = AX * BX (গুণফল)
    print "Product: "          ; গুণফল লেখাটি দেখানো
    call print_num             ; ফলাফল প্রিন্ট করা
    printn                     ; নতুন লাইন

    ; ভাগফল হিসাব
    mov ax, si                 ; প্রথম সংখ্যাটি AX এ নেওয়া
    mov bx, di                 ; দ্বিতীয় সংখ্যাটি BX এ নেওয়া
    xor dx, dx                 ; DX রেজিস্টার ক্লিয়ার (ভাগের আগে)
    div bx                     ; AX = ভাগফল, DX = ভাগশেষ
    print "Quotient: "         ; ভাগফল লেখাটি দেখানো
    call print_num             ; ফলাফল প্রিন্ট করা
    printn                     ; নতুন লাইন

    mov ah, 4ch                ; DOS ইন্টারাপ্ট কলের জন্য প্রস্তুত
    int 21h                    ; প্রোগ্রাম শেষ করা হচ্ছে

define_scan_num               ; ইনপুট নেওয়ার ফাংশন সংজ্ঞা
define_print_num              ; সংখ্যা প্রিন্ট করার ফাংশন সংজ্ঞা
define_print_num_uns          ; unsigned সংখ্যা প্রিন্ট করার সংজ্ঞা
define_get_string             ; স্ট্রিং ইনপুট নেওয়ার ফাংশন সংজ্ঞা

end start                     ; প্রোগ্রামের শেষ
