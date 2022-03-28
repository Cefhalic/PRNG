#include <stdint.h>
#include <array>
#include "utils.cpp"
// #include <random>

/* This is xoshiro256** 1.0, one of our all-purpose, rock-solid generators. 
   It has excellent (sub-ns) speed, a state (256 bits) that is large enough 
   for any parallel application, and it passes all tests we are aware of.

   For generating just floating-point numbers, xoshiro256+ is even faster.

   The state must be seeded so that it is not everywhere zero. If you have
   a 64-bit seed, we suggest to seed a splitmix64 generator and use its
   output to fill s. */

// static std::mt19937 rng(42);

typedef unsigned __int128 uint128_t;

class xoshiro256float
{
private:
  std::array< uint64_t , 4 > s;
  std::array< uint64_t , 3 > t;
  
  struct FloatUtil { 
    uint16_t  Exponent;
    uint128_t Mantissa;
  };

  std::array< FloatUtil , 7 > u;


public:
  xoshiro256float() : s{ 0x0123456789ABCDEF , 0xFEDCBA9876543210 , 0xF0E1D2C3B4A59687 , 0x78695A4B3C2D1E0F },
  t{ 0 , 0 , 0 },
  u{ FloatUtil{0,0} , FloatUtil{0,0} , FloatUtil{0,0} , FloatUtil{0,0} , FloatUtil{0,0} , FloatUtil{0,0} , FloatUtil{0,0} }
  {    
    for( uint32_t i( 7 ) ; i!= 0 ; --i ) (*this)(); // The first 7 clock-cycles are invalid
  }

  inline double operator() ()
  {

    for( uint32_t i( 7 ) ; i!= 0 ; --i )
    {
      uint32_t size = (1<<(7-i));
      u[i] = ( ( u[i-1].Mantissa >> (128-size) ) == 0 ) ? FloatUtil{ u[i-1].Exponent - size , u[i-1].Mantissa << size } : u[i-1];    
    }
    u[0] = { 1022 , (uint128_t)(s[3])<<64 | s[1] };


    //int32_t lRes = ( (uint32_t)(u[7].Exponent) << 23 ) | ( t[2] >> 41 );
    int64_t lRes = ( (uint64_t)(u[7].Exponent) << 52 ) | ( t[2] >> 12 );

    // std::cout << ( (uint64_t)(u[7].Exponent) << 52 ) << " | " << ( t[2] >> 12 ) << std::endl; 

    t = { s[1] * 5 , rotl( t[0] , 7 ) , t[1] * 9 };

    std::array< uint64_t , 2 > smin = { s[2] ^ s[0] , s[3] ^ s[1] };
    s = { s[0] ^ smin[1] , s[1] ^ smin[0] , smin[0] ^ ( s[1] << 17 ) , rotl( smin[1] , 45) };


    return reinterpret_cast< double& >( lRes );
  }

};
