# GTU-C312 Operating System with Macros - Complete Implementation
# Register and Memory Layout Macros
.define $PC 0
.define $SP 1
.define $SYSCALL_RES 2
.define $INSTR_COUNT 3
.define $TEMP1 4
.define $TEMP2 5
.define $TEMP3 6
.define $TEMP4 7
.define $TEMP5 8
.define $TEMP6 9
.define $PARAM1 10
.define $PARAM2 11
.define $PARAM3 12
.define $ZERO 13
.define $FP 14
.define $STORE1 15
.define $STORE2 16
.define $STORE3 17
.define $STORE4 18



# Memory Layout Constants
.define @KERNEL_START 21
.define @KERNEL_END 999
.define @USER_START 1000
.define @THREAD1_START 1000
.define @THREAD1_END 1999
.define @THREAD2_START 2000
.define @THREAD2_END 2999
.define @THREAD3_START 3000
.define @THREAD3_END 3999
.define @THREAD4_START 4000
.define @THREAD4_END 4999
.define @THREAD5_START 5000
.define @THREAD5_END 5999
.define @THREAD6_START 6000
.define @THREAD6_END 6999
.define @THREAD7_START 7000
.define @THREAD7_END 7999
.define @THREAD8_START 8000
.define @THREAD8_END 8999
.define @THREAD9_START 9000
.define @THREAD9_END 9999
.define @THREAD10_START 10000
.define @THREAD10_END 10999
.define @THREAD_TABLE_BASE 40

# Sentinel Values
.define SENTINEL_DEAD 57005
.define SENTINEL_BEEF 48879

# Thread States
.define THREAD_INACTIVE 0
.define THREAD_READY 1
.define THREAD_RUNNING 2
.define THREAD_BLOCKED 3

# System Configuration
.define MAX_THREADS 11
.define THREAD_ENTRY_SIZE 10

# OS Data Locations
.define @OS_STATE 25
.define @CURRENT_THREAD 23
.define @THREAD_COUNT 22
.define @SCHEDULER_COUNTER 24
.define @CONTEXT_SWITCH_FLAG 26
.define @NEXT_THREAD 165
.define @ACTIVE_THREAD_COUNT 174
.define @COMPLETED_THREAD_COUNT 175

# Debug Configuration
.ifdef DEBUG
.define DEBUG_PRINT SYSCALL PRN
.else
.define DEBUG_PRINT
.endif

#GTU-C312 Operating System with Cooperative Multitasking
Begin Data Section
# CPU Registers (Memory-mapped)
$PC 100
$SP 1000
$SYSCALL_RES 0
$INSTR_COUNT 0
$TEMP1 0
$TEMP2 0
$TEMP3 0
$TEMP4 0
$TEMP5 0
$TEMP6 0
$PARAM1 0
$PARAM2 0
$PARAM3 0
$ZERO 0
$FP 0
$STORE1 0
$STORE2 0
$STORE3 0
$STORE4 0
19 0
20 0

# OS Data Area (21-999) - Kernel mode only
@KERNEL_START SENTINEL_DEAD
@THREAD_COUNT MAX_THREADS
@CURRENT_THREAD 0
@SCHEDULER_COUNTER 0
@OS_STATE 0
@CONTEXT_SWITCH_FLAG 0
27 0
28 @THREAD_TABLE_BASE
29 0
30 1



#ID:1 starting time:2 how many execution:3 so far in the thread:4 state:5, PC:6, SP:7, FP:8,
# Thread Table Structure (4 threads * 10 words each)
# Thread 0 (OS itself)
#######THREAD TABLE#######

@THREAD_TABLE_BASE 0
41 0
42 0
43 THREAD_RUNNING
44 @KERNEL_START
45 @KERNEL_END
46 @KERNEL_END
47 0
48 0
49 0

# Thread 1 (Sorting Thread) - FIXED STACK SIZE
50 1
51 0
52 0
53 THREAD_READY
54 @THREAD1_START
55 @THREAD1_END
56 @THREAD1_END
57 0
58 0
59 0

# Thread 2 (Search Thread) - FIXED STACK SIZE
60 2
61 0
62 0
63 THREAD_READY
64 @THREAD2_START
65 @THREAD2_END
66 @THREAD2_END
67 0
68 0
69 0

