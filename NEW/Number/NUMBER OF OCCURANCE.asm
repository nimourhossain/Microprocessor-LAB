include 'emu8086.inc'      ; EMU8086 এর ইনক্লুড ফাইল অন্তর্ভুক্ত করা হয়েছে
org 100h                    ; প্রোগ্রাম মেমরির 100h অফসেট থেকে শুরু হবে
jmp start                   ; start লেবেলে জাম্প করো

arr db 20 dup(?)            ; 20 বাইটের একটি অ্যারে arr তৈরি করা হয়েছে, যা ইনপুট সংখ্যা সংরক্ষণ করবে
occ db 20 dup(0)            ; 20 বাইটের একটি অ্যারে occ তৈরি করা হয়েছে এবং সব মান 0 দিয়ে শুরু করা হয়েছে, যা সংখ্যার উপস্থিতি (occurrence) সংরক্ষণ করবে

start:
print "How many numbers: "  ; "How many numbers: " এই বার্তাটি প্রিন্ট করো
call scan_num               ; ব্যবহারকারীর কাছ থেকে একটি সংখ্যা স্ক্যান করো (এটি CX রেজিস্টারে সংরক্ষণ হবে)
mov bx, cx                  ; CX এর মান BX এ কপি করো (n = BX)
mov si, 0                   ; SI রেজিস্টারকে 0 এ সেট করো (অ্যারে ইনডেক্স হিসাবে ব্যবহৃত হবে)
mov di, 0                   ; DI রেজিস্টারকে 0 এ সেট করো (occ অ্যারে ইনডেক্স হিসাবে ব্যবহৃত হবে)

printn                      ; একটি নতুন লাইন প্রিন্ট করো
print "Enter the numbers: " ; "Enter the numbers: " এই বার্তাটি প্রিন্ট করো
printn                      ; একটি নতুন লাইন প্রিন্ট করো

input_loop:
call scan_num               ; ব্যবহারকারীর কাছ থেকে একটি সংখ্যা স্ক্যান করো (এটি CL রেজিস্টারে সংরক্ষণ হবে)
mov arr[di], cl             ; CL এর মান arr[di] এ সংরক্ষণ করো
mov occ[di], 0              ; occ[di] এর মান 0 এ সেট করো (প্রাথমিকভাবে)

; ইনপুট করা সংখ্যাটি তাৎক্ষণিকভাবে প্রিন্ট করার জন্য
mov al, cl                  ; CL এর মান AL এ কপি করো
cbw                         ; AL কে AX এ প্রসারিত করো (byte to word)
mov ax, ax                  ; AX এর মান AX এই রাখো (কোন পরিবর্তন না হলেও, এটি একটি প্রয়োজনীয় ধাপ)
call print_num              ; AX এর মান প্রিন্ট করো
printn                      ; একটি নতুন লাইন প্রিন্ট করো

inc di                      ; DI কে 1 বাড়াও
inc si                      ; SI কে 1 বাড়াও
dec bx                      ; BX কে 1 কমাও
jnz input_loop              ; যদি BX শূন্য না হয়, তাহলে input_loop এ ফিরে যাও

mov cx, si                  ; SI এর মান CX এ কপি করো (অ্যারের মোট সংখ্যা)
mov si, 0                   ; SI কে 0 এ সেট করো (বাইরের লুপের জন্য অ্যারে ইনডেক্স)

outer_loop:
mov di, si                  ; DI কে SI এর মান দিয়ে সেট করো
mov al, arr[si]             ; arr[si] এর মান AL এ লোড করো
cmp occ[si], 0              ; occ[si] এর মান 0 এর সাথে তুলনা করো
jne skip_outer              ; যদি occ[si] 0 না হয়, তাহলে skip_outer এ জাম্প করো (তার মানে এই সংখ্যাটি আগে গণনা করা হয়েছে)

