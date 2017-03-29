@echo off
echo (make-boot-file "loadrelative.boot" '("scheme") "source/basic/loadrelative.ss") > compile-loadrelative.ss
scheme --script compile-loadrelative.ss & del compile-loadrelative.ss