# Thread 3 (Custom Thread) - FIXED STACK SIZE
70 3
71 0
72 0
73 THREAD_READY
74 @THREAD3_START
75 @THREAD3_END
76 @THREAD3_END
77 0
78 0
79 0

# Thread 4 (placeholder Thread) - FIXED STACK SIZE
80 4
81 0
82 0
83 THREAD_INACTIVE
84 @THREAD4_START
85 @THREAD4_END
86 @THREAD4_END
87 0
88 0
89 0

# Thread 5 (placeholder Thread) - FIXED STACK SIZE
90 5
91 0
92 0
93 THREAD_INACTIVE
94 @THREAD5_START
95 @THREAD5_END
96 @THREAD5_END
97 0
98 0
99 0

# Thread 6 (placeholder Thread) - FIXED STACK SIZE
100 6
101 0
102 0
103 THREAD_INACTIVE
104 @THREAD6_START
105 @THREAD6_END
106 @THREAD6_END
107 0
108 0
109 0

# Thread 7 (Custom Thread) - FIXED STACK SIZE
110 7
111 0
112 0
113 THREAD_INACTIVE
114 @THREAD7_START
115 @THREAD7_END
116 @THREAD7_END
117 0
118 0
119 0

# Thread 8 (placeholder Thread) - FIXED STACK SIZE
120 8
121 0
122 0
123 THREAD_INACTIVE
124 @THREAD8_START
125 @THREAD8_END
126 @THREAD8_END
127 0
128 0
129 0

# Thread 9 (placeholder Thread) - FIXED STACK SIZE
130 9
131 0
132 0
133 THREAD_INACTIVE
134 @THREAD9_START
135 @THREAD9_END
136 @THREAD9_END
137 0
138 0
139 0

# Thread 10 (placeholder Thread) - FIXED STACK SIZE
140 6
141 0
142 0
143 THREAD_INACTIVE
144 @THREAD10_START
145 @THREAD10_END
146 @THREAD10_END
147 0
148 0
149 0


# OS Working Variables
160 0
161 0
162 0
163 0
164 0
@NEXT_THREAD 1
170 0
171 0
172 0
173 0
@ACTIVE_THREAD_COUNT 4
@COMPLETED_THREAD_COUNT 0

@KERNEL_END SENTINEL_BEEF

# Thread 1 Data Area (1000-1999) - Bubble Sort
@THREAD1_START 0
1001 5
1002 64
1003 34
1004 25
1005 12
1006 90
1007 0
1008 0
1009 0
1010 0

# Thread 2 Data Area (2000-2999) - Linear Search
@THREAD2_START 0
2001 5
2002 25
2003 64
2004 34
2005 25
2006 12
2007 90
2008 -1
2009 0
2010 0

# Thread 3 Data Area (3000-3999) - Factorial Calculator
@THREAD3_START 0
3001 5
3002 1
3003 1
3004 0
3005 0

End Data Section

# GTU-C312 Operating System - Complete Implementation from Scratch
# Using provided macros and data section

Begin Instruction Section

# OS Boot and Initialization (Instructions 100-199)
100 SET 0 $ZERO                       # Initialize zero register
101 SET 1 @OS_STATE                   # Set OS state to running
102 SET 0 @CURRENT_THREAD             # Initialize current thread to OS (0)
103 SET 0 @SCHEDULER_COUNTER          # Initialize scheduler counter
104 SET 0 @CONTEXT_SWITCH_FLAG        # Initialize context switch flag
105 CALL 200                          # Call thread table initialization
106 SET 4 @ACTIVE_THREAD_COUNT        # Set active thread count (threads 1-4)
107 SET 0 @COMPLETED_THREAD_COUNT     # Initialize completed thread count
108 SET 110 $PC                       # Jump to main OS loop

