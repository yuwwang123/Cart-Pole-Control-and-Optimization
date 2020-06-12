function plot_unicycle_trajectory(t, x, y_spline, z_spline)
y_d = ppval(y_spline, t);
z_d = ppval(z_spline, t);
a = 0.3;
y = x(:,1)';
z = x(:,2)';
th = x(:,3)';
stale = .01;
tic

i = 1;
while i<=numel(t)
    start = toc;
    hold off;
    scatter([0],[0],70,'filled','b');
    hold on;
    scatter([10],[0],70,'filled','g');
    
    
    rectangle('Position',[2,-3,6,6],...
    'Curvature',[1,1], 'FaceColor','r','EdgeColor','r');
    
    plot(y_d, z_d, 'b:','LineWidth',3);
    
    plot(y(1:i), z(1:i), 'g','LineWidth',3);
    plot([y(i) + a*cos(th(i)), y(i) - a*cos(th(i))], ...
         [z(i) + a*sin(th(i)), z(i) - a*sin(th(i))], 'r','LineWidth',3);

    B = 2;
    xlim([min(y_d) - B, max(y_d) + B]);
    ylim([min(z_d) - B, max(z_d) + B]);

    xlabel('y');
    ylabel('z');
    titl = sprintf('Unicycle Trajectory, $t =  %.2f $',t(i));
    title(titl,'Interpreter','latex');
    axis equal;
    
    compu = toc - start;
    stale_i = max(stale,compu*2);
    next_i = find(t >= start + stale_i);
    if numel(next_i) < 1
        if i < numel(t)
            i = numel(t);
        else
            break;
        end
    else
        i = next_i(1);
    end
    pause(t(i) - toc);
end