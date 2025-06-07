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
#ID:1 starting time:2 how many execution:3 so far in the thread:4 state:5, PC:6, SP:7, FP:8,
# Thread Table Structure (4 threads * 10 words each)
# Thread 0 (OS itself)
#######THREAD TABLE#######

40 0
41 0
42 0
43 2
44 21
45 999
46 999
47 0
48 0
49 0

# Thread 1 (Sorting Thread) - FIXED STACK SIZE
50 1
51 0
52 0
53 1
54 1000
55 1999
56 1999
57 0
58 0
59 0

# Thread 2 (Search Thread) - FIXED STACK SIZE
60 2
61 0
62 0
63 1
64 2000
65 2999
66 2999
67 0
68 0
69 0

# Thread 3 (Custom Thread) - FIXED STACK SIZE
70 3
71 0
72 0
73 1
74 3000
75 3999
76 3999
77 0
78 0
79 0

# Thread 4 (placeholder Thread) - FIXED STACK SIZE
80 4
81 0
82 0
83 0
84 4000
85 4999
86 4999
87 0
88 0
89 0

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
175 0

999 48879

# Thread 1 Data Area (1000-1999) - Bubble Sort
1000 0
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
2000 0
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
3000 0
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
100 SET 0 13                       # Initialize zero register
101 SET 1 25                   # Set OS state to running
102 SET 0 23             # Initialize current thread to OS (0)
103 SET 0 24          # Initialize scheduler counter
104 SET 0 26        # Initialize context switch flag

106 SET 4 174        # Set active thread count (threads 1-4)
107 SET 0 175     # Initialize completed thread count
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
119 ADD 7 -3                     # Check if all threads done
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
357 SET 390 0                       # Exit if counter > 3
 
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
375 JIF 16 385                   # If unblock_time >= current_time, block remain
376 SET 382 0                       # unblock, try next

# Unblock the thread
382 CPY 12 16               # Get thread table base
383 ADD 16 3                     # Move to state field
384 SET 1 16          # Set thread back to READY
#TODO may reset unblock time

# Try next thread
385 ADD 16 1                      # Increment thread ID
386 CPY 16 7                 # Copy thread ID
387 ADD 7 -3                     # ✅ FIXED: temp4 = thread_ID - 3
388 JIF 7 392                    # Continue if thread_ID <= 3
389 SET 1 16                      # Wrap to thread 1

392 ADD 17 1                      # Increment counter
393 SET 354 0                       # Continue loop

390 CPY 15 14                   # Restore frame pointer
391 RET                               # Return





# Round Robin Scheduler (Instructions 400-499) - ADJUSTED FOR YOUR REGISTER LAYOUT
400 CPY 14 15                   # Save frame pointer
401 CPY 1 14                       # Set new frame pointer

# Initialize search variables
402 CPY 23 16       # ✅ Use STORE2 for current thread ID (persistent)
403 ADD 16 1                     # Start search from next thread
404 CPY 16 4                # Check if thread > 3
405 ADD 4 -3                     # temp1 = thread_ID - 3
406 JIF 4 408                    # If thread_ID <= 3, continue
407 SET 1 16                     # If thread_ID > 3, wrap to 1

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
422 JIF 5 425                    # If 1 - state <= 0 (state >= 1)
423 SET 440 0                       # If state < 1, try next thread

# Both conditions met: state == 1 (READY)
425 CPY 16 165          # Set next thread (found ready thread)
426 CALL 700                          # ✅ SAFE: STORE2 preserved across call
427 SET 470 0                       # Jump to exit

# Try next thread
440 ADD 16 1                     # ✅ Increment thread ID (preserved)
441 CPY 16 4                # Copy thread ID
442 ADD 4 -3                     # Check if > 3
443 JIF 4 445                    # If > 3, wrap to 1
444 SET 450 0                       # Continue with current thread ID

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
525 SET 6 5                 # Store unblock time

526 SET 1 26        # Force context switch
527 SET 550 0                       # Return


# Handle YIELD system call
530 SET 1 26        # Set context switch flag
531 SET 550 0                       # Return

