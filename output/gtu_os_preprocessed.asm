# GTU-C312 Operating System with Macros - Complete Implementation
# Register and Memory Layout Macros
# gtu_os.asm



# Memory Layout Constants

# Sentinel Values

# Thread States

# System Configuration

# OS Data Locations

# Debug Configuration

#GTU-C312 Operating System with Cooperative Multitasking
Begin Data Section
# CPU Registers (Memory-mapped)
0 100
1 1000
2 0
3 0
4 0
5 0
6 0
7 0
8 0
9 0
10 0
11 0
12 0
13 0
14 0
15 0
16 0
17 0
18 0
19 0
20 0

# OS Data Area (21-999) - Kernel mode only
21 57005
22 11
23 0
24 0
25 0
26 0
27 0
28 40
29 0
30 1


# Offset 9:  UNBLOCK TIME
#ID:0 starting time:1 how many execution so far in the thread:2 status:3, PC:4, SP:5, FP:6, Res_R:7 15, Res_R:8 16  unblocking_time:9
# Thread Table Structure (4 threads * 10 words each)
# Thread 0 (OS itself)
#######THREAD TABLE#######
# Thread Control Block Layout: ID, Start_Time, Instructions_Used, State, PC, SP, FP, Reserved1, Reserved2, Unblock_Time

# Thread 0 (OS itself)
40 0                  # Thread ID: 0 (OS)
41 0                                  # Starting time: 0
42 0                                  # Instructions used: 0
43 2                     # State: RUNNING (2)
44 100                                # PC: OS starts at instruction 100
45 999                                # SP: OS stack pointer (kernel end)
46 999                                # FP: OS frame pointer (kernel end)
47 0                                  # Reserved register 1 (15)
48 0                                  # Reserved register 2 (16)
49 0                                  # Unblock time: 0 (not applicable for OS)

# Thread 1 (Simple Counter Thread)
50 1                                  # Thread ID: 1
51 0                                  # Starting time: 0 (will be set by OS)
52 0                                  # Instructions used: 0
53 3                       # State: READY (1)
54 1000                     # PC: 1000 (thread start address)
55 1999                       # SP: 1999 (thread stack top)
56 1999                       # FP: 1999 (thread frame pointer)
57 0                                  # Reserved register 1 (15)
58 0                                  # Reserved register 2 (16)
59 0                                  # Unblock time: 0 (not blocked)

# Thread 2 (Bubble Sort Thread)
60 2                                  # Thread ID: 2
61 0                                  # Starting time: 0 (will be set by OS)
62 0                                  # Instructions used: 0
63 0                       # State: READY (1)
64 2000                     # PC: 2000 (thread start address)
65 2999                       # SP: 2999 (thread stack top)
66 2999                       # FP: 2999 (thread frame pointer)
67 0                                  # Reserved register 1 (15)
68 0                                  # Reserved register 2 (16)
69 0                                  # Unblock time: 0 (not blocked)

# Thread 3 (Linear Search Thread)
70 3                                  # Thread ID: 3
71 0                                  # Starting time: 0 (will be set by OS)
72 0                                  # Instructions used: 0
73 1                       # State: READY (1)
74 3000                     # PC: 3000 (thread start address)
75 3999                       # SP: 3999 (thread stack top)
76 3999                       # FP: 3999 (thread frame pointer)
77 0                                  # Reserved register 1 (15)
78 0                                  # Reserved register 2 (16)
79 0                                  # Unblock time: 0 (not blocked)

# Thread 4 (Inactive placeholder)
80 4                                  # Thread ID: 4
81 0                                  # Starting time: 0
82 0                                  # Instructions used: 0
83 0                    # State: INACTIVE (0)
84 4000                     # PC: 4000 (placeholder)
85 4999                       # SP: 4999 (placeholder)
86 4999                       # FP: 4999 (placeholder)
87 0                                  # Reserved register 1 (15)
88 0                                  # Reserved register 2 (16)
89 0                                  # Unblock time: 0 (not applicable)


# Thread 5 (placeholder Thread) - FIXED STACK SIZE
90 5
91 0
92 0
93 0
94 5000
95 5999
96 5999
97 0
98 0
99 0

# Thread 6 (placeholder Thread) - FIXED STACK SIZE
100 6
101 0
102 0
103 0
104 6000
105 6999
106 6999
107 0
108 0
109 0