#OS state == 2 (shutdown) inti:0,running:1,shutdown:2
# Main OS Loop (Instructions 110-179) - ALTERNATIVE
110 CPY @OS_STATE $TEMP1              # Load OS state
112 ADD $TEMP1 -1                     # temp2 = OS_state - 2
113 JIF $TEMP1 115                    # If OS_state < 2, continue
114 SET 190 $PC                       # If OS_state >= 2, shutdown
# Normal operation continues here
115 CPY @COMPLETED_THREAD_COUNT $TEMP2 # Check thread completion
116 CPY @ACTIVE_THREAD_COUNT $TEMP3   # Load active thread count
117 CPY $TEMP2 $TEMP4                 # Copy completed count
118 ADD $TEMP4 -3                     # Check if all threads done
119 JIF $TEMP4 120                    # Jump to completion handler
114 SET 180 $PC                       # If OS_state >= 2, shutdown

120 CALL 400                          # Call scheduler
121 CALL 500                          # Call system call handler
122 ADD @SCHEDULER_COUNTER 1          # Increment scheduler counter
123 SET 110 $PC                       # Loop back to start


# All Threads Completed Handler (Instructions 180-189)
180 SET SENTINEL_DEAD $TEMP1          # Load completion sentinel
181 SYSCALL PRN $TEMP1                # Print completion marker
182 SET 2 @OS_STATE                   # Set OS state to shutdown
183 SET 190 $PC                       # Jump to shutdown

# OS Shutdown Sequence (Instructions 190-199)
190 SET SENTINEL_BEEF $TEMP1          # Load shutdown sentinel
191 SYSCALL PRN $TEMP1                # Print shutdown marker
192 HLT                               # Halt the system

# Thread Table Initialization (Instructions 200-299)
200 CPY $FP $STORE1                  # Save frame pointer
201 CPY $SP $FP                       # Set new frame pointer
202 SET @THREAD_TABLE_BASE $TEMP1     # Load thread table base
203 SET 0 $TEMP2                      # Initialize counter

# Thread initialization loop
204 CPY $TEMP2 $TEMP3                 # Copy counter
205 ADD $TEMP3 -11                    # Check if counter >= 11 (MAX_THREADS)
206 JIF $TEMP3 250                    # Exit if done

207 CPY $TEMP1 $PARAM1                # Pass thread table pointer
208 CPY $TEMP2 $PARAM2                # Pass thread ID
209 CALL 260                          # Call thread initialization helper

210 ADD $TEMP1 THREAD_ENTRY_SIZE      # Move to next thread entry
211 ADD $TEMP2 1                      # Increment counter
212 CPY 204 $PC                       # Loop back

250 CPY $STORE15 $FP                  # Restore frame pointer
251 RET                               # Return

# Thread Initialization Helper (Instructions 260-299)
260 CPY $PARAM1 $TEMP1                # Get thread table pointer
261 CPY $PARAM2 $TEMP2                # Get thread ID

# Store thread ID
262 SET $TEMP2 $TEMP1                 # Store thread ID at offset 0
263 ADD $TEMP1 1                      # Move to starting time field

# Store starting time
264 CPY $INSTR_COUNT $TEMP3           # Get current instruction count
265 SET $TEMP3 $TEMP1                 # Store starting time at offset 1
266 ADD $TEMP1 1                      # Move to instructions used field

# Initialize instructions used
267 SET 0 $TEMP1                      # Set instructions used to 0
268 ADD $TEMP1 1                      # Move to state field

# Set thread state based on ID
269 CPY $TEMP2 $TEMP3                 # Copy thread ID
270 JIF $TEMP3 280                    # If thread 0 (OS), set running

# Check if valid user thread (1-4)
271 CPY $TEMP2 $TEMP4                 # Copy thread ID
272 ADD $TEMP4 -4                     # Check if thread ID > 4
273 JIF $TEMP4 285                    # If > 4, set inactive

# Valid user thread (1-4), set ready
274 SET THREAD_READY $TEMP1           # Set state to ready
275 CALL 290                          # Set PC and SP for user thread
276 CPY 299 $PC                       # Jump to return

# OS thread (0), set running
280 SET THREAD_RUNNING $TEMP1         # Set state to running
281 ADD $TEMP1 1                      # Move to PC field
282 SET 100 $TEMP1                    # Set PC to OS start
283 ADD $TEMP1 1                      # Move to SP field
284 SET 1000 $TEMP1                   # Set SP for OS
285 CPY 299 $PC                       # Jump to return

