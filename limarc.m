function [x,y]=limarc(O,A,B,nbpts)

if nargin < 4
nbpts=100;
end

rA=sqrt(sum((O-A).^2));
rB=sqrt(sum((O-B).^2));
if abs(rA-rB) > 1e-1
	error('on veut les points A et B sur un cecle de centre O')
end
r=rA;

tA=sign(A(2)-O(2))*acos((A(1)-O(1))/rA);
tB=sign(B(2)-O(2))*acos((B(1)-O(1))/rB);


if abs(tB-tA)>pi
	if tA>tB
        	tA=tA-2*pi;
	else 
		tB=tB-2*pi;
	end
end
t=linspace(tA,tB,nbpts);

x=O(1)+rA*cos(t);
y=O(2)+rA*sin(t);

