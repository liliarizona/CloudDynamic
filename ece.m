function ece()
%data=[0 0;1 1;3 3;11 11;22 22;36 29;27 21;12 2];
%data=[0 0;0 0;1 1;3 3;6 6;8 8;11 7;4 2];
%data=[0 0;0 0;1 1;2 2;5 5;9 7;6 6;2 1];
%data=[0 0;0 0;0 0;1 1;4 4;6 6;5 5;1 1];
data=[112 89;33 27;25 22;17 17];
[m n]=size(data);
b=bar(data);
ch=get(b,'children');
set(gca,'XTickLabel',{'solution1','solution2','solution3','solution4'});
legend('Chronologic Backtracking','Directional Look Ahead');
ylabel('total number of backtracks for each solution');