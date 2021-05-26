function coef = fcn_poly_derivative(coef_in)
len = length(coef_in);
for i = 1:len-1
    coef(i) = coef_in(i)*(len-i);
end
    
end