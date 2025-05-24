include 'emu8086.inc'           ; EMU8086 লাইব্রেরি ইনক্লুড
org 100h                       ; প্রোগ্রামের শুরু ঠিকানা

jmp start                      ; সরাসরি start লেবেলে যাবে

buffer db 21 dup(0)            ; ২১ বাইট জায়গা (২০ অক্ষর + 0 দিয়ে শেষ)

start:
    printn "Enter a string (max 20):"  ; ইউজারকে স্ট্রিং ইনপুট দিতে বলো
    lea di, buffer                     ; DI-তে buffer এর ঠিকানা লোড করো
    mov dx, 20                       ; সর্বোচ্চ ২০ অক্ষর নাও
    call get_string                  ; get_string কল করো

    lea si, buffer                   ; SI-তে buffer ঠিকানা লোড করো
    mov cx, 0                       ; CX=0 (স্ট্রিং দৈর্ঘ্য গন্য করার জন্য)

length_loop:
    mov al, [si]                    ; AL-এ বর্তমান অক্ষর নাও
    cmp al, 0                       ; যদি 0 (null terminator) হয়, লুপ শেষ
    je done
    inc cx                         ; দৈর্ঘ্য ১ বাড়াও
    inc si                         ; পরবর্তী অক্ষরে যাও
    jmp length_loop                 ; লুপ চালিয়ে যাও

done:
    printn                          ; নতুন লাইন
    print "Length: "                ; দৈর্ঘ্য দেখাও
    mov ax, cx                     ; CX থেকে AX-এ মান নাও (print_num expects AX)
    call print_num                 ; সংখ্যাটি প্রিন্ট করো
    printn                         ; নতুন লাইন

    mov ah, 4Ch                    ; প্রোগ্রাম শেষ করার DOS কল
    int 21h

DEFINE_GET_STRING                ; get_string ফাংশন ডিফাইন করা আছে
DEFINE_PRINT_NUM                ; print_num ফাংশন ডিফাইন করা আছে
DEFINE_PRINT_NUM_UNS            ; print_num_unsigned ডিফাইন আছে
end