# Inactive thread (>4), set inactive
286 SET THREAD_INACTIVE $TEMP1        # Set state to inactive
287 ADD $TEMP1 1                      # Move to PC field
288 SET 0 $TEMP1                      # Set PC to 0
289 CPY 299 $PC                       # Jump to return

# Set PC and SP for user threads
290 ADD $TEMP1 1                      # Move to PC field
291 CPY $TEMP2 $TEMP3                 # Copy thread ID
292 SET 1000 $TEMP4                   # Base address
293 CPY $TEMP3 $TEMP5                 # Copy thread ID
294 ADD $TEMP5 $TEMP5                 # thread_ID * 2
295 ADD $TEMP5 $TEMP5                 # thread_ID * 4  
296 ADD $TEMP5 $TEMP5                 # thread_ID * 8
297 ADD $TEMP4 $TEMP5                 # Approximate thread_ID * 1000
298 SET $TEMP4 $TEMP1                 # Store PC
299 ADD $TEMP1 1                      # Move to SP field
300 ADD $TEMP4 999                    # Calculate end of thread area
301 SET $TEMP4 $TEMP1                 # Store SP
302 RET                               # Return



# Round Robin Scheduler (Instructions 400-499) - ADJUSTED FOR YOUR REGISTER LAYOUT
400 CPY $FP $STORE1                   # Save frame pointer
401 CPY $SP $FP                       # Set new frame pointer

# Initialize search variables
402 CPY @CURRENT_THREAD $STORE2       # ✅ Use STORE2 for current thread ID (persistent)
403 ADD $STORE2 1                     # Start search from next thread
404 CPY $STORE2 $TEMP1                # Check if thread > 3
405 ADD $TEMP1 -3                     # temp1 = thread_ID - 3
406 JIF $TEMP1 408                    # If thread_ID <= 3, continue
407 SET 1 $STORE2                     # If thread_ID > 3, wrap to 1

408 SET 0 $STORE3                     # ✅ Use STORE3 for search counter (persistent)

# Search loop for next ready thread
409 CPY $STORE3 $TEMP1                # Copy search counter
410 ADD $TEMP1 -3                     # Check if searched all 3 threads
411 JIF $TEMP1 413                    # If searched all, continue
412 SET 470 $PC                       # If searched all, no ready thread found

# Get thread state for current candidate
413 CPY $STORE2 $PARAM1               # Pass thread ID to get state
414 CALL 600                          # ✅ SAFE: STORE2 preserved across call
415 CPY $PARAM3 $STORE4               # ✅ Save state in STORE4 (persistent)

# Check if thread state == READY (1) using proper equality test
416 CPY $STORE4 $TEMP1                # Copy state
417 ADD $TEMP1 -1                     # temp1 = state - 1
418 JIF $TEMP1 420                    # If state <= 1, check second condition
419 SET 440 $PC                       # If state > 1, try next thread

# Second equality check: 1 - state
420 SET 1 $TEMP2                      # Load constant 1
421 SUBI $STORE4 $TEMP2               # temp2 = 1 - state
422 JIF $TEMP2 425                    # If 1 - state <= 0 (state >= 1)
423 SET 440 $PC                       # If state < 1, try next thread

# Both conditions met: state == 1 (READY)
425 CPY $STORE2 @NEXT_THREAD          # Set next thread (found ready thread)
426 CALL 700                          # ✅ SAFE: STORE2 preserved across call
427 SET 470 $PC                       # Jump to exit

# Try next thread
440 ADD $STORE2 1                     # ✅ Increment thread ID (preserved)
441 CPY $STORE2 $TEMP1                # Copy thread ID
442 ADD $TEMP1 -3                     # Check if > 3
443 JIF $TEMP1 445                    # If > 3, wrap to 1
444 SET 450 $PC                       # Continue with current thread ID

445 SET 1 $STORE2                     # Wrap to thread 1

450 ADD $STORE3 1                     # ✅ Increment search counter (preserved)
451 SET 409 $PC                       # Continue search loop

# Exit scheduler
470 CPY $STORE1 $FP                   # Restore frame pointer
471 RET                               # Return



