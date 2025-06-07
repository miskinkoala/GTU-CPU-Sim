# GTU-C312 Operating System with Macros - Complete Implementation
# Register and Memory Layout Macros
# gtu_os.asm
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


# Offset 9:  UNBLOCK TIME
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
115 CALL 350 
116 CPY @COMPLETED_THREAD_COUNT $TEMP2 # Check thread completion
117 CPY @ACTIVE_THREAD_COUNT $TEMP3   # Load active thread count
118 CPY $TEMP2 $TEMP4                 # Copy completed count
119 ADD $TEMP4 -3                     # Check if all threads done
120 JIF $TEMP4 125                    # Jump to completion handler
121 SET 180 $PC                       # If OS_state >= 2, shutdown

125 CALL 400                          # Call scheduler
126 CALL 500                          # Call system call handler
127 ADD @SCHEDULER_COUNTER 1          # Increment scheduler counter
128 SET 110 $PC                       # Loop back to start

# All Threads Completed Handler (Instructions 180-189)
180 SET SENTINEL_DEAD $TEMP1          # Load completion sentinel
181 SYSCALL PRN $TEMP1                # Print completion marker
182 SET 2 @OS_STATE                   # Set OS state to shutdown
183 SET 190 $PC                       # Jump to shutdown

# OS Shutdown Sequence (Instructions 190-199)
190 SET SENTINEL_BEEF $TEMP1          # Load shutdown sentinel
191 SYSCALL PRN $TEMP1                # Print shutdown marker
192 HLT                               # Halt the system


# THREAD_INACTIVE 0
# THREAD_READY 1
# THREAD_RUNNING 2
# THREAD_BLOCKED 3

# Check Blocked Threads for Unblocking (Instructions 350-399) - USING ADD INSTEAD OF SUBI
350 CPY $FP $STORE1                   # Save frame pointer
351 CPY $SP $FP                       # Set new frame pointer
352 SET 1 $TEMP1                      # Start with thread 1
353 SET 0 $TEMP2                      # Thread counter

# Loop through threads 1-3
354 CPY $TEMP2 $TEMP3                 # Copy counter
355 ADD $TEMP3 -3                     # ✅ FIXED: temp3 = counter - 3
356 JIF $TEMP3 358                    # Continue if counter <= 3
357 SET 390 $PC                       # Exit if counter > 3
 
# Check if thread is blocked
358 CPY $TEMP1 $PARAM1                # Pass thread ID
359 CALL 600                          # Get thread state
360 CPY $PARAM3 $TEMP4                # Get state
361 ADD $TEMP4 -2                     # ✅ FIXED: temp4 = state - 
362 JIF $TEMP4 365                    # Continue if state > 2 = BLOCKED
363 SET 385 $PC                       # Process blocked thread

# Get thread table entry for blocked thread
365 CPY $TEMP1 $PARAM1                # Pass thread ID
366 CALL 650                          # Get thread table base
367 CPY $PARAM3 $TEMP5                # Get thread table base

368 ADD $TEMP5 9                      # Move to block type field
369 CPYI $TEMP5 $TEMP6                # unbock time

# Check if 100 instructions have passed (offset 8)
372 CPY $INSTR_COUNT $STORE2          # Get thread table base again
373 CPY $TEMP6 $STORE3                # Move to unblock time field
374 SUBI $STORE3 $STORE2              # store2 = current_time - unblock_time
375 JIF $STORE2 385                   # If unblock_time >= current_time, block remain
376 SET 382 $PC                       # unblock, try next

# Unblock the thread
382 CPY $PARAM3 $STORE2               # Get thread table base
383 ADD $STORE2 3                     # Move to state field
384 SET THREAD_READY $STORE2          # Set thread back to READY

# Try next thread
385 ADD $TEMP1 1                      # Increment thread ID
386 CPY $TEMP1 $TEMP4                 # Copy thread ID
387 ADD $TEMP4 -3                     # ✅ FIXED: temp4 = thread_ID - 3
388 JIF $TEMP4 392                    # Continue if thread_ID <= 3
389 SET 1 $TEMP1                      # Wrap to thread 1

392 ADD $TEMP2 1                      # Increment counter
393 SET 354 $PC                       # Continue loop

