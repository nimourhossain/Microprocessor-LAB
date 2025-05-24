include 'emu8086.inc'       ; emu8086 লাইব্রেরি অন্তর্ভুক্ত করো
org 100h                   ; প্রোগ্রাম শুরু হবে 100h ঠিকানায়

jmp start                  ; start লেবেলে লাফাও

start:
    mov cx, 2              ; CX কে 2 দিয়ে শুরু করো (প্রথম সংখ্যা)
    mov bx, 0              ; BX = 0 (প্রাইম সংখ্যা গণনার জন্য কাউন্টার)

next_num:
    cmp cx, 10             ; CX কি 10 এর সমান বা বেশি?
    jge done               ; যদি >=10 হয়, কাজ শেষ করো

    mov si, 1              ; ধরে নাও সংখ্যা প্রাইম (SI=1)
    mov dx, 0              ; DX ক্লিয়ার করো (ডিভিশনের জন্য)
    mov ax, cx             ; AX = CX (যে সংখ্যা চেক করবো)
    mov di, 2              ; ডিভাইসর DI = 2 থেকে শুরু

check_div:
    cmp di, cx             ; DI কি CX এর সমান?
    je count_prime         ; যদি সমান হয়, প্রাইম (ডিভাইসর শেষ)
    mov dx, 0              ; DX ক্লিয়ার করো (ডিভিশনের জন্য)
    div di                 ; AX কে DI দিয়ে ভাগ করো
    cmp dx, 0              ; ভাগশেষ 0 কিনা চেক করো
    je not_prime           ; যদি 0 হয়, প্রাইম না (ভাগ যায়)
    inc di                 ; DI এক বাড়াও (পরবর্তী ডিভাইসর)
    mov ax, cx             ; AX আবার CX এ সেট করো
    jmp check_div          ; আবার চেক করো

not_prime:
    mov si, 0              ; প্রাইম নয়, SI=0 সেট করো

count_prime:
    cmp si, 1              ; SI=1 কিনা চেক করো (প্রাইম হলে)
    jne skip_count         ; না হলে কাউন্ট বাড়ানো যাবে না
    inc bx                 ; প্রাইম সংখ্যা কাউন্টার ১ বাড়াও

skip_count:
    inc cx                 ; পরবর্তী সংখ্যা
    jmp next_num           ; লুপ চালিয়ে যাও

done:
    print "Total prime numbers: "  ; মোট প্রাইম সংখ্যা প্রিন্ট করো
    mov ax, bx                     ; BX (গণনা) AX-এ নাও
    call print_num                 ; সংখ্যা প্রিন্ট করো
    printn                        ; নতুন লাইন

    mov ah, 4ch                   ; প্রোগ্রাম শেষ করার জন্য DOS কল সেট করো
    int 21h                      ; DOS ইন্টারাপ্ট কল করো

define_scan_num
define_print_num
define_print_num_uns
define_get_string

end start                      ; প্রোগ্রাম শেষ, start থেকে শুরু হবে
