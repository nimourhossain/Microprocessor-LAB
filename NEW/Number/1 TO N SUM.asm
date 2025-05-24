include 'emu8086.inc'          ; emu8086 লাইব্রেরি ইমপোর্ট

org 100h                     ; প্রোগ্রামের শুরু ঠিকানা 100h

jmp start                    ; সরাসরি start লেবেলে যান

buffer db 5 dup(0)           ; ৫ বাইটের একটি বাফার তৈরি (সর্বোচ্চ ৫ সংখ্যার ইনপুট)

start:
    printn "Enter number n (max 5 digits):"   ; ব্যবহারকারীর কাছে ইনপুট চাইছি (৫ ডিজিট পর্যন্ত)
    lea di, buffer                           ; DI রেজিস্টারে বাফারের ঠিকানা লোড করছি
    mov dx, 5                               ; DX রেজিস্টারে সর্বোচ্চ ৫ ক্যারেক্টার সেট করছি
    call get_string                         ; ইউজার থেকে স্ট্রিং ইনপুট নেওয়ার ফাংশন কল

    call str_to_num                        ; স্ট্রিং থেকে সংখ্যায় রূপান্তর ফাংশন কল
    mov cx, ax                            ; AX এর মান (সংখ্যা) CX তে কপি করলাম

    xor ax, ax                            ; AX = 0 (যোগফল জমা শুরু করছি)
    mov bx, 1                             ; BX = 1 (গণনা শুরু)

sum_loop:
    add ax, bx                           ; AX = AX + BX (যোগফল আপডেট)
    inc bx                              ; BX = BX + 1 (পরবর্তী সংখ্যা)
    cmp bx, cx                          ; BX ও CX তুলনা
    jle sum_loop                        ; যদি BX <= CX হয়, লুপ চালিয়ে যাও

    printn                               ; নতুন লাইনে যান
    print "Sum = "                       ; "Sum = " মেসেজ প্রিন্ট
    call print_num                      ; ফলাফল প্রিন্ট
    printn                              ; নতুন লাইনে যান

    mov ah, 4Ch                         ; প্রোগ্রাম শেষ করার DOS কল প্রস্তুত
    int 21h                            ; প্রোগ্রাম শেষ

; স্ট্রিং থেকে নম্বর কনভার্ট করার ফাংশন
str_to_num:
    xor ax, ax                         ; AX = 0 (আরম্ভিক সংখ্যা)
    lea si, buffer                     ; SI তে বাফারের ঠিকানা লোড

convert_loop:
    mov bl, [si]                      ; SI পয়েন্টারের বর্তমান ক্যারেক্টার নিন
    cmp bl, 0                         ; যদি NULL ক্যারেক্টার হয় (স্ট্রিং শেষ)
    je done_conv                      ; তাহলে কনভার্সন শেষ

    sub bl, '0'                       ; ASCII থেকে সংখ্যা রূপান্তর

    mov dx, 0                        ; DX = 0 (মাল্টিপ্লিকেশন প্রস্তুত)
    mov bx, 10                       ; ১০ দিয়ে গুণ করব
    mul bx                          ; AX = AX * 10
    mov bx, 0
    mov bl, [si]
    sub bl, '0'                     ; আবার ASCII থেকে সংখ্যা রূপান্তর
    mov bh, 0
    add ax, bx                      ; AX += BL (নতুন সংখ্যা যোগ করলাম)

    inc si                         ; SI পরবর্তী ক্যারেক্টারে বাড়ান
    jmp convert_loop               ; লুপ চালিয়ে যান

done_conv:
    ret                           ; রিটার্ন করুন

DEFINE_GET_STRING                 ; get_string ফাংশন ডিফাইন (emu8086.inc এ)
DEFINE_PRINT_NUM                 ; print_num ফাংশন ডিফাইন
DEFINE_PRINT_NUM_UNS             ; print_num_unsigned ফাংশন ডিফাইন
end