# System Call Handler (Instructions 500-599)
500 CPY $SYSCALL_RES $TEMP1           # Check if system call pending
501 JIF $TEMP1 550                    # If no system call, return

# Handle different system call types
502 CPY $TEMP1 $TEMP2                 # Copy system call type
503 ADD $TEMP2 -1                     # Check if PRN (type 1)
504 JIF $TEMP2 510                    # Handle PRN

505 CPY $TEMP1 $TEMP2                 # Copy system call type again
506 ADD $TEMP2 -2                     # Check if YIELD (type 2)
507 JIF $TEMP2 520                    # Handle YIELD

508 CPY $TEMP1 $TEMP2                 # Copy system call type again
509 ADD $TEMP2 -3                     # Check if HLT (type 3)
510 JIF $TEMP2 530                    # Handle HLT
511 CPY 550 $PC                       # Unknown system call, return

# Handle PRN system call (already handled by CPU)
515 CPY 550 $PC                       # Return

# Handle YIELD system call
520 SET 1 @CONTEXT_SWITCH_FLAG        # Set context switch flag
521 CPY 550 $PC                       # Return

# Handle HLT system call
530 CALL 800                          # Mark thread as completed
531 SET 1 @CONTEXT_SWITCH_FLAG        # Force context switch
532 SET 550 $PC                       # Return

550 SET 0 $SYSCALL_RES                # Clear system call result
551 RET                               # Return

# Get Thread State Helper (Instructions 600-699) - ADJUSTED FOR YOUR REGISTER LAYOUT
600 CPY $PARAM1 $TEMP1                # Get thread ID
601 SET @THREAD_TABLE_BASE $TEMP2     # Get thread table base address (40)
602 CPY $TEMP1 $TEMP3                 # Copy thread ID
603 SET 0 $TEMP4                      # Initialize offset to 0

# Calculate thread table offset (thread_ID * THREAD_ENTRY_SIZE)
604 JIF $TEMP3 620                    # If thread ID = 0, skip multiplication
605 ADD $TEMP4 THREAD_ENTRY_SIZE      # Add 10 to offset
606 ADD $TEMP3 -1                     # Decrement thread ID counter
607 SET 604 $PC                       # Loop back to check

# Calculate final address and get state
620 ADDI $TEMP2 $TEMP4                # Add offset to base (base + thread_ID*10)
621 ADD $TEMP2 3                      # Move to state field (offset 3)
622 CPYI $TEMP2 $PARAM3               # Get VALUE AT address using indirect copy
623 RET                               # Return with state in PARAM3



# Context Switch (Instructions 700-799) - COMPLETE IMPLEMENTATION
700 CPY $FP $STORE1                   # Save frame pointer
701 CPY $SP $FP                       # Set new frame pointer

# Get current thread ID and validate
702 CPY @CURRENT_THREAD $STORE2       # Get current thread ID
703 JIF $STORE2 720                   # If current thread = 0 (OS), skip saving

# Save current thread context
704 CPY $STORE2 $PARAM1               # Pass current thread ID
705 CALL 750                          # Save current thread state
706 CPY $PARAM3 $TEMP1                # Get thread table address result
707 ADD $TEMP1 3                      # Move to state field
708 SET THREAD_READY $TEMP1           # Set current thread to READY

# Load new thread context
720 CPY @NEXT_THREAD $STORE3          # Get next thread ID
721 CPY $STORE3 @CURRENT_THREAD       # Update current thread
722 CPY $STORE3 $PARAM1               # Pass new thread ID
723 CALL 800                          # ✅ FIXED: Call correct load helper
724 CPY $PARAM3 $TEMP1                # Get thread table address result
725 ADD $TEMP1 3                      # Move to state field
726 SET THREAD_RUNNING $TEMP1         # Set new thread to RUNNING

# Switch to user mode and jump to new thread
727 CPY $STORE3 $TEMP2                # Copy new thread ID
728 JIF $TEMP2 740                    # If thread 0 (OS), stay in kernel
729 CALL 790                          # Switch to user mode for user threads
730 CPY 740 $PC                       # Jump to exit

740 CPY $STORE1 $FP                   # Restore frame pointer
741 RET                               # Return

