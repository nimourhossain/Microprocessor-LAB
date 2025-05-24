include 'emu8086.inc'       ; emu8086 লাইব্রেরি অন্তর্ভুক্ত করা
org 100h                   ; প্রোগ্রামের শুরু ঠিকানা 100h

jmp start                  ; start লেবেলে জাম্প করো

start:
    call scan_num          ; ব্যবহারকারীর থেকে সংখ্যা নাও (CX-তে)
    mov ax, cx             ; ইনপুট সংখ্যা AX-তে নাও
    mov bx, 0              ; BX-এ যোগফল শুরুতে 0 রাখো

sum_loop:
    cmp ax, 0              ; AX শূন্য কি না চেক করো
    je done                ; শূন্য হলে লুপ শেষ করো
    xor dx, dx             ; DX ক্লিয়ার করো (ডিভিশনের আগে)
    mov cx, 10             ; 10 দিয়ে ভাগ করার জন্য CX-তে 10 রাখো
    div cx                 ; AX কে 10 দ্বারা ভাগ করো, ভাগশেষ DX-তে আসবে
    add bx, dx             ; ভাগশেষ (ডিজিট) যোগফলে যোগ করো
    jmp sum_loop           ; আবার লুপ চালাও

done:
    mov ax, bx             ; যোগফল AX-তে নিয়ে আসো
    print "Sum of digits: " ; টেক্সট প্রিন্ট করো "Sum of digits: "
    call print_num         ; AX এর মান প্রিন্ট করো
    printn                 ; নতুন লাইন প্রিন্ট করো

    mov ah, 4ch            ; প্রোগ্রাম শেষ করার জন্য DOS কল
    int 21h                ; ইন্টারাপ্ট 21h কল করো

define_scan_num             ; scan_num ফাংশন ডিফাইন করো
define_print_num            ; print_num ফাংশন ডিফাইন করো
define_print_num_uns        ; print_num_unsigned ডিফাইন করো (এখানে ব্যবহার হয়নি)
define_get_string           ; get_string ডিফাইন করো (এখানে ব্যবহার হয়নি)

end start                  ; প্রোগ্রামের শেষ, start থেকে শুরু হবে
