include 'emu8086.inc'        ; EMU8086 লাইব্রেরি যুক্ত করা হয়েছে যাতে print, input এর মতো ম্যাক্রো ব্যবহার করা যায়
org 100h                     ; প্রোগ্রামের শুরু 100h থেকে হবে (COM ফরম্যাটের জন্য প্রয়োজনীয়)

jmp start                    ; শুরুতেই control পাঠানো হচ্ছে start লেবেলে

buf db 81 dup(0)             ; ৮১ বাইটের একটি বাফার তৈরি করা হয়েছে যেখানে ইউজার ইনপুট সংরক্ষণ হবে

start:
    printn "Enter a string (max 80):"  ; ইউজারকে ইনপুট দিতে বলছে
    lea di, buf              ; di রেজিস্টারে buffer-এর অ্যাড্রেস রাখা হলো
    mov dx, 80               ; dx-তে ইনপুটের সীমা ৮০ সেট করা হচ্ছে
    call get_string          ; ইউজারের ইনপুট নেওয়া হচ্ছে

    lea si, buf              ; si রেজিস্টারে ইনপুট বাফারের অ্যাড্রেস রাখা হচ্ছে
    mov cx, 0                ; cx রেজিস্টারে শুরুতে word count = 0
    mov bx, 0                ; bx = 0 -> প্রাথমিকভাবে কোনো word শুরু হয়নি
    mov dx, 1                ; dx = 1 -> ধরা হচ্ছে word valid যতক্ষণ না ভুল প্রমাণ হয়

next_char:
    mov al, [si]             ; বর্তমান ক্যারেক্টার al রেজিস্টারে রাখা হচ্ছে
    cmp al, 0                ; null চরিত্র এসেছে কি? (স্ট্রিং এর শেষ)
    je maybe_count           ; হ্যাঁ হলে শেষ word এর চেক করার জন্য লাফ

    cmp al, ' '              ; ক্যারেক্টারটি স্পেস কিনা যাচাই
    je handle_space          ; হ্যাঁ হলে স্পেস হ্যান্ডল করার অংশে চলে যাও

    ; ক্যারেক্টারটি কি A-Z বা a-z?
    cmp al, 'A'
    jb not_alpha             ; A-এর নিচে হলে অক্ষর নয়
    cmp al, 'Z'
    jbe is_alpha             ; Z-এর মধ্যে হলে অক্ষর

    cmp al, 'a'
    jb not_alpha             ; a-এর নিচে হলে অক্ষর নয়
    cmp al, 'z'
    jbe is_alpha             ; z-এর মধ্যে হলে অক্ষর

not_alpha:
    mov dx, 0                ; অক্ষর না হলে dx = 0, মানে word invalid
is_alpha:

    cmp bx, 0
    jne skip_set             ; যদি ইতিমধ্যেই word শুরু হয়, তবে সেট না করেও এগিয়ে যাও
    mov bx, 1                ; নতুন word শুরু হচ্ছে, তাই bx = 1
    ; dx এখানে reset করিনি, কারণ word ইতিমধ্যেই invalid হয়ে থাকতে পারে

skip_set:
    inc si                   ; পরবর্তী ক্যারেক্টারের দিকে যাও
    jmp next_char            ; আবার loop চালিয়ে যাও

handle_space:
    cmp bx, 1
    jne skip_space           ; যদি word শুরু না হয়ে থাকে, তাহলে কিছু না করে এগিয়ে যাও
    cmp dx, 1
    jne skip_space           ; যদি word invalid হয়ে থাকে, তাহলে count না করে এগিয়ে যাও
    inc cx                   ; valid word পেলে count বাড়াও

skip_space:
    mov bx, 0                ; স্পেস পেলে word শেষ ধরা হয়, তাই bx = 0
    mov dx, 1                ; পরবর্তী word এর জন্য আবার dx valid ধরে নিচ্ছে
    inc si                   ; পরবর্তী ক্যারেক্টারে যাও
    jmp next_char            ; loop চালিয়ে যাও

maybe_count:
    cmp bx, 1
    jne done                 ; যদি কোনো word শুরুই না হয়, তাহলে done-এ চলে যাও
    cmp dx, 1
    jne done                 ; যদি word invalid হয়, তাহলে done-এ চলে যাও
    inc cx                   ; যদি valid হয়, তাহলে final word count করো

done:
    printn                   ; লাইন ব্রেক
    print "Words count: "    ; ফলাফল দেখানোর জন্য মেসেজ
    mov ax, cx               ; cx-তে থাকা word count ax-এ নেওয়া হচ্ছে
    call print_num           ; সংখ্যাটি প্রিন্ট করা হচ্ছে
    printn

    mov ah, 4Ch              ; প্রোগ্রাম শেষ করার জন্য DOS interrupt তৈরি
    int 21h                  ; DOS interrupt চালানো হচ্ছে

DEFINE_GET_STRING            ; ইনপুট ফাংশন সংজ্ঞায়িত
DEFINE_PRINT_NUM             ; সংখ্যা প্রিন্ট ফাংশন সংজ্ঞায়িত
DEFINE_PRINT_NUM_UNS
end                          ; প্রোগ্রামের সমাপ্তি
