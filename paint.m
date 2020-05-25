% M.L. Paint, [ Silas Henderson ]
% 28x28 painter for mnist [ mguludag ]
function image_data=paint
    clc; clf;
    mouse_click_new = 0;                       
    mouse_down = 0;
    program_on = 1;
    
    function mouse_down_call(~,~)
        mouse_click_new = 1;
        mouse_down = 1;
    end

    function mouse_up_call(~,~)
        mouse_down = 0;
    end
   
    function close_req_call(~,~)
        program_on = 0;
        image_data = getfield( getframe( gcf),'cdata');
        image_data=imresize(image_data,.1);
        delete(gcf);
    end
     
    brush_line_count = 0;
    brush_size = 10; 
    active_color = [0,0,0];                 
    set(0, 'units', 'normalized');
    set(gcf,'Position', [500 500 280 280]);
    set(gcf, ...
        'windowbuttondownfcn', @mouse_down_call, 'color',   [0 0 0], ...
        'windowbuttonupfcn',   @mouse_up_call,   'menubar', 'none', ...
        'closerequestfcn',     @close_req_call,  'pointer', 'custom', ...
        'pointershapecdata',   NaN(16,16),       'units',   'normalized', ...
        'numbertitle',        'off');
    
    figure_pos = get(gcf, 'position');  
    
    set(gca, ...
        'units',    'normal',   'xlim', [0 1], ...          
        'position', [0 0 1 1],  'ylim', [0 1], ...     
        'ticklen',  [0 0],      'pickableparts','none', ...
        'box',      'on');    
    
    function box = box_patch(x, y, w, h, face_color, edge_color)
        box = patch( ...
            'vertices', [x-w, x-w, x+w, x+w; y-h, y+h, y+h, y-h]', ...
            'faces', [1, 2, 3, 4], ...
            'facecolor', face_color, ...
            'edgecolor', edge_color);     
    end
 
    brush_pointer = line( ...
        'linestyle', 'none', ...                   
        'marker', 'o', ...
        'markersize', brush_size, ...
        'markeredgecolor', 'white');
    
    function restack_graphics_objects
        figure_pos = get(gcf, 'position');   
        uistack( brush_pointer, 'top');
    end
       
    while program_on == 1
        
        mouse_pos  = get(0, 'pointerlocation');        
        brush_x = (mouse_pos(1) - figure_pos(1))/(figure_pos(3));        
        brush_y = (mouse_pos(2) - figure_pos(2))/(figure_pos(4)); 
    
        set( brush_pointer, ...
            'markersize', brush_size, ...
            'markerfacecolor', active_color, ...
            'xdata', brush_x,...   
            'ydata', brush_y);    
      
        if mouse_click_new == 1
            brush_line_count = brush_line_count + 1;
            brush_line(brush_line_count) = animatedline( ...
                'linewidth', brush_size, ...
                'color', active_color);
            uistack( brush_pointer, 'top');
            if brush_y > .9                          
                if brush_x > .15 && brush_x < .25
                    paint;
                end                 
            end
            mouse_click_new = 0;                                     
        end
    
        if mouse_down == 1                                      
            if brush_y>.0
            addpoints( brush_line( brush_line_count), brush_x, brush_y);
            end
        end
        pause(.01);
    end
    delete(gcf);
end