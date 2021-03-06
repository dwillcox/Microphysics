module microphysics_math_module

  implicit none

  public

contains

  ! Implementation of the exact summation routine from:
  ! https://code.activestate.com/recipes/393090/

  ! This function computes the sum of an array of
  ! double precision numbers with a result that is
  ! exact to the precision of the arithmetic.
  ! It does this by keeping a running array of
  ! partial sums, where each individual sum is split
  ! between the result and the associated roundoff error,
  ! such that all of the components of the partial
  ! sums array are exactly correct and in increasing
  ! order so that the final summation is also exact.
  ! The idea comes from the paper by Andrew Shewchuk,
  ! "Adaptive Precision Floating-Point Arithmetic and
  ! Fast Robust Geometric Predicates," in Discrete
  ! & Computational Geometry (1997), 18, 305.
  ! http://www.cs.berkeley.edu/~jrs/papers/robustr.pdf
  
  ! This routine should give the same results
  ! (up to the machine epsilon in double precision)
  ! as a summation done at higher precision.
  ! It is therefore a useful alternative to working
  ! in, say, quad precision arithmetic.

  ! The sum is over the first n components of the
  ! input array, so array must have at least that
  ! many components.

  function esum(array,n)

    use bl_error_module

    implicit none

    double precision, intent(in) :: array(:)
    integer, intent(in)          :: n

    double precision :: esum

    integer :: p, i, j, k

    double precision :: partials(0:n-1)

    double precision :: x, y, z, hi, lo

    partials = 0.0d0

    ! p keeps track of how many entries in partials are actually used.

    p = 0

    ! The first partial is just the first term.

    partials(p) = array(1)

    do i = 2, n

       j = 0

       x = array(i)

       do k = 0, p

          y = partials(k)

          if (abs(x) < abs(y)) then
             
             ! Swap x, y

             z = y
             y = x
             x = z

          endif

          hi = x + y
          lo = y - (hi - x)

          if (lo .ne. 0.0d0) then

             partials(j) = lo
             j = j + 1

             if (j > p) then
                p = p + 1

             endif

          endif

          x = hi

       enddo

       partials(j) = x
       partials(j+1:n-1) = 0.0d0

    enddo

    if (p > n - 1) then
       call bl_error("Error: too many partials created in esum.")
    endif
    
    esum = sum(partials(0:p))

  end function esum

end module microphysics_math_module
