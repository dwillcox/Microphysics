module actual_network

  use bl_types
  use actual_network_data

  implicit none

contains

  subroutine actual_network_init()

    ! set the names
    spec_names(ihe4_)  = "helium-4"
    spec_names(ic12_)  = "carbon-12"
    spec_names(io16_)  = "oxygen-16"
    spec_names(ife56_) = "iron-56"

    short_spec_names(ihe4_)  = "He4"
    short_spec_names(ic12_)  = "C12"
    short_spec_names(io16_)  = "O16"
    short_spec_names(ife56_) = "Fe56"


    ! set the species properties
    aion(ihe4_)  =  4.0_dp_t
    aion(ic12_)  = 12.0_dp_t
    aion(io16_)  = 16.0_dp_t
    aion(ife56_) = 56.0_dp_t

    zion(ihe4_)  =  2.0_dp_t
    zion(ic12_)  =  6.0_dp_t
    zion(io16_)  =  8.0_dp_t
    zion(ife56_) = 26.0_dp_t

    ! our convention is that binding energy is negative.  The following are 
    ! the binding energies per unit mass (erg / g) obtained by converting
    ! the energies in MeV to erg then multiplying by (N_A / aion) where 
    ! N_A = 6.0221415e23 is Avogadro's number
    ebin(ihe4_)  = -6.8253797e18_dp_t    !  28.39603 MeV / nucleon
    ebin(ic12_)  = -7.4103097e18_dp_t    !  92.16294 MeV / nucleon
    ebin(io16_)  = -7.6959581e18_dp_t    ! 127.62093 MeV / nucleon
    ebin(ife56_) = -8.4813001e18_dp_t    ! 492.25389 MeV / nucleon

  end subroutine actual_network_init



  function network_reaction_index(name)

    use actual_burner_data

    character(len=*) :: name
    integer :: network_reaction_index, n

    network_reaction_index = -1

    do n = 1, nrates
       if (name == reac_names(n)) then
          network_reaction_index = n
          exit
       endif
    enddo

    return
  end function network_reaction_index


  subroutine network_finalize()
    ! stub for MAESTRO
  end subroutine network_finalize

end module actual_network
