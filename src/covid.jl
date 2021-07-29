### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ 85733a59-aef2-445e-9205-f45ad8323d15
using DataFrames

# ╔═╡ c6a5e77d-6fd3-4795-8264-f55da845e61d
using CSV

# ╔═╡ 77a5be3c-ac72-49f0-9fb7-54cec57470be
using Dates

# ╔═╡ 78a6a1ed-a91a-4709-865b-e0844d80be2a
using Plots

# ╔═╡ f2cb1354-d929-4fa2-9133-19865ead5a8f
using StatsPlots

# ╔═╡ 4cbf50de-3cd3-4284-80e5-3b61f25aba8e
fcases = "$(homedir())/covid/COVID-19_Case_Surveillance_Public_Use_Data_with_Geography.csv"

# ╔═╡ 0e06dad7-c6d8-4769-ad72-cafbfd9c26b3
fvaccs = "$(homedir())/covid/COVID-19_Vaccinations_in_the_United_States_County.csv"

# ╔═╡ c4ee2e10-c2d7-4a85-a829-16babf93fda4
allcases = DataFrame(CSV.File(fcases))

# ╔═╡ 9f7f4730-f965-47ae-bc07-f1ba36b37949
sum(allcases.case_month .>= Dates.Date(2021, 05))

# ╔═╡ d82e07c6-78d1-48dc-95fc-df47a4eb346c
cases = allcases[allcases.case_month .>= Dates.Date(2021, 06), [:county_fips_code]]

# ╔═╡ 7c1c0901-9f7d-4bb0-ad84-37834b530e22
allvaccs = DataFrame(CSV.File(fvaccs))

# ╔═╡ d673d134-9fce-4770-93ec-70f9a4244394
length(allvaccs.Date[allvaccs.Date .== "06/01/2021"])

# ╔═╡ a3ef66f3-8893-4e90-b617-c2e2c36ae922
vaccs = allvaccs[allvaccs.Date .== "06/24/2021",[:FIPS, :Series_Complete_Pop_Pct, :Series_Complete_Yes, :Administered_Dose1_Recip_18PlusPop_Pct]]

# ╔═╡ fbc2d689-3e25-4d1a-a152-44a809f4885a
vaccs.Total_Pop = 100 .* vaccs.Series_Complete_Yes ./ vaccs.Series_Complete_Pop_Pct

# ╔═╡ f9b4accd-5b20-429b-b9de-fc5481fdc5ce
begin
	vaccs.CasesMonth = fill(0, length(vaccs[:,1]))
	for i=1:length(cases[:,1])
		vaccs.CasesMonth[vaccs.FIPS .== cases.county_fips_code[i]] .+= 1
	end
	vaccs.Case_Rate = 100 * vaccs.CasesMonth ./ vaccs.Total_Pop
	vaccs
end

# ╔═╡ 40923a74-6880-48d1-b18c-9ad0758ac9f1
length(vaccs.CasesMonth) - sum(vaccs.CasesMonth .== 0)

# ╔═╡ 51ff83b6-165f-4845-bce1-e88ae9ae2388
plotlyjs()

# ╔═╡ 3b93677f-0a2c-4d02-a41a-e20401ef536e
@df vaccs scatter(
	:Administered_Dose1_Recip_18PlusPop_Pct,
	:Series_Complete_Pop_Pct,
	xlabel="At Least Dose 1",
	ylabel="Fully Vaccinated",)

# ╔═╡ 5726aa70-b008-47cc-aba9-0ebda8edaf80
@df vaccs scatter(
	:Series_Complete_Pop_Pct,
	#:Administered_Dose1_Recip_18PlusPop_Pct,
	:Case_Rate,
	xlabel="Vaccination Rate",
	ylabel="Case Rate",)

# ╔═╡ Cell order:
# ╠═85733a59-aef2-445e-9205-f45ad8323d15
# ╠═c6a5e77d-6fd3-4795-8264-f55da845e61d
# ╠═77a5be3c-ac72-49f0-9fb7-54cec57470be
# ╟─4cbf50de-3cd3-4284-80e5-3b61f25aba8e
# ╟─0e06dad7-c6d8-4769-ad72-cafbfd9c26b3
# ╠═c4ee2e10-c2d7-4a85-a829-16babf93fda4
# ╠═9f7f4730-f965-47ae-bc07-f1ba36b37949
# ╠═d82e07c6-78d1-48dc-95fc-df47a4eb346c
# ╠═7c1c0901-9f7d-4bb0-ad84-37834b530e22
# ╠═d673d134-9fce-4770-93ec-70f9a4244394
# ╠═a3ef66f3-8893-4e90-b617-c2e2c36ae922
# ╠═fbc2d689-3e25-4d1a-a152-44a809f4885a
# ╠═f9b4accd-5b20-429b-b9de-fc5481fdc5ce
# ╠═40923a74-6880-48d1-b18c-9ad0758ac9f1
# ╠═78a6a1ed-a91a-4709-865b-e0844d80be2a
# ╠═51ff83b6-165f-4845-bce1-e88ae9ae2388
# ╠═f2cb1354-d929-4fa2-9133-19865ead5a8f
# ╠═3b93677f-0a2c-4d02-a41a-e20401ef536e
# ╠═5726aa70-b008-47cc-aba9-0ebda8edaf80
