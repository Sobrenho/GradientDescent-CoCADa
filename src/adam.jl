function ADAM(gradient, β1, β2; chute = [0;1], maxSteps=200, erro=0.01, ϵ=10^-8, startOffset=10)

    w = chute
    n,  = size(w)

    m = zeros(n,1)
    v = zeros(n,1)

    maxSize= startOffset+maxSteps+1
    ws = zeros(n, maxSize)
    
    ws[:, 1:startOffset] .= w
    
    i = 1
    while i < maxSteps
    
        g = gradient(w)

        if norm(g) < erro break end
    
        m = β1*m + (1-β1)*g
        v = β2*v + (1-β2)*g.^2

        m_linha = m./(1-β1)
        v_linha = v./(1-β2)

        w -= @. m_linha/(sqrt(v_linha) + ϵ)

        ws[:, startOffset+i] = w
        i += 1
    end
    
    ws[:, startOffset+i:maxSize] .= w 
    return ws
end