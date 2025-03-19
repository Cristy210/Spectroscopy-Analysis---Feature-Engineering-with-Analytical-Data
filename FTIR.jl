### A Pluto.jl notebook ###
# v0.20.4

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    #! format: off
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
    #! format: on
end

# ╔═╡ 1a324b3f-c68f-4e02-913f-0e14a6b3c4dc
import Pkg; Pkg.activate(@__DIR__)

# ╔═╡ 549a6db9-85b3-47f7-b2c1-dcc25ec6621d
using LinearAlgebra, CSV, CairoMakie, DataFrames, SciPy, PyCall, PlutoUI

# ╔═╡ 32c11fd3-09f3-491c-8337-250afe3acbd6
html"""<style>
input[type*="range"] {
	width: calc(100% - 4rem);
}
main {
    max-width: 96%;
    margin-left: 0%;
    margin-right: 2% !important;
}
"""

# ╔═╡ 39e36f7a-584d-4188-92be-e49c4297d891
spy_sig = pyimport("scipy.signal")

# ╔═╡ 526cad54-68ce-48a0-80bf-39bbd9b166af
FTIR_dir = joinpath(@__DIR__, "Project Deliverables", "FTIR", "FTIR_data.csv")

# ╔═╡ 6b2c291d-b6c5-44f6-b08a-e3fba0f7841d
FTIR = CSV.read(FTIR_dir, DataFrame)

# ╔═╡ d17c3bae-d3f5-483f-9df6-f5a83c797412
wave_cols = names(FTIR, r"^Wavenumber\[1/cm\]_")

# ╔═╡ 23b02402-d38d-4d29-bccd-9346044c5664
absorb_cols = names(FTIR, r"^Absorbance_")

# ╔═╡ 301069c6-f5b7-419d-8e70-8914c26ad065
FTIR_wave = FTIR[:, wave_cols]

# ╔═╡ 1058226e-d6aa-48b2-b510-4fa025ee0b4b
FTIR_abs = FTIR[:, absorb_cols]

# ╔═╡ 5b397f6b-e779-4e6f-a03f-e61f0cbaab98
min_FTIR_abs = [minimum(FTIR_abs[i, :]) for i in 1:size(FTIR_abs, 1)]

# ╔═╡ 9a5b3b52-4810-456c-a314-9589e7b4642c
max_FTIR_abs = [maximum(FTIR_abs[i, :]) for i in 1:size(FTIR_abs, 1)]

# ╔═╡ 3d886335-1034-4f3f-8ddf-724a13263835
max_min_abs = max_FTIR_abs - min_FTIR_abs

# ╔═╡ 1eb82728-b8bc-43c8-a3a8-68416862573a
FTIR_abs_norm = (FTIR_abs .- min_FTIR_abs) ./ max_min_abs

# ╔═╡ 264d24d9-d41c-4844-96aa-969569c23ed9
FTIR_norm_mat = hcat([convert(Vector{Float64}, FTIR_abs_norm[:, i]) for i in 1:size(FTIR_abs_norm, 2)]...)

# ╔═╡ 56d07cfc-4e7e-4922-83b4-0c7e1ded25ff
FTIR_wave_mat = hcat([convert(Vector{Float64}, FTIR_wave[:, i]) for i in 1:size(FTIR_wave, 2)]...)

# ╔═╡ 1f8acacd-80f4-4703-b526-7f6153945c71
FTIR_abs_norm[1, :]

# ╔═╡ b5945ea4-4bb4-417a-ae65-d4c14c765d87
FTIR_norm_mat[1, :]

# ╔═╡ 0e6e6fd0-4d68-442a-955c-66e6bb3bb9fc


# ╔═╡ 7ff855aa-7138-4396-baec-faa9d0b0773c
peak_locs = [spy_sig.find_peaks(FTIR_norm_mat[i, :], prominence=0.0009)[1] for i in 1:size(FTIR_norm_mat, 1)]

# ╔═╡ 2eed5769-d968-42c6-9c3b-ff57aba8abc9
FTIR_wave_mat[1, :][peak_locs[1]]