# Thread 7 (Custom Thread) - FIXED STACK SIZE
110 7
111 0
112 0
113 0
114 7000
115 7999
116 7999
117 0
118 0
119 0

# Thread 8 (placeholder Thread) - FIXED STACK SIZE
120 8
121 0
122 0
123 0
124 8000
125 8999
126 8999
127 0
128 0
129 0

# Thread 9 (placeholder Thread) - FIXED STACK SIZE
130 9
131 0
132 0
133 0
134 9000
135 9999
136 9999
137 0
138 0
139 0

# Thread 10 (placeholder Thread) - FIXED STACK SIZE
140 6
141 0
142 0
143 0
144 10000
145 10999
146 10999
147 0
148 0
149 0


# OS Working Variables
160 0
161 0
162 0
163 0
164 0
165 1
170 0
171 0
172 0
173 0
174 4
175 1

999 48879

# Thread 1 Data Area (1000-1999) - Simple Counter
1000 0                     # Thread start marker
1001 10                              # Count from 1 to 10
1002 0                               # Unused
1003 0                               # Sum accumulator (initially 0)


# Thread 2 Data Area (2000-2999) - Bubble Sort
2000 0                     # Thread start marker
2001 5                               # N = Array size (5 numbers)
2002 0                               # Unused
2003 64                              # Array element 0
2004 34                              # Array element 1  
2005 25                              # Array element 2
2006 12                              # Array element 3
2007 90                              # Array element 4
2008 0                               # Workspace
2009 0                               # Workspace
2010 0                               # Workspace



# Thread 3 Data Area (3000-3999) - Linear Search
3000 0                     # Thread start marker
3001 5                               # N = Array size (5 numbers)
3002 25                              # Search key (looking for 25)
3003 64                              # Array element 0
3004 34                              # Array element 1  
3005 25                              # Array element 2 ← Target found here
3006 12                              # Array element 3
3007 90                              # Array element 4
3008 -1                              # Result storage (initially -1 = not found)
3009 0                               # Workspace
3010 0                               # Workspace


End Data Section

# GTU-C312 Operating System - Complete Implementation from Scratch
# Using provided macros and data section

Begin Instruction Section

# OS Boot and Initialization (Instructions 100-199)
100 SET 0 13                       # Initialize zero register
101 SET 1 25                   # Set OS state to running
102 SET 0 23             # Initialize current thread to OS (0)
103 SET 0 24          # Initialize scheduler counter
104 SET 0 26        # Initialize context switch flag

106 SET 4 174        # Set active thread count (threads 1-4)
107 SET 1 175     # Initialize completed thread count
108 SET 110 0                       # Jump to main OS loop

#OS state == 2 (shutdown) inti:0,running:1,shutdown:2
# Main OS Loop (Instructions 110-179) - ALTERNATIVE
110 CPY 25 4              # Load OS state
112 ADD 4 -1                     # temp2 = OS_state - 2
113 JIF 4 115                    # If OS_state < 2, continue
114 SET 190 0                       # If OS_state >= 2, shutdown

# Normal operation continues here
115 CALL 350 
116 CPY 175 5 # Check thread completion
117 CPY 174 6   # Load active thread count
118 CPY 5 7                 # Copy completed count
119 ADD 7 -2                     # Check if all threads done CHANGED FROM 3 to 2 !!
120 JIF 7 125                    # Jump to completion handler
121 SET 180 0                       # If OS_state >= 2, shutdown

125 CALL 400                          # Call scheduler
126 CALL 500                          # Call system call handler
127 ADD 24 1          # Increment scheduler counter
128 SET 110 0                       # Loop back to start

# All Threads Completed Handler (Instructions 180-189)
180 SET 57005 4          # Load completion sentinel
181 SYSCALL PRN 4                # Print completion marker
182 SET 2 25                   # Set OS state to shutdown
183 SET 190 0                       # Jump to shutdown

# OS Shutdown Sequence (Instructions 190-199)
190 SET 48879 4          # Load shutdown sentinel
191 SYSCALL PRN 4                # Print shutdown marker
192 HLT                               # Halt the system


# 0 0
# 1 1
# 2 2
# 3 3

# Check Blocked Threads for Unblocking (Instructions 350-399) - USING ADD INSTEAD OF SUBI
350 CPY 14 15                   # Save frame pointer
351 CPY 1 14                       # Set new frame pointer
352 SET 1 16                      # Start with thread 1
353 SET 0 17                      # Thread counter

