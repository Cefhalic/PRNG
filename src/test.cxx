#include "xoshiro.cpp"
#include "utils.cpp"

/* ===== For TestU01 ===== */
extern "C"
{
#include "TestU01.h"
};

/* ===== For PractRand ===== */
#include <cstdio>


int main()
{
    char* lName = (char*)( "Xorshiro**" );

//    FnPtr32 lPtr = [](){ return interleave( xoshiro ); }; // interleave takes a function-pointer to the generator
    // FnPtr32 lPtr = [](){ return low32( xoshiro ); };
    // FnPtr32 lPtr = [](){ return high32( xoshiro ); };
    FnPtr32 lPtr = [](){ return rev32( low32( xoshiro ) ); };
    // FnPtr32 lPtr = [](){ return rev32( high32( xoshiro ) ); };


/* ===== For TestU01 ===== */
    // // Create TestU01 PRNG object for our generator
    // unif01_Gen* gen = unif01_CreateExternGenBits( lName , lPtr );

    // // Run the tests.
    // bbattery_SmallCrush(gen);
    // //bbattery_Crush(gen);

    // // Clean up.
    // unif01_DeleteExternGenBits(gen);
/* ===== For TestU01 ===== */


/* ===== For PractRand ===== */
    constexpr size_t BUFFER_SIZE = ( 1<<6 );
    static uint32_t buffer[BUFFER_SIZE];

    while (1) {
        for (size_t i = 0; i != BUFFER_SIZE; ++i) buffer[i] = (*lPtr)();
        fwrite((void*) buffer, sizeof(buffer[0]), BUFFER_SIZE, stdout);
    }
/* ===== For PractRand ===== */


    return 0;
}

