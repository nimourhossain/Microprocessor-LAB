include 'emu8086.inc'        ; EMU8086 লাইব্রেরি যোগ করা হয়েছে
org 100h                    ; প্রোগ্রামের শুরু ঠিকানা (COM ফাইলের জন্য)

jmp start                   ; সরাসরি start লেবেলে যাবে

buf db 21 dup(0)            ; ২১ বাইট জায়গা রাখা হয়েছে স্ট্রিং সংরক্ষণের জন্য (২০ অক্ষর + শেষের ০)

start:
    printn "Enter string (max 20):" ; ইউজারকে স্ট্রিং ইনপুট দিতে বলো, সর্বোচ্চ ২০ অক্ষর
    lea di, buf             ; DI রেজিস্টারে buf এর ঠিকানা লোড করো
    mov dx, 20              ; DX-তে সর্বোচ্চ ইনপুট দৈর্ঘ্য ২০ সেট করো
    call get_string         ; get_string ফাংশন কল করো ইনপুট নিতে

    ; স্ট্রিং এর দৈর্ঘ্য বের করার জন্য শুরু করা
    lea si, buf             ; SI তে স্ট্রিং শুরু পয়েন্ট লোড করো
    mov cx, 0               ; CX-তে দৈর্ঘ্য শুরুতে ০ সেট করো

strlen_loop:
    mov al, [si]            ; AL-এ বর্তমান অক্ষর লোড করো
    cmp al, 0               ; যদি AL == 0 হয় (স্ট্রিং এর শেষ)
    je check_palindrome     ; তাহলে palindrome চেক করার অংশে যাও
    inc si                  ; অন্যথায় SI বাড়াও, পরের অক্ষরে যাও
    inc cx                  ; দৈর্ঘ্য বাড়াও
    jmp strlen_loop         ; লুপ চালিয়ে যাও

check_palindrome:
    ; SI ও DI পয়েন্টার ঠিক করো, SI শুরুতে, DI শেষে
    lea si, buf             ; SI তে স্ট্রিং শুরু
    lea di, buf             ; DI তেও শুরু (শুরু থেকে)
    mov bx, cx              ; BX তে স্ট্রিং দৈর্ঘ্য নাও
    dec bx                  ; শেষ অক্ষরের ইনডেক্স = দৈর্ঘ্য - ১
    add di, bx              ; DI কে শেষ অক্ষরে নিয়ে যাও

pal_loop:
    cmp si, di              ; যদি SI >= DI হয়, মানে সব চেক হয়ে গিয়েছে, প্যালিনড্রোম
    jge palindrome_true

    mov al, [si]            ; AL = শুরু পয়েন্টের অক্ষর
    mov bl, [di]            ; BL = শেষ পয়েন্টের অক্ষর

    ; বড় হাতের অক্ষরকে ছোট হাতের অক্ষরে রূপান্তর (case-insensitive চেকের জন্য)
    cmp al, 'A'             ; AL কি বড় হাতের A এর আগে?
    jb skip_lower_al        ; হ্যাঁ হলে স্কিপ করো
    cmp al, 'Z'             ; AL কি বড় হাতের Z এর পরে?
    ja skip_lower_al        ; হ্যাঁ হলে স্কিপ করো
    or al, 20h              ; না হলে ছোট হাতের অক্ষরে রূপান্তর করো (ASCII 20h যোগ করে)

skip_lower_al:

    cmp bl, 'A'             ; BL জন্য একই রকম চেক করো
    jb skip_lower_bl
    cmp bl, 'Z'
    ja skip_lower_bl
    or bl, 20h

skip_lower_bl:

    cmp al, bl              ; দুই অক্ষর মিলছে কিনা চেক করো
    jne palindrome_false    ; না হলে প্যালিনড্রোম না

    inc si                  ; SI বাড়াও (পরের অক্ষরে যাও)
    dec di                  ; DI কমাও (পিছনের অক্ষরে যাও)
    jmp pal_loop            ; লুপ চালিয়ে যাও

palindrome_true:
    printn "String is palindrome"  ; স্ট্রিং প্যালিনড্রোম হলে মেসেজ দেখাও
    jmp exit

palindrome_false:
    printn "String is NOT palindrome" ; না হলে অন্য মেসেজ দেখাও

exit:
    mov ah, 4Ch             ; প্রোগ্রাম শেষ করার জন্য DOS ইন্টারাপ্ট প্রস্তুত করো
    int 21h                 ; প্রোগ্রাম শেষ করো

DEFINE_GET_STRING           ; get_string ফাংশনের সংজ্ঞা যোগ করা হয়েছে
end                        ; প্রোগ্রাম শেষ