mov bx, 1                   ; BX কে 1 এ সেট করো (বর্তমান সংখ্যার গণনাকারী, এটি নিজেই একটি উপস্থিতি)

inner_loop:
inc di                      ; DI কে 1 বাড়াও
cmp di, cx                  ; DI কে CX এর সাথে তুলনা করো
jge save_result             ; যদি DI, CX এর চেয়ে বড় বা সমান হয়, তাহলে save_result এ জাম্প করো

mov ah, arr[di]             ; arr[di] এর মান AH এ লোড করো
cmp ah, al                  ; AH কে AL এর সাথে তুলনা করো (বর্তমান সংখ্যা এবং arr[di])
jne inner_loop              ; যদি AH, AL এর সমান না হয়, তাহলে inner_loop এ ফিরে যাও
inc bx                      ; যদি সমান হয়, BX কে 1 বাড়াও
mov occ[di], 255            ; occ[di] কে 255 এ সেট করো (এই সংখ্যাটি ইতিমধ্যেই গণনা করা হয়েছে নির্দেশ করতে)
jmp inner_loop              ; inner_loop এ ফিরে যাও

save_result:
mov occ[si], bl             ; BX এর লোয়ার বাইট (BL) এর মান occ[si] এ সংরক্ষণ করো (বর্তমান সংখ্যার মোট উপস্থিতি)

skip_outer:
inc si                      ; SI কে 1 বাড়াও
cmp si, cx                  ; SI কে CX এর সাথে তুলনা করো
jl outer_loop               ; যদি SI, CX এর চেয়ে ছোট হয়, তাহলে outer_loop এ ফিরে যাও

; ফলাফল প্রিন্ট করার অংশ

mov si, 0                   ; SI কে 0 এ সেট করো (প্রিন্ট লুপের জন্য অ্যারে ইনডেক্স)

print_loop:
cmp occ[si], 0              ; occ[si] কে 0 এর সাথে তুলনা করো
je skip_print               ; যদি occ[si] 0 হয়, তাহলে skip_print এ জাম্প করো (কারণ এটি একটি নতুন এন্ট্রি বা ব্যবহার করা হয়েছে)
cmp occ[si], 255            ; occ[si] কে 255 এর সাথে তুলনা করো
je skip_print               ; যদি occ[si] 255 হয়, তাহলে skip_print এ জাম্প করো (কারণ এটি আগে গণনা করা হয়েছে)

mov al, arr[si]             ; arr[si] এর মান AL এ লোড করো
cbw                         ; AL কে AX এ প্রসারিত করো
mov ax, ax                  ; AX এর মান AX এই রাখো
call print_num              ; arr[si] এর মান প্রিন্ট করো
print " : "                 ; " : " প্রিন্ট করো
mov al, occ[si]             ; occ[si] এর মান AL এ লোড করো
cbw                         ; AL কে AX এ প্রসারিত করো
mov ax, ax                  ; AX এর মান AX এই রাখো
call print_num              ; occ[si] এর মান প্রিন্ট করো
printn                      ; একটি নতুন লাইন প্রিন্ট করো

skip_print:
inc si                      ; SI কে 1 বাড়াও
cmp si, cx                  ; SI কে CX এর সাথে তুলনা করো
jl print_loop               ; যদি SI, CX এর চেয়ে ছোট হয়, তাহলে print_loop এ ফিরে যাও

mov ah, 4ch                 ; প্রোগ্রাম শেষ করার জন্য DOS ফাংশন 4Ch লোড করো
int 21h                     ; DOS ইন্টারাপ্ট কল করো

DEFINE_SCAN_NUM             ; scan_num ম্যাক্রো সংজ্ঞায়িত করো
DEFINE_PRINT_NUM            ; print_num ম্যাক্রো সংজ্ঞায়িত করো
DEFINE_PRINT_NUM_UNS        ; print_num_uns ম্যাক্রো সংজ্ঞায়িত করো
end start                   ; প্রোগ্রামের শেষ নির্দেশ করে