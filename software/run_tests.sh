rm ${PWD}/batch_output/*.txt

# Suite 0=SmallCrush, 1=Crush, 2=BigCrush
# Bits 0=Low32, 1=High32, 2=Low32-reversed, 3=High32-reversed
for suite in {0..2}; do
  for bits in {0..3}; do
    qsub -N suite-${suite}.bits-${bits} -j y -o ${PWD}/batch_output/suite-${suite}.bits-${bits}.txt -b y ${PWD}/test_bits.exe --suite ${suite} --bits ${bits}
  done
done

# Suite 3=PractRand
qsub -N suite-3 -j y -o ${PWD}/batch_output/suite-3.txt -b y ./test_bits.exe --suite 3 | ./PractRand/RNG_test.exe stdin64
