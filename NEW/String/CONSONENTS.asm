include 'emu8086.inc'        ; EMU8086 লাইব্রেরি অন্তর্ভুক্ত
org 100h                    ; .COM প্রোগ্রামের জন্য শুরু ঠিকানা 100h
jmp start                   ; সরাসরি start লেবেলে যাবে

buf db 21 dup(0)            ; স্ট্রিং ইনপুটের জন্য ২১ বাইট জায়গা (২০ ক্যারেক্টার + নাল)

start:
    printn "Enter string (max 20):" ; ইউজারকে স্ট্রিং ইনপুটের জন্য বলা
    lea di, buf             ; DI-তে buf এর ঠিকানা লোড করো
    mov dx, 20              ; সর্বোচ্চ ২০ ক্যারেক্টার ইনপুট নেওয়ার সীমা
    call get_string         ; স্ট্রিং ইনপুট নাও

    xor cx, cx              ; CX রেজিস্টার ০ দিয়ে ক্লিয়ার করো (consonant গননার জন্য কাউন্টার)
    lea si, buf             ; SI-তে buf এর শুরু ঠিকানা লোড করো

loop_:
    mov al, [si]            ; SI পয়েন্টারের অক্ষর AL-এ নাও
    test al, al             ; AL == 0 (স্ট্রিং শেষ) কিনা চেক করো
    jz done                 ; যদি শেষ হয় তাহলে done এ যাও

    cmp al, 'A'             ; AL কি 'A' এর আগে?
    jb next                 ; যদি আগে হয়, next এ যাও (non-alphabetic)
    cmp al, 'Z'             ; AL কি 'Z' এর পরে?
    ja next                 ; যদি পরে হয়, next এ যাও
    or al, 20h              ; বড় হাতের অক্ষর হলে ছোট হাতের অক্ষরে রূপান্তর করো

    cmp al, 'a'             ; AL কি 'a' এর আগে?
    jb next                 ; আগে হলে next এ যাও
    cmp al, 'z'             ; AL কি 'z' এর পরে?
    ja next                 ; পরে হলে next এ যাও

    ; AL এখন ছোট হাতের অক্ষর; স্বরবর্ণ না হলে গননা বাড়াবে

    cmp al, 'a'             ; AL কি 'a'?
    je next                 ; যদি হ্যাঁ, next এ যাও
    cmp al, 'e'             ; AL কি 'e'?
    je next                 ; যদি হ্যাঁ, next এ যাও
    cmp al, 'i'             ; AL কি 'i'?
    je next                 ; যদি হ্যাঁ, next এ যাও
    cmp al, 'o'             ; AL কি 'o'?
    je next                 ; যদি হ্যাঁ, next এ যাও
    cmp al, 'u'             ; AL কি 'u'?
    je next                 ; যদি হ্যাঁ, next এ যাও

    inc cx                  ; অন্যথায় এটি ব্যঞ্জনবর্ণ, CX বাড়াও

next:
    inc si                  ; SI বাড়াও (পরবর্তী অক্ষর)
    jmp loop_               ; লুপ চালিয়ে যাও

done:
    printn                  ; নতুন লাইন প্রিন্ট করো
    print "Consonants count: " ; ব্যঞ্জনবর্ণের সংখ্যা দেখানোর মেসেজ
    mov ax, cx              ; CX থেকে AX এ সংখ্যা কপি করো
    call print_num          ; সংখ্যা প্রিন্ট করো
    printn                  ; নতুন লাইন প্রিন্ট করো

    mov ah, 4Ch             ; প্রোগ্রাম শেষ করার জন্য DOS ইন্টারাপ্ট প্রস্তুত
    int 21h                 ; প্রোগ্রাম শেষ করো

DEFINE_GET_STRING           ; get_string ফাংশন সংজ্ঞা
DEFINE_PRINT_NUM_UNS        ; unsigned সংখ্যা প্রিন্টের ফাংশন সংজ্ঞা
DEFINE_PRINT_NUM            ; সংখ্যা প্রিন্টের ফাংশন সংজ্ঞা
end                        ; প্রোগ্রাম শেষ, শুরু পয়েন্ট start
