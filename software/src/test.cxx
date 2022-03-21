// #include <iostream>
// #include <iomanip>

// #include "xoshiro.cpp"
// #include "xoshiro256float.cpp"
// #include "xorchain.cpp"
// #include "utils.cpp"

/* ===== For TestU01 ===== */
// extern "C"
// {
// #include "TestU01.h"
// };

/* ===== For PractRand ===== */
// #include <cstdio>
// #include <unistd.h>

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

// xoshiro256float lXoshiro2; 
// xoshiro         lXoshiro;

int main(int argc, char **argv)
{
//    FnPtrDbl lPtr = [](){ return (double) lXoshiro2(); };


// char* lName = (char*)( "Xorshiro256Float" );
// //    FnPtrDbl lPtr = [](){ return (double)(lXoshiro() >> 11) * 0x1.0p-53; };  // Passes
// //FnPtrDbl lPtr = [](){ float lVal = (double)(lXoshiro() >> 11) * 0x1.0p-53; return (double)( lVal ); };   // Fails

// /* ===== For TestU01 ===== */
//     unif01_Gen* gen = unif01_CreateExternGen01( lName , lPtr );
//     //bbattery_SmallCrush(gen);
//     bbattery_Crush(gen);
//     unif01_DeleteExternGen01(gen);
// /* ===== For TestU01 ===== */



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


