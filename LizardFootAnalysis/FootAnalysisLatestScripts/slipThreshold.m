        % Slip Threshold Script
        
        %assign stance positions for each foot to 2D cell
%         distStance{:,1}={StancePositions.FO}';
%         distStance{:,2}={StancePositions.FI}';
%         distStance{:,3}={StancePositions.HO}';
%         distStance{:,4}={StancePositions.HI}';
        
        % stance slip distances for each foot from touchdown to liftoff
        distStanceSlip{:,1}={distStance.FO}';
        distStanceSlip{:,2}={distStance.FI}';
        distStanceSlip{:,3}={distStance.HO}';
        distStanceSlip{:,4}={distStance.HI}';
        distStanceSlip{:,5}={distStance.ID}';
        
%         outlierTrialCell=cell(1,5);
        
        %start here, organize histograms and find trials!!!
        % figure out which IDs correspond to bad trials, I can also go leg
        % by leg with the current code I have...
        for footNumber=1:4
            distStanceFormat{footNumber}=[]
            for i = 1:length(distStanceSlip{1,1})
                for stanceNumber=1:3
                    if ~isequaln(distStanceSlip{1,footNumber}{i,1}(stanceNumber),NaN)
                        if cell2mat(distStanceSlip{1,footNumber}{i,1}(stanceNumber))>4
                            switch footNumber
                                case 1
                                    name='FO';
                                case 2
                                    name='FI';
                                case 3
                                    name='HO';
                                case 4
                                    name='HI';
                            end;
%                             outlierTrialCell=vertcat(outlierTrialCell,horzcat(distStanceSlip{1,5}{i},[name,num2str(stanceNumber)],num2str(cell2mat(distStanceSlip{1,footNumber}{i,1}(stanceNumber)))))
                        end;
                    end;
               
                end;
            addition=cell2mat(distStanceSlip{1,footNumber}{i}')
            distStanceFormat{footNumber}=[distStanceFormat{footNumber};addition];
            end;
            a=1;
            distStanceFormat{footNumber}=distStanceFormat{footNumber}(~arrayfun(@isnan,distStanceFormat{footNumber}))
        end;
%         outlierTrialCell=outlierTrialCell(2:end,:)
        

        
        
% %         now cut trials (foot stances) that fail slip threshold limits and separate
% %         feet out for additional analysis
%         for stanceNumber=1:3
%             [failedThresholdTrials,distStanceSlip{1,stanceNumber}] = ...
%                 StanceSlipDist( distStanceSlip{1,1}, stanceNumber,'FO' );
% %             for i=1:size(failedThresholdTrials')
% %                 relfootdat(failedThresholdTrials(i)).FO{1,stanceNumber}=NaN;
% %             end;
%             
%             [failedThresholdTrials,distStanceSlip{2,stanceNumber}] = ...
%                 StanceSlipDist( distStanceSlip{1,2}, stanceNumber,'FI' );
% %             for i=1:size(failedThresholdTrials')
% %                 relfootdat(failedThresholdTrials(i)).FI{1,stanceNumber}=NaN;
% %             end;
%             
%                         [failedThresholdTrials,distStanceSlip{3,stanceNumber}] = ...
%                 StanceSlipDist( distStanceSlip{1,3}, stanceNumber,'HO' );
% %             for i=1:size(failedThresholdTrials')
% %                 relfootdat(failedThresholdTrials(i)).HO{1,stanceNumber}=NaN;
% %             end;
%             
%                         [failedThresholdTrials,distStanceSlip{4,stanceNumber}] = ...
%                 StanceSlipDist( distStanceSlip{1,4}, stanceNumber,'HI' );
% %             for i=1:size(failedThresholdTrials')
% %                 relfootdat(failedThresholdTrials(i)).HI{1,stanceNumber}=NaN;
% %             end;
%         end;
%    a=1;     
%     distStanceSlip{1}=[distStanceSlip{1,1},distStanceSlip{1,2},distStanceSlip{1,3},B.ID];
%     distStanceSlip{2}=[distStanceSlip{2,1},distStanceSlip{2,2},distStanceSlip{2,3},B.ID];
%     distStanceSlip{3}=[distStanceSlip{3,1},distStanceSlip{3,2},distStanceSlip{3,3},B.ID];
%     distStanceSlip{4}=[distStanceSlip{4,1},distStanceSlip{4,2},distStanceSlip{4,3},B.ID];
% a=1;

    for i=1:4
        histogram(distStanceFormat{i},100);

        switch i
            case 1
                name='FO';
            case 2
                name='FI';
            case 3
                name='HO';
            case 4
                name='HI';
        end;
        disp([name '     (mean,median,max): ' num2str([mean(distStanceFormat{i}) ...
            median(distStanceFormat{i}) max(distStanceFormat{i})])])
        title([name, ' slipping distances (all three footStances)'])
        savefig(['Slip Histogram ', name, ' all stances'])
        figure;
    end;
    
%     filename = 'TrialSlipErrors.csv';
% outlierTrialCell=cell2table(outlierTrialCell)
% writetable(outlierTrialCell,filename)
    
%     error('end')