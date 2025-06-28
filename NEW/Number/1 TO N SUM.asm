include 'emu8086.inc'       ; emu8086 লাইব্রেরি অন্তর্ভুক্ত করো
org 100h                   ; প্রোগ্রাম শুরু হবে 100h ঠিকানায়

jmp start                  ; start লেবেলে লাফাও

start:
mov cx, 0                  ; CX কে 0 দিয়ে শুরু করো (প্রথম  সংখ্যা)
mov bx, 0                  ; BX কে 0 দিয়ে শুরু করো (যোগফল রাখার জন্য)

L:
add bx, cx                 ; BX-তে CX যোগ করো (যোগফল আপডেট করো)
add cx, 1                  ; CX-তে 2 যোগ করো (পরবর্তী  সংখ্যা)
cmp cx, 16                 ; CX কি 16 এর কম?
jl L                       ; যদি কম হয়, আবার লুপ চালাও

print "SUM: "              ; "SUM: " টেক্সট প্রিন্ট করো
mov ax, bx                 ; AX-এ যোগফল নিয়ে আসো
call print_num             ; AX এর মান প্রিন্ট করো
printn                     ; নতুন লাইন প্রিন্ট করো

mov ah, 4ch                ; প্রোগ্রাম শেষ করার জন্য DOS কল সেট করো
int 21h                    ; DOS ইন্টারাপ্ট কল করো

define_scan_num            ; scan_num ফাংশন ডিফাইন করো (এখানে ব্যবহার হয়নি)
define_print_num           ; print_num ফাংশন ডিফাইন করো
define_print_num_uns       ; print_num_unsigned ডিফাইন করো (এখানে ব্যবহার হয়নি)
define_get_string          ; get_string ডিফাইন করো (এখানে ব্যবহার হয়নি)

end start                  ; প্রোগ্রাম শেষ, start থেকে শুরু হবে