# Loop through threads 1-3
354 CPY 17 6                 # Copy counter
355 ADD 6 -3                     # ✅ FIXED: temp3 = counter - 3
356 JIF 6 358                    # Continue if counter <= 3
357 SET 392 0                       # Exit if counter > 3
 
# Check if thread is blocked
358 CPY 16 10                # Pass thread ID
359 CALL 600                          # Get thread state
360 CPY 12 7                # Get state
361 ADD 7 -2                     # ✅ FIXED: temp4 = state - 
362 JIF 7 385                    # Continue if state > 2 = BLOCKED
363 SET 365 0                       # Process blocked thread

# Get thread table entry for blocked thread
365 CPY 16 10                # Pass thread ID
366 CALL 650                          # Get thread table base
367 CPY 12 8                # Get thread table base

368 ADD 8 9                      # Move to unblock time
369 CPYI 8 9                # unbock time

# Check if 100 instructions have passed (offset 8)
372 CPY 3 16          # Get thread table base again
373 CPY 9 17                # Move to unblock time field
374 SUBI 17 16              # store2 = current_time - unblock_time
375 JIF 16 387                   # If unblock_time >= current_time, block remain
376 SET 382 0                       # unblock, try next

# Unblock the thread
382 CPY 12 16               # Get thread table base
383 ADD 16 3                     # Move to state field

384 SET 751 8                      # Move to state field
385 SET 1 751
386 CPYI2 8 16
#TODO may reset unblock time

# Try next thread
387 ADD 16 1                      # Increment thread ID
388 CPY 16 7                 # Copy thread ID
389 ADD 7 -3                     # ✅ FIXED: temp4 = thread_ID - 3
390 JIF 7 392                    # Continue if thread_ID <= 3
391 SET 1 16                      # Wrap to thread 1

392 CPY 15 14                   # Restore frame pointer
393 RET                             # Return
                             
394 ADD 17 1                      # Increment counter
395 SET 354 0                       # Continue loop




# Round Robin Scheduler (Instructions 400-499) - ADJUSTED FOR YOUR REGISTER LAYOUT
400 CPY 14 15                   # Save frame pointer
401 CPY 1 14                       # Set new frame pointer

# Initialize search variables
402 CPY 23 16       # ✅ Use STORE2 for current thread ID (persistent)
403 ADD 16 1                     # Start search from next thread
404 CPY 16 4                # Check if thread > 3
405 ADD 4 -3                     # temp1 = thread_ID - 3
406 JIF 4 408                    # If thread_ID <= 3, continue
407 SET 1 16                     # If thread_ID > 3, wrap to 1 TODO: 3 BLOCK CONDITION

408 SET 0 17                     # ✅ Use STORE3 for search counter (persistent)

# Search loop for next ready thread
409 CPY 17 4                # Copy search counter
410 ADD 4 -3                     # Check if searched all 3 threads
411 JIF 4 413                    # If searched all, continue
412 SET 470 0                       # If searched all, no ready thread found

# Get thread state for current candidate
413 CPY 16 10               # Pass thread ID to get state
414 CALL 600                          # ✅ SAFE: STORE2 preserved across call
415 CPY 12 18               # ✅ Save state in STORE4 (persistent)

# Check if thread state == READY (1) using proper equality test
416 CPY 18 4                # Copy state
417 ADD 4 -1                     # temp1 = state - 1
418 JIF 4 420                    # If state <= 1, check second condition
419 SET 440 0                       # If state > 1, try next thread

# Second equality check: 1 - state
420 SET 1 5                      # Load constant 1
421 SUBI 18 5               # temp2 = 1 - state
422 JIF 5 425                    # If 1 - state <= 0 (state >= 1) = ! READY
423 SET 440 0                       # If state < 1, try next thread

# Both conditions met: state == 1 (READY)
425 CPY 16 165          # Set next thread (found ready thread)
426 CALL 700                          # ✅ SAFE: STORE2 preserved across call
427 SET 470 0                       # Jump to exit

# Try next thread
440 ADD 16 1                     # ✅ Increment thread ID (preserved)
441 CPY 16 4                # Copy thread ID
442 ADD 4 -3                     # Check if > 3
443 JIF 4 450                    # If > 3, wrap to 1
444 SET 445 0                       # Continue with current thread ID

445 SET 1 16                     # Wrap to thread 1

