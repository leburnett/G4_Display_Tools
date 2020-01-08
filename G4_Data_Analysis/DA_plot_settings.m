%% Normalization Settings
function [normalize_settings, histogram_plot_settings, histogram_annotation_settings, ...
    CL_hist_plot_settings, timeseries_plot_settings, TC_plot_settings, save_settings] = DA_plot_settings()

    normalize_settings = struct;
    normalize_settings.normalize_to_baseline = {'LpR'};%datatypes to normalize by setting the baseline value to 1
    normalize_settings.baseline_startstop = [0 1]; %start and stop times to use for baseline normalization
    normalize_settings.normalize_to_max = {'LmR'}; %datatypes to normalize by setting the maximum (or minimum) values to +1 (or -1)
    normalize_settings.max_startstop = [1 3]; %start and stop times to use for max normalization
    normalize_settings.max_prctile = 98; %percentile to use as a more robust estimate of the maximum value

    %% Plot Settings for basic Histograms
    histogram_plot_settings = struct;
    histogram_plot_settings.histogram_ylimits = [0 100; -6 6; 2 10];
    histogram_plot_settings.subtitle_FontSize = 8;
    histogram_plot_settings.rep_colors = [0 0 0; 1 0 0; 0 0 1; 0 1 0; 1 1 1; 1 1 0; 1 0 1; 0 1 1; .5 .5 .5]; %default 3 colors supports up to 3 groups (add more colors for more groups)
    histogram_plot_settings.mean_colors = [0 0 0; 1 0 0; 0 0 1; 0 1 0; 1 1 1; 1 1 0; 1 0 1; 0 1 1; .5 .5 .5]; %default 3 colors supports up to 3 groups (add more colors for more groups)
    histogram_plot_settings.rep_LineWidth = 0.05;
    histogram_plot_settings.mean_LineWidth = 1;

    %% Annotation settings for basic Histograms
    histogram_annotation_settings = struct;
    histogram_annotation_settings.textbox = [0.3 0.0001 0.7 0.027];
    histogram_annotation_settings.font_size = 10;
    histogram_annotation_settings.font_name = 'Arial';
    histogram_annotation_settings.line_style = '-';
    histogram_annotation_settings.edge_color = [1 1 1];
    histogram_annotation_settings.line_width = 1;
    histogram_annotation_settings.background_color = [1 1 1];
    histogram_annotation_settings.color = [0 0 0];
    histogram_annotation_settings.interpreter = 'none';

    %% Plot settings for Closed-Loop histograms
    CL_hist_plot_settings = struct;
    % overlap: logical (0 default); plots every 2 rows of conditions on a single row of axes in different colors
    CL_hist_plot_settings.overlap = 0;
    CL_hist_plot_settings.rep_colors = [0.5 0.5 0.5; 1 0.5 0.5; 0.5 0.5 1];
    CL_hist_plot_settings.rep_lineWidth = 0.05;
    CL_hist_plot_settings.mean_colors = [0 0 0;1 0 0; 0 0 1];
    CL_hist_plot_settings.mean_lineWidth = 1;
    CL_hist_plot_settings.histogram_ylimits = [0 100; -6 6; 2 10];
    CL_hist_plot_settings.subtitle_fontSize = 8;

    %% Plot settings for Open-Loop timeseries plots

    timeseries_plot_settings = struct;
    timeseries_plot_settings.timeseries_ylimits = [-1.1 1.1; -1 6; -1 6; -1 6; 1 192; -1.1 1.1; 2 20; -2 4]; %[min max] y limits for each datatype (including 1 additional for 'faLmR' option)
    timeseries_plot_settings.timeseries_xlimits = [0 4];
    timeseries_plot_settings.subtitle_fontSize = 8;
    timeseries_plot_settings.legend_fontSize = 6;
    timeseries_plot_settings.overlap = 0;
    timeseries_plot_settings.rep_colors = [0.5 0.5 0.5; 1 0.5 0.5; 0.5 0.5 1];
    timeseries_plot_settings.rep_lineWidth = 0.05;
    timeseries_plot_settings.mean_colors = [0 0 0; 1 0 0; 0 0 1; 0 1 0; 1 1 1; 1 1 0; 1 0 1; 0 1 1; .5 .5 .5];
    timeseries_plot_settings.mean_lineWidth = 1;
    timeseries_plot_settings.edgeColor = 'none';
    timeseries_plot_settings.patch_alpha = 0.3; %sets the level of transparency for patch region around timeseries data
    timeseries_plot_settings.frame_scale = .5;
    timeseries_plot_settings.frame_color = [0.7 0.7 0.7];
    timeseries_plot_settings.frame_superimpose = 0;%plots the frame position underneath each timeseries plot

    %% Plot settings for tuning curves
    TC_plot_settings = struct;
    TC_plot_settings.overlap = 0;
    TC_plot_settings.rep_lineWidth = 0.05;
    TC_plot_settings.mean_lineWidth = 1;
    TC_plot_settings.timeseries_ylimits = [-1.1 1.1; -1 6; -1 6; -1 6; 1 192; -1.1 1.1; 2 20; 0 5.1];
    TC_plot_settings.rep_colors = [0.5 0.5 0.5; 1 0.5 0.5; 0.5 0.5 1; 0.5 0.75 0.5; 1 0.5 1 ]; %default 3 colors supports up to 3 groups (add more colors for more groups)
    TC_plot_settings.mean_colors = [0 0 0; 1 0 0; 0 0 1; 0 0.5 0; 1 0 1; 0 1 1];
    TC_plot_settings.subtitle_fontSize = 8;

    %% Save settings

    save_settings.paperunits = 'inches';
    save_settings.x_width = 8; 
    save_settings.y_width = 10;
    save_settings.orientation = 'landscape';

end