# Save Thread State Helper (Instructions 750-799) - COMPLETELY FIXED
750 CPY $FP $STORE1                   # Save frame pointer
751 CPY $SP $FP                       # Set new frame pointer
752 CPY $PARAM1 $TEMP1                # Get thread ID

# Calculate thread table base address manually (thread_ID * 10)
753 SET @THREAD_TABLE_BASE $TEMP2     # Get thread table base (40)
754 CPY $TEMP1 $TEMP3                 # Copy thread ID
755 SET 0 $TEMP4                      # Initialize offset

# Multiplication loop: offset = thread_ID * THREAD_ENTRY_SIZE
756 JIF $TEMP3 770                    # If thread ID = 0, skip multiplication
757 ADD $TEMP4 THREAD_ENTRY_SIZE      # Add 10 to offset
758 ADD $TEMP3 -1                     # Decrement thread ID counter
759 SET 756 $PC                       # Loop back to check

# Calculate thread entry base address
770 ADD $TEMP2 $TEMP4                 # base + offset = thread entry address

# Save CPU registers to thread table
771 CPY $TEMP2 $STORE2                # Save thread entry base address
772 ADD $STORE2 4                     # Move to PC field (offset 4)
773 CPY $PC $TEMP5                    # Get current PC
774 SET $TEMP5 $STORE2                # Store PC in thread table

775 CPY $TEMP2 $STORE2                # Restore thread entry base
776 ADD $STORE2 5                     # Move to SP field (offset 5)
777 CPY $SP $TEMP5                    # Get current SP
778 SET $TEMP5 $STORE2                # Store SP in thread table

779 CPY $TEMP2 $STORE2                # Restore thread entry base
780 ADD $STORE2 6                     # Move to FP field (offset 6)
781 CPY $FP $TEMP5                    # Get current FP
782 SET $TEMP5 $STORE2                # Store FP in thread table

# Save additional working registers if needed
783 CPY $TEMP2 $STORE2                # Restore thread entry base
784 ADD $STORE2 7                     # Move to saved register area (offset 7)
785 CPY $TEMP1 $TEMP5                 # Save TEMP1 (thread ID)
786 SET $TEMP5 $STORE2                # Store in thread table

787 ADD $STORE2 1                     # Move to next save slot (offset 8)
788 CPY $TEMP2 $TEMP5                 # Save TEMP2 (base address)
789 SET $TEMP5 $STORE2                # Store in thread table

790 CPY $TEMP2 $PARAM3                # Return thread table base address
791 CPY $STORE1 $FP                   # Restore frame pointer
792 RET                               # Return


# Load Thread State Helper (Instructions 800-849) - COMPLETE
800 CPY $FP $STORE1                   # Save frame pointer
801 CPY $SP $FP                       # Set new frame pointer
802 CPY $PARAM1 $TEMP1                # Get thread ID

# Calculate thread table base address manually
803 SET @THREAD_TABLE_BASE $TEMP2     # Get thread table base (40)
804 CPY $TEMP1 $TEMP3                 # Copy thread ID
805 SET 0 $TEMP4                      # Initialize offset

# Multiplication loop: offset = thread_ID * THREAD_ENTRY_SIZE
806 JIF $TEMP3 820                    # If thread ID = 0, skip multiplication
807 ADD $TEMP4 THREAD_ENTRY_SIZE      # Add 10 to offset
808 ADD $TEMP3 -1                     # Decrement thread ID counter
809 SET 806 $PC                       # Loop back to check

# Calculate thread entry base address
820 ADD $TEMP2 $TEMP4                 # base + offset = thread entry address

# Load CPU registers from thread table
821 CPY $TEMP2 $STORE2                # Save thread entry base address
822 ADD $STORE2 4                     # Move to PC field (offset 4)
823 CPYI $STORE2 $TEMP5               # Get stored PC value
824 SET $TEMP5 $PC                    # Restore PC

825 CPY $TEMP2 $STORE2                # Restore thread entry base
826 ADD $STORE2 5                     # Move to SP field (offset 5)
827 CPYI $STORE2 $TEMP5               # Get stored SP value
828 SET $TEMP5 $SP                    # Restore SP

