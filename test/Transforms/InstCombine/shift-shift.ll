; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instcombine -S | FileCheck %s

; These would crash if we didn't check for a negative shift.

; https://llvm.org/bugs/show_bug.cgi?id=12967

define void @pr12967() {
; CHECK-LABEL: @pr12967(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label %loop
; CHECK:       loop:
; CHECK-NEXT:    br label %loop
;
entry:
  br label %loop

loop:
  %c = phi i32 [ %shl, %loop ], [ undef, %entry ]
  %shr = shl i32 %c, 7
  %shl = lshr i32 %shr, -2
  br label %loop
}

; https://llvm.org/bugs/show_bug.cgi?id=26760

define void @pr26760() {
; CHECK-LABEL: @pr26760(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label %loop
; CHECK:       loop:
; CHECK-NEXT:    br label %loop
;
entry:
  br label %loop

loop:
  %c = phi i32 [ %shl, %loop ], [ undef, %entry ]
  %shr = lshr i32 %c, 7
  %shl = shl i32 %shr, -2
  br label %loop
}

