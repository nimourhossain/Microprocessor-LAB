include 'emu8086.inc'        ; EMU8086 লাইব্রেরি অন্তর্ভুক্ত করা হলো
org 100h                   ; প্রোগ্রামের শুরু অবস্থান (100h)

jmp start                  ; সরাসরি start লেবেলে লাফ দেওয়া হবে

start:
    call scan_num          ; সংখ্যা ইনপুট নাও
    mov bx, cx             ; ইনপুটকৃত সংখ্যা BX রেজিস্টারে রাখো
    mov si, 1              ; প্রথম বিজোড় সংখ্যা ১ থেকে শুরু করো
    mov ax, 0              ; যোগফল AX এ ০ দিয়ে শুরু করো

L:
    cmp si, bx             ; SI এবং BX তুলনা করো
    ja done                ; যদি SI > BX হয়, তাহলে done এ যাও

    add ax, si             ; AX এ SI যোগ করো (sum += si)
    mov dx, ax             ; AX এর মান DX এ নাও (প্রিন্ট করার জন্য)
    call print_num         ; সংখ্যা প্রিন্ট করো

    printn                 ; নতুন লাইনে যাও

    add si, 2              ; পরের বিজোড় সংখ্যায় যাও (SI += 2)
    jmp L                  ; লুপ চালিয়ে যাও

done:
    mov ah, 4ch            ; প্রোগ্রাম শেষ করার জন্য DOS ইন্টারাপ্ট সেট করো
    int 21h                ; প্রোগ্রাম শেষ করো

DEFINE_SCAN_NUM             ; scan_num ফাংশন ডিফাইন
DEFINE_PRINT_NUM            ; print_num ফাংশন ডিফাইন
DEFINE_PRINT_NUM_UNS        ; print_num_uns ফাংশন ডিফাইন

end start                  ; প্রোগ্রাম শেষ, start থেকে শুরু করবে