450 ADD 17 1                     # ✅ Increment search counter (preserved)
451 SET 409 0                       # Continue search loop

# Exit scheduler
470 CPY 15 14                   # Restore frame pointer
471 RET                               # Return


# System Call Handler (Instructions 500-599) - ALTERNATIVE CLEAN FIX
500 CPY 2 4           # Check if system call pending
501 JIF 4 550                    # If no system call, return

# Handle different system call types
502 CPY 4 5                 # Copy system call type
503 ADD 5 -1                     # Check if PRN (type 1)
504 JIF 5 515                    # ✅ FIXED: Jump to actual PRN handler

505 CPY 4 5                 # Copy system call type again
506 ADD 5 -2                     # Check if YIELD (type 2)
507 JIF 5 530                    # ✅ FIXED: Jump to actual YIELD handler

508 CPY 4 5                 # Copy system call type again
509 ADD 5 -3                     # Check if HLT (type 3)
510 JIF 5 535                    # ✅ FIXED: Jump to actual HLT handler
511 SET 550 0                       # Unknown system call, return

# Handle PRN system call - ALTERNATIVE FIX
515 CPY 23 15       # Get current thread ID
516 CPY 15 10               # Pass thread ID
517 CALL 650                          # ✅ NEW: Call thread table base helper
518 CPY 12 4                # Get thread table base address
519 ADD 4 3                      # Move to state field
520 SET 3 4         # Set thread to BLOCKED
# Record when blocking started (for 100 instruction countdown)
521 CPY 12 5                # Get thread table base again
522 ADD 5 9                      # Move to reserved area (offset 9) for unblock time
523 CPY 3 6           # Get current instruction count
524 ADD 6 100                    # Add 100 instructions

525 CPY 6 750
525 SET 6 750

526 CPYI2 750 5                # ✅ CORRECT: Store 6 value at address 5

527 SET 1 26        # Force context switch
528 SET 550 0                       # Return


# Handle YIELD system call
530 SET 1 26        # Set context switch flag
531 SET 550 0                       # Return

# Handle HLT system call
535 CALL 900                          # Mark thread as completed
536 SET 1 26        # Force context switch
537 SET 550 0                       # Return

550 SET 0 2                # Clear system call result
551 SET 125 0

# Get Thread State Helper (Instructions 600-699) - ADJUSTED FOR YOUR REGISTER LAYOUT
600 CPY 10 4                # Get thread ID
601 SET 40 5     # Get thread table base address (40)
602 CPY 4 6                 # Copy thread ID
603 SET 0 7                      # Initialize offset to 0

# Calculate thread table offset (thread_ID * 10)
604 JIF 6 620                    # If thread ID = 0, skip multiplication
605 ADD 7 10      # Add 10 to offset
606 ADD 6 -1                     # Decrement thread ID counter
607 SET 604 0                       # Loop back to check

# Calculate final address and get state
620 ADDI 5 7                # Add offset to base (base + thread_ID*10)
621 ADD 5 3                      # Move to state field (offset 3)
622 CPYI 5 12               # Get VALUE AT address using indirect copy
623 RET                               # Return with state in PARAM3


# Get Thread Table Base Helper (Instructions 650-699) - NEW FUNCTION
650 CPY 10 4                # Get thread ID
651 SET 40 5     # Get thread table base (40)
652 CPY 4 6                 # Copy thread ID
653 SET 0 7                      # Initialize offset

# Multiplication loop
654 JIF 6 670                    # If thread ID = 0, skip multiplication
655 ADD 7 10      # Add 10 to offset
656 ADD 6 -1                     # Decrement thread ID counter
657 SET 654 0                       # Loop back to check

670 ADDI 5 7                 # Calculate thread entry base address
671 CPY 5 12                # Return base address in PARAM3
672 RET                               # Return





# Context Switch (Instructions 700-799) - COMPLETE IMPLEMENTATION
700 CPY 14 15                   # Save frame pointer
701 CPY 1 14                       # Set new frame pointer

# Get current thread ID and validate
702 CPY 23 16       # Get current thread ID
703 JIF 16 720                   # If current thread = 0 (OS), skip saving OS NOT SAVED PROBLEM

# Save current thread context
704 CPY 16 10               # Pass current thread ID
705 CALL 750                          # Save current thread state
706 CPY 12 4                # Get thread table address result
707 ADD 4 3                      # Move to state field

