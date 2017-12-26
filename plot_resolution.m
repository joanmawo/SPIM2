%bkgnd = mean(Y);


f1 = fit(Z_1_70, Intensity_1_70, 'gauss2');
% f2 = fit(Z_1_80, Intensity_1_80, 'gauss2');
 
 figure
 plot(f1,Z_1_70, Intensity_1_70)
%  hold on
%  plot(f2,'--',Z_1_80, Intensity_1_80)
 title('Intensity depth profile - Two 2um beads separated 35um - Original Intensity');
 xlabel('Z spim [slices]');
 ylabel('Intensity [AU]');
 legend('Recorded Intensity','Fitted - 2 Gaussians')
 ylim([0 inf])
 
 
%%% Compute minima and derivative
 
