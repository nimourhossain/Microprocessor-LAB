include 'emu8086.inc'          ; emu8086.inc ফাইল ইনক্লুড করলাম
org 100h                      ; প্রোগ্রামের শুরু ঠিকানা 100h

jmp start                    ; প্রোগ্রামের শুরুতে সরাসরি start লেবেলে যাবে

buf db 81 dup(0)             ; ৮০ ক্যারেক্টার + ১টা নাল টার্মিনেটর এর জন্য জায়গা বরাদ্দ

start:
    printn "Enter a string (max 80):"   ; ইউজারকে স্ট্রিং ইনপুট দিতে বললাম (সর্বোচ্চ ৮০)
    lea di, buf                        ; DI রেজিস্টারে buffer এর ঠিকানা লোড করলাম
    mov dx, 80                        ; DX রেজিস্টারে ইনপুটের সর্বোচ্চ দৈর্ঘ্য ৮০ সেট করলাম
    call get_string                   ; ইউজার থেকে স্ট্রিং ইনপুট নিলাম

    lea si, buf                      ; SI রেজিস্টারে buffer এর শুরু ঠিকানা লোড করলাম
    mov cx, 0                       ; CX = 0, শব্দ গণনা শুরু
    mov bx, 0                       ; BX = 0, শব্দের ভিতরে নাকি বাইরে তা ট্র্যাক করার ফ্ল্যাগ

count_loop:
    mov al, [si]                    ; AL এ SI পয়েন্ট করা ক্যারেক্টার নিলাম
    cmp al, 0                       ; AL == 0? (স্ট্রিং এর শেষ নাল টার্মিনেটর কিনা)
    je done                        ; হ্যা হলে লুপ শেষ করবো

    cmp al, ' '                    ; AL == স্পেস কিনা চেক করবো
    je space_found                 ; যদি স্পেস হয়, তাহলে space_found এ যাবে

    cmp bx, 0                     ; BX == 0? (মানে এখনো শব্দের বাইরে)
    jne continue_char             ; যদি BX != 0 হয় (মানে শব্দের ভিতরে), তাহলে continue_char এ যাবে

    inc cx                       ; নতুন শব্দের শুরু, শব্দ সংখ্যা বাড়াবো
    mov bx, 1                    ; BX = 1, এখন শব্দের ভিতরে আছি

continue_char:
    inc si                       ; SI এক ধাপ বাড়িয়ে পরের ক্যারেক্টারে যাবে
    jmp count_loop               ; লুপ আবার শুরু করবে

space_found:
    mov bx, 0                    ; স্পেস পাওয়ায় BX = 0, মানে শব্দের বাইরে
    inc si                       ; SI এক ধাপ বাড়িয়ে পরের ক্যারেক্টারে যাবে
    jmp count_loop               ; লুপ আবার শুরু করবে

done:
    printn                       ; নতুন লাইনে যাবে
    print "Words count: "        ; শব্দের সংখ্যা লিখবে
    mov ax, cx                  ; AX এ শব্দ সংখ্যা নিয়ে আসবে
    call print_num              ; শব্দ সংখ্যা প্রিন্ট করবে
    printn                      ; নতুন লাইনে যাবে

    mov ah, 4Ch                 ; প্রোগ্রাম শেষ করার জন্য DOS ইন্টারাপ্ট সেট করবে
    int 21h                     ; DOS ইন্টারাপ্ট কল করবে

DEFINE_GET_STRING              ; get_string ফাংশনের ডেফিনিশন
DEFINE_PRINT_NUM              ; print_num ফাংশনের ডেফিনিশন
DEFINE_PRINT_NUM_UNS          ; print_num_uns ফাংশনের ডেফিনিশন
end                           ; প্রোগ্রাম শেষ
