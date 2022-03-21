#include <iostream>

#include "xoshiro256float.cpp"
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


xoshiro256float x;

int main(int argc, char **argv)
{
    bool Help( false );
    uint32_t TestSuite(-1);

    po::options_description lDesc("General options");
    lDesc.add_options()
    ( "help",  po::bool_switch( &Help ) , "Produce help message" )
    ( "suite", po::value( &TestSuite )  , "Test-suite (0 = SmallCrush , 1 = Crush , 2 = BigCrush )" );
    ;

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
        char* lName = (char*)( "Xorshiro256float" );
        FnPtrDbl lPtr = [](){ return rev32( high32( x() ) ); };

        FnTestSuite lSuite[3] = { &bbattery_SmallCrush , &bbattery_Crush , &bbattery_BigCrush };

        unif01_Gen* lGenerator = unif01_CreateExternGen01( lName , lPtr );
        ( *lSuite[ TestSuite ] )( lGenerator );
        unif01_DeleteExternGen01( lGenerator );
        /* ===== For TestU01 ===== */
    }
    else
    {
        std::cout << lDesc << std::endl;
        throw std::runtime_error( "Illegal value for test-suite" );
    }

    return 0;
}


