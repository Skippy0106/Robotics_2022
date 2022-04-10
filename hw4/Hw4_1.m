x1=xlsread('C:\Users\v3096\OneDrive\桌面\四軸旋翼機\hw4\HW4-1','a2:a51');
x2=xlsread('C:\Users\v3096\OneDrive\桌面\四軸旋翼機\hw4\HW4-1','b2:b51');
y=xlsread('C:\Users\v3096\OneDrive\桌面\四軸旋翼機\hw4\HW4-1','c2:c51');
X=[ones(size(x1)) x1 x2];
b=regress(y,X);

scatter3(x1,x2,y,'filled')
hold on
x1fit = min(x1):10:max(x1);
x2fit = min(x2):10:max(x2);
[X1FIT,X2FIT] = meshgrid(x1fit,x2fit);
YFIT = b(1) + b(2)*X1FIT + b(3)*X2FIT 
mesh(X1FIT,X2FIT,YFIT)
xlabel('x1')
ylabel('x2')
zlabel('y')
view(50,10)
hold off