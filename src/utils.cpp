#include <stdint.h>

using FnPtr32 = uint32_t (*)();
using FnPtr64 = uint64_t (*)();


inline uint32_t rev32( uint32_t v )
{
    // https://graphics.stanford.edu/~seander/bithacks.html
    v = ((v >>  1) & 0x55555555) | ((v & 0x55555555) <<  1); // swap odd and even bits
    v = ((v >>  2) & 0x33333333) | ((v & 0x33333333) <<  2); // swap consecutive pairs
    v = ((v >>  4) & 0x0F0F0F0F) | ((v & 0x0F0F0F0F) <<  4); // swap nibbles ...
    v = ((v >>  8) & 0x00FF00FF) | ((v & 0x00FF00FF) <<  8); // swap bytes
    v = ( v >> 16              ) | ( v               << 16); // swap 2-byte-long pairs
    return v;
}

inline uint32_t high32( const uint64_t& v )
{
  return (uint32_t)(v >> 32);
}

inline uint32_t low32( const uint64_t& v )
{
  return (uint32_t)(v);
}

inline uint32_t interleave( FnPtr64 gen64 )
{
  static uint64_t lVal = 0;
  static bool lPhase = false;
  lPhase = not lPhase;

  if( lPhase )
  { 
    lVal = (*gen64)();
    return high32(lVal);
  }
  else
  {
    return low32(lVal);
  }
}

// Utility wrapper taking a function pointer, rather than a uint32_t
inline uint32_t high32( FnPtr64 gen64 )
{
  return high32( (*gen64)() );
}

// Utility wrapper taking a function pointer, rather than a uint32_t
inline uint32_t low32( FnPtr64 gen64 )
{
  return low32( (*gen64)() );
}