# ╔═╡ 031e1919-bac6-490b-905d-82a82fe6f74c
with_theme() do
	fig = Figure(; size=(1300, 900))
	# fig_1 = Label(fig[1, 1], "FTIR - Peak Identification")
	grid_peaks = GridLayout(fig[1, 1]; nrow=4, ncol=3)
	n_samples = size(FTIR_norm_mat, 1)
	nrow, ncol = 4, 3
	k=0

	for row in 1:nrow, col in 1:ncol
		k += 1
		if k > n_samples
			break
		end
		ax = Axis(grid_peaks[row, col], title = "Sample $k", xlabel = "Wavenumber", ylabel = "Absorbance", xreversed = true)
		lines!(ax, FTIR_wave_mat[k, :], FTIR_norm_mat[k, :], color=(:blue, 5))
		scatter!(ax, FTIR_wave_mat[k, :][peak_locs[k]], FTIR_norm_mat[k, :][peak_locs[k]]; marker = :x, color = :red)
	end

	fig

end

# ╔═╡ fb35643c-1d39-4e52-9e7a-15bf41fe8177
md"""
### Select the Sample
"""

# ╔═╡ a69adc69-c1e6-48bc-9786-bd6430bea240
@bind sample PlutoUI.Slider(1:size(FTIR_norm_mat, 1); show_value=true)

# ╔═╡ fda184e9-2d26-425b-9652-e9e4af3f2004
with_theme() do
	fig = Figure(; size=(1000, 700))
	ax = Axis(fig[1, 1], title="FTIR Sample Peak", xlabel ="wavenumber", ylabel = "Absorbance", xreversed=true)
	lines!(ax, FTIR_wave_mat[sample, :], FTIR_norm_mat[sample, :], color=(:blue, 5))
	scatter!(ax, FTIR_wave_mat[sample, :][peak_locs[sample]], FTIR_norm_mat[sample, :][peak_locs[sample]]; marker= :x, color=:red)
	fig
end

# ╔═╡ 33defb9d-a55b-4a2c-a4a7-7e78df473a48
md"""
### Rough Work
"""

# ╔═╡ 71045e2b-4733-4e0f-9d56-9bf60e9b4569
SciPy.signal.find_peaks(FTIR_norm_mat[1, :], prominence=0.0009)[1]

# ╔═╡ Cell order:
# ╟─32c11fd3-09f3-491c-8337-250afe3acbd6
# ╠═1a324b3f-c68f-4e02-913f-0e14a6b3c4dc
# ╠═549a6db9-85b3-47f7-b2c1-dcc25ec6621d
# ╠═39e36f7a-584d-4188-92be-e49c4297d891
# ╠═526cad54-68ce-48a0-80bf-39bbd9b166af
# ╠═6b2c291d-b6c5-44f6-b08a-e3fba0f7841d
# ╠═d17c3bae-d3f5-483f-9df6-f5a83c797412
# ╠═23b02402-d38d-4d29-bccd-9346044c5664
# ╠═301069c6-f5b7-419d-8e70-8914c26ad065
# ╠═1058226e-d6aa-48b2-b510-4fa025ee0b4b
# ╠═5b397f6b-e779-4e6f-a03f-e61f0cbaab98
# ╠═9a5b3b52-4810-456c-a314-9589e7b4642c
# ╠═3d886335-1034-4f3f-8ddf-724a13263835
# ╠═1eb82728-b8bc-43c8-a3a8-68416862573a
# ╠═264d24d9-d41c-4844-96aa-969569c23ed9
# ╠═56d07cfc-4e7e-4922-83b4-0c7e1ded25ff
# ╠═1f8acacd-80f4-4703-b526-7f6153945c71
# ╠═b5945ea4-4bb4-417a-ae65-d4c14c765d87
# ╠═0e6e6fd0-4d68-442a-955c-66e6bb3bb9fc
# ╠═7ff855aa-7138-4396-baec-faa9d0b0773c
# ╠═2eed5769-d968-42c6-9c3b-ff57aba8abc9
# ╠═031e1919-bac6-490b-905d-82a82fe6f74c
# ╟─fb35643c-1d39-4e52-9e7a-15bf41fe8177
# ╠═a69adc69-c1e6-48bc-9786-bd6430bea240
# ╠═fda184e9-2d26-425b-9652-e9e4af3f2004
# ╟─33defb9d-a55b-4a2c-a4a7-7e78df473a48
# ╠═71045e2b-4733-4e0f-9d56-9bf60e9b4569
