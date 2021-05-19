function [r,theta] = distance_and_angle(matrix, option, alpha, beta)

%% Find source position
if option == "source"
    [N_row, N_column] = find(matrix == 1);
    N_column = 9+1-N_column;

    % Calculation
    r = sqrt((10*N_row+alpha).^2+(10*(N_column-1)+40-beta).^2);
    theta = atand((10*(N_column-1)+40-beta)./(10*N_row+alpha))

%% Find print position
elseif option == "print"
    [N_row, N_column] = find(matrix == 1);

    % Calculation
    r = sqrt((10*N_row+alpha).^2+(10*(N_column-1)+40+beta).^2);
    theta = -1*atand((10*(N_column-1)+40+beta)./(10*N_row+alpha))
end

