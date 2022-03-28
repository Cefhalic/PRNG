#include <iostream>

#include "xoshiro.cpp"
#include "utils.cpp"

#include "boost/program_options.hpp"
namespace po = boost::program_options;

/* ===== For TestU01 ===== */
extern "C"
{
#include "TestU01.h"
};

/* ===== For PractRand ===== */
#include <cstdio>
#include <unistd.h>


xoshiro x;

int main(int argc, char **argv)
{
    bool Help( false );
    uint32_t TestSuite(-1) , Bits(-1);

    po::options_description lDesc("General options");
    lDesc.add_options()
    ( "help",  po::bool_switch( &Help ) , "Produce help message" )
    ( "suite", po::value( &TestSuite )  , "Test-suite (0 = SmallCrush , 1 = Crush , 2 = BigCrush , 3 = PractRand stream)" )
    ( "bits",  po::value( &Bits )       , "Bits (0 = Low32 , 1 = High32 , 2 = Low32-reversed , 3 = High32-reversed)" );
    

    po::variables_map lVm;
    po::store( po::command_line_parser( argc , argv ).options( lDesc ).run() , lVm );
    po::notify( lVm ); 

    if( Help )
    {
        std::cout << lDesc << std::endl;
        exit(0);
    }

    if( TestSuite < 3 )
    {
        /* ===== For TestU01 ===== */
        if( Bits > 3 )
        { 
            std::cout << lDesc << std::endl;            
            throw std::runtime_error( "Illegal value for bits" );
        }

        char* lName = (char*)( "Xorshiro**" );
        FnPtr32 lPtr[4] = { [](){ return low32( x() ); } ,
                            [](){ return high32( x() ); } ,
                            [](){ return rev32( low32( x() ) ); } ,
                            [](){ return rev32( high32( x() ) ); } };

        FnTestSuite lSuite[3] = { &bbattery_SmallCrush , &bbattery_Crush , &bbattery_BigCrush };

        unif01_Gen* lGenerator = unif01_CreateExternGenBits( lName , lPtr[ Bits ] );
        ( *lSuite[ TestSuite ] )( lGenerator );
        unif01_DeleteExternGenBits( lGenerator );
        /* ===== For TestU01 ===== */
    }
    else if( TestSuite == 3 )
    {
        /* ===== For PractRand ===== */
        constexpr size_t BUFFER_SIZE = ( 1<<6 );
        static uint64_t buffer[BUFFER_SIZE];

        while (1) {
            for (size_t i = 0; i != BUFFER_SIZE; ++i) buffer[i] = x();
            fwrite((void*) buffer, sizeof(buffer[0]), BUFFER_SIZE, stdout);
        }
        /* ===== For PractRand ===== */
    }
    else
    {
        std::cout << lDesc << std::endl;
        throw std::runtime_error( "Illegal value for test-suite" );
    }

    return 0;
}

