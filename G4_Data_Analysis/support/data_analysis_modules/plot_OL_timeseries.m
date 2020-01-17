%plot timeseries data for open-loop trials

%Variables i need for this:  overlap, \
%mean_Colors, mean_LineWidth, EdgeColor, patch_alpha,
%subtitle_FontSize, timeseries_ylimits, timeseries_xlimits,
%frame_superimpose, Frame_ind, frame_scale, frame_color, 


function plot_OL_timeseries(timeseries_data, timestampsIN, OL_conds, OL_durations, OL_inds, ...
    axis_labels, Frame_ind, num_groups, genotype, plot_settings, top_left_place, bottom_left_place, ...
    left_col_places)

    overlap = plot_settings.overlap;
    rep_Colors = plot_settings.rep_colors;
    mean_Colors = plot_settings.mean_colors;
    mean_LineWidth = plot_settings.mean_lineWidth;
    EdgeColor = plot_settings.edgeColor;
    patch_alpha = plot_settings.patch_alpha;
    subtitle_FontSize = plot_settings.subtitle_fontSize;
    legend_FontSize = plot_settings.legend_fontSize;
    frame_scale = plot_settings.frame_scale;
    frame_color = plot_settings.frame_color;
    frame_superimpose = plot_settings.frame_superimpose;
    timeseries_ylimits = plot_settings.timeseries_ylimits;
    timeseries_xlimits = plot_settings.timeseries_xlimits;
    rep_LineWidth = plot_settings.rep_lineWidth;
    cond_name = plot_settings.cond_name;
    

    
    if ~isempty(OL_conds)
    
    num_exps = size(timeseries_data,2);
    %loop for different data types
        for d = OL_inds
            
            %num_plot_rows = (1-overlap/2)*max(nansum(OL_conds(:,:,fig)>0));
            %num_plot_cols = max(nansum(OL_conds(:,:,fig)>0,2));
            num_plot_rows = size(OL_conds,1);
            num_plot_cols = size(OL_conds,2);
            figure('Position',[100 100 540 540*(num_plot_rows/num_plot_cols)])
            for row = 1:num_plot_rows
                for col = 1:num_plot_cols
                    cond = OL_conds(1+(row-1)*(1+overlap),col);
                    placement = col+num_plot_cols*(row-1);
                    place = row+num_plot_rows*(col-1);
                    if cond>0
                        better_subplot(num_plot_rows, num_plot_cols, placement)
                        hold on
                        for g = 1:num_groups
                            tmpdata = squeeze(timeseries_data(g,:,d,cond,:));
                            meandata = nanmean(tmpdata);
                            nanidx = isnan(meandata);
                            stddata = nanstd(tmpdata);
                            semdata = stddata./sqrt(sum(max(~isnan(tmpdata),[],2)));
                            timestamps = timestampsIN(~nanidx);
                            meandata(nanidx) = []; 
                            semdata(nanidx) = []; 
                            if num_groups==1 && overlap==0 
                                plot(repmat(timestampsIN',[1 num_exps]),tmpdata','Color',mean_Colors(g,:),'LineWidth',rep_LineWidth);
                            end
                            plot(timestamps,meandata,'Color',mean_Colors(g,:),'LineWidth',mean_LineWidth);
                            if num_groups>1
                                patch([timestamps fliplr(timestamps)],[meandata+semdata fliplr(meandata-semdata)],'k','FaceColor',mean_Colors(g,:),'EdgeColor','none','FaceAlpha',patch_alpha)
                            end
                        end
%                         titlestr = ['\fontsize{' num2str(subtitle_FontSize) '} Condition #{\color[rgb]{' num2str(mean_Colors(g,:)) '}' num2str(cond)]; 
                        title(cond_name{cond},'FontSize',subtitle_FontSize)
                        ylim(timeseries_ylimits(d,:));
                        %xlim(timeseries_xlimits)
                        if frame_superimpose==1
                            yrange = diff(timeseries_ylimits(d,:));
                            framepos = squeeze(nanmedian(nanmedian(timeseries_data(:,:,Frame_ind,cond,:),2),1))';
                            framepos = (frame_scale*framepos/max(framepos))+timeseries_ylimits(d,1)-frame_scale*yrange;
                            ylim([timeseries_ylimits(d,1)-frame_scale*yrange timeseries_ylimits(d,2)])
                            plot(timestampsIN,framepos,'Color',frame_color,'LineWidth',mean_LineWidth);
                        end
                        if overlap==1
                            cond = OL_conds(row*2,col);
                            if cond>0
%                                 titlestr = [titlestr ' \color[rgb]{' num2str(rep_Colors(g,:)) '}(' num2str(cond) ')'];
                                for g = 1:num_groups
                                    tmpdata = squeeze(timeseries_data(g,:,d,cond,:));
                                    meandata = nanmean(tmpdata);
                                    nanidx = isnan(meandata);
                                    stddata = nanstd(tmpdata);
                                    semdata = stddata./sqrt(sum(max(~isnan(tmpdata),[],2)));
                                    timestamps = timestampsIN(~nanidx);
                                    meandata(nanidx) = []; 
                                    semdata(nanidx) = []; 
                                    plot(timestamps,meandata,'Color',mean_Colors(g,:),'LineWidth',mean_LineWidth);
                                    patch([timestamps fliplr(timestamps)],[meandata+semdata fliplr(meandata-semdata)],'k','FaceColor',mean_Colors(g,:),'EdgeColor','none','FaceAlpha',patch_alpha)
                                end
                            end
                        end
%                         title([titlestr '}'])
                        % title
                        title(cond_name{cond},'FontSize',subtitle_FontSize)
                        % legend


                    end



                    % setting axes and labels

                    if ~ismember(place,left_col_places) %far-most left axis (clear all the right subplots)
                          currGraph = gca; 
                          currGraph.YAxis.Visible = 'off';
                    end 
                    % Set labels
                    xlabel('')
                    ylabel('')
                    if place == top_left_place
                        ylabel(axis_labels(2)) %1st subplot - Top Left
                        set(gca,'YTick');
                    end
                    if place == bottom_left_place
                        xlabel(axis_labels(1)) %7th subplot - Bottom Left
                    end
                    if ~isnan(OL_durations(place))
                        xlim([0, OL_durations(place)]);
                    end

%                         % setting figures
%                         if OL_conds == 41 
%                             set(gcf,'Position', [10 10 250 400])
%                         end
                end
            end

            h = findobj(gcf,'Type','line');
            if num_groups==1
                legend1 = legend(genotype,'FontSize',legend_FontSize);
            else
                legend1 = legend(h(num_groups+1:-1:2),genotype{1:end},'FontSize',legend_FontSize,'Orientation','horizontal');%prints warnings in orange but ignore
            end


            newPosition = [0.5 0.004 0.001 0.001]; %legend positioning


            newUnits = 'normalized';
            legend1.ItemTokenSize = [10,7];
            set(legend1,'Position', newPosition,'Units', newUnits, 'Interpreter', 'none','Box','off');



        end
    end
    
end
