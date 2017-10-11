%% Plot the result of our method

plot(cmcS(1,:),'g-+','LineWidth',2);
box('on');
title(['CMC on ' dataset ' dataset']);
set(gca,'XTick',[1 2 5 10 15 25]);
ylabel('Matches');
xlabel('Rank');
xlim([1 25]);
ylim([0 1]);
hold off;
grid on;
hold on;
plot(cmcS(2,:),'b-*','LineWidth',2);
plot(cmcS(3,:),'c-','LineWidth',2);
plot(cmcS(4,:),'m.-','LineWidth',2);
plot(cmcS(5,:),'r-x','LineWidth',2);
h=legend(method_name_1,method_name_2,'Fusion\_Baseline','Our\_SRA','Our\_DSRA','Location','SouthEast');
set(h,'Fontsize',12);
