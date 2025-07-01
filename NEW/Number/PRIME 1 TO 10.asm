include 'emu8086.inc'        ; ইনপুট-আউটপুট ফাংশনের জন্য EMU8086 লাইব্রেরি যুক্ত করা হচ্ছে
org 100h                     ; .COM প্রোগ্রামের জন্য শুরু পয়েন্ট (মেমোরি 100h থেকে শুরু হবে)

jmp start                    ; প্রোগ্রাম শুরুতে start লেবেলে যাবে

start:
    print "Enter your Number: "
    call scan_num
    printn
    mov di,cx
    mov cx, 2                ; cx=2 দিয়ে শুরু করা হচ্ছে (প্রথম প্রাইম সংখ্যা চেকের জন্য)

next_num:
    cmp cx, di               ; যদি cx >= 10 হয়, তাহলে শেষ করে done-এ যাবে
    jge done

    mov bx, 2                ; bx=2 দিয়ে ভাগ করা শুরু হবে
    mov si, 1                ; si=1 ধরে নিচ্ছে সংখ্যাটি প্রাইম

check_div:
    cmp bx, cx               ; যদি bx = cx হয়, মানে নিজে ছাড়া ভাগ হয়নি
    je print_prime           ; তাহলে প্রাইম ধরে প্রিন্ট করবে

    mov dx, 0
    mov ax, cx
    div bx                   ; cx / bx → ফলাফল ax তে, ভাগশেষ dx তে

    cmp dx, 0
    je not_prime             ; যদি ভাগশেষ 0 হয়, তাহলে প্রাইম না

    inc bx                   ; ভাগ করার জন্য পরবর্তী সংখ্যা
    jmp check_div            ; আবার ভাগ করে দেখে

not_prime:
    mov si, 0                ; প্রাইম নয়, si=0 করে

print_prime:
    cmp si, 1                ; si=1 মানে প্রাইম হলে
    jne skip_print           ; যদি প্রাইম না হয়, তাহলে প্রিন্ট করবে না

    mov ax, cx
    call print_num           ; প্রাইম নাম্বার প্রিন্ট করবে
    print " "                ; স্পেস দিচ্ছে সংখ্যার পরে

skip_print:
    inc cx                   ; পরবর্তী সংখ্যা চেক করার জন্য cx বাড়ায়
    jmp next_num             ; আবার লুপে যায়

done:
    printn                   ; নতুন লাইনে যাওয়ার জন্য
    mov ah,4ch
    int 21h                  ; প্রোগ্রাম শেষ করে

define_scan_num              ; scan_num ফাংশনের ডেফিনিশন (এখানে ব্যবহৃত হয়নি)
define_print_num             ; print_num ফাংশনের ডেফিনিশন
define_print_num_uns         ; unsigned নাম্বার প্রিন্টের জন্য (এখানে ব্যবহৃত হয়নি)
define_get_string            ; স্ট্রিং ইনপুট নেওয়ার জন্য (এখানে ব্যবহৃত হয়নি)

end start                    ; প্রোগ্রামের শেষ এবং এন্ট্রি পয়েন্ট start
