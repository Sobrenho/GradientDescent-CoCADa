function Nesterov_gd(gradient, α, ρ ; chute=[0;1], max_steps=200, erro=0.01, startOffset=10)
    w = chute
    n, = size(w)
    ϕ = zeros(n,1)

    ws = zeros(length(w), startOffset + max_steps+1)
    ws[:,1:startOffset] .= w
    
    i=1
    while i < max_steps
        g = gradient(w - ρ*ϕ)

        if norm(g) < erro break end
        
        ϕ = ρ*ϕ + α*g
        w -= ϕ
        
        ws[:,startOffset+i]= w
        i += 1
    end
    
    ws[:, i:startOffset+max_steps+1] .= w
    return ws
end