include 'emu8086.inc'       ; EMU8086 লাইব্রেরি যুক্ত করা হয়েছে
org 100h                   ; .COM প্রোগ্রামের জন্য শুরু ঠিকানা 100h

jmp start                  ; সরাসরি start লেবেলে যাবে

start:
    call scan_num          ; ইউজার থেকে একটি সংখ্যা ইনপুট নেবে (CX রেজিস্টারে থাকবে)
    mov cx, cx             ; CX নিজেকে কপি করছে (প্রয়োজনীয় নয়, বুঝানোর জন্য)
    mov ax, 1              ; AX = 1 দিয়ে ফ্যাক্টরিয়ালের শুরু মান ঠিক করলো
    mov bx, cx             ; BX-এ ইনপুট সংখ্যা কপি করলো (লুপ কাউন্টার)

fact_loop:
    cmp bx, 1              ; চেক করছে BX ১ এর সমান বা ছোট কিনা
    jle done_fact          ; হ্যাঁ হলে লুপ শেষ, done_fact এ যাবে
    mul bx                 ; AX = AX * BX (ফ্যাক্টরিয়াল গুণ)
    dec bx                 ; BX ১ কমালো
    jmp fact_loop          ; লুপ আবার শুরু করলো

done_fact:
    print "Factorial: "    ; "Factorial:" লিখে দেখাবে
    call print_num         ; AX-এর মান (ফ্যাক্টরিয়াল ফলাফল) প্রিন্ট করবে
    printn                 ; নতুন লাইন দিবে

    mov ah, 4ch            ; প্রোগ্রাম শেষ করার জন্য DOS ইন্টারাপ্ট প্রস্তুত
    int 21h                ; প্রোগ্রাম বন্ধ করবে

define_scan_num             ; ইনপুট নেওয়ার ফাংশন সংজ্ঞা
define_print_num            ; সংখ্যা প্রিন্টের ফাংশন সংজ্ঞা
define_print_num_uns        ; unsigned সংখ্যা প্রিন্ট ফাংশন (ব্যবহৃত হয়নি)
define_get_string           ; স্ট্রিং ইনপুট নেওয়ার ফাংশন (ব্যবহৃত হয়নি)

end start                  ; প্রোগ্রামের শেষ, শুরু পয়েন্ট start
