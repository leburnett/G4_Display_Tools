function create_grid_plot(dark_data, light_data, grid_rows, grid_columns, plot_chan, ...
    timestamps, exp_folder)
    
%% Need to switch back to passing in all data. WIll want to plot each rep individually
% in light color and then the average thicker on each axis. 
    fignum = 1;
    for cond = 1:length(dark_data)
        fig(fignum) = figure; 
        fignum = fignum + 1;
        ts = timestamps{cond};
        for rep = 1:size(dark_data{cond},3)
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
        dark_gauss_title = ['Condition ' num2str(cond) 'Dark Gaussian Fit'];
        light_gauss_title = ['Condition ' num2str(cond) 'Light Gaussian Fit'];
        dark_yax = [min(rep_min_dark) max(rep_max_dark)];
        light_yax = [min(rep_min_light) max(rep_max_light)];
        [gap_x, gap_y] = get_plot_spacing(grid_rows(cond), grid_columns(cond));
        for dframe = 1:size(avg_data_dark,1)
            % if sum(~isnan(data_to_plot(dframe, :))) > 0
                if size(avg_data_dark,1) > 32
                    gap_x = 5;
                    gap_y = 15;
                end
                better_subplot(grid_rows(cond), grid_columns(cond), dframe, gap_x, gap_y);
                yline(0);
                hold on
                for rep = 1:size(rep_data_dark,1)
                    plot(ts, squeeze(rep_data_dark(rep, dframe,:)));
                end
                plot(ts, squeeze(avg_data_dark(dframe, :)), 'Color', 'black', 'Linewidth', 2.0);
                ylim(dark_yax);
                % if dframe == 1
                %     ylabel('volts');
                % end
                % if dframe == (grid_rows(cond) - 1)*grid_columns(cond) + 1
                %     xlabel('ms');
                % end
                set(gca, 'Xcolor', '#F0F0F0', 'Ycolor', '#F0F0F0');
                set(gca, 'XTick', []);
                set(gca, 'YTick', []);
                set(gca, 'color', '#F0F0F0');
            % end
        end
        
        sgtitle(dark_plot_title);
       

        hold off 

        fig(fignum) = figure;
        fignum = fignum + 1;

        for lframe = 1:size(avg_data_light,1)
             if size(avg_data_light,1) > 32
                gap_x = 5;
                gap_y = 15;
            end
            better_subplot(grid_rows(cond), grid_columns(cond), lframe, gap_x, gap_y);
            yline(0);
            hold on
            for rep = 1:size(rep_data_light,1)
                plot(ts, squeeze(rep_data_light(rep, lframe,:)));
            end
            plot(ts, squeeze(avg_data_light(lframe, :)), 'Color', 'black', 'Linewidth', 2.0);
            ylim(light_yax);
            % if lframe == 1
            %     ylabel('volts');
            % end
            % if lframe == (grid_rows(cond) - 1)*grid_columns(cond) + 1
            %     xlabel('ms');
            % end
            set(gca, 'Xcolor', '#F0F0F0', 'Ycolor', '#F0F0F0');
            set(gca, 'XTick', []);
            set(gca, 'YTick', []);
            set(gca, 'color', '#F0F0F0');
            sgtitle(light_plot_title);

        end
        hold off

        rep_data_dark = [];
        rep_data_light = [];

    end

    savefig(fig, fullfile(exp_folder, 'GridPlots.fig'));

end
