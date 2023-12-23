function RMSprop(gradient, α, ρ; chute = [0;1], maxSteps=200, erro= 0.01, ϵ=10^-8, startOffset=10)
    w = chute
    n,  = size(w)

    sumGrad = zeros(n,1)

    maxSize = startOffset+maxSteps+1
    ws = zeros(n, maxSize)
        
    ws[:,1:startOffset] .= w
    
    i = 1
    while i < maxSteps
        g = gradient(w)

        if norm(g) < erro break end
            
        sumGrad = ρ*sumGrad + (1-ρ)*g.^2

        w -= @. α/(ϵ + sqrt(sumGrad))*g 

        ws[:, startOffset+i] = w
        i += 1
    end

    ws[:, startOffset+i:maxSize] .= w 
    return ws
end