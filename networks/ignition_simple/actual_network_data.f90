module actual_network_data

  implicit none

  integer, parameter :: nspec = 3
  integer, parameter :: nspec_evolve = 1
  integer, parameter :: naux  = 0

  integer, parameter :: ic12  = 1
  integer, parameter :: io16  = 2
  integer, parameter :: img24 = 3

  character (len=16), save :: spec_names(nspec) 
  character (len= 5), save :: short_spec_names(nspec)
  character (len= 5), save :: short_aux_names(naux)

  double precision :: aion(nspec), zion(nspec), bion(nspec)
  double precision :: nion(nspec), mion(nspec), wion(nspec)

  !$acc declare create(aion, zion, bion, nion, mion, wion)

end module actual_network_data
