### A Pluto.jl notebook ###
# v0.19.27

using Markdown
using InteractiveUtils

# ╔═╡ 7a650246-4c8c-11ee-3ace-5b3be23a1e11
# ╠═╡ show_logs = false
begin
	using Pkg; Pkg.activate(".")
	using Ginterpolations
	using Plots
end

# ╔═╡ fdfd7bc9-85b9-45f7-be8d-9200e06ee7de
md"# Ginterpolations.
Fast linear interpolations of gridded data in n dimensions. Interpolate data from one grid to another grid. Compute interpolation weights that can be re-used and do not depend on the data that is evaluated. Does not require sorted input arrays. Multidimensional interpolation is done by shifting along each axis one after the other."

# ╔═╡ b3d9686c-c08a-46c9-94e1-9b8c03005eeb
x = range(1, 10, length=100) |> collect

# ╔═╡ b4611b68-7a70-438c-a695-ada82d6684b9
x2 = range(1, 10, length=10) |> collect

# ╔═╡ 6a585cea-2de5-44c8-8c0e-495537bb3752
ip = ginterpolate(Grid(x), Grid(x2))

# ╔═╡ 11923eb8-ac34-42eb-a68e-1839d330dc30
begin
	scatter(
		x2, x2.^2, label="analytical", framestyle=:box, grid=nothing, markersize=7
	)
	scatter!(x2, gevaluate!(ip, x.^2), label="interpolated")
end

# ╔═╡ eef031dc-0f21-45ac-aeb4-0cc30cd3e09c
md"Also unsorted grids can be interpolated. The interpolator sorts all arrays that are given to it, and then saves the way they were sorted. Unsorted data arrays may hence been passed to the evaluation function, which will then automatically use the weights for the right spots and return the array as it was expected from the output axis, which may also be unsorted. Note that there might be perfomance penalties for unsorted array access, because the functionality is using non-contiguos views."

# ╔═╡ 8ea0ef23-a209-4a29-aeca-5b3675b51535
xu = Ginterpolations.scale(rand(100), 0, 10)

# ╔═╡ 31229195-73c2-4e91-b757-00ffb82b2075
x2u = Ginterpolations.scale(rand(10), 0, 10)

# ╔═╡ fbbfbcce-86ac-4d3c-8abc-c1a30890b356
ipu = ginterpolate(Grid(xu), Grid(x2u))

# ╔═╡ 5656be70-22fe-4ebb-a05b-314bb1d4053d
begin
	scatter(
		x2u, x2u.^3, label="analytical", framestyle=:box, grid=nothing, markersize=7
	)
	scatter!(x2u, gevaluate!(ipu, xu .^3), label="interpolated")
end

# ╔═╡ cd89ef1d-b721-4d15-91b8-b088320e0283
md"This also works in more than 1 dimension"

# ╔═╡ e36744fd-86d4-478e-a0f2-2b39d4c91504
yu = Ginterpolations.scale(rand(100), 0, 10) 

# ╔═╡ 74a51163-817d-4b26-899c-d56cf6f21284
y2u = Ginterpolations.scale(rand(10), 0, 10)

# ╔═╡ 3c992b67-d519-4ce3-924d-8c8d8349ef82
ipxyu = ginterpolate(Grid(xu, yu), Grid(x2u, y2u))

# ╔═╡ 8c0cb2e4-f6e8-4030-bf1f-b6a16559b301
xm, ym = sortperm(x2u), sortperm(y2u)

# ╔═╡ be4d0398-3a17-41d8-a2c8-e16006c45b42
begin
	h1 = heatmap(
		sort(x2u), sort(y2u), sort(x2u).^2 .+ sort(y2u)'.^2, 
		label="analytical", framestyle=:box, grid=nothing, markersize=7
	)
	h2 = heatmap(
		sort(x2u), sort(y2u), gevaluate!(ipxyu, xu.^2 .+ yu'.^2)[xm, ym], 
		label="interpolated", framestyle=:box, grid=nothing, markersize=7
	)

	plot(h1, h2)
end

# ╔═╡ Cell order:
# ╟─fdfd7bc9-85b9-45f7-be8d-9200e06ee7de
# ╠═7a650246-4c8c-11ee-3ace-5b3be23a1e11
# ╠═b3d9686c-c08a-46c9-94e1-9b8c03005eeb
# ╠═b4611b68-7a70-438c-a695-ada82d6684b9
# ╠═6a585cea-2de5-44c8-8c0e-495537bb3752
# ╠═11923eb8-ac34-42eb-a68e-1839d330dc30
# ╟─eef031dc-0f21-45ac-aeb4-0cc30cd3e09c
# ╠═8ea0ef23-a209-4a29-aeca-5b3675b51535
# ╠═31229195-73c2-4e91-b757-00ffb82b2075
# ╠═fbbfbcce-86ac-4d3c-8abc-c1a30890b356
# ╠═5656be70-22fe-4ebb-a05b-314bb1d4053d
# ╟─cd89ef1d-b721-4d15-91b8-b088320e0283
# ╠═e36744fd-86d4-478e-a0f2-2b39d4c91504
# ╠═74a51163-817d-4b26-899c-d56cf6f21284
# ╠═3c992b67-d519-4ce3-924d-8c8d8349ef82
# ╠═8c0cb2e4-f6e8-4030-bf1f-b6a16559b301
# ╟─be4d0398-3a17-41d8-a2c8-e16006c45b42
