function create_grid_plot(dark_data, light_data, grid_rows, grid_columns, plot_chan, ...
    timestamps, exp_folder, gaussColors, medianVoltage, maxVoltage, minVoltage)
    
%% Need to switch back to passing in all data. WIll want to plot each rep individually
% in light color and then the average thicker on each axis. 
    fignum = 1;
    yax_lims = [round(minVoltage,2), round(maxVoltage,2)];
    darkRepColor = [0, 0, 0.5];
    lightRepColor = [0.8, 0.8, 1];
    
    
    for cond = 1:length(dark_data)
        
        ts = timestamps{cond};
        num_reps = size(dark_data{cond},3);
        colorRange = linspace(0,1,num_reps);
        for rep = 1:num_reps
            rep_data_dark(rep,:,:) = squeeze(dark_data{cond}(plot_chan, 1, rep, :, :));
            rep_data_light(rep,:,:) = squeeze(light_data{cond}(plot_chan, 1, rep, :, :));
            rep_max_light(rep) = max(max(rep_data_light(rep, :, :)));
            rep_min_light(rep) = min(min(rep_data_light(rep, :, :)));
            rep_max_dark(rep) = max(max(rep_data_dark(rep,:,:)));
            rep_min_dark(rep) = min(min(rep_data_dark(rep,:,:)));
        end
        avg_data_dark = squeeze(mean(rep_data_dark,1));
        avg_data_light = squeeze(mean(rep_data_light,1));
        dark_plot_title = ['Condition ' num2str(cond) ' Dark Squares'];
        light_plot_title = ['Condition ' num2str(cond) ' Light Squares'];
        [gap_x, gap_y] = get_plot_spacing(grid_rows(cond), grid_columns(cond));
        if sum(isnan(avg_data_dark(:,1))) < size(avg_data_dark,1)
            fig(fignum) = figure; 
            fignum = fignum + 1;
            for dframe = 1:size(avg_data_dark,1)
               %  if sum(~isnan(data_to_plot(dframe, :))) > 0
                    frame_num = dframe + 1;
                    if size(avg_data_dark,1) > 32 && size(avg_data_dark,1) < 183
                        gap_x = 5;
                        gap_y = 15;
                    elseif size(avg_data_dark,1) > 182
                        gap_x = 1;
                        gap_y = 7; %This is the minimum y gap that can be passed to the better_subplot function
                                    % without producing a negative y
                                    % position for the axis and therefore
                                    % cutting it off at the bottom of the
                                    % figure.
    
                    end
                    better_subplot_columns1st(grid_rows(cond), grid_columns(cond), dframe, gap_x, gap_y);
                    yline(0);
                    hold on
                    for rep = 1:num_reps
                        repColor = lightRepColor * colorRange(rep) + darkRepColor * (1 - colorRange(rep));
                       
                        plot(ts, squeeze(rep_data_dark(rep, dframe, 1:length(ts))), 'Color', repColor);
                    end
                    plot(ts, squeeze(avg_data_dark(dframe, 1:length(ts))), 'Color', 'black', 'Linewidth', 2.0);
                    yline(medianVoltage, 'Color', '#ADADAD');
                    ylim(yax_lims);
                    if dframe == 1
                        ylabel('volts');
                    end
                    if dframe == (grid_rows(cond) - 1)*grid_columns(cond) + 1
                        xlabel('ms');
                    end
                    
                    set(gca, 'Xcolor', '#F0F0F0', 'Ycolor', '#F0F0F0');
                    set(gca, 'XTick', []);
                    set(gca, 'FontSize', 6);
                    if dframe == grid_rows(cond) %&& size(avg_data_dark,1)<=32
                        set(gca, 'YTick', [round(minVoltage,2), round(maxVoltage,2)], 'Ycolor', 'k');
                    else
                        set(gca, 'YTick', []);
                    end
                    if sum(find(gaussColors.redInds{cond}==frame_num)>0)
                        set(gca, 'color', '#FDDFDF');
                    elseif sum(find(gaussColors.orangeInds{cond}==frame_num)>0)
                        set(gca, 'color', '#F6E8D6');
                    elseif sum(find(gaussColors.yellowInds{cond}==frame_num)>0)
                        set(gca, 'color', '#F6F5D6');
                    else
                        set(gca, 'color', '#F0F0F0');
                    end
                    subtitle(num2str(frame_num), FontSize = 6);
             %    end
            end
        
            sgtitle(dark_plot_title);
       

            hold off 
    
            
        end

        if sum(isnan(avg_data_light(:,1))) < size(avg_data_light,1)

            fig(fignum) = figure;
            fignum = fignum + 1;

            for lframe = 1:size(avg_data_light,1)
                frame_num = lframe+size(avg_data_dark,1)+1;
                 if size(avg_data_light,1) > 32 && size(avg_data_light,1) < 183
                    gap_x = 5;
                    gap_y = 15;
                elseif size(avg_data_light,1) > 182
                    gap_x = 1;
                    gap_y = 7;
                end
                better_subplot_columns1st(grid_rows(cond), grid_columns(cond), lframe, gap_x, gap_y);
                yline(0);
                hold on
                for rep = 1:size(rep_data_light,1)
                    repColor = lightRepColor * colorRange(rep) + darkRepColor * (1 - colorRange(rep));
                    plot(ts, squeeze(rep_data_light(rep, lframe,1:length(ts))), 'Color', repColor);
                end
                plot(ts, squeeze(avg_data_light(lframe, 1:length(ts))), 'Color', 'black', 'Linewidth', 2.0);
                yline(medianVoltage, 'Color', '#ADADAD');
                ylim(yax_lims);
                if lframe == 1
                    ylabel('volts');
                end
                if lframe == (grid_rows(cond) - 1)*grid_columns(cond) + 1
                    xlabel('ms');
                end
                set(gca, 'Xcolor', '#F0F0F0', 'Ycolor', '#F0F0F0');
                set(gca, 'XTick', []);
                set(gca, 'FontSize', 6);
                if lframe == grid_rows(cond) %&& size(avg_data_light,1)<=32
                        set(gca, 'YTick', [round(minVoltage,2), round(maxVoltage,2)], 'Ycolor', 'k');
                    else
                        set(gca, 'YTick', []);
                end           
                if sum(find(gaussColors.redInds{cond}==frame_num)>0)
                    set(gca, 'color', '#FDDFDF');
                elseif sum(find(gaussColors.orangeInds{cond}==frame_num)>0)
                    set(gca, 'color', '#F6E8D6');
                elseif sum(find(gaussColors.yellowInds{cond}==frame_num)>0)
                    set(gca, 'color', '#F6F5D6');
                else
                    set(gca, 'color', '#F0F0F0');
                end
                sgtitle(light_plot_title);
                subtitle(num2str(frame_num), FontSize = 6);
    
            end
            hold off
    
            rep_data_dark = [];
            rep_data_light = [];
        end

    end

    savefig(fig, fullfile(exp_folder, 'GridPlots.fig'));

end
