

.PHONY: all _all # clean _cleanall

default: all

# clean: _cleanall
# _cleanall:
# 	rm -rf obj lib bin sbin elements

all: _all
build: _all
buildall: _all
_all: xoshirotest.exe PractRand/RNG_test.exe



TestU01/lib/libtestu01.a : 
	mkdir -p TestU01/lib-so; \
	cd TestU01; \
	curl -OL http://simul.iro.umontreal.ca/testu01/TestU01.zip; \
	unzip -q TestU01.zip; \
	cd TestU01-1.2.3; \
	./configure --prefix=${PWD}/TestU01/; \
	make -j 8; make -j 8 install; \
	mv ../lib/*.so ../lib-so/


PractRand/RNG_test.exe :
	mkdir -p PractRand/obj; \
	cd PractRand; \
	curl -OL https://downloads.sourceforge.net/project/pracrand/PractRand-pre0.95.zip; \
	unzip -q PractRand-pre0.95.zip; \
	g++ -std=c++11 -c src/*.cpp src/RNGs/*.cpp src/RNGs/other/*.cpp -O3 -Iinclude -pthread; \
	mv *.o obj; \
	g++ -std=c++11 -o RNG_test.exe tools/RNG_test.cpp obj/*.o -O3 -Iinclude -pthread


xoshirotest.exe : src/test.cxx | TestU01/lib/libtestu01.a 
	g++ -std=c++11 -Wall -O3 $^ -ITestU01/include -LTestU01/lib -ltestu01 -lprobdist -lmylib -lm -o $@
