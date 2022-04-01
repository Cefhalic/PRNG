#include <iostream>
#include <iomanip>
#include <vector>
#include <string>
#include <map>

#include "xoshiro.cpp"
#include "xoshiro256float.cpp"
#include "xorchain.cpp"
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

// bool gHelp( false );

// enum TestSuite { SmallCrush = 0 , Crush = 1 , BigCrush = 2 , PractRand = 3 , UnknownSuite = -1 };
// const std::map< std::string , TestSuite > TestSuiteMap = { {"SmallCrush",SmallCrush} , {"Crush",Crush} , {"BigCrush",BigCrush} , {"PractRand",PractRand} };

// enum Bits { Hi32 = 0 , Lo32 = 1 , Hi32Rev = 2 , Low32Rev = 3 , UnknownBits = -1 };
// const std::map< std::string , Bits > BitsMap = { {"Hi32",Hi32} , {"Lo32",Lo32} , {"Hi32Rev",Hi32Rev} , {"Low32Rev",Low32Rev} };




// void Parse( std::vector< std::string >& aArgs , po::options_description_easy_init& aDesc )
// {
//     bool lHelp( false );
//     aDesc( "help", po::bool_switch( &lHelp ) , "Produce help message" );

//     // This is a really filthy hack to get around the fact that the po::options_description_easy_init has the owner as a private member
//     struct Hack{ po::options_description* owner; };
//     auto lDesc = reinterpret_cast<Hack*>( &aDesc )->owner;

//     auto lParsed = po::command_line_parser( aArgs ).options( *lDesc ).allow_unregistered().run();
//     po::variables_map lVm;
//     po::store( lParsed , lVm );
//     po::notify( lVm ); 

//     auto lUnused = po::collect_unrecognized( lParsed.options , po::include_positional );

//     if( ( gHelp or lHelp ) and ( aArgs.size() - lUnused.size() < 2 ) )
//     {
//         std::cout << *lDesc << std::endl;
//         exit(0);
//     }

//     gHelp |= lHelp;

//     std::swap ( lUnused , aArgs );
// }



// // void PractRandStream()
// // {
// //     constexpr size_t BUFFER_SIZE = ( 1<<6 );
// //     static uint64_t buffer[BUFFER_SIZE];

// //     while (1) {
// //         for (size_t i = 0; i != BUFFER_SIZE; ++i) buffer[i] = x();
// //         fwrite((void*) buffer, sizeof(buffer[0]), BUFFER_SIZE, stdout);
// //     }    
// // }



    

// void TestDouble( std::vector< std::string >& aArgs , const bool& aStdIn )
// {
//     TestSuite lTestSuite( UnknownSuite );     
//     Parse( lArgs , po::options_description( "Double options" ).add_options()( "suite" , po::value<std::string>()->notifier( [&]( const std::string& aArg ){ auto lIt = TestSuiteMap.find( aArg ); if( lIt == TestSuiteMap.end() ) throw std::runtime_error( "Unknown test-suite." ); lTestSuite = lIt->second; } ) , "Options are [ SmallCrush , Crush , BigCrush ]" ) );
//     if( lTestSuite == PractRand )  throw std::runtime_error( "Unknown test-suite." );   

    


// }

// void TestInt( std::vector< std::string >& aArgs , const bool& aStdIn )
// {
//     TestSuite lTestSuite( UnknownSuite );     
//     Parse( lArgs , po::options_description( "Int64 options" ).add_options() ( "suite" , po::value<std::string>()->notifier( [&]( const std::string& aArg ){ auto lIt = TestSuiteMap.find( aArg ); if( lIt == TestSuiteMap.end() ) throw std::runtime_error( "Unknown test-suite." ); lTestSuite = lIt->second; } ) , "Options are [ SmallCrush , Crush , BigCrush , PractRand ]" ) );

//     xoshiro x;


// }

// //   // xoshiro x;



// int main(int argc, char **argv)
// {
//     std::vector< std::string > lArgs( argv+1 , argv+argc );

//     // Select the data-type
//     bool lDouble( false ) , lInt( false ) , lStdIn( false );
//     Parse( lArgs , po::options_description( "General options" ).add_options()
//                    ( "double", po::bool_switch( &lDouble ) , "Test double-precision floating point" )
//                    ( "int64",  po::bool_switch( &lInt ) ,    "Test 64-bit integer" ) 
//                    ( "stdin",  po::bool_switch( &lStdIn ) ,  "Use stdin instead of internal generator" ) );

//     // -----------------------------------------------------------------------------------------------
//     // Select the test-suite based on the data-type
//     if( lDouble and lInt ) throw std::runtime_error( "Options 'double' and 'int64' are mutually exclusive." );
//     else if( lDouble ) TestDouble( lArgs , lStdIn );
//     else if( lInt ) TestInt( lArgs , lStdIn );
//     else throw std::runtime_error( "Either 'double' or 'int64' is required." );

