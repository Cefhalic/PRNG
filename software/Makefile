# Files for executables
EXECUTABLE_SOURCES = $(sort $(wildcard src/*.cxx) )
EXECUTABLE_OBJECT_FILES = $(patsubst src/%.cxx,obj/%.o,${EXECUTABLE_SOURCES})
EXECUTABLES = $(patsubst src/%.cxx,bin/%.exe,${EXECUTABLE_SOURCES})

DIRECTORIES = obj bin

.PHONY: all _all clean _cleanall

default: all
all: _all
build: _all
buildall: _all
_all: PractRand/RNG_test.exe ${EXECUTABLES}
	# /usr/bin/root-config

clean: _cleanall
_cleanall:
	rm -rf ${DIRECTORIES}

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


GJrand/lib/gjrand.a :
	mkdir -p GJrand/{lib,lib-so}; \
	cd GJrand; \
	curl -OL  https://sourceforge.net/projects/gjrand/files/gjrand/gjrand.3.4.4/gjrand.3.4.4.tar.bz2; \
	tar --strip-components=1 -xjf gjrand.3.4.4.tar.bz2 && rm gjrand.3.4.4.tar.bz2; \
 	cd src/; \
	./compile; \
	mv *.a ../lib; \
	mv *.so ../lib-so


# /usr/bin/root-config:
# 	sudo yum install -y epel-release
# 	sudo yum install -y root

${DIRECTORIES}:
	mkdir -p $@

.SECONDEXPANSION:
obj/%.o : src/%.cxx | obj
	g++ -march=native -std=c++11 -c ${FLAGS} -Iinclude -ITestU01/include -fPIC -MMD -MP $< -o $@
	# `root-config --cflags`

-include $(EXECUTABLE_OBJECT_FILES:.o=.d)

${EXECUTABLES}: bin/%.exe : obj/%.o | TestU01/lib/libtestu01.a GJrand/lib/gjrand.a bin
	g++ -march=native -std=c++11 -MMD -MP -Wall -O3 $^ -LTestU01/lib -ltestu01 -lprobdist -lmylib -lm -lboost_program_options -o $@
	# `root-config --glibs --libs`
