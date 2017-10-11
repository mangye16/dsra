%% Input orginal rank
% It's used for inputing the original ranking list of the method
switch dataset  
  case  {'viper'} %viper has two confirgurations
    rank_dir    = ['data/' dataset '_rank/'];
    switch method
        case {'1 2'}
        load( [rank_dir 'kissme_rank_' dataset '.mat']);   %The orginal ranking list of method 1
        RL_1_a_b = kissme_rank_a_b;
        RL_1_b_b = kissme_rank_b_b;
        load( [rank_dir 'sdc_rank_' dataset '.mat']);   %The orginal ranking list of method 2
        RL_2_a_b = sdc_rank_a_b;
        RL_2_b_b = sdc_rank_b_b;
        method_name_1 = 'KISSME';
        method_name_2 = 'SDC';
        case {'3 4'}
        load( [rank_dir 'sdalf_rank_' dataset '.mat']);   %The orginal ranking list of method 1
        RL_1_a_b = sdalf_rank_a_b;
        RL_1_b_b = sdalf_rank_b_b;
        load( [rank_dir 'ldfv_rank_' dataset '.mat']);   %The orginal ranking list of method 2
        RL_2_a_b = ldfv_rank_a_b;
        RL_2_b_b = ldfv_rank_b_b;
        method_name_1 = 'SDALF';
        method_name_2 = 'LDFV';
        otherwise
        fprintf('The confirguration is not correct!');
    end
case {'cuhk'} % cuhk only one
    rank_dir    = ['data/' dataset '_rank/'];
    load( [rank_dir 'kissme_rank_' dataset '.mat']);   %The orginal ranking list of method 1
    RL_1_a_b = kissme_rank_cuhk_a_b;
    RL_1_b_b = kissme_rank_cuhk_b_b;
    load( [rank_dir 'sdc_rank_' dataset '.mat']);   %The orginal ranking list of method 2
    RL_2_a_b = sdc_rank_cuhk_a_b;
    RL_2_b_b = sdc_rank_cuhk_b_b;
    method_name_1 = 'KISSME';
    method_name_2 = 'SDC';
otherwise
    fprintf('The dataset selection is not correct!');
end