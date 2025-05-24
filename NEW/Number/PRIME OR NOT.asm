include 'emu8086.inc'        ; EMU8086 লাইব্রেরি অন্তর্ভুক্ত করা হলো
org 100h                   ; প্রোগ্রামের শুরু মেমোরি লোকেশন নির্ধারণ

jmp start                  ; start লেবেলে ঝাঁপ দাও

start:
    print "Enter a number: "  ; ব্যবহারকারীকে সংখ্যা ইনপুট দিতে বলো
    call scan_num            ; সংখ্যা CX রেজিস্টারে ইনপুট নেওয়া হবে

    cmp cx, 2                ; CX এর মান 2 এর চেয়ে কম কিনা চেক করো
    jb not_prime             ; যদি কম হয়, তাহলে প্রাইম নয় (not_prime এ যাবে)
    mov si, 1                ; প্রাইম ধরা হলো (si=1)

    mov bx, 2                ; ভাগ করার জন্য শুরু ভাগক=2

check_div:
    cmp bx, cx               ; যদি ভাগক(cx) এর সমান হয়, মানে ভাগ হয়েছে না
    je is_prime              ; তাহলে প্রাইম, is_prime এ যাবে

    mov ax, cx
    mov dx, 0                ; ডিভিশনের জন্য dx কে 0 করো
    div bx                   ; cx কে bx দিয়ে ভাগ করো
    cmp dx, 0                ; ভাগশেষ 0 কিনা চেক করো
    je not_prime             ; যদি 0 হয়, তাহলে প্রাইম নয়

    inc bx                   ; ভাগক 1 বাড়াও
    jmp check_div            ; আবার ভাগ পরীক্ষা করো

is_prime:
    printn                   ; নতুন লাইন দাও
    print "THE NUMBER IS PRIME."  ; প্রাইম সংখ্যা মেসেজ দেখাও
    printn                   ; নতুন লাইন দাও
    jmp end_program          ; প্রোগ্রাম শেষ করো

not_prime:
    printn                   ; নতুন লাইন দাও
    print "THE NUMBER IS NOT PRIME." ; প্রাইম নয় মেসেজ দেখাও
    printn                   ; নতুন লাইন দাও

end_program:
    mov ah,4ch               ; DOS প্রোগ্রাম শেষ করার ইন্টারাপ্ট কল
    int 21h

define_scan_num              ; scan_num ফাংশন সংজ্ঞা
define_print_num             ; print_num ফাংশন সংজ্ঞা
define_print_num_uns         ; print_num_unsigned ফাংশন সংজ্ঞা
define_get_string            ; get_string ফাংশন সংজ্ঞা

end start                   ; প্রোগ্রাম শেষ, এন্ট্রি পয়েন্ট start
