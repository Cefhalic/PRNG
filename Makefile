SOURCES = src/test.cxx
EXECUTABLE = xoshirotest.exe

${EXECUTABLE} : ${SOURCES} 
	g++ -std=c++11 -Wall -O3 $^ -ITestU01/include -LTestU01/lib -ltestu01 -lprobdist -lmylib -lm -o $@
