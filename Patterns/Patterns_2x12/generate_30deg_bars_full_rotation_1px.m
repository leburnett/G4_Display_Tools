% Script for making 30 degree bar stimuli
% Created by Burnett - 28 February 2025

save_directory = 'C:\matlabroot\BurnettLE\Patterns\Patterns_2x12';

n_rows = 2;
n_cols = 12;
h_display = n_rows*16;
w_display = n_cols*16;
% 
bkg_color = 1;
bar_color = 0; 

bar_width = 6;
flip_value = false;

%% 
if flip_value == true
    flip_str = '-';
else
    flip_str = '';
end 

patName = [num2str(bar_width), 'pix_bar_' flip_str, '30deg_', num2str(bar_color), 'bar_', num2str(bkg_color), 'bkg'];
create_pattern(h_display, w_display, bar_width, bkg_color, bar_color, flip_value, patName, save_directory)

%%
function create_pattern(h_display, w_display, bar_width, bkg_color, bar_color, flip_value, patName, save_directory)

    % Create pattern for BAR:
    fullim = create_striped_fullim(h_display, w_display, bar_width/2, bkg_color, bar_color);

    if flip_value==true
        fullim = flip(fullim);
    end

    % Generate full pattern across all frames
    Pats = generate_Pats(fullim, h_display, w_display);

    % Set some parameters that need to be hard-coded. 
    param.stretch = zeros(w_display, 1);
    param.gs_val = 1; % greyscale
    param.arena_pitch = 0; 
    
    %% Save the new pattern. 
    % Finds appropriate ID for the pattern to be saved under. 
    param.ID = get_pattern_ID(save_directory);
    
    % Saves the pattern as both .mat and .pat. 
    save_pattern_G4(Pats, param, save_directory, patName);

end 


%% BAR
function fullim = create_striped_fullim(h_display, w_display, bar_width, bkg_color, bar_color)
    % Create an array filled with background color
    fullim = ones(h_display, w_display) * bkg_color;
    % Define the angle
    angle = 30; % degrees
    slope = tand(angle); % Convert angle to slope
    % Compute center positions
    centerRow = ceil(h_display / 10);
    centerCol = ceil(w_display / 10);
    % Adjust initial position so the first stripe is centered
    y1 = 1;  % Start stripe at the middle column
    x1 = centerRow - (centerCol / slope); % Adjust to align with center
    % Iterate over each stripe position relative to the center
    for offset = 1:bar_width
        % Iterate over each pixel in the image
        for row = 1:h_display
            for col = 1:w_display
                % Calculate expected column position
                expectedCol = round(slope * (row - x1) + y1);
                % Check if the pixel falls within the stripe thickness
                if abs(col - expectedCol) <= bar_width / 2
                    fullim(row, col) = bar_color;
                end
            end
        end
    end
end


%% 

function Pats = generate_Pats(fullim, h_display, w_display)

    n_frames = 192;
    Pats = zeros(h_display, w_display, n_frames);
       
    Pats(:, :, 1) = fullim;
    
    % Fill in the remaining 191 frames of this pattern by shifting the first
    % frame by one pixel each time. 
    for j = 2:192
        Pats(:,:,j) = ShiftMatrix(Pats(:,:,j-1), 1, 'r', 'y');
    end

end 

% TEST % % % % % % % 
% % 
% figure
% for i = 1:192
% aa = Pats(:, :, i);
% imagesc(aa)
% pause(0.1)
% end 
% % % 


%% Create pattern with 2 frames - one of the bar at 30deg and one of the same bar at -30 deg.

Pats = zeros(h_display, w_display, 2);
Pats(:, :, 1) = fullim;
Pats(:, :, 2) = flip(fullim);

% Set some parameters that need to be hard-coded. 
param.stretch = zeros(w_display, 1);
param.gs_val = 1; % greyscale
param.arena_pitch = 0; 

%% Save the new pattern. 
% Finds appropriate ID for the pattern to be saved under. 
param.ID = get_pattern_ID(save_directory);s

% Saves the pattern as both .mat and .pat. 
patName = '30deg_6pix_bar_2frames';
save_pattern_G4(Pats, param, save_directory, patName);
