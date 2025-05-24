include 'emu8086.inc'          ; EMU8086 লাইব্রেরি ইনক্লুড করা হলো
org 100h                      ; প্রোগ্রামের শুরু ঠিকানা

jmp start                     ; সরাসরি start লেবেলে যাবে

buf db 21 dup(0)              ; ২১ বাইট জায়গা (২০ অক্ষর + ০ দিয়ে শেষ)

start:
    printn "Enter string (max 20):"  ; ইউজারকে ইনপুট নিতে বলো
    lea di, buf                      ; DI-তে buffer এর ঠিকানা লোড করো
    mov dx, 20                      ; সর্বোচ্চ ২০ অক্ষর ইনপুট নাও
    call get_string                 ; get_string কল করো

    lea si, buf                     ; SI-তে buffer এর ঠিকানা লোড করো

convert_loop:
    mov al, [si]                   ; AL-এ বর্তমান অক্ষর নাও
    cmp al, 0                      ; যদি ০ (null) হয়, শেষ হয়েছে
    je done

    ; যদি ছোট হাতের a থেকে z এর মধ্যে হয়, বড় হাতের অক্ষরে রূপান্তর করো
    cmp al, 'a'                    ; 'a' এর আগে হলে skip করো
    jb skip
    cmp al, 'z'                    ; 'z' এর পরে হলে skip করো
    ja skip
    sub al, 20h                   ; ছোট হাত থেকে বড় হাতের অক্ষরে রূপান্তর (ASCII)
    mov [si], al                   ; রূপান্তরিত অক্ষর সংরক্ষণ করো

skip:
    inc si                        ; পরবর্তী অক্ষরে যাও
    jmp convert_loop              ; লুপ চালাও

done:
    printn "Uppercase string: "    ; ফলাফল দেখাও
    lea si, buf                   ; SI-তে buffer ঠিকানা লোড করো
    call print_string             ; স্ট্রিং প্রিন্ট করো

    mov ah, 4Ch                   ; প্রোগ্রাম শেষ করার জন্য DOS ইন্টারাপ্ট
    int 21h

DEFINE_GET_STRING               ; get_string ফাংশন ডিফাইন করা আছে
DEFINE_PRINT_STRING             ; print_string ফাংশন ডিফাইন করা আছে
end
