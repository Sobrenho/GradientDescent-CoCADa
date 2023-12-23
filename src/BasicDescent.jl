function gd_CoCADa(gradient, α; chute=[0,1], maxSteps=200, erro= 0.01, startOffset=10)
    w = chute
    n, = size(w)
    maxSize = startOffset+maxSteps+1
    ws = zeros(n, maxSize)
    ws[:,1:startOffset] .= w
    i = 1
    while  i < maxSteps
        g = gradient(w)

        if norm(g) < erro break end
        
        w -= α*g

        ws[:, startOffset+i] = w
        i+=1
    end
    ws[:, startOffset+i:maxSize] .= w
    return ws
end

