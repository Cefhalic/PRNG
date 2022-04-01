#include <stdint.h>
#include <array>
#include "utils.cpp"
// #include <random>

/* This is Xoshiro64bit256** 1.0, one of our all-purpose, rock-solid generators. 
   It has excellent (sub-ns) speed, a state (256 bits) that is large enough 
   for any parallel application, and it passes all tests we are aware of.

   For generating just floating-point numbers, Xoshiro64bit256+ is even faster.

   The state must be seeded so that it is not everywhere zero. If you have
   a 64-bit seed, we suggest to seed a splitmix64 generator and use its
   output to fill s. */

// static std::mt19937 rng(42);

class Xoshiro64bit
{
private:
  std::array< uint64_t , 4 > s;

public:
  Xoshiro64bit() : s{ 0x0123456789ABCDEF , 0xFEDCBA9876543210 , 0xF0E1D2C3B4A59687 , 0x78695A4B3C2D1E0F }
  {}

  inline uint64_t operator() ()
  {
    const uint64_t lResult = rotl(s[1] * 5, 7) * 9;
    const uint64_t lTemporary = s[1] << 17;

    s[2] ^= s[0];
    s[3] ^= s[1];
    s[1] ^= s[2];
    s[0] ^= s[3];

    s[2] ^= lTemporary;
    s[3] = rotl(s[3], 45);

    return lResult;
  }

};
