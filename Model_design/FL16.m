%Figure for LSW friction law

mu_s = 0.6;
mu_d = 0.1;
d_c = 2.7;

k = (mu_s - mu_d) / (0-d_c); 
x = 0:0.1:10;
for i=1:length(x)
    if x(i)<2.7
        y(i) = k*x(i)+mu_s;
    else
        y(i) = 0;
    end
end 
   

figure
plot(x,y)
ylim([0,1]);
xlim([0,5]);
%%
p1=[0.1,0.6];
p2=[2.7,0];
p4 = [2.7,10];
p3=[0.1,0.1];
p5=[0,2.7];
dx = 0.5;
dy=0.02;
x = 2.7*ones(1,10);
y = linspace(0,0.1,10);
y1 = 0.1*ones(1,10);
x1 = linspace(0,2.7,10);

fig = figure;
fig.Units = 'centimeters';
fig.Position = [0 0 50 50/1.6];%define size of the figure
l1 = line(p2,p1);
set(l1,"LineWidth",5,"Color",'r');
hold on
l2 = line(p4,p3);
set(l2,"LineWidth",5,"Color",'r');
hold on
plot(x,y,'b--',"LineWidth",5);
hold on
plot(x1,y1,'b--',"LineWidth",5);


ax=gca;
ax.FontSize =50; 


title('Linear Slip Weakening Friction Law','FontSize',50,'Fontweight','bold');
xlabel('Slip [meters]','FontSize',50);
ylabel('Coeficient of friciton','FontSize',50);
text(0,0.6+0.05,'\mu_s','FontSize',50);
text(0,0.1+0.05,'\mu_d','FontSize',50)
text(2.7,-1,'D_c','FontSize',50)



ylim([0,1]);
yticks([0 0.1 0.6 1]);
xlim([0,10]);
xticks([2.7 5 10]);





