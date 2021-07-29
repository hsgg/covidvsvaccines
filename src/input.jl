#!/usr/bin/env julia


module covid

using DataFrames
using CSV


function main()
    fcases = "../COVID-19_Case_Surveillance_Public_Use_Data_with_Geography.csv"
    fvaccs = "../COVID-19_Vaccinations_in_the_United_States_County.csv"

    cases = DataFrame(CSV.File(fcases))
    vaccs = DataFrame(CSV.File(fvaccs))
end


end

covid.main()


# vim: set sw=4 et sts=4 :
