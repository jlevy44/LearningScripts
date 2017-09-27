%Save progress and ask to quit...
    save('InputFile.mat','InputStructure')
    Quit=input('Quit? (y?): ','s');
    Quit=lower(Quit);
    if (strcmp(Quit,'y')==1)
        error('Exiting application')
    end;