390 CPY $STORE1 $FP                   # Restore frame pointer
391 RET                               # Return





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


# System Call Handler (Instructions 500-599) - ALTERNATIVE CLEAN FIX
500 CPY $SYSCALL_RES $TEMP1           # Check if system call pending
501 JIF $TEMP1 550                    # If no system call, return

# Handle different system call types
502 CPY $TEMP1 $TEMP2                 # Copy system call type
503 ADD $TEMP2 -1                     # Check if PRN (type 1)
504 JIF $TEMP2 515                    # ✅ FIXED: Jump to actual PRN handler

505 CPY $TEMP1 $TEMP2                 # Copy system call type again
506 ADD $TEMP2 -2                     # Check if YIELD (type 2)
507 JIF $TEMP2 530                    # ✅ FIXED: Jump to actual YIELD handler

508 CPY $TEMP1 $TEMP2                 # Copy system call type again
509 ADD $TEMP2 -3                     # Check if HLT (type 3)
510 JIF $TEMP2 535                    # ✅ FIXED: Jump to actual HLT handler
511 SET 550 $PC                       # Unknown system call, return

# Handle PRN system call - ALTERNATIVE FIX
515 CPY @CURRENT_THREAD $STORE1       # Get current thread ID
516 CPY $STORE1 $PARAM1               # Pass thread ID
517 CALL 650                          # ✅ NEW: Call thread table base helper
518 CPY $PARAM3 $TEMP1                # Get thread table base address
519 ADD $TEMP1 3                      # Move to state field
520 SET THREAD_BLOCKED $TEMP1         # Set thread to BLOCKED
# Record when blocking started (for 100 instruction countdown)
521 CPY $PARAM3 $TEMP2                # Get thread table base again
522 ADD $TEMP2 9                      # Move to reserved area (offset 9) for unblock time
523 CPY $INSTR_COUNT $TEMP3           # Get current instruction count
524 ADD $TEMP3 100                    # Add 100 instructions
525 SET $TEMP3 $TEMP2                 # Store unblock time

526 SET 1 @CONTEXT_SWITCH_FLAG        # Force context switch
527 SET 550 $PC                       # Return


# Handle YIELD system call
530 SET 1 @CONTEXT_SWITCH_FLAG        # Set context switch flag
531 SET 550 $PC                       # Return

# Handle HLT system call
535 CALL 900                          # Mark thread as completed
536 SET 1 @CONTEXT_SWITCH_FLAG        # Force context switch
537 SET 550 $PC                       # Return

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


# Get Thread Table Base Helper (Instructions 650-699) - NEW FUNCTION
650 CPY $PARAM1 $TEMP1                # Get thread ID
651 SET @THREAD_TABLE_BASE $TEMP2     # Get thread table base (40)
652 CPY $TEMP1 $TEMP3                 # Copy thread ID
653 SET 0 $TEMP4                      # Initialize offset

# Multiplication loop
654 JIF $TEMP3 670                    # If thread ID = 0, skip multiplication
655 ADD $TEMP4 THREAD_ENTRY_SIZE      # Add 10 to offset
656 ADD $TEMP3 -1                     # Decrement thread ID counter
657 SET 654 $PC                       # Loop back to check

670 ADD $TEMP2 $TEMP4                 # Calculate thread entry base address
671 CPY $TEMP2 $PARAM3                # Return base address in PARAM3
672 RET                               # Return





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
729 CALL 850                           # Switch to user mode for user threads
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
820 ADDI $TEMP2 $TEMP4                 # base + offset = thread entry address


# Load CPU registers from thread table
821 CPY $TEMP2 $STORE2                # Save thread entry base address
822 ADD $STORE2 4                     # Move to PC field (offset 4)
823 CPYI $STORE2 $TEMP5               # Get stored PC value
824 CPY $TEMP5 $PC                    # Restore PC

825 CPY $TEMP2 $STORE2                # Restore thread entry base
826 ADD $STORE2 5                     # Move to SP field (offset 5)
827 CPYI $STORE2 $TEMP5               # Get stored SP value
828 CPY $TEMP5 $SP                    # Restore SP

