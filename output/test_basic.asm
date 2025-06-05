

#GTU-C312 Test Program with Preprocessor Directives
Begin Data Section
0 100
1 1000
2 0
3 0
4 0
5 0
10 0
11 0
13 0
14 0
21 57005
40 40
1000 1000
2000 2000
4 4
500 500
End Data Section

Begin Instruction Section
# Test preprocessor symbol expansion
100 SET 0 13
101 SET 1 25
102 SET 4 22
103 SET 1000 10
104 # No debug output 25
105 CPY 10 4
106 ADD 4 500
107 SYSCALL PRN 4
108 HLT
End Instruction Section
