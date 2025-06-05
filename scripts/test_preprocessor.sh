#!/bin/bash

echo "Testing GTU-C312 Preprocessor..."

# Create output directory
mkdir -p output

# Test 1: Basic preprocessing
echo "Test 1: Basic preprocessing"
./tools/preprocessor programs/test_input.asm output/test_basic.asm -v
if [ $? -eq 0 ]; then
    echo "✓ Basic test passed"
else
    echo "✗ Basic test failed"
fi

# Test 2: Complex preprocessing with defines
echo "Test 2: Complex preprocessing"
./tools/preprocessor programs/complex_test.asm output/test_complex.asm -v -DENABLE_FACTORIAL=1
if [ $? -eq 0 ]; then
    echo "✓ Complex test passed"
else
    echo "✗ Complex test failed"
fi

# Test 3: Conditional compilation
echo "Test 3: Conditional compilation"
./tools/preprocessor programs/complex_test.asm output/test_conditional.asm -v -DDISABLE_DEBUG=1
if [ $? -eq 0 ]; then
    echo "✓ Conditional test passed"
else
    echo "✗ Conditional test failed"
fi

# Test 4: Run preprocessed code through simulator
echo "Test 4: Running preprocessed code"
./src/simulator output/test_basic.asm -D 1
if [ $? -eq 0 ]; then
    echo "✓ Simulation test passed"
else
    echo "✗ Simulation test failed"
fi

echo "All tests completed!"
