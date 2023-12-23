using LinearAlgebra
using Random
using Plots

function create_anim(
    f,
    path,
    xlims,
    ylims,
    file_name = joinpath(pwd(), randstring(12) * ".gif");
    xbounds = xlims,
    ybounds = ylims,
    fps = 10,
)
    xs = range(xlims...; length = 100)
    ys = range(ylims...; length = 100)
    plt = contourf(xs, ys, f; color = :turbo)

    # add constraints if provided ---> ??????
    if !(xbounds == xlims && ybounds == ylims)
        x_rect = [xbounds[1]; xbounds[2]; xbounds[2]; xbounds[1]; xbounds[1]]
        y_rect = [ybounds[1]; ybounds[1]; ybounds[2]; ybounds[2]; ybounds[1]]

        plot!(x_rect, y_rect; line = (2, :dash, :red), label="")
    end

    # add an empty plot
    plot!(Float64[], Float64[]; line = (4, :arrow, :black), label = "")

    # extract the last plot series
    plt_path = plt.series_list[end]

    # create the animation and save it
    anim = Animation()
    for x in eachcol(path)
        push!(plt_path, x[1], x[2]) # add a new point
        frame(anim)
    end
    gif(anim, file_name; fps = fps, show_msg = false)
    return nothing
end



function create_multi_anim(
    f,
    paths,
    xlims,
    ylims,
    file_name = joinpath(pwd(), randstring(12) * ".gif");
    labels = ["" for i = 1:length(paths)], #implementation names
    xbounds = xlims,
    ybounds = ylims,
    fps = 10,
)
    xs = range(xlims...; length = 100)
    ys = range(ylims...; length = 100)
    plt = contourf(xs, ys, f; color = :gnuplot2)

    # add constraints if provided
    if !(xbounds == xlims && ybounds == ylims)
        x_rect = [xbounds[1]; xbounds[2]; xbounds[2]; xbounds[1]; xbounds[1]]
        y_rect = [ybounds[1]; ybounds[1]; ybounds[2]; ybounds[2]; ybounds[1]]

        plot!(x_rect, y_rect; line = (2, :dash, :red), label="")
    end

    
    #colors for each implementation
    colors = [:red, :orange, :green1, :hotpink, :antiquewhite, :gold]

    # create the animation and save it
    anim = Animation()
    n,m = size(paths[1])
    plt_paths = []
    for gd = 1:length(paths)
        
        # add an empty plots for each gradient descent implementation
        plot!(Float64[], Float64[]; line = (2, :arrow, colors[gd]), label = labels[gd])
        
        push!(plt_paths,plt.series_list[end])      
    end
        
    for t = 1:m #todas as iterações
        for  (i, gd) in enumerate(paths)
            push!(plt_paths[i], gd[1, t], gd[2,t])
        end
        frame(anim)
    end
    
    gif(anim, file_name; fps = fps, show_msg = false)
    return nothing
end