# Handle HLT system call
535 CALL 900                          # Mark thread as completed
536 SET 1 26        # Force context switch
537 SET 550 0                       # Return

550 SET 0 2                # Clear system call result
551 RET                               # Return


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
703 JIF 16 720                   # If current thread = 0 (OS), skip saving

# Save current thread context
704 CPY 16 10               # Pass current thread ID
705 CALL 750                          # Save current thread state
706 CPY 12 4                # Get thread table address result
707 ADD 4 3                      # Move to state field
708 SET 1 4           # Set current thread to READY

# Load new thread context
720 CPY 165 17          # Get next thread ID
721 CPY 17 23       # Update current thread
722 CPY 17 10               # Pass new thread ID
723 CALL 800                          # ✅ FIXED: Call correct load helper
724 CPY 12 4                # Get thread table address result
725 ADD 4 3                      # Move to state field
726 SET 2 4         # Set new thread to RUNNING

# Switch to user mode and jump to new thread
727 CPY 17 5                # Copy new thread ID
728 JIF 5 740                    # If thread 0 (OS), stay in kernel
729 CALL 850                           # Switch to user mode for user threads
730 CPY 740 0                       # Jump to exit

740 CPY 15 14                   # Restore frame pointer
741 RET                               # Return

# Save Thread State Helper (Instructions 750-799) - COMPLETELY FIXED
750 CPY 14 15                   # Save frame pointer
751 CPY 1 14                       # Set new frame pointer
752 CPY 10 4                # Get thread ID

# Calculate thread table base address manually (thread_ID * 10)
753 SET 40 5     # Get thread table base (40)
754 CPY 4 6                 # Copy thread ID
755 SET 0 7                      # Initialize offset

# Multiplication loop: offset = thread_ID * 10
756 JIF 6 770                    # If thread ID = 0, skip multiplication
757 ADD 7 10      # Add 10 to offset
758 ADD 6 -1                     # Decrement thread ID counter
759 SET 756 0                       # Loop back to check

# Calculate thread entry base address
770 ADD 5 7                 # base + offset = thread entry address

# Save CPU registers to thread table
771 CPY 5 16                # Save thread entry base address
772 ADD 16 4                     # Move to PC field (offset 4)
773 CPY 0 8                    # Get current PC
774 SET 8 16                # Store PC in thread table

775 CPY 5 16                # Restore thread entry base
776 ADD 16 5                     # Move to SP field (offset 5)
777 CPY 1 8                    # Get current SP
778 SET 8 16                # Store SP in thread table

779 CPY 5 16                # Restore thread entry base
780 ADD 16 6                     # Move to FP field (offset 6)
781 CPY 14 8                    # Get current FP
782 SET 8 16                # Store FP in thread table

# Save additional working registers if needed
783 CPY 5 16                # Restore thread entry base
784 ADD 16 7                     # Move to saved register area (offset 7)
785 CPY 4 8                 # Save TEMP1 (thread ID)
786 SET 8 16                # Store in thread table

787 ADD 16 1                     # Move to next save slot (offset 8)
788 CPY 5 8                 # Save TEMP2 (base address)
789 SET 8 16                # Store in thread table

790 CPY 5 12                # Return thread table base address
791 CPY 15 14                   # Restore frame pointer
792 RET                               # Return


# Load Thread State Helper (Instructions 800-849) - COMPLETE
800 CPY 14 15                   # Save frame pointer
801 CPY 1 14                       # Set new frame pointer
802 CPY 10 4                # Get thread ID

# Calculate thread table base address manually
803 SET 40 5     # Get thread table base (40)
804 CPY 4 6                 # Copy thread ID
805 SET 0 7                      # Initialize offset

# Multiplication loop: offset = thread_ID * 10
806 JIF 6 820                    # If thread ID = 0, skip multiplication
807 ADD 7 10      # Add 10 to offset
808 ADD 6 -1                     # Decrement thread ID counter
809 SET 806 0                       # Loop back to check

# Calculate thread entry base address
820 ADDI 5 7                 # base + offset = thread entry address