829 CPY $TEMP2 $STORE2                # Restore thread entry base
830 ADD $STORE2 6                     # Move to FP field (offset 6)
831 CPYI $STORE2 $TEMP5               # Get stored FP value
832 CPY $TEMP5 $FP                    # Restore FP

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



# Thread Completion Handler (Instructions 900-949) - USING HELPER FUNCTION
900 CPY $FP $STORE1                   # Save frame pointer
901 CPY $SP $FP                       # Set new frame pointer
902 CPY @CURRENT_THREAD $PARAM1       # Get current thread ID and pass as parameter

# Use existing helper function to get thread table base address
903 CALL 650                          # Call thread table base helper
904 CPY $PARAM3 $TEMP1                # Get thread table base address from helper

# Mark thread as completed
905 ADD $TEMP1 3                      # Move to state field (offset 3)
906 SET THREAD_INACTIVE $TEMP1        # Set thread to INACTIVE at correct address

# Update completion statistics
907 ADD @COMPLETED_THREAD_COUNT 1     # Increment completed count
908 SET 0 @CURRENT_THREAD             # Reset current thread to OS

909 CPY $STORE1 $FP                   # Restore frame pointer
910 RET                               # Return


# Thread 1: Bubble Sort - FIXED FOR ARCHITECTURE
@THREAD1_START SET 1002 $TEMP1        # Load array start address (1002)
1001 CPY 1001 $TEMP2                  # Load array size (5)
1002 SET 0 $TEMP3                     # Outer loop counter

# Outer loop
1003 CPY $TEMP3 $TEMP4                # Copy outer counter
1004 CPY $TEMP2 $TEMP5                # Copy array size
1005 ADD $TEMP5 -1                    # size - 1
1006 SUBI $TEMP5 $TEMP4               # temp4 = (size-1) - outer (keep SUBI as is)
1007 JIF $TEMP4 1080                  # Exit if outer >= size-1

1008 SET 0 $TEMP6                     # Inner loop counter

# Inner loop
1009 CPY $TEMP6 $STORE1               # Copy inner counter
1010 CPY $TEMP2 $STORE2               # Copy array size
1011 ADD $STORE2 -1                   # size - 1
1012 CPY $TEMP3 $STORE3               # Copy outer counter
1013 SUBI $STORE2 $STORE3             # store2 = (size-1) - outer (keep SUBI as is)
1014 SUBI $STORE2 $STORE1             # store2 = (size-1-outer) - inner (keep SUBI as is)
1015 JIF $STORE2 1070                 # Exit inner if inner >= (size-1-outer)

# Compare adjacent elements
1016 CPY $TEMP1 $STORE3               # Copy array base
1017 ADD $STORE3 $TEMP6               # Add inner counter
1018 CPYI $STORE3 $PARAM1             # ✅ FIXED: Get arr[inner] using indirect copy
1019 ADD $STORE3 1                    # Move to next element
1020 CPYI $STORE3 $PARAM2             # ✅ FIXED: Get arr[inner+1] using indirect copy

# Check if swap needed
1021 CPY $PARAM1 $PARAM3              # Copy first element
1022 SUBI $PARAM2 $PARAM3             # param3 = arr[inner] - arr[inner+1] (keep SUBI as is)
1023 JIF $PARAM3 1060                 # If arr[inner] <= arr[inner+1], no swap

# Swap elements
1024 CPY $TEMP1 $STORE3               # Array base
1025 ADD $STORE3 $TEMP6               # Add inner counter
1026 SET $PARAM2 $STORE3              # Store arr[inner+1] in arr[inner]
1027 ADD $STORE3 1                    # Move to next
1028 SET $PARAM1 $STORE3              # Store arr[inner] in arr[inner+1]

1060 ADD $TEMP6 1                     # Increment inner counter
1061 SYSCALL YIELD                    # ✅ Yield CPU for cooperative scheduling
1062 SET 1009 $PC                     # Continue inner loop

1070 ADD $TEMP3 1                     # Increment outer counter
1071 SYSCALL YIELD                    # ✅ Yield CPU between outer loop iterations
1072 SET 1003 $PC                     # Continue outer loop

