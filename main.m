%################################################
%#                  Primera Parte               #
%################################################


 f1 = @(x)  8 * ( log(4*x + 12) / log(5) ) ;
    
 f2 = @(x) sin(6*( log(x + 9) / log(2) )) + cos(7*(log(4*x + 32) / log(6))) ;
    
 types = [ "r *" , "g +"] ;
   
 vector = (0:0.01:15*pi);
    
 titles = [ "8log_5(4x + 12)" , "sen(6(log_2(x + 9))) + cos(7(log_6(4x + 32)))"];
    
 plotFunctions(f1,f2,vector,types,titles)


%################################################
%#                  Segunda Parte               #
%################################################




f_1_2 = @(x) 6* exp(x + 18); 
interval = [-10, 10];
f_1_2_title = '6e^(^x^+^1^8^)';

print_scales(f_1_2, f_1_2_title, interval)