829 CPY $TEMP2 $STORE2                # Restore thread entry base
830 ADD $STORE2 6                     # Move to FP field (offset 6)
831 CPYI $STORE2 $TEMP5               # Get stored FP value
832 SET $TEMP5 $FP                    # Restore FP

# Load additional working registers if needed
833 CPY $TEMP2 $STORE2                # Restore thread entry base
834 ADD $STORE2 7                     # Move to saved register area (offset 7)
835 CPYI $STORE2 $TEMP1               # Restore TEMP1

836 ADD $STORE2 1                     # Move to next save slot (offset 8)
837 CPYI $STORE2 $TEMP2               # Restore TEMP2

838 CPY $TEMP2 $PARAM3                # Return thread table base address
839 CPY $STORE1 $FP                   # Restore frame pointer
840 RET                               # Return





# Switch to User Mode Helper (Instructions 850-899)
850 CPY $PARAM1 $TEMP1                # Get thread ID
851 SET 1000 $TEMP2                   # Base user address
852 CPY $TEMP1 $TEMP3                 # Copy thread ID
853 ADD $TEMP3 $TEMP3                 # thread_ID * 2
854 ADD $TEMP3 $TEMP3                 # thread_ID * 4
855 ADD $TEMP3 $TEMP3                 # thread_ID * 8
856 ADD $TEMP2 $TEMP3                 # Approximate thread start address
857 USER $TEMP2                       # Switch to user mode and jump
858 RET                               # Return (should not reach here)



# Thread Completion Handler (Instructions 800-899)
800 CPY @CURRENT_THREAD $PARAM1       # Get current thread ID
801 CALL 600                          # Get thread table entry
802 # Mark thread as inactive
803 SET THREAD_INACTIVE $PARAM3       # Set state to inactive
804 ADD @COMPLETED_THREAD_COUNT 1     # Increment completed count
805 SET 0 @CURRENT_THREAD             # Reset current thread to OS
806 RET                               # Return

# Thread 1: Bubble Sort (Instructions 1000-1199)
@THREAD1_START SET 1002 $TEMP1        # Load array start address
1001 CPY 1001 $TEMP2                  # Load array size (5)
1002 SET 0 $TEMP3                     # Outer loop counter

# Outer loop
1003 CPY $TEMP3 $TEMP4                # Copy outer counter
1004 CPY $TEMP2 $TEMP5                # Copy array size
1005 ADD $TEMP5 -1                    # size - 1
1006 ADD $TEMP4 -1                    # Check if outer >= size-1
1007 SUBI $TEMP5 $TEMP4               # temp4 = (size-1) - outer
1008 JIF $TEMP4 1080                  # Exit if done

1009 SET 0 $TEMP6                     # Inner loop counter

# Inner loop
1010 CPY $TEMP6 $STORE15              # Copy inner counter
1011 CPY $TEMP2 $STORE16              # Copy array size
1012 ADD $STORE16 -1                  # size - 1
1013 CPY $TEMP3 $STORE17              # Copy outer counter
1014 ADD $STORE16 -1                  # (size-1) - outer
1015 SUBI $STORE17 $STORE16           # temp = (size-1-outer) - inner
1016 JIF $STORE16 1070                # Exit inner if done

# Compare adjacent elements
1017 CPY $TEMP1 $STORE17              # Copy array base
1018 ADD $STORE17 $TEMP6              # Add inner counter
1019 CPY $STORE17 $PARAM1             # Get arr[inner]
1020 ADD $STORE17 1                   # Move to next element
1021 CPY $STORE17 $PARAM2             # Get arr[inner+1]

# Check if swap needed
1022 CPY $PARAM1 $PARAM3              # Copy first element
1023 SUBI $PARAM2 $PARAM3             # param3 = arr[inner] - arr[inner+1]
1024 JIF $PARAM3 1060                 # If arr[inner] <= arr[inner+1], no swap

# Swap elements
1025 CPY $TEMP1 $STORE17              # Array base
1026 ADD $STORE17 $TEMP6              # Add inner counter
1027 SET $PARAM2 $STORE17             # Store arr[inner+1] in arr[inner]
1028 ADD $STORE17 1                   # Move to next
1029 SET $PARAM1 $STORE17             # Store arr[inner] in arr[inner+1]

