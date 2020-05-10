function [ x0 ] = Fourier( func, a, b)
    delta = 1e-5;
    %Asumiendo 5 operaciones para evaluar func:
    df1 = @(x) ((func(x+delta) - func(x))/delta); %6 + 5 + 1 + 1 = 12
    df2 = @(x) ((df1(x+delta) - df1(x))/delta); %13 + 12 + 1 + 1 = 27
    m = (a + b)/2; 
    % 27 operaciones para evaluar df2
    if(subs(df1, m) > 0) 
        if(subs(df2, m) > 0)
            x0 = b;
        elseif(subs(df2, m) < 0)
            x0 = a;
        end
    elseif(subs(df1, m) < 0 )
        if(subs(df2, m) > 0 )
            x0 = a;
        elseif(subs(df2, m) < 0)
            x0 = b;
        end
    end
end