708 SET 751 8                      # Move to state field
709 SET 1 751
719 CPYI2 8 4


# Load new thread context
720 CPY 165 17          # Get next thread ID
721 CPY 17 23       # Update current thread
722 CPY 17 10               # Pass new thread ID
723 CALL 800                          # ✅ FIXED: Call correct load helper
724 CPY 12 4                # Get thread table address result
725 CPY 4 5                # Get thread table address result
726 ADD 5 3                      # Move to state field
727 SET 2 5         # Set new thread to RUNNING
728 ADD 4 4

# Switch to user mode and jump to new thread
729 CPY 17 5                # Copy new thread ID
730 JIF 5 740                    # If thread 0 (OS), stay in kernel
731 USER 4                       # Switch to user mode and jump

740 RET


# Save Thread State Helper (Instructions 750-799) - USING HELPER FUNCTION
750 CPY 14 15                   # Save frame pointer
751 CPY 1 14                       # Set new frame pointer
752 CPY 10 4                # Get thread ID

# Use Get Thread Table Base Helper instead of manual calculation
753 CPY 4 10                # Pass thread ID to helper
754 CALL 650                          # Call Get Thread Table Base Helper
755 CPY 12 4                # Get thread table base address

# Save CPU registers to thread table following new layout
# Offset 4: PC (Program Counter)
756 CPY 4 5                 # Get thread table base address
757 ADD 5 4                      # Move to PC field (offset 4)
758 CPY 0 8                    # Get current PC
759 SET 8 5                 # Store PC in thread table

# Offset 5: SP (Stack Pointer)
760 CPY 4 5                 # Get fresh thread table base
761 ADD 5 5                      # Move to SP field (offset 5)
762 CPY 1 8                    # Get current SP
763 SET 8 5                 # Store SP in thread table

# Offset 6: FP (Frame Pointer)
764 CPY 4 5                 # Get fresh thread table base
765 ADD 5 6                      # Move to FP field (offset 6)
766 CPY 14 8                    # Get current FP
767 SET 8 5                 # Store FP in thread table

# Offset 7: Reserved Register 1 (save 15)
768 CPY 4 5                 # Get fresh thread table base
769 ADD 5 7                      # Move to Res_R field (offset 7)
770 CPY 15 8                # Get 15 value
771 SET 8 5                 # Store Reserved Register 1

# Offset 8: Reserved Register 2 (save 16)
772 CPY 4 5                 # Get fresh thread table base
773 ADD 5 8                      # Move to Res_R field (offset 8)
774 CPY 16 8                # Get 16 value
775 SET 8 5                 # Store Reserved Register 2

# Note: Offset 9 (unblocking_time) is managed by OS for SYSCALL PRN blocking

776 CPY 4 12                # Return thread table base address
777 CPY 15 14                   # Restore frame pointer
778 RET                               # Return



# Load Thread State Helper (Instructions 800-849) - CORRECTED FOR NEW OFFSETS
800 CPY 14 15                   # Save frame pointer
801 CPY 1 14                       # Set new frame pointer
802 CPY 10 4                # Get thread ID

# Use Get Thread Table Base Helper
803 CPY 4 10                # Pass thread ID to helper
804 CALL 650                          # Call Get Thread Table Base Helper
805 CPY 12 4                # Get thread table base address

# Restore SP FIRST (offset 5) ✅ CORRECT
806 CPY 4 5                 # Get thread entry base address
807 ADD 5 5                      # Move to SP field (offset 5)
808 CPYI 5 8                # Get stored SP value
809 CPY 8 1                    # Restore SP

# Restore FP (offset 6) ✅ CORRECT
810 CPY 4 5                 # Get fresh thread entry base
811 ADD 5 6                      # Move to FP field (offset 6)
812 CPYI 5 8                # Get stored FP value
813 CPY 8 14                    # Restore FP

# Load Reserved Register 1 from offset 7
814 CPY 4 5                 # Get fresh thread entry base
815 ADD 5 7                      # Move to Res_R field (offset 7)
816 CPYI 5 8                # Get stored register value
817 CPY 8 15                # Restore to 15 (or appropriate register)

# Load Reserved Register 2 from offset 8
818 CPY 4 5                 # Get fresh thread entry base
819 ADD 5 8                      # Move to Res_R field (offset 8)
820 CPYI 5 8                # Get stored register value
821 CPY 8 16                # Restore to 16 (or appropriate register)