//     if( lTestSuite == UnknownSuite ) throw std::runtime_error( "Option --suite is required." );
//     // -----------------------------------------------------------------------------------------------


//     // -----------------------------------------------------------------------------------------------
//     // Select the bits to be tested if we are using TestU01
//     Bits lBits( UnknownBits );
//     if( lInt and ( lTestSuite < PractRand ) ) // SmallCrush, Crush or BigCrush
//     {
//         Parse( lArgs , po::options_description( "Crush options" ).add_options() ( "bits" , po::value<std::string>()->notifier( [&]( const std::string& aArg ){ auto lIt = BitsMap.find( aArg ); if( lIt == BitsMap.end() ) throw std::runtime_error( "Unknown bits." ); lBits = lIt->second; } ) , "Options are [ Hi32 , Lo32 , Hi32Rev , Lo32Rev ]" ) );
//         if( lBits == UnknownBits ) throw std::runtime_error( "Option --bits is required." );
//     }
//     // -----------------------------------------------------------------------------------------------


//     // if( TestSuite < 3 )
//     // {
//     //     /* ===== For TestU01 ===== */
//     //     if( Bits > 3 )
//     //     { 
//     //         std::cout << lDesc << std::endl;            
//     //         throw std::runtime_error( "Illegal value for bits" );
//     //     }

//     //     char* lName = (char*)( "Xorshiro**" );
//     //     FnPtr32 lPtr[4] = { [](){ return low32( x() ); } ,
//     //                         [](){ return high32( x() ); } ,
//     //                         [](){ return rev32( low32( x() ) ); } ,
//     //                         [](){ return rev32( high32( x() ) ); } };

//     //     FnTestSuite lSuite[3] = { &bbattery_SmallCrush , &bbattery_Crush , &bbattery_BigCrush };

//     //     unif01_Gen* lGenerator = unif01_CreateExternGenBits( lName , lPtr[ Bits ] );
//     //     ( *lSuite[ TestSuite ] )( lGenerator );
//     //     unif01_DeleteExternGenBits( lGenerator );
//     //     /* ===== For TestU01 ===== */
//     // }
//     // else if( TestSuite == 3 )
//     // {
//     //     /* ===== For PractRand ===== */
//     //     constexpr size_t BUFFER_SIZE = ( 1<<6 );
//     //     static uint64_t buffer[BUFFER_SIZE];

//     //     while (1) {
//     //         for (size_t i = 0; i != BUFFER_SIZE; ++i) buffer[i] = x();
//     //         fwrite((void*) buffer, sizeof(buffer[0]), BUFFER_SIZE, stdout);
//     //     }
//     //     /* ===== For PractRand ===== */
//     // }
//     // else
//     // {
//     //     std::cout << lDesc << std::endl;
//     //     throw std::runtime_error( "Illegal value for test-suite" );
//     // }

//     return 0;
// }














/* ===== For Root ===== */
// #include "TH2F.h"
// #include "TCanvas.h"
// #include "TROOT.h"
// #include "TStyle.h"
// #include "TApplication.h"
// #include "TRootCanvas.h"


// FnPtr64 lGen1 = [](){ static xoshiro x; return x(); };
// FnPtr64 lGen2 = [](){ static xoshiro x; return x(); };

// FnPtr64 lGen3 = [](){ static xorchain<4> x( lGen1 , lGen2 ); x(); return x[2]; };

xoshiro256float lXoshiro2; 
// xoshiro         lXoshiro;

