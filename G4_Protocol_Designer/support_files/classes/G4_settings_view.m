classdef G4_settings_view < handle

    properties
        fig_
        con_
        config_filepath_textbox_
        sheet_key_textbox_
        experimenter_gid_textbox_
        age_gid_textbox_
        sex_gid_textbox_
        geno_gid_textbox_
        temp_gid_textbox_
        rearing_gid_textbox_
        light_gid_textbox_
        run_protocol_textbox_
        plot_protocol_textbox_
        proc_protocol_textbox_
        flight_test_textbox_
        walkCam_test_textbox_
        walkChip_test_textbox_
        test_run_textbox_
        test_process_textbox_
        test_plot_textbox_
        disabled_color_textbox_
        disabled_text_textbox_
    end
    
    properties (Dependent)
        fig
        con
        config_filepath_textbox
        sheet_key_textbox
        experimenter_gid_textbox
        age_gid_textbox
        sex_gid_textbox
        geno_gid_textbox
        temp_gid_textbox
        rearing_gid_textbox
        light_gid_textbox
        run_protocol_textbox
        plot_protocol_textbox
        proc_protocol_textbox
        flight_test_textbox
        walkCam_test_textbox
        walkChip_test_textbox
        test_run_textbox
        test_process_textbox
        test_plot_textbox
        disabled_color_textbox
        disabled_text_textbox
    end
    
    methods
        
        function self = G4_settings_view(controller)
            %% User adjusted values to control appearance and object
            %  positions
            self.con = controller;
            figure_position = [.1 .1 .8 .8];
            top_left_label = [.01,.95, .24, .04]; %position of the first label
            gap_between_edges = .0052; %size gap between objects
            textbox_label_ratio = 2.5; %ratio of the textbox size to the label size
            button_textbox_ratio = .15; %ratio of the button size to the textbox size
            panel_height = .4;
            panel_width = .98;
            self.fig = figure('Name', 'G4 Settings', 'NumberTitle', 'off', ...
                'units','normalized', 'Position', figure_position);
            
            %% Configuration filepath
            %Configuration filepath - label
            config_label = self.create_label(self.fig, 'Configuration file location: ', top_left_label);
            
            %Configuration filepath - textbox
            config_box_position = self.calc_new_textbox_position(top_left_label, gap_between_edges, textbox_label_ratio);
            self.config_filepath_textbox = self.create_text_box(self.fig, self.con.model.settings.Configuration_Filepath, config_box_position);           
            
            %Configuration filepath - browse button
            browse_position = self.calc_new_browse_position(config_box_position, gap_between_edges, button_textbox_ratio);
            config_browse_button = self.create_button(self.fig, 'Browse', browse_position);
            
            %% Default run protocol
            %Default run protocol - label
            run_label_pos = self.calc_new_label_position(top_left_label, gap_between_edges);
            run_label = self.create_label(self.fig, 'Default Run Protocol: ', run_label_pos);
            
            %Def run protocol - textbox
            run_box_pos = self.calc_new_textbox_position(run_label_pos, gap_between_edges, textbox_label_ratio);
            self.run_protocol_textbox = self.create_text_box(self.fig, self.con.model.settings.run_protocol_file, run_box_pos);
            %set(self.run_protocol_textbox);
            
            %Def run protocol - browse button
            browse2_pos = self.calc_new_browse_position(run_box_pos, gap_between_edges, button_textbox_ratio);
            run_browse_button = self.create_button(self.fig, 'Browse', browse2_pos);
            
            %% Default processing protocol
             %Def processing protocol - label
            
            proc_label_pos = self.calc_new_label_position(run_label_pos, gap_between_edges);
            proc_label = self.create_label(self.fig, 'Default Processing Protocol: ', proc_label_pos);
            
            %Def processing protocol - textbox
            
            proc_box_pos = self.calc_new_textbox_position(proc_label_pos, gap_between_edges, textbox_label_ratio);
            self.proc_protocol_textbox = self.create_text_box(self.fig, self.con.model.settings.processing_file, proc_box_pos);
            
            %Def processing protocol - browse button
            browse4_pos = self.calc_new_browse_position(proc_box_pos, gap_between_edges, button_textbox_ratio);
            proc_browse_button = self.create_button(self.fig, 'Browse', browse4_pos);
            
            %% Default plotting protocol
            %Def plot protocol - label
            
            plot_label_pos = self.calc_new_label_position(proc_label_pos, gap_between_edges);
            plot_label = self.create_label(self.fig, 'Default Plotting Protocol: ', plot_label_pos);
            
            %Def plot protocol - textbox
            plot_box_pos = self.calc_new_textbox_position(plot_label_pos, gap_between_edges, textbox_label_ratio);
            self.plot_protocol_textbox = self.create_text_box(self.fig, self.con.model.settings.plotting_file, plot_box_pos);
            
            %Def plot protocol - browse button
            browse3_pos = self.calc_new_browse_position(plot_box_pos, gap_between_edges, button_textbox_ratio);
            plot_browse_button = self.create_button(self.fig, 'Browse', browse3_pos);
            
            %% Default flight test protocol
             %Def flight test protocol - label
            
            flight_label_pos = self.calc_new_label_position(plot_label_pos, gap_between_edges);
            flight_label = self.create_label(self.fig, 'Default Flight Test Protocol: ', flight_label_pos);
            
            %Def flight test protocol - textbox
            flight_box_pos = self.calc_new_textbox_position(flight_label_pos, gap_between_edges, textbox_label_ratio);
            self.flight_test_textbox = self.create_text_box(self.fig, self.con.model.settings.test_protocol_file_flight, flight_box_pos);
            
            %Def flight test protocol - browse button
            browse5_pos = self.calc_new_browse_position(flight_box_pos, gap_between_edges, button_textbox_ratio);
            flight_browse_button = self.create_button(self.fig, 'Browse', browse5_pos);
            
            %% Default camera walk test protocol
            %Def cam test protocol - label
            
            cam_label_pos = self.calc_new_label_position(flight_label_pos, gap_between_edges);
            cam_label = self.create_label(self.fig, 'Default Camera Walk Test Protocol: ', cam_label_pos);
            
            %Def cam test protocol - textbox
            
            cam_box_pos = self.calc_new_textbox_position(cam_label_pos, gap_between_edges, textbox_label_ratio);
            self.walkCam_test_textbox = self.create_text_box(self.fig, self.con.model.settings.test_protocol_file_camWalk, cam_box_pos);
            
            %Def cam test protocol - browse button
            browse6_pos = self.calc_new_browse_position(cam_box_pos, gap_between_edges, button_textbox_ratio);
            cam_browse_button = self.create_button(self.fig, 'Browse', browse6_pos);
            
            %% Default Chip walk test protocol
            %Def chip test protocol - label
            
            chip_label_pos = self.calc_new_label_position(cam_label_pos, gap_between_edges);
            chip_label = self.create_label(self.fig, 'Default Chip Walk Test Protocol: ', chip_label_pos);
            
            %Def chip test protocol - textbox
            
            chip_box_pos = self.calc_new_textbox_position(chip_label_pos, gap_between_edges, textbox_label_ratio);
            self.walkChip_test_textbox = self.create_text_box(self.fig, self.con.model.settings.test_protocol_file_chipWalk, chip_box_pos);
            
            %Def chip test protocol - browse button
            browse7_pos = self.calc_new_browse_position(chip_box_pos, gap_between_edges, button_textbox_ratio);
            chip_browse_button = self.create_button(self.fig, 'Browse', browse7_pos);
            
            %% Default run protocol for the TEST
            %Def run protocol for test - label
            
            testRun_label_pos = self.calc_new_label_position(chip_label_pos, gap_between_edges);
            testRun_label = self.create_label(self.fig, 'Default Run Protocol for Test: ', testRun_label_pos);
            
            %Def run protocol for test - textbox
            
            testRun_box_pos = self.calc_new_textbox_position(testRun_label_pos, gap_between_edges, textbox_label_ratio);
            self.test_run_textbox = self.create_text_box(self.fig, self.con.model.settings.test_run_protocol_file, testRun_box_pos);
            
            %Def run protocol for test - browse button
            browse8_pos = self.calc_new_browse_position(testRun_box_pos, gap_between_edges, button_textbox_ratio);
            testRun_browse_button = self.create_button(self.fig, 'Browse', browse8_pos);
            %% Default processing file for the TEST 
            
            %Def process file for test - label
            
            test_process_label_pos = self.calc_new_label_position(testRun_label_pos, gap_between_edges);
            test_process_label = self.create_label(self.fig, 'Default Processing file for Test: ', test_process_label_pos);
            
            %Def process file for test - textbox
            
            test_process_box_pos = self.calc_new_textbox_position(test_process_label_pos, gap_between_edges, textbox_label_ratio);
            self.test_process_textbox = self.create_text_box(self.fig, self.con.model.settings.test_processing_file, test_process_box_pos);
            
            %Def process file for test - browse button
            browse9_pos = self.calc_new_browse_position(test_process_box_pos, gap_between_edges, button_textbox_ratio);
            test_process_browse_button = self.create_button(self.fig, 'Browse', browse9_pos);
            
            %% Default plotting file for the TEST
            %Def plot file for test - label
            test_plot_label_pos = self.calc_new_label_position(test_process_label_pos, gap_between_edges);
            test_plot_label = self.create_label(self.fig, 'Default Plotting file for Test: ', test_plot_label_pos);
            
            %Def plot file for test - textbox
            test_plot_box_pos = self.calc_new_textbox_position(test_plot_label_pos, gap_between_edges, textbox_label_ratio);
            self.test_plot_textbox = self.create_text_box(self.fig, self.con.model.settings.test_plotting_file, test_plot_box_pos);
            
            %Def plot file for test - browse button
            browse10_pos = self.calc_new_browse_position(test_plot_box_pos, gap_between_edges, button_textbox_ratio);
            test_plot_browse_button = self.create_button(self.fig, 'Browse', browse10_pos);
            
           
            %% The fill color of disabled cells
            %Disabled cell color - label
            color_label_pos = self.calc_new_label_position(test_plot_label_pos, gap_between_edges);
            color_label = self.create_label(self.fig, 'Color of disabled cells: ', color_label_pos);
            
            %Disabled cell color - textbox
            color_box_pos = self.calc_new_textbox_position(color_label_pos, gap_between_edges, textbox_label_ratio);
            self.disabled_color_textbox = self.create_text_box(self.fig, self.con.model.settings.Uneditable_Cell_Color, color_box_pos);
            
            %% The fill text of disabled cells
            %Disabled cell text - label
            text_label_pos = self.calc_new_label_position(color_label_pos, gap_between_edges);
            text_label = self.create_label(self.fig, 'Text inside disabled cells: ', text_label_pos);
            
            %Disabled cell text - textbox
            text_box_pos = self.calc_new_textbox_position(text_label_pos, gap_between_edges, textbox_label_ratio);
            self.disabled_text_textbox = self.create_text_box(self.fig, self.con.model.settings.Uneditable_Cell_Text, text_box_pos);
            
            %% Google Sheets information
            % Google Sheets key and GID values - panel
            panel_pos = [text_label.Position(1), text_label.Position(2) - gap_between_edges*2 - panel_height, panel_width, panel_height]; 
            googlesheet_panel = uipanel(self.fig, 'Title', 'Metadata Google Sheets Properties', ...
                'FontSize', 12, 'Position', panel_pos);
            
            % Google Sheets key and GID values - Google Sheets key
            sheet_label_pos = [top_left_label(1), top_left_label(2) - .07, top_left_label(3), top_left_label(4) + .07];
            sheet_label = self.create_label(googlesheet_panel, 'Google Sheets Key: ', sheet_label_pos);
            
            sheet_box_pos = self.calc_new_textbox_position(sheet_label_pos, gap_between_edges, textbox_label_ratio);
            self.sheet_key_textbox = self.create_text_box(googlesheet_panel, self.con.model.settings.Google_Sheet_Key, sheet_box_pos);
            
            % Google sheet key and GID values - Experimenter tab GID
            exp_label_pos = self.calc_new_label_position(sheet_label_pos, gap_between_edges);
            exp_label = self.create_label(googlesheet_panel, 'Experimenter Tab GID: ', exp_label_pos);
            
            exp_box_pos = self.calc_new_textbox_position(exp_label_pos, gap_between_edges, textbox_label_ratio);
            self.experimenter_gid_textbox = self.create_text_box(googlesheet_panel, self.con.model.settings.Users_Sheet_GID, exp_box_pos);
            
            % Google Sheets key and GID values - Fly age tab GID
            age_label_pos = self.calc_new_label_position(exp_label_pos, gap_between_edges);
            age_label = self.create_label(googlesheet_panel, 'Fly Age Tab GID: ', age_label_pos);
            
            age_box_pos = self.calc_new_textbox_position(age_label_pos, gap_between_edges, textbox_label_ratio);
            self.age_gid_textbox = self.create_text_box(googlesheet_panel, self.con.model.settings.Fly_Age_Sheet_GID, age_box_pos);
            
            % Google Sheets key and GID values - Fly sex tab GID
            sex_label_pos = self.calc_new_label_position(age_label_pos, gap_between_edges);
            sex_label = self.create_label(googlesheet_panel, 'Fly Sex Tab GID: ', sex_label_pos);
            
            sex_box_pos = self.calc_new_textbox_position(sex_label_pos, gap_between_edges, textbox_label_ratio);
            self.sex_gid_textbox = self.create_text_box(googlesheet_panel, self.con.model.settings.Fly_Sex_Sheet_GID, sex_box_pos);
            
            % Google Sheets key and GID values - Fly genotype tab GID
            geno_label_pos = self.calc_new_label_position(sex_label_pos, gap_between_edges);
            geno_label = self.create_label(googlesheet_panel, 'Fly Genotype Tab GID: ', geno_label_pos);
            
            geno_box_pos = self.calc_new_textbox_position(geno_label_pos, gap_between_edges, textbox_label_ratio);
            self.geno_gid_textbox = self.create_text_box(googlesheet_panel, self.con.model.settings.Fly_Geno_Sheet_GID, geno_box_pos);
            
            % Google Sheets key and GID values - Experiment temp tab GID
            temp_label_pos = self.calc_new_label_position(geno_label_pos, gap_between_edges);
            temp_label = self.create_label(googlesheet_panel, 'Experiment Temp tab GID: ', temp_label_pos);
            
            temp_box_pos = self.calc_new_textbox_position(temp_label_pos, gap_between_edges, textbox_label_ratio);
            self.temp_gid_textbox = self.create_text_box(googlesheet_panel, self.con.model.settings.Experiment_Temp_Sheet_GID, temp_box_pos);
            
            % Google Sheets key and GID values - Rearing protocol tab GID
            rearing_label_pos = self.calc_new_label_position(temp_label_pos, gap_between_edges);
            rearing_label = self.create_label(googlesheet_panel, 'Rearing Protocol tab GID: ', rearing_label_pos);
            
            rearing_box_pos = self.calc_new_textbox_position(rearing_label_pos, gap_between_edges, textbox_label_ratio);
            self.rearing_gid_textbox = self.create_text_box(googlesheet_panel, self.con.model.settings.Rearing_Protocol_Sheet_GID, rearing_box_pos);
            
            % Google Sheets key and GID values - Light Cycle tab GID
            light_label_pos = self.calc_new_label_position(rearing_label_pos, gap_between_edges);
            light_label = self.create_label(googlesheet_panel, 'Light Cycle tab GID: ', light_label_pos);
            
            light_box_pos = self.calc_new_textbox_position(light_label_pos, gap_between_edges, textbox_label_ratio);
            self.light_gid_textbox = self.create_text_box(googlesheet_panel, self.con.model.settings.Light_Cycle_Sheet_GID, light_box_pos);
            
            %% Apply and cancel buttons
            apply_button_pos = [gap_between_edges, gap_between_edges, self.config_filepath_textbox.Position(3)*button_textbox_ratio + .03, self.config_filepath_textbox.Position(4)];
            apply_button = self.create_button(self.fig, 'Apply Changes', apply_button_pos);
            cancel_button_pos = [apply_button_pos(1) + apply_button_pos(3) + .01, apply_button_pos(2), apply_button_pos(3), apply_button_pos(4)];
            cancel_button = self.create_button(self.fig, 'Cancel', cancel_button_pos);
            
            %% Set callbacks (browse, apply, and cancel buttons)
            set(apply_button, 'Callback', @self.apply_changes);
            set(cancel_button, 'Callback', @self.cancel_changes);
            set(config_browse_button, 'Callback', @self.browse_for_config);
            set(run_browse_button, 'Callback', @self.browse_for_run);
            set(plot_browse_button, 'Callback', @self.browse_for_plot);
            set(proc_browse_button, 'Callback', @self.browse_for_proc);
            set(flight_browse_button, 'Callback', @self.browse_for_flight);
            set(cam_browse_button, 'Callback', @self.browse_for_walkCam);
            set(chip_browse_button, 'Callback', @self.browse_for_walkChip);
            set(testRun_browse_button, 'Callback', @self.browse_for_testRun);
            set(test_process_browse_button, 'Callback', @self.browse_for_testProc);
            set(test_plot_browse_button, 'Callback', @self.browse_for_testPlot);
        end

        %% Callback functions - buttons
        function apply_changes(self, ~, ~)
           %Calls function for each value in the window checking that it's
           %value is valid. If it is (or has no limitation), the controller then calls the model
           %to update its value and the settings file accordingly. If not
           %valid, it returns an error
           failed = [];
           
           failed(end+1) = self.con.check_valid_config(self.config_filepath_textbox.String);
           failed(end+1) = self.con.check_valid_run_file(self.run_protocol_textbox.String);
           failed(end+1) = self.con.check_valid_plot_file(self.plot_protocol_textbox.String);
           failed(end+1) = self.con.check_valid_proc_file(self.proc_protocol_textbox.String);
           failed(end+1) = self.con.check_valid_flight_file(self.flight_test_textbox.String);
           failed(end+1) = self.con.check_valid_camWalk_file(self.walkCam_test_textbox.String);
           failed(end+1) = self.con.check_valid_chipWalk_file(self.walkChip_test_textbox.String);
           failed(end+1) = self.con.check_valid_test_run(self.test_run_textbox.String);
           failed(end+1) = self.con.check_valid_test_process(self.test_process_textbox.String);
           failed(end+1) = self.con.check_valid_test_plot(self.test_plot_textbox.String);
           failed(end+1) = self.con.check_valid_color(self.disabled_color_textbox.String);
           
           %Currently no validity testing for the following
           failed(end+1) = self.con.check_valid_text(self.disabled_text_textbox.String);
           failed(end+1) = self.con.check_valid_key(self.sheet_key_textbox.String);
           failed(end+1) = self.con.check_valid_usersGID(self.experimenter_gid_textbox.String);
           failed(end+1) = self.con.check_valid_ageGID(self.age_gid_textbox.String);
           failed(end+1) = self.con.check_valid_sexGID(self.sex_gid_textbox.String);
           failed(end+1) = self.con.check_valid_genoGID(self.geno_gid_textbox.String);
           failed(end+1) = self.con.check_valid_tempGID(self.temp_gid_textbox.String);
           failed(end+1) = self.con.check_valid_rearingGID(self.rearing_gid_textbox.String);
           failed(end+1) = self.con.check_valid_lightGID(self.light_gid_textbox.String);

           %This updates the gui with the most current model values. 
           self.con.update_view();
           if sum(failed) == 0
                self.con.close_window();
           end
        end
        
        function cancel_changes(self, ~, ~)
            self.con.close_window();
        end
        
        function browse_for_config(self, ~, ~)
            new_file = self.con.browse('*.ini');
            if new_file ~= 0
                self.config_filepath_textbox.String = new_file;
            end
        end
        
        function browse_for_run(self, ~, ~)
            new_file = self.con.browse('*.m');
            if new_file ~= 0
                self.run_protocol_textbox.String = new_file;
            end
        end
        
        function browse_for_plot(self, ~, ~)
            new_file = self.con.browse('*.m');
            if new_file ~= 0
                self.plot_protocol_textbox.String = new_file;
            end
        end
        
        function browse_for_proc(self, ~, ~)
            new_file = self.con.browse('*.m');
            if new_file ~= 0
                self.proc_protocol_textbox.String = new_file;
            end
        end
        
        function browse_for_flight(self, ~, ~)
            new_file = self.con.browse('*.g4p');
            if new_file ~= 0
                self.flight_test_textbox.String = new_file;
            end
        end
        
        function browse_for_walkCam(self, ~, ~)
            
            new_file = self.con.browse('*.g4p');
            if new_file ~= 0
                self.walkCam_test_textbox.String = new_file;
                
            end
        end
        
        function browse_for_walkChip(self, ~, ~)
            new_file = self.con.browse('*.g4p');
            if new_file ~= 0
                self.walkChip_test_textbox.String = new_file;
            end
        end
        
        function browse_for_testRun(self, ~, ~)
            new_file = self.con.browse('*.m');
            if new_file ~= 0
                self.test_run_textbox.String = new_file;
            end
        end
        
        function browse_for_testProc(self, ~, ~)
            new_file = self.con.browse('*.m');
            if new_file ~= 0
                self.test_process_textbox.String = new_file;
            end
        end
        
        function browse_for_testPlot(self, ~, ~)
            new_file = self.con.browse('*.m');
            if new_file ~= 0
                self.test_plot_textbox.String = new_file;
            end
        end

        %% Functions to create GUI objects
        function label = create_label(self, parent, text, position)
            label = uicontrol(parent, 'Style', 'text', 'units', 'normalized', ...
                'FontSize', 14, 'HorizontalAlignment', 'left', 'String', text, 'Position', position);
        end

        function box = create_text_box(self, parent, value, position)
            box = uicontrol(parent, 'Style', 'edit', 'units', 'normalized', ...
                'FontSize', 14, 'String', value, 'Position', position);      
        end

        function button = create_button(self, parent, text, position)
            button = uicontrol(parent, 'Style', 'pushbutton', 'units', 'normalized', ...
                'FontSize', 14, 'String', text, 'Position', position);
        end

        function position = calc_new_label_position(self, prev_pos, gap)
            position = [prev_pos(1), prev_pos(2) - gap - prev_pos(4), ...
                prev_pos(3), prev_pos(4)];
        end

        function position = calc_new_textbox_position(self, prev_pos, gap, ratio)
            position = [prev_pos(1) + prev_pos(3) + gap, ...
                prev_pos(2), prev_pos(3) * ratio, prev_pos(4)];
        end

        function position = calc_new_browse_position(self, prev_pos, gap, ratio)
            position = [prev_pos(1) + prev_pos(3) + gap, ...
                prev_pos(2), prev_pos(3)*ratio, prev_pos(4)];
        end

        
        %% Getters
        function value = get.fig(self)
            value = self.fig_;
        end

        function value = get.con(self)
            value = self.con_;
        end

        function value = get.config_filepath_textbox(self)
            value = self.config_filepath_textbox_;
        end

        function value = get.sheet_key_textbox(self)
            value = self.sheet_key_textbox_;
        end

        function value = get.experimenter_gid_textbox(self)
            value = self.experimenter_gid_textbox_;
        end

        function value = get.age_gid_textbox(self)
            value = self.age_gid_textbox_;
        end

        function value = get.sex_gid_textbox(self)
            value = self.sex_gid_textbox_;
        end

        function value = get.geno_gid_textbox(self)
            value = self.geno_gid_textbox_;
        end

        function value = get.temp_gid_textbox(self)
            value = self.temp_gid_textbox_;
        end

        function value = get.rearing_gid_textbox(self)
            value = self.rearing_gid_textbox_;
        end

        function value = get.light_gid_textbox(self)
            value = self.light_gid_textbox_;
        end

        function value = get.run_protocol_textbox(self)
            value = self.run_protocol_textbox_;
        end

        function value = get.plot_protocol_textbox(self)
            value = self.plot_protocol_textbox_;
        end

        function value = get.proc_protocol_textbox(self)
            value = self.proc_protocol_textbox_;
        end

        function value = get.flight_test_textbox(self)
            value = self.flight_test_textbox_;
        end

        function value = get.walkCam_test_textbox(self)
            value = self.walkCam_test_textbox_;
        end

        function value = get.walkChip_test_textbox(self)
            value = self.walkChip_test_textbox_;
        end

        function value = get.disabled_color_textbox(self)
            value = self.disabled_color_textbox_;
        end

        function value = get.disabled_text_textbox(self)
            value = self.disabled_text_textbox_;
        end

        function value = get.test_run_textbox(self)
            value = self.test_run_textbox_;
        end

        function value = get.test_process_textbox(self)
            value = self.test_process_textbox_;
        end

        function value = get.test_plot_textbox(self)
            value = self.test_plot_textbox_;
        end
        
        %% Setters
        function set.fig(self, value)
            self.fig_ = value;
        end

        function set.con(self, value)
            self.con_ = value;
        end

        function set.config_filepath_textbox(self, value)
            self.config_filepath_textbox_ = value;
        end

        function set.sheet_key_textbox(self, value)
            self.sheet_key_textbox_ = value;
        end

        function set.experimenter_gid_textbox(self, value)
            self.experimenter_gid_textbox_ = value;
        end

        function set.age_gid_textbox(self, value)
            self.age_gid_textbox_ = value;
        end

        function set.sex_gid_textbox(self, value)
            self.sex_gid_textbox_ = value;
        end

        function set.geno_gid_textbox(self, value)
            self.geno_gid_textbox_ = value;
        end

        function set.temp_gid_textbox(self, value)
            self.temp_gid_textbox_ = value;
        end

        function set.rearing_gid_textbox(self, value)
            self.rearing_gid_textbox_ = value;
        end

        function set.light_gid_textbox(self, value)
            self.light_gid_textbox_ = value;
        end

        function set.run_protocol_textbox(self, value)
            self.run_protocol_textbox_ = value;
        end

        function set.plot_protocol_textbox(self, value)
            self.plot_protocol_textbox_ = value;
        end

        function set.proc_protocol_textbox(self, value)
            self.proc_protocol_textbox_ = value;
        end

        function set.flight_test_textbox(self, value)
            self.flight_test_textbox_ = value;
        end

        function set.walkCam_test_textbox(self, value)
            self.walkCam_test_textbox_ = value;
        end

        function set.walkChip_test_textbox(self, value)
            self.walkChip_test_textbox_ = value;
        end

        function set.disabled_color_textbox(self, value)
            self.disabled_color_textbox_ = value;
        end

        function set.disabled_text_textbox(self, value)
            self.disabled_text_textbox_ = value;
        end

        function set.test_run_textbox(self, value)
            self.test_run_textbox_ = value;
        end

        function set.test_process_textbox(self, value)
            self.test_process_textbox_ = value;
        end

        function set.test_plot_textbox(self, value)
            self.test_plot_textbox_ = value;
        end
    end
end