822 CPY 4 5                 # Get fresh thread entry base
823 ADD 5 3                      # Move to state field


824 SET 751 8                      # Move to state field
825 SET 2 751
826 CPYI2 8 5

827 CPY 4 5                 # Get fresh thread entry base
828 ADD 5 4

# Switch to user mode and jump to new thread
829 CPYI 4 4
830 JIF 4 115                    # If thread 0 (OS), stay in kernel
831 CPYI 5 5
832 USER 5                       # Switch to user mode and jump

#ID:0 starting time:1 how many execution so far in the thread:2 status:3, PC:4, SP:5, FP:6, Res_R:7, Res_R:8  unblocking_time:9








# Thread Completion Handler (Instructions 900-949) - USING HELPER FUNCTION
900 CPY 14 15                   # Save frame pointer
901 CPY 1 14                       # Set new frame pointer
902 CPY 23 10       # Get current thread ID and pass as parameter

# Use existing helper function to get thread table base address
903 CALL 650                          # Call thread table base helper
904 CPY 12 4                # Get thread table base address from helper

# Mark thread as completed
905 ADD 4 3                      # Move to state field (offset 3)

906 SET 
 8                      # Move to state field
907 SET 0 751
908 CPYI2 8 4





# Update completion statistics
909 ADD 175 1     # Increment completed count
910 SET 0 23             # Reset current thread to OS

911 CPY 15 14                   # Restore frame pointer
912 RET                               # Return



# Thread 1: Simple Counter
1000 CPY 1001 4        # Load maximum count (10)
1001 SET 1 5                     # Initialize counter to 1
1002 SET 0 1003                       # Initialize sum to 0

# Main counting loop
1003 CPY 5 7                # Copy counter
1004 CPY 4 8                # Copy max count  
1005 SUBI 7 8               # temp5 = max_count - counter
1006 JIF 8 1020                  # Exit if counter > max_count

# Print current number
1007 SYSCALL PRN 5               # Print current counter value
1008 SYSCALL YIELD                    # Yield CPU for cooperative scheduling

# Add to sum
1009 CPYI 1003 9                 # Load current sum
1010 ADD 9 5                # Add counter to sum
1011 SET 9 1003                  # Store sum back

# Increment counter and continue
1012 ADD 5 1                     # Increment counter
1013 SYSCALL YIELD                    # Yield CPU between iterations
1014 SET 1003 0                     # Continue main loop

# Print final sum
1020 CPYI 1003 10                # Get final sum
1021 SYSCALL PRN 10              # Print total sum (should be 55 for 1-10)
1022 SYSCALL HLT                      # Thread complete






# Thread 2: Linear Search - CORRECTED VERSION
2000 CPY 2001 4        # Load array size (5)
2001 CPY 2002 5                  # Load search key (25)
2002 SET 2003 6                  # Array start address (2003)
2003 SET 0 7                     # Search counter/index
2004 SET -1 2008                      # Initialize result to -1 (not found)

# Search loop
2005 CPY 7 8                # Copy counter
2006 CPY 4 9                # Copy array size
2007 SUBI 8 9               # temp6 = array_size - counter
2008 JIF 9 2050                  # Exit if counter >= array_size

# Get current element from array
2009 CPY 6 9                # Copy array base address
2010 ADD 9 7                # Add counter offset to get element address
2011 CPYI 9 10              # Get current element using indirect copy

# Compare with search key
2012 CPY 10 11              # Copy current element
2013 CPY 5 12               # Copy search key
2014 SUBI 11 12             # param3 = key - element
2015 JIF 12 2040                 # If not equal (result != 0), continue

# Found element - store index and exit
2016 SET 7 2008                  # Store found index in result location
2017 SET 2050 0                     # Exit search immediately

# Continue to next element
2040 ADD 7 1                     # Increment counter/index
2041 SYSCALL YIELD                    # Yield CPU for cooperative scheduling
2042 SET 2005 0                     # Continue search loop

# Print result
2050 CPYI 2008 10                # Get search result using indirect copy
2051 SYSCALL PRN 10              # Print result (index if found, -1 if not found)
2052 SYSCALL HLT                      # Thread complete



# Thread 2: Bubble Sort - Sorts N Numbers in Increasing Order (NOT READY)
2000 CPY 2001 4        # Load array size N (5)
2001 SET 2003 5                  # Array start address (2003)
2002 SET 0 6                     # Outer loop counter

