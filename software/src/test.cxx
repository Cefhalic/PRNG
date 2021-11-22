#include "xoshiro.cpp"
#include "xorchain.cpp"
#include "utils.cpp"

/* ===== For TestU01 ===== */
extern "C"
{
#include "TestU01.h"
};

/* ===== For PractRand ===== */
#include <cstdio>
#include <unistd.h>

#include <iostream>
#include <iomanip>


FnPtr64 lGen1 = [](){ static xoshiro x; return x(); };
FnPtr64 lGen2 = [](){ static xoshiro x; return x(); };

FnPtr64 lGen3 = [](){ static xorchain<4> x( lGen1 , lGen2 ); x(); return x[1]; };


int main()
{
    char* lName = (char*)( "Xorshiro**" );


    // for( int i(0) ; i!=100 ; ++i ) std::cout << std::hex << std::setw(16) << lGen() << " " << std::setw(16) << lGen2() << std::endl;

    FnPtr32 lPtr1 = [](){ return interleave( lGen3 ); }; // interleave takes a function-pointer to the generator
    // FnPtr32 lPtr2 = [](){ return low32( lGen1 ); };
    // FnPtr32 lPtr3 = [](){ return high32( lGen1 ); };
    // FnPtr32 lPtr4 = [](){ return rev32( low32( lGen1 ) ); };
    // FnPtr32 lPtr5 = [](){ return rev32( high32( lGen1 ) ); };

/* ===== For TestU01 ===== */
    unif01_Gen* gen = unif01_CreateExternGenBits( lName , lPtr1 );
    bbattery_SmallCrush(gen);
    //bbattery_Crush(gen);
    unif01_DeleteExternGenBits(gen);
/* ===== For TestU01 ===== */

// // if ( isatty(fileno(stdout)) ) {
// //   throw std::runtime_error( "Output must not be the terminal for PractRand" );
// }

/* ===== For PractRand ===== */
    // constexpr size_t BUFFER_SIZE = ( 1<<6 );
    // static uint32_t buffer[BUFFER_SIZE];

    // while (1) {
    //     for (size_t i = 0; i != BUFFER_SIZE; ++i) buffer[i] = (*lPtr)();
    //     fwrite((void*) buffer, sizeof(buffer[0]), BUFFER_SIZE, stdout);
    // }
/* ===== For PractRand ===== */


    return 0;
}