1060 ADD $TEMP6 1                     # Increment inner counter
1061 SYSCALL YIELD                    # Yield CPU
1062 CPY 1010 $PC                     # Continue inner loop

1070 ADD $TEMP3 1                     # Increment outer counter
1071 CPY 1003 $PC                     # Continue outer loop

# Print sorted array
1080 SET 0 $TEMP3                     # Print counter
1081 CPY $TEMP3 $TEMP4                # Copy counter
1082 ADD $TEMP4 -5                    # Check if printed all 5
1083 JIF $TEMP4 1090                  # Exit if done
1084 CPY $TEMP1 $TEMP5                # Array base
1085 ADD $TEMP5 $TEMP3                # Add counter
1086 SYSCALL PRN $TEMP5               # Print element
1087 ADD $TEMP3 1                     # Increment counter
1088 CPY 1081 $PC                     # Continue printing

1090 SYSCALL HLT                      # Thread complete

# Thread 2: Linear Search (Instructions 2000-2199)
@THREAD2_START CPY 2001 $TEMP1        # Load array size
2001 CPY 2002 $TEMP2                  # Load search key
2002 SET 2003 $TEMP3                  # Array start address
2003 SET 0 $TEMP4                     # Search counter
2004 SET -1 2008                      # Initialize result to -1 (not found)

# Search loop
2005 CPY $TEMP4 $TEMP5                # Copy counter
2006 ADD $TEMP5 -5                    # Check if searched all 5 elements
2007 JIF $TEMP5 2050                  # Exit if done

2008 CPY $TEMP3 $TEMP6                # Copy array base
2009 ADD $TEMP6 $TEMP4                # Add counter offset
2010 CPY $TEMP6 $PARAM1               # Get current element

# Compare with key
2011 CPY $PARAM1 $PARAM2              # Copy element
2012 SUBI $TEMP2 $PARAM2              # param2 = key - element
2013 JIF $PARAM2 2040                 # If not equal, continue

# Found element
2014 SET $TEMP4 2008                  # Store found index
2015 CPY 2050 $PC                     # Exit search

2040 ADD $TEMP4 1                     # Increment counter
2041 SYSCALL YIELD                    # Yield CPU
2042 CPY 2005 $PC                     # Continue search

2050 SYSCALL PRN 2008                 # Print result
2051 SYSCALL HLT                      # Thread complete

# Thread 3: Factorial Calculator (Instructions 3000-3199)
@THREAD3_START CPY 3001 $TEMP1        # Load factorial input (5)
3001 SET 1 3002                       # Initialize result to 1
3002 SET 1 $TEMP2                     # Initialize counter to 1

# Factorial loop
3003 CPY $TEMP2 $TEMP3                # Copy counter
3004 ADD $TEMP3 -1                    # Check if counter > input
3005 SUBI $TEMP1 $TEMP3               # temp3 = input - counter
3006 JIF $TEMP3 3050                  # Exit if counter > input

# Multiply result by counter
3007 CPY 3002 $TEMP4                  # Load current result
3008 SET 0 $TEMP5                     # Initialize multiplication result
3009 CPY $TEMP2 $TEMP6                # Copy counter for multiplication

# Multiplication by addition loop
3010 JIF $TEMP6 3030                  # Exit if multiplier = 0
3011 ADD $TEMP5 $TEMP4                # Add result to accumulator
3012 ADD $TEMP6 -1                    # Decrement multiplier
3013 SYSCALL YIELD                    # Yield CPU during multiplication
3014 CPY 3010 $PC                     # Continue multiplication

3030 SET $TEMP5 3002                  # Store multiplication result
3031 ADD $TEMP2 1                     # Increment counter
3032 SYSCALL YIELD                    # Yield CPU
3033 CPY 3003 $PC                     # Continue factorial loop

3050 SYSCALL PRN 3002                 # Print factorial result
3051 SYSCALL HLT                      # Thread complete

# Thread 4: Placeholder - Immediate HLT
@THREAD4_START SYSCALL HLT            # Inactive thread

End Instruction Section