# Load CPU registers from thread table
821 CPY 5 16                # Save thread entry base address
822 ADD 16 4                     # Move to PC field (offset 4)
823 CPYI 16 8               # Get stored PC value
824 CPY 8 0                    # Restore PC

825 CPY 5 16                # Restore thread entry base
826 ADD 16 5                     # Move to SP field (offset 5)
827 CPYI 16 8               # Get stored SP value
828 CPY 8 1                    # Restore SP

829 CPY 5 16                # Restore thread entry base
830 ADD 16 6                     # Move to FP field (offset 6)
831 CPYI 16 8               # Get stored FP value
832 CPY 8 14                    # Restore FP

# Load additional working registers if needed
833 CPY 5 16                # Restore thread entry base
834 ADD 16 7                     # Move to saved register area (offset 7)
835 CPYI 16 4               # Restore TEMP1

836 ADD 16 1                     # Move to next save slot (offset 8)
837 CPYI 16 5               # Restore TEMP2

838 CPY 5 12                # Return thread table base address
839 CPY 15 14                   # Restore frame pointer
840 RET                               # Return





# Switch to User Mode Helper (Instructions 850-899)
850 CPY 10 4                # Get thread ID
851 SET 1000 5                   # Base user address
852 CPY 4 6                 # Copy thread ID
853 ADD 6 6                 # thread_ID * 2
854 ADD 6 6                 # thread_ID * 4
855 ADD 6 6                 # thread_ID * 8
856 ADD 5 6                 # Approximate thread start address
857 USER 5                       # Switch to user mode and jump
858 RET                               # Return (should not reach here)



# Thread Completion Handler (Instructions 900-949) - USING HELPER FUNCTION
900 CPY 14 15                   # Save frame pointer
901 CPY 1 14                       # Set new frame pointer
902 CPY 23 10       # Get current thread ID and pass as parameter

# Use existing helper function to get thread table base address
903 CALL 650                          # Call thread table base helper
904 CPY 12 4                # Get thread table base address from helper

# Mark thread as completed
905 ADD 4 3                      # Move to state field (offset 3)
906 SET 0 4        # Set thread to INACTIVE at correct address

# Update completion statistics
907 ADD 175 1     # Increment completed count
908 SET 0 23             # Reset current thread to OS

909 CPY 15 14                   # Restore frame pointer
910 RET                               # Return


# Thread 1: Bubble Sort - FIXED FOR ARCHITECTURE
1000 SET 1002 4        # Load array start address (1002)
1001 CPY 1001 5                  # Load array size (5)
1002 SET 0 6                     # Outer loop counter

# Outer loop
1003 CPY 6 7                # Copy outer counter
1004 CPY 5 8                # Copy array size
1005 ADD 8 -1                    # size - 1
1006 SUBI 8 7               # temp4 = (size-1) - outer (keep SUBI as is)
1007 JIF 7 1080                  # Exit if outer >= size-1

1008 SET 0 9                     # Inner loop counter

# Inner loop
1009 CPY 9 15               # Copy inner counter
1010 CPY 5 16               # Copy array size
1011 ADD 16 -1                   # size - 1
1012 CPY 6 17               # Copy outer counter
1013 SUBI 16 17             # store2 = (size-1) - outer (keep SUBI as is)
1014 SUBI 16 15             # store2 = (size-1-outer) - inner (keep SUBI as is)
1015 JIF 16 1070                 # Exit inner if inner >= (size-1-outer)

# Compare adjacent elements
1016 CPY 4 17               # Copy array base
1017 ADD 17 9               # Add inner counter
1018 CPYI 17 10             # ✅ FIXED: Get arr[inner] using indirect copy
1019 ADD 17 1                    # Move to next element
1020 CPYI 17 11             # ✅ FIXED: Get arr[inner+1] using indirect copy

# Check if swap needed
1021 CPY 10 12              # Copy first element
1022 SUBI 11 12             # param3 = arr[inner] - arr[inner+1] (keep SUBI as is)
1023 JIF 12 1060                 # If arr[inner] <= arr[inner+1], no swap

