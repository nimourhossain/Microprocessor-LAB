include 'emu8086.inc'        ; EMU8086 এর লাইব্রেরি ইম্পোর্ট করা হয়েছে
org 100h                    ; প্রোগ্রামের শুরু 100h থেকে (COM ফাইলের জন্য)

jmp start                   ; সরাসরি start লেবেলে জাম্প করা হয়েছে

start:
    print "Enter first number: " ; প্রথম সংখ্যা ইনপুটের জন্য মেসেজ দেখানো
    printn                      ; পরবর্তী লাইনে যাওয়া
    call scan_num               ; ইউজার ইনপুট নেওয়া হচ্ছে (সংখ্যা), ফলাফল CX রেজিস্টারে
    mov ax, cx                 ; CX এর মান AX এ কপি করা হচ্ছে (প্রথম সংখ্যা)

    print "Enter second number: " ; দ্বিতীয় সংখ্যা ইনপুটের জন্য মেসেজ
    printn                      ; নতুন লাইন
    call scan_num               ; দ্বিতীয় সংখ্যা ইনপুট, CX এ যাবে
    mov bx, cx                 ; CX এর মান BX এ কপি করা হচ্ছে (দ্বিতীয় সংখ্যা)

    ; যোগফল (Addition)
    mov cx, ax                 ; প্রথম সংখ্যাটি আবার CX এ কপি করা
    add cx, bx                 ; CX = CX + BX (প্রথম + দ্বিতীয় সংখ্যা)
    print "Sum: "              ; "Sum:" লেখা দেখানো
    mov ax, cx                 ; ফলাফল AX এ নেওয়া হচ্ছে প্রিন্ট করার জন্য
    call print_num             ; যোগফল প্রিন্ট করা হচ্ছে
    printn                     ; নতুন লাইন

    ; বিয়োগফল (Subtraction)
    mov cx, ax                 ; আবার প্রথম সংখ্যা CX এ কপি
    sub cx, bx                 ; CX = CX - BX (প্রথম - দ্বিতীয় সংখ্যা)
    print "Difference: "       ; "Difference:" লেখা দেখানো
    mov ax, cx                 ; ফলাফল AX এ নেওয়া হচ্ছে
    call print_num             ; বিয়োগফল প্রিন্ট করা
    printn                     ; নতুন লাইন

    ; গুণফল (Multiplication)
    mov ax, ax                 ; AX এ প্রথম সংখ্যা আগে থেকেই আছে
    mul bx                     ; AX = AX * BX (ফলাফল AX এ যাবে)
    print "Product: "          ; "Product:" লেখা দেখানো
    call print_num             ; গুণফল প্রিন্ট করা
    printn                     ; নতুন লাইন

    ; ভাগফল (Division)
    mov ax, ax                 ; AX এ dividend (প্রথম সংখ্যা)
    xor dx, dx                 ; DX ক্লিয়ার করা (উচ্চ অংশ) ভাগের আগে
    div bx                     ; AX = ভাগফল, DX = ভাগশেষ
    print "Quotient: "         ; "Quotient:" লেখা দেখানো
    call print_num             ; ভাগফল প্রিন্ট করা
    printn                     ; নতুন লাইন

    mov ah, 4ch                ; প্রোগ্রাম বন্ধ করার জন্য DOS ইন্টারাপ্ট কল প্রস্তুত
    int 21h                    ; প্রোগ্রাম শেষ
                                 
define_scan_num               ; ইনপুট ফাংশনের ডেফিনিশন
define_print_num              ; সংখ্যা প্রিন্ট ফাংশনের ডেফিনিশন
define_print_num_uns          ; unsigned সংখ্যা প্রিন্টের ডেফিনিশন
define_get_string             ; স্ট্রিং ইনপুটের ডেফিনিশন

end start                     ; প্রোগ্রামের শেষ
