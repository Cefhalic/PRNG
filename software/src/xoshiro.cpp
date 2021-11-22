#include <stdint.h>
#include <array>
#include <random>

/* This is xoshiro256** 1.0, one of our all-purpose, rock-solid generators. 
   It has excellent (sub-ns) speed, a state (256 bits) that is large enough 
   for any parallel application, and it passes all tests we are aware of.

   For generating just floating-point numbers, xoshiro256+ is even faster.

   The state must be seeded so that it is not everywhere zero. If you have
   a 64-bit seed, we suggest to seed a splitmix64 generator and use its
   output to fill s. */

static inline uint64_t rotl( const uint64_t& x, const int& k ) {
  return (x << k) | (x >> (64 - k));
}

static std::mt19937 rng(42);

class xoshiro
{
private:
  std::array< uint64_t , 4 > s;

public:
  xoshiro() : s{ rng() , rng() , rng() , rng() }
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