# Swap elements
1024 CPY 4 17               # Array base
1025 ADD 17 9               # Add inner counter
1026 SET 11 17              # Store arr[inner+1] in arr[inner]
1027 ADD 17 1                    # Move to next
1028 SET 10 17              # Store arr[inner] in arr[inner+1]

1060 ADD 9 1                     # Increment inner counter
1061 SYSCALL YIELD                    # ✅ Yield CPU for cooperative scheduling
1062 SET 1009 0                     # Continue inner loop

1070 ADD 6 1                     # Increment outer counter
1071 SYSCALL YIELD                    # ✅ Yield CPU between outer loop iterations
1072 SET 1003 0                     # Continue outer loop

# Print sorted array
1080 SET 0 6                     # Print counter
1081 CPY 6 7                # Copy counter
1082 ADD 7 -5                    # Check if printed all 5
1083 JIF 7 1090                  # Exit if done
1084 CPY 4 8                # Array base
1085 ADD 8 6                # Add counter
1086 CPYI 8 10              # ✅ FIXED: Get element using indirect copy
1087 SYSCALL PRN 10              # ✅ FIXED: Print element value
1088 ADD 6 1                     # Increment counter
1089 SET 1081 0                     # Continue printing

1090 SYSCALL HLT                      # Thread complete




# Thread 2: Linear Search - FIXED FOR ARCHITECTURE
2000 CPY 2001 4        # Load array size (5)
2001 CPY 2002 5                  # Load search key (25)
2002 SET 2003 6                  # Array start address (2003)
2003 SET 0 7                     # Search counter
2004 SET -1 2008                      # Initialize result to -1 (not found)

# Search loop
2005 CPY 7 8                # Copy counter
2006 SUBI 4 8               # temp5 = array_size - counter (keep SUBI as is)
2007 JIF 8 2050                  # Exit if counter >= array_size

2008 CPY 6 9                # Copy array base
2009 ADD 9 7                # Add counter offset
2010 CPYI 9 10              # ✅ FIXED: Get current element using indirect copy

# Compare with key
2011 CPY 10 11              # Copy element
2012 SUBI 5 11              # param2 = key - element (keep SUBI as is)
2013 JIF 11 2040                 # If not equal, continue

# Found element
2014 SET 7 2008                  # Store found index
2015 SET 2050 0                     # Exit search

2040 ADD 7 1                     # Increment counter
2041 SYSCALL YIELD                    # ✅ Yield CPU for cooperative scheduling
2042 SET 2005 0                     # Continue search

2050 CPYI 2008 10                # ✅ FIXED: Get result using indirect copy
2051 SYSCALL PRN 10              # ✅ FIXED: Print result value
2052 SYSCALL HLT                      # Thread complete



# Thread 3: Factorial Calculator - FIXED FOR ARCHITECTURE
3000 CPY 3001 4        # Load factorial input (5)
3001 SET 1 3002                       # Initialize result to 1
3002 SET 1 5                     # Initialize counter to 1

# Factorial loop
3003 CPY 5 6                # Copy counter
3004 SUBI 4 6               # temp3 = input - counter (keep SUBI as is)
3005 JIF 6 3050                  # Exit if counter > input

# Multiply result by counter
3006 CPYI 3002 7                 # ✅ FIXED: Load current result using indirect copy
3007 SET 0 8                     # Initialize multiplication result
3008 CPY 5 9                # Copy counter for multiplication

# Multiplication by addition loop
3009 JIF 9 3030                  # Exit if multiplier = 0
3010 ADD 8 7                # Add result to accumulator
3011 ADD 9 -1                    # Decrement multiplier
3012 SYSCALL YIELD                    # ✅ Yield CPU during multiplication
3013 SET 3009 0                     # Continue multiplication

3030 SET 8 3002                  # Store multiplication result
3031 ADD 5 1                     # Increment counter
3032 SYSCALL YIELD                    # ✅ Yield CPU between factorial iterations
3033 SET 3003 0                     # Continue factorial loop

3050 CPYI 3002 10                # ✅ FIXED: Get factorial result using indirect copy
3051 SYSCALL PRN 10              # ✅ FIXED: Print factorial result value
3052 SYSCALL HLT                      # Thread complete



End Instruction Section
