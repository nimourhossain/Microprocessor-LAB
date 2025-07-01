
include 'emu8086.inc'       ; ইনক্লুড লাইব্রেরি, যাতে ইনপুট/আউটপুট ফাংশন ব্যবহার করা যায়
org 100h                    ; .COM ফাইল হিসেবে প্রোগ্রাম শুরু করার নির্দেশ

jmp start                   ; প্রোগ্রামের মূল অংশে যাওয়ার জন্য লাফ

start:
    print "Enter n numbers: " ; ইউজারকে সংখ্যা কতবার ইনপুট দেবে তা জিজ্ঞেস করো
    call scan_num             ; ইউজার ইনপুট দেবে, ফলাফল CX রেজিস্টারে যাবে
    mov si, cx                ; লুপের জন্য CX এর মান SI তে রাখো (n বার ইনপুট)
    mov bx, 0                 ; BX এ min মান সংরক্ষণের জন্য 0 দিয়ে শুরু করো
    mov dx, 0                 ; DX এ max মান সংরক্ষণের জন্য 0 দিয়ে শুরু করো

printn
    print "Input the numbers:" ; ইউজারকে বার্তা দেখাও ইনপুট শুরু করার
    printn

input_loop:
    call scan_num             ; ইউজার ইনপুট দেবে, ফলাফল CX তে যাবে
    mov ax, cx                ; পূর্ণ সংখ্যা AX এ রাখো

    print "Num: "             ; সংখ্যাটি দেখাও
    call print_num
    printn

    cmp bx, 0                 ; যদি এটা প্রথম ইনপুট হয় (min = 0 ধরে নিছি)
    je init_min_max           ; তাহলে min এবং max সেট করে নাও

    cmp ax, bx                ; নতুন সংখ্যা min (BX) থেকে ছোট কিনা?
    jl set_min                ; ছোট হলে সেট করো

    cmp ax, dx                ; নতুন সংখ্যা max (DX) থেকে বড় কিনা?
    jg set_max                ; বড় হলে সেট করো

    jmp cont                  ; কিছুই না হলে পরের ইনপুটে যাও

init_min_max:
    mov bx, ax                ; প্রথম ইনপুট min ধরে নাও
    mov dx, ax                ; এবং সেটাকেই max ও ধরে নাও
    jmp cont

set_min:
    mov bx, ax                ; নতুন min সেট করো
    jmp cont

set_max:
    mov dx, ax                ; নতুন max সেট করো

cont:
    dec si                    ; ইনপুটের সংখ্যা এক কমাও
    jnz input_loop            ; যদি এখনও ইনপুট বাকি থাকে, আবার লুপে যাও

print "Min="                 ; Min দেখাও
    mov ax, bx
    call print_num

print " Max="                ; Max দেখাও
    mov ax, dx
    call print_num

printn

    mov ah, 4Ch               ; প্রোগ্রাম শেষ করার জন্য DOS ইন্টারাপ্ট কল
    int 21h

define_scan_num               ; ইনপুট ফাংশনের ডেফিনিশন
define_print_num              ; নাম্বার প্রিন্ট করার ফাংশনের ডেফিনিশন
define_print_num_uns          ; unsigned সংখ্যা প্রিন্ট করার ফাংশন
define_get_string             ; স্ট্রিং ইনপুট নেওয়ার ফাংশন

end                           ; প্রোগ্রামের শেষ
