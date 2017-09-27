%ask to save progress and quit
progress=input('Save Progress? (y?): ','s');
progress=lower(progress);
if (strcmp(progress,'y')==1)
    save('FootAnalyze.mat','FootAnalyze')
    Quit=input('Quit? (y?): ','s');
    Quit=lower(Quit);
    if (strcmp(Quit,'y')==1)
        error('Exiting application')
    end;
end;