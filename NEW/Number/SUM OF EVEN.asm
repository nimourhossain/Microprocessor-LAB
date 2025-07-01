include 'emu8086.inc'       ; emu8086 লাইব্রেরি অন্তর্ভুক্ত করো
org 100h                   ; প্রোগ্রামের শুরু ঠিকানা 100h

jmp start                  ; start লেবেলে জাম্প করো

start:
print "Enter an Even Number: "
call scan_num
printn
mov di,cx
mov cx, 2                  ; CX = 2 থেকে শুরু করো (প্রথম জোড় সংখ্যা)
mov bx, 0                  ; BX এ যোগফল 0 রাখো (শূন্যে শুরু)

L:
add bx, cx                 ; BX তে CX এর মান যোগ করো (যোগফল আপডেট)
add cx, 2                  ; CX তে 2 যোগ করো (পরের জোড় সংখ্যা)
cmp cx, di                 ; CX কি 16 এর চেয়ে ছোট?
jle L                       ; যদি ছোট হয়, লুপ আবার চালাও

print "SUM: "              ; টেক্সট প্রিন্ট করো "SUM: "
mov ax, bx                 ; AX এ যোগফল নিয়ে আসো
call print_num             ; AX এর মান প্রিন্ট করো
printn                     ; নতুন লাইন প্রিন্ট করো

mov ah, 4ch                ; প্রোগ্রাম শেষ করার জন্য DOS কল
int 21h                    ; ইন্টারাপ্ট 21h কল করো

define_scan_num            ; scan_num ডিফাইন করো (এখানে ব্যবহার হয়নি)
define_print_num           ; print_num ডিফাইন করো
define_print_num_uns       ; print_num_unsigned ডিফাইন করো (এখানে ব্যবহার হয়নি)
define_get_string          ; get_string ডিফাইন করো (এখানে ব্যবহার হয়নি)

end start                  ; প্রোগ্রামের শেষ, start থেকে শুরু হবে
