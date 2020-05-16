%################################################
%#                  Primera Parte               #
%################################################



function [] = plotNewton( f , f_0, results, title )
    
    v = polyval(f, results);
    
    root = results(end)
    
    x = linspace(root-5, root+5, 1000);
    
    y = interp1(results, v, x, 'spline');
    
    figure(1)
    plot(results, v, 'o', x, y, 'r-'); 
    xlabel("x")
    ylabel(title)
    title('Newton Rhapson method')
end


    
    
    
    
    
    
    