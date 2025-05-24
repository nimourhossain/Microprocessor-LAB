include 'emu8086.inc'         ; EMU8086 লাইব্রেরি যোগ করা হয়েছে
org 100h                     ; COM প্রোগ্রামের শুরু ঠিকানা

jmp start                    ; সরাসরি start লেবেলে যাবে

buffer db 21 dup(0)          ; ২১ বাইট জায়গা রাখা হয়েছে (২০ অক্ষর + ০ দিয়ে শেষ)

start:
    ; ইউজারকে ইনপুট দিতে বলো
    printn "Enter a string (max 20 chars):"

    ; buffer ঠিকানা DI-তে লোড করো
    lea di, buffer
    mov dx, 20               ; সর্বোচ্চ ২০ অক্ষর ইনপুট নাও
    call get_string          ; স্ট্রিং ইনপুট নাও

    ; স্ট্রিং দৈর্ঘ্য বের করা শুরু
    lea si, buffer          ; SI-তে স্ট্রিং শুরু পয়েন্ট লোড করো
    mov cx, 0               ; CX-তে দৈর্ঘ্য শূন্য থেকে শুরু করো

find_len:
    cmp byte ptr [si], 0    ; স্ট্রিং এর শেষ ০ (null) কি পাওয়া গেছে?
    je reverse_start        ; হ্যাঁ হলে reverse শুরু করো
    inc si                  ; না হলে পরের অক্ষরে যাও
    inc cx                  ; দৈর্ঘ্য বাড়াও
    jmp find_len            ; আবার লুপ চালাও

reverse_start:
    lea si, buffer          ; SI-তে স্ট্রিং শুরু পয়েন্ট লোড করো
    lea di, buffer
    add di, cx              ; DI-তে স্ট্রিং এর শেষে যাও
    dec di                  ; শেষ অক্ষরের ঠিকানা (null নয়)

reverse_loop:
    cmp si, di              ; SI >= DI হলে সব রিভার্স হয়েছে
    jge done_reverse

    mov al, [si]            ; AL-এ শুরু অক্ষর
    mov bl, [di]            ; BL-এ শেষ অক্ষর
    mov [si], bl            ; শুরুতে শেষ অক্ষর সেট করো
    mov [di], al            ; শেষে শুরু অক্ষর সেট করো

    inc si                  ; SI বাড়াও (পরের অক্ষরে যাও)
    dec di                  ; DI কমাও (আগের অক্ষরে যাও)
    jmp reverse_loop        ; লুপ চালাও

done_reverse:
    printn                  ; নতুন লাইন
    print "Reversed: "      ; রিভার্সড স্ট্রিং দেখানোর জন্য মেসেজ
    lea si, buffer          ; SI-তে স্ট্রিং শুরু পয়েন্ট লোড করো
    call print_string       ; স্ট্রিং প্রিন্ট করো

    ; প্রোগ্রাম শেষ
    mov ah, 4Ch
    int 21h

DEFINE_GET_STRING             ; get_string ফাংশন ডিফাইন করা আছে
DEFINE_PRINT_STRING           ; print_string ফাংশন ডিফাইন করা আছে
end
