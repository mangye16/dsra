%% Similarity and Dissimilarity Ranking Aggregation 
% It's for the main process of our method

cmcS=zeros(5,size(RL_1_a_b,2)); %init of the CMC(Cumulated Matching Characteristics) curves
for c=1:trial  
	%The method 1
    rank_1_a_b = RL_1_a_b(:,:,c);
    rank_1_b_b = RL_1_b_b(:,:,c);
    %The method 2
    rank_2_a_b = RL_2_a_b(:,:,c);
    rank_2_b_b = RL_2_b_b(:,:,c);
    
    rerank_1 = rank_1_a_b + rank_2_a_b; %Driectly  Combination
    rerank_2 =(rank_1_a_b+0.2*rank_2_a_b)/1.2;
%     rerank_2 =(rank_1_a_b+rank_2_a_b)/2;
    rerank_3 = rerank_2;
    num_pic = size(rank_1_a_b,2);
    for i=1:num_pic
        tmp_idx_a_b_1 = find (rank_1_a_b(i,:)<=num_knn);
        tmp_idx_a_b_2 = find (rank_2_a_b(i,:)<=num_knn);
        for j=1:length(tmp_idx_a_b_1)
            tmp_idx_b_b_1 = find (rank_1_b_b(tmp_idx_a_b_1(j),:)<=num_knn);
            tmp_idx_b_b_2 = find (rank_2_b_b(tmp_idx_a_b_2(j),:)<=num_knn);
            tmp_sim_2(j) = length(intersect(tmp_idx_a_b_2,tmp_idx_b_b_2))/length(union(tmp_idx_a_b_2,tmp_idx_b_b_2));

        end
        [new_sim_2 tmp_idx_2]= sort(tmp_sim_2,'descend');
        [tmp_dist_2 tmp_new_rank_2] = sort(tmp_idx_2,'ascend');

        rerank_2(i,tmp_idx_a_b_2)=1/2*(rerank_2(i,tmp_idx_a_b_2)+0.5*tmp_new_rank_2);
%       rerank_3(i,tmp_idx_a_b_2)=1/2*(rerank_3(i,tmp_idx_a_b_2)+0.7*tmp_ne
%       w_rank_2);
       [dist tmp_rank(i,:)] = sort(rerank_2(i,:));
       [tmp_dist rank_a_b(i,:)] = sort(tmp_rank(i,:),'ascend');
       
       
       dis_idx_1 = find (rank_1_a_b(i,:)>(num_pic-num_dis));
       dis_idx_2 = find (rank_2_a_b(i,:)>(num_pic-num_dis));
       tmp_dis_idx = union(dis_idx_1,dis_idx_2);
       %compute the original term frequency
       dis_idx = unique(tmp_dis_idx);
       for m= 1:length(tmp_dis_idx)
           tmp_tf = length(find(dis_idx(m)==tmp_dis_idx));
           if rank_a_b(i,dis_idx(m))>7
%                 rank_a_b(i,dis_idx(m)) =  rank_a_b(i,dis_idx(m))*(1+tmp_tf)^(2*alpha);
%                 rank_a_b(i,dis_idx(m)) =  rank_a_b(i,dis_idx(m))+tmp_tf*5;
                rank_a_b(i,dis_idx(m)) =  rank_a_b(i,dis_idx(m))*exp(tmp_tf*beta);
           end
       end
       
      % backward requery
       for k =1:length(tmp_dis_idx)
           tmp_dis_idx_b_1(k,:) = find (rank_1_b_b(tmp_dis_idx(k),:)<=num_dis);
           tmp_dis_idx_b_2(k,:) = find (rank_2_b_b(tmp_dis_idx(k),:)<=num_dis);
       end
       tmp_dis_idx_1 = [tmp_dis_idx_b_1(:);tmp_dis_idx_b_2(:)];
       dis_idx_1 = unique(tmp_dis_idx_1);
       %compute the term frequency
       for m= 1:length(dis_idx_1)
           tmp_tf_1 = length(find(dis_idx_1(m)==tmp_dis_idx_1));
           if rank_a_b(i,dis_idx_1(m))>7
%                 rank_a_b(i,dis_idx_1(m)) =  rank_a_b(i,dis_idx_1(m))*((1+tmp_tf_1)^alpha);
%                   rank_a_b(i,dis_idx_1(m)) =  rank_a_b(i,dis_idx_1(m))+tmp_tf_1*2;
                  rank_a_b(i,dis_idx_1(m)) =  rank_a_b(i,dis_idx_1(m))*exp(tmp_tf_1*beta);
           end
       end
       clear dis_idx_1 tmp_tf_1 tmp_dis_idx_1 tmp_dis_idx dis_idx tmp_tf tmp_dis_idx_b_1 tmp_dis_idx_b_2;
       
    end
    rerank_2 =(rank_1_a_b+0.2*rank_2_a_b)/1.2;
    %compute the CMC
    cmcS(1,:) = cmcS(1,:) + calc_CMC(rank_1_a_b);
    cmcS(2,:) = cmcS(2,:) + calc_CMC(rank_2_a_b);
    cmcS(3,:) = cmcS(3,:) + calc_CMC(rerank_1);
    cmcS(4,:) = cmcS(4,:) + calc_CMC(rerank_2);
    cmcS(5,:) = cmcS(5,:) + calc_CMC(rank_a_b);  
end
cmcS=cmcS/c;

%compute the nAUC (normalized Area Under Curve) values
nAUC = mean(cmcS,2); 
