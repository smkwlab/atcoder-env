#! /bin/sh
if [ "$1" -gt 1024 ]; then
    stack_size=1024
else
    stack_size="$1"
fi
java -Xss"$stack_size"M -DONLINE_JUDGE=true -cp ac_library.jar: Main
