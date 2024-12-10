function[centers] = Visualizecenters(x,y,z,diameters,lowerbound,upperbound)

diameterindices2 = lowerbound<diameters(:,4) & diameters(:,4)<upperbound;
centers = diameters(diameterindices2,:);
xyzindices = z>lowerbound & z<upperbound;
x = x(xyzindices);
y = y(xyzindices);
z = z(xyzindices);
figure;
hold on;

scatter3(centers(:,2),centers(:,3),centers(:,4),35,centers(:,1),'filled');
    colormap('jet');
    colorbar;

scatter3(x,y,z,5,[0.75 0.75 0.75],'filled');
    title('centers of z-sections');
    zlabel('z');
    xlabel('x');
    ylabel('y');
    axis equal;