#.define 10 10
#.define 10 10
#.define OS_RUNNING 1

#.ifndef DISABLE_DEBUG
#.define PRINT_DEBUG SYSCALL PRN
#.else
#.define PRINT_DEBUG # Debug disabled
#.endif

#.ifdef 1
#.define FACTORIAL_INPUT 5
#.else
#.define FACTORIAL_INPUT 3
#.endif

#GTU-C312 Complex Preprocessor Test
Begin Data Section
# CPU Registers
0 100
1 1000
2 0
3 0

# OS Data
25 OS_RUNNING
22 10
23 0

# Thread table (10 * 10 words)
40 40

# Test data
1000 FACTORIAL_INPUT
1001 0
1002 1
End Data Section

Begin Instruction Section
100 SET 0 13
101 SET OS_RUNNING 25
102 SET 10 22
103 CPY 40 4
104 ADD 4 10
106 SET FACTORIAL_INPUT 1000
107 CALL 200
108 HLT

# Factorial subroutine
200 CPY 1000 10
201 SET 1 1001
202 JIF 10 210
203 CALL 220
204 RET
210 SYSCALL PRN 1001
211 RET

# Multiply helper
220 CPY 1001 4
221 CPY 10 5
222 ADD 1001 4
223 ADD 10 -1
224 JIF 10 230
225 SET 222 0
230 RET
End Instruction Section
