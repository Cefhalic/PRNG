#include <stdint.h>
#include <iostream>

#include <array>


using FnPtr64 = uint64_t (*)();

template< int N >
class xorchain
{
private:
  std::array< uint64_t , N > A , B ;
  FnPtr64 mGenA , mGenB;

public:
  xorchain( FnPtr64 aGenA , FnPtr64 aGenB ) : A{} , B{} , mGenA( aGenA ) , mGenB( aGenB )
  {}

  inline void operator() ()
  {
    B[0] = mGenA() xor A[1];
    for( int i(1) ; i!= N-2 ; ++i ) B[i] = A[i-1] xor A[i+1];
    B[N-1] = A[N-2] xor mGenB();

    A.swap( B );
  }

  inline uint64_t operator[] ( const uint32_t& aIndex )
  {
    return A[aIndex];
  }

};
