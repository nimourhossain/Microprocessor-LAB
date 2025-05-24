include 'emu8086.inc'           ; EMU8086 লাইব্রেরি ইনক্লুড
org 100h                       ; প্রোগ্রামের শুরু ঠিকানা

jmp start                      ; সরাসরি start লেবেলে যাবে

buf db 21 dup(0)               ; ২১ বাইট জায়গা (২০ অক্ষর + 0 দিয়ে শেষ)

start:
    printn "Enter string (max 20):"  ; ইউজারকে স্ট্রিং ইনপুট দিতে বলো
    lea di, buf                     ; DI-তে buffer ঠিকানা লোড করো
    mov dx, 20                     ; সর্বোচ্চ ২০ অক্ষর নাও
    call get_string                ; get_string কল করো

    xor cx, cx                    ; CX=0, স্বরবর্ণের সংখ্যা শুরুতে শূন্য
    lea si, buf                   ; SI-তে buffer ঠিকানা লোড করো

loop_:
    mov al, [si]                  ; AL-এ বর্তমান অক্ষর নাও
    test al, al                  ; AL == 0? (স্ট্রিং শেষ কি না চেক)
    jz done                      ; যদি শেষ, লুপ শেষ করো

    cmp al, 'A'                  ; বড় হাতের A-র থেকে ছোট কিনা
    jb skip                     ; যদি ছোট হয়, vowel চেক বাদ দাও
    cmp al, 'Z'                  ; বড় হাতের Z-র থেকে বড় কিনা
    ja skip                     ; যদি বড় হয়, vowel চেক বাদ দাও
    or al, 20h                   ; বড় হাতের অক্ষরকে ছোট হাতের করে ফেলো

skip:
    cmp al, 'a'                  ; vowel 'a'?
    je inc
    cmp al, 'e'                  ; vowel 'e'?
    je inc
    cmp al, 'i'                  ; vowel 'i'?
    je inc
    cmp al, 'o'                  ; vowel 'o'?
    je inc
    cmp al, 'u'                  ; vowel 'u'?
    je inc
    jmp next                    ; vowel না হলে পরের অক্ষরে যাও

inc:
    inc cx                      ; vowel সংখ্যা ১ বাড়াও

next:
    inc si                      ; পরবর্তী অক্ষরে যাও
    jmp loop_                   ; লুপ চালিয়ে যাও

done:
    printn                      ; নতুন লাইন
    print "Vowels count: "      ; vowel সংখ্যা দেখাও
    mov ax, cx                  ; CX থেকে AX-এ মান নাও (print_num expects AX)
    call print_num              ; সংখ্যা প্রিন্ট করো
    printn                      ; নতুন লাইন

    mov ah, 4Ch                 ; প্রোগ্রাম শেষ করার DOS কল
    int 21h

DEFINE_GET_STRING               ; get_string ফাংশন ডিফাইন করা আছে
DEFINE_PRINT_NUM_UNS           ; print_num_unsigned ফাংশন ডিফাইন আছে
DEFINE_PRINT_NUM               ; print_num ফাংশন ডিফাইন আছে
end