# Outer loop
2003 CPY 6 7                # Copy outer counter
2004 CPY 4 8                # Copy array size N
2005 ADD 8 -1                    # size - 1
2006 SUBI 7 8               # temp5 = (size-1) - outer
2007 JIF 8 2080                  # Exit if outer >= size-1

2008 SET 0 9                     # Inner loop counter

# Inner loop with bubble sort comparison
2009 CPY 9 15               # Copy inner counter
2010 CPY 4 16               # Copy array size
2011 ADD 16 -1                   # size - 1
2012 CPY 6 17               # Copy outer counter
2013 SUBI 16 17             # store2 = (size-1) - outer
2014 SUBI 16 15             # store2 = (size-1-outer) - inner
2015 JIF 16 2070                 # Exit inner if inner >= (size-1-outer)

# Compare adjacent elements
2016 CPY 5 17               # Copy array base address
2017 ADD 17 9               # Add inner counter to get current element address
2018 CPYI 17 10             # Get arr[inner] using indirect copy
2019 ADD 17 1                    # Move to next element address
2020 CPYI 17 11             # Get arr[inner+1] using indirect copy

# Check if swap needed (if arr[inner] > arr[inner+1])
2021 CPY 10 12              # Copy first element
2022 SUBI 11 12             # param3 = arr[inner] - arr[inner+1]
2023 JIF 12 2060                 # If arr[inner] <= arr[inner+1], no swap needed

# Swap elements (arr[inner] > arr[inner+1])
2024 CPY 5 17               # Get array base address
2025 ADD 17 9               # Add inner counter
2026 SET 11 17              # Store arr[inner+1] in arr[inner] position
2027 ADD 17 1                    # Move to next position
2028 SET 10 17              # Store arr[inner] in arr[inner+1] position

2060 ADD 9 1                     # Increment inner counter
2061 SYSCALL YIELD                    # Yield CPU for cooperative scheduling
2062 SET 2009 0                     # Continue inner loop

2070 ADD 6 1                     # Increment outer counter
2071 SYSCALL YIELD                    # Yield CPU between outer loop iterations
2072 SET 2003 0                     # Continue outer loop

# Print sorted array in increasing order
2080 SET 0 6                     # Print counter
2081 CPY 6 7                # Copy counter
2082 CPY 4 8                # Copy array size
2083 SUBI 7 8               # temp5 = array_size - counter
2084 JIF 8 2090                  # Exit if printed all elements
2085 CPY 5 9                # Array base address
2086 ADD 9 6                # Add counter to get element address
2087 CPYI 9 10              # Get element using indirect copy
2088 SYSCALL PRN 10              # Print sorted element value
2089 ADD 6 1                     # Increment print counter
2090 SET 2081 0                     # Continue printing

2091 SYSCALL HLT                      # Thread complete




# Thread 3: Linear Search - CORRECTED VERSION
3000 CPY 3001 4        # Load array size (5)
3001 CPY 3002 5                  # Load search key (25)
3002 SET 3003 6                  # Array start address (3003)
3003 SET 0 7                     # Search counter/index
3004 SET -1 3008                      # Initialize result to -1 (not found)

# Search loop
3005 CPY 7 8                # Copy counter
3006 CPY 4 9                # Copy array size
3007 SUBI 8 9               # temp6 = array_size - counter
3008 JIF 9 3050                  # Exit if counter >= array_size

# Get current element from array
3009 CPY 6 9                # Copy array base address
3010 ADD 9 7                # Add counter offset to get element address
3011 CPYI 9 10              # Get current element using indirect copy

# Compare with search key
3012 CPY 10 11              # Copy current element
3013 CPY 5 12               # Copy search key
3014 SUBI 11 12             # param3 = key - element
3015 JIF 12 3040                 # If not equal (result != 0), continue

# Found element - store index and exit
3016 CPY 7 3008                  # Store found index in result location
3017 SET 3050 0                     # Exit search immediately

# Continue to next element
3040 ADD 7 1                     # Increment counter/index
3041 SYSCALL YIELD                    # Yield CPU for cooperative scheduling
3042 SET 3005 0                     # Continue search loop

# Print result
3050 CPYI 3008 10                # Get search result using indirect copy
3051 SYSCALL PRN 10              # Print result (index if found, -1 if not found)
3052 SYSCALL HLT                      # Thread complete



End Instruction Section
