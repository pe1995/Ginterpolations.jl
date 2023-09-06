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

# ╔═╡ b3d9686c-c08a-46c9-94e1-9b8c03005eeb
x = range(1, 10, length=100) |> collect

# ╔═╡ b4611b68-7a70-438c-a695-ada82d6684b9
x2 = range(1, 10, length=10) |> collect

# ╔═╡ 6a585cea-2de5-44c8-8c0e-495537bb3752
ip = ginterpolate(Grid(x), Grid(x2))

# ╔═╡ 11923eb8-ac34-42eb-a68e-1839d330dc30
begin
	plot(x2, x2.^2, label="analytical")
	plot!(x2, gevaluate!(ip, x.^2), label="interpolated")
end

# ╔═╡ Cell order:
# ╠═7a650246-4c8c-11ee-3ace-5b3be23a1e11
# ╠═b3d9686c-c08a-46c9-94e1-9b8c03005eeb
# ╠═b4611b68-7a70-438c-a695-ada82d6684b9
# ╠═6a585cea-2de5-44c8-8c0e-495537bb3752
# ╠═11923eb8-ac34-42eb-a68e-1839d330dc30
