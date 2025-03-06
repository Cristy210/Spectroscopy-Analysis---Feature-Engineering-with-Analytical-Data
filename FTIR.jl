### A Pluto.jl notebook ###
# v0.20.4

using Markdown
using InteractiveUtils

# ╔═╡ 1a324b3f-c68f-4e02-913f-0e14a6b3c4dc
import Pkg; Pkg.activate(@__DIR__)

# ╔═╡ 549a6db9-85b3-47f7-b2c1-dcc25ec6621d
using LinearAlgebra, CSV, CairoMakie, DataFrames, SciPy

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

# ╔═╡ 79ea9055-0748-4b16-b40d-f247e19651b7


# ╔═╡ Cell order:
# ╟─32c11fd3-09f3-491c-8337-250afe3acbd6
# ╠═1a324b3f-c68f-4e02-913f-0e14a6b3c4dc
# ╠═549a6db9-85b3-47f7-b2c1-dcc25ec6621d
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
# ╠═79ea9055-0748-4b16-b40d-f247e19651b7