int main(int argc, char **argv)
{
    FnPtrDbl lPtr = [](){ return (double) lXoshiro2(); };

    // std::cout << std::hex << std::scientific;
    // for( int i(0) ; i!=1000 ; ++i ){ 
    //     auto lVal = (*lPtr)();
    //     std::cout << std::setw(16) << reinterpret_cast< int64_t& >(lVal) << " " << lVal << std::endl;
    // }



char* lName = (char*)( "Xorshiro256Float" );
// // FnPtrDbl lPtr = [](){ return (double)(lXoshiro() >> 11) * 0x1.0p-53; };  // Passes
// // FnPtrDbl lPtr = [](){ float lVal = (double)(lXoshiro() >> 11) * 0x1.0p-53; return (double)( lVal ); };   // Fails

// //FnPtrDbl lPtr = [](){ float lVal = (double)(lXoshiro() >> 40) * 0x1.0p-24; return (double)( lVal ); };   // Fails


/* ===== For TestU01 ===== */
    unif01_Gen* gen = unif01_CreateExternGen01( lName , lPtr );
    //bbattery_SmallCrush(gen);
    bbattery_Crush(gen);

    unif01_DeleteExternGen01(gen);
/* ===== For TestU01 ===== */



    // std::cout << std::hex << std::setfill('0');
    // for( auto i(0) ; i!= 16 ; ++i )
    // {
    //     // std::cout << std::setw(16) << lXoshiro() << " | " << std::setw(16) << lXoshiro2() << std::endl;
    //     std::cout << lXoshiro2() << std::endl;
    // }


//   TApplication app("app", &argc, argv);

//   // gROOT->Reset ( ) ; // re−initialize ROOT
//   // gROOT->SetStyle ( "Plain" ) ; // set empty TStyle ( nicer o npaper )
//   gStyle->SetOptStat ( 0 ) ; // print statistics on plots , ( 0 ) for no output
//   gStyle->SetOptFit ( 1111 ) ; // print fit results on plot , ( 0 ) for no ouput
//   // gStyle->SetPalette ( 1 ) ; // set nicer colors than default
//   // gStyle->SetOptTitle ( 0 ) ; // suppress title box



//     constexpr uint32_t N( 4 );


//     TCanvas* c = new TCanvas("c", "Something", 0, 0, 800, 600);
//     c->Divide( N-1 , N-2 );

//     std::array< TH2F* , int( 0.5 * (N-1) * N ) > lHists{}; 
//     {
//       uint32_t lIndex(0);
//       for( int i(0) ; i!=N-1 ; ++i )
//       {
//         for( int j(i+1) ; j!=N ; ++j )
//         {
//           std::string lLabel = "h"+std::to_string(i)+std::to_string(j);
//           lHists[lIndex] = new TH2F( lLabel.c_str() , lLabel.c_str() , 101, 0.0 , 1.0 , 101, 0.0 , 1.0 );
//           lIndex++;
//         }        
//       }
//     }

//     xorchain< N > x( lGen1 , lGen2 );
//     for( int e(0) ; e!= 1e3 ; ++e )
//     {
//       x();
//       uint32_t lIndex(0);
//       for( int i(0) ; i!=N-1 ; ++i )
//       {
//         for( int j(i+1) ; j!=N ; ++j )
//         {
//           if ( lHists[ lIndex ] == NULL ) throw std::runtime_error( "Null" );
//           lHists[ lIndex ]->Fill( (x[i] >> 11) * 0x1.0p-53  , (x[j] >> 11) * 0x1.0p-53 );
//           lIndex++;
//         }        
//       }
      
//     }


//     {
//       uint32_t lIndex(0);
//       for( int i(0) ; i!=N-1 ; ++i )
//       {
//         for( int j(i+1) ; j!=N ; ++j )
//         {
//           c->cd(lIndex+1);
//           // lHists[lIndex]->SetLineWidth( 1 );
//           // lHists[lIndex]->Fit("gaus");
//           lHists[lIndex]->Draw();
//           lIndex++;
//         }        
//       }
//     }

// //    c->Print("demo1.pdf");


    // for( int i(0) ; i!=100 ; ++i ) std::cout << std::hex << std::setw(16) << lGen() << " " << std::setw(16) << lGen2() << std::endl;


//     char* lName = (char*)( "Xorshiro**" );

//     // FnPtr32 lPtr = [](){ return interleave( lGen3 ); }; // interleave takes a function-pointer to the generator
//     FnPtr32 lPtr = [](){ return low32( lGen1 ); };
//     // FnPtr32 lPtr = [](){ return high32( lGen1 ); };
//     // FnPtr32 lPtr = [](){ return rev32( low32( lGen1 ) ); };
//     // FnPtr32 lPtr = [](){ return rev32( high32( lGen1 ) ); };

// /* ===== For TestU01 ===== */
//     unif01_Gen* gen = unif01_CreateExternGenBits( lName , lPtr );
//     //bbattery_SmallCrush(gen);
//     bbattery_Crush(gen);
//     unif01_DeleteExternGenBits(gen);
// /* ===== For TestU01 ===== */

// // // if ( isatty(fileno(stdout)) ) {
// // //   throw std::runtime_error( "Output must not be the terminal for PractRand" );
// // }

// /* ===== For PractRand ===== */
//     // constexpr size_t BUFFER_SIZE = ( 1<<6 );
//     // static uint32_t buffer[BUFFER_SIZE];

//     // while (1) {
//     //     for (size_t i = 0; i != BUFFER_SIZE; ++i) buffer[i] = (*lPtr)();
//     //     fwrite((void*) buffer, sizeof(buffer[0]), BUFFER_SIZE, stdout);
//     // }
// /* ===== For PractRand ===== */


//    // TRootCanvas *rc = (TRootCanvas *)c->GetCanvasImp();
//    // rc->Connect("CloseWindow()", "TApplication", gApplication, "Terminate()");
//    // app.Run();

    return 0;
}


