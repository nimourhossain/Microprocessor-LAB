include 'emu8086.inc'            ; EMU8086-এর হেল্পার ফাংশন ইনক্লুড করা হচ্ছে
org 100h                         ; প্রোগ্রাম শুরু হবে 100h অ্যাড্রেস থেকে (COM ফাইল স্ট্যান্ডার্ড)

jmp start                        ; সরাসরি 'start' লেবেলে লাফ দিয়ে যাওয়া

array dw 100 dup(?)              ; ১০০টি word এর জন্য একটি অ্যারে রিজার্ভ (ইনপুট সংখ্যা সংরক্ষণে)

start:
    print "Enter how many numbers: "  ; ইউজারকে সংখ্যা ইনপুট করতে বলা
    call scan_num                     ; ইউজার থেকে সংখ্যা ইনপুট নেওয়া
    mov bx, cx                        ; BX-এ মোট ইনপুট সংখ্যা রেখে দেওয়া
    mov dx, cx                        ; DX-এ কপি করে রাখা পরে ব্যবহারের জন্য
    mov si, 0                         ; SI রেজিস্টারকে 0 করে শুরু (array ইনডেক্স)

    printn
    print "Enter your numbers: "      ; ইনপুট নেওয়ার বার্তা দেখানো
    

input_loop:
    call scan_num
    printn                     ; ইউজার ইনপুট নিচ্ছে
    mov [array + si], cx             ; ইনপুট মান array-তে সংরক্ষণ
    add si, 2                         ; পরবর্তী word-এ যাওয়ার জন্য SI বাড়ানো
    dec bx                            ; মোট ইনপুট সংখ্যা কমানো
    jnz input_loop                    ; BX ≠ 0 হলে লুপ চালিয়ে যাওয়া

    printn
    print "You entered: "            ; আউটপুট দেখানোর শুরু
    

    mov si, 0                         ; আবার প্রথম ইনডেক্স থেকে শুরু
                                      ; BX-এ আবার সংখ্যার মোট কপি
 
print_loop:
    mov ax, [array + si]             ; অ্যারে থেকে মান উঠিয়ে AX-এ রাখা
    call print_num                   ; সংখ্যা প্রিন্ট করা
    print " "
    add si, 2                        ; পরবর্তী উপাদানে যাওয়ার জন্য SI বাড়ানো
    dec dx                           ; প্রিন্ট কাউন্টার কমানো
    jnz print_loop                   ; যতক্ষণ BX ≠ 0, লুপ চালিয়ে যাওয়া

    mov ah, 4ch                      ; প্রোগ্রাম শেষ করার জন্য DOS ইন্টারাপ্ট কল প্রস্তুত
    int 21h

define_scan_num                     ; ইনপুট নেওয়ার ফাংশনের ডেফিনিশন
define_print_num_uns
define_print_num                    ; আউটপুট দেখানোর ফাংশনের ডেফিনিশন

end start                            ; প্রোগ্রাম শেষ, শুরু হবে 'start' থেকে