# Print sorted array
1080 SET 0 $TEMP3                     # Print counter
1081 CPY $TEMP3 $TEMP4                # Copy counter
1082 ADD $TEMP4 -5                    # Check if printed all 5
1083 JIF $TEMP4 1090                  # Exit if done
1084 CPY $TEMP1 $TEMP5                # Array base
1085 ADD $TEMP5 $TEMP3                # Add counter
1086 CPYI $TEMP5 $PARAM1              # ✅ FIXED: Get element using indirect copy
1087 SYSCALL PRN $PARAM1              # ✅ FIXED: Print element value
1088 ADD $TEMP3 1                     # Increment counter
1089 SET 1081 $PC                     # Continue printing

1090 SYSCALL HLT                      # Thread complete




# Thread 2: Linear Search - FIXED FOR ARCHITECTURE
@THREAD2_START CPY 2001 $TEMP1        # Load array size (5)
2001 CPY 2002 $TEMP2                  # Load search key (25)
2002 SET 2003 $TEMP3                  # Array start address (2003)
2003 SET 0 $TEMP4                     # Search counter
2004 SET -1 2008                      # Initialize result to -1 (not found)

# Search loop
2005 CPY $TEMP4 $TEMP5                # Copy counter
2006 SUBI $TEMP1 $TEMP5               # temp5 = array_size - counter (keep SUBI as is)
2007 JIF $TEMP5 2050                  # Exit if counter >= array_size

2008 CPY $TEMP3 $TEMP6                # Copy array base
2009 ADD $TEMP6 $TEMP4                # Add counter offset
2010 CPYI $TEMP6 $PARAM1              # ✅ FIXED: Get current element using indirect copy

# Compare with key
2011 CPY $PARAM1 $PARAM2              # Copy element
2012 SUBI $TEMP2 $PARAM2              # param2 = key - element (keep SUBI as is)
2013 JIF $PARAM2 2040                 # If not equal, continue

# Found element
2014 SET $TEMP4 2008                  # Store found index
2015 SET 2050 $PC                     # Exit search

2040 ADD $TEMP4 1                     # Increment counter
2041 SYSCALL YIELD                    # ✅ Yield CPU for cooperative scheduling
2042 SET 2005 $PC                     # Continue search

2050 CPYI 2008 $PARAM1                # ✅ FIXED: Get result using indirect copy
2051 SYSCALL PRN $PARAM1              # ✅ FIXED: Print result value
2052 SYSCALL HLT                      # Thread complete



# Thread 3: Factorial Calculator - FIXED FOR ARCHITECTURE
@THREAD3_START CPY 3001 $TEMP1        # Load factorial input (5)
3001 SET 1 3002                       # Initialize result to 1
3002 SET 1 $TEMP2                     # Initialize counter to 1

# Factorial loop
3003 CPY $TEMP2 $TEMP3                # Copy counter
3004 SUBI $TEMP1 $TEMP3               # temp3 = input - counter (keep SUBI as is)
3005 JIF $TEMP3 3050                  # Exit if counter > input

# Multiply result by counter
3006 CPYI 3002 $TEMP4                 # ✅ FIXED: Load current result using indirect copy
3007 SET 0 $TEMP5                     # Initialize multiplication result
3008 CPY $TEMP2 $TEMP6                # Copy counter for multiplication

# Multiplication by addition loop
3009 JIF $TEMP6 3030                  # Exit if multiplier = 0
3010 ADD $TEMP5 $TEMP4                # Add result to accumulator
3011 ADD $TEMP6 -1                    # Decrement multiplier
3012 SYSCALL YIELD                    # ✅ Yield CPU during multiplication
3013 SET 3009 $PC                     # Continue multiplication

3030 SET $TEMP5 3002                  # Store multiplication result
3031 ADD $TEMP2 1                     # Increment counter
3032 SYSCALL YIELD                    # ✅ Yield CPU between factorial iterations
3033 SET 3003 $PC                     # Continue factorial loop

3050 CPYI 3002 $PARAM1                # ✅ FIXED: Get factorial result using indirect copy
3051 SYSCALL PRN $PARAM1              # ✅ FIXED: Print factorial result value
3052 SYSCALL HLT                      # Thread complete



End Instruction Section
