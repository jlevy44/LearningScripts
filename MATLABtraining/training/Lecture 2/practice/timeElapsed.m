function [time]=timeElapsed(start,finish)
    secPerMin=60;
    secPerHour=3600;
    secPerDay=24*secPerHour;
    secPerMonth=30.5*secPerDay;
    secPerYear=12*secPerMonth;
    secondConversion=[secPerYear secPerMonth secPerDay secPerHour ...
        secPerMin 1];
    elapsedTime=finish-start;
    time=secondConversion*elapsedTime'
 
end