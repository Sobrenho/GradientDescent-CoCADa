function classical_momentum_gd(gradient, α, ρ ; chute=[0;1], maxSteps=200, erro=0.01, startOffset = 10) #Também chamado de Heavy Ball
  
    w = chute 
    n,  = size(w)
    v = zeros(n,1)
    
    maxSize = startOffset+maxSteps+1
    ws = zeros(n, maxSize)
    
    ws[:,1:startOffset] .= w
    
    i = 1
    while i < maxSteps
        g = gradient(w)

        if norm(g) < erro break end

        
        v = ρ*v + α*g
        w -= v

        ws[:, startOffset+i]= w
        i +=1
    end
    
    ws[:, startOffset+i:maxSize] .= w
    return ws
end