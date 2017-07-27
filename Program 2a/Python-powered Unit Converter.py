#display welcome text to user

welcomeText=['Welcome to our Python-powered Unit Converter v1.0 by Joshua Levy!',
             'You can convert Distances , Weights , & Volumes  to one another, but only',
             'within units of the same category, which are shown below. E.g.: 1 mi in ft',
             '   Distances: ft cm mm mi m yd km in',
             '   Weights: lb mg kg oz g',
             '   Volumes: floz qt cup mL L gal pint']
for line in welcomeText:
    print(line)

# creating lists of different metrics and their conversion factors to the base unit
distances=['ft','cm','mm','mi','m','yd','km','in']
weights=['lb', 'mg', 'kg', 'oz', 'g']
volume=['floz', 'qt', 'cup', 'mL', 'L', 'gal', 'pint']
# meter is base measurement for conversion, below are conversion factors
dist_conv=[0.3048,0.01,0.001,1609.34,1,0.9144,1000,0.0254]
# gram is base measurement for conversion
weight_conv=[453.592,0.001,1000,28.3495,1]
# liter is base measurement for conversion
vol_conv=[0.0295735,0.946353,0.24,0.001,1,3.78541,0.473176]


# create function that returns conversion factor indices for conversion factors for source and dest with respect to base
def convert_index(sourceDestUnit,metricInput):
    """
    convert_index inputs the type of unit of the source or destination unit and the metric list, and outputs the index
    of the metric list that matches up with the source/dest unit type. The index corresponds to a conversion factor.
    """
    if sourceDestUnit in metricInput:
        for index_conversion in range(len(metricInput)):
            if metricInput[index_conversion]==sourceDestUnit:
                return index_conversion
    else:
        return unit_conversion()

# create function that does conversion between units
def unit_conversion():

    """
    No inputs to this function, but it is a function that returns to itself if an error occurs or the app runs all the
    through. Asks for input and then converts between units of weight, volume, or length through base conversion
    factors.
    """

    #user input
    conversion_String=input('Convert [Amount Source_Unit in Dest_Unit], or (q)uit]: ')

    # quits application if the user chooses to quit
    if conversion_String.lower() == 'q':
        return print('Thank you for using the conversion program. We hope you use it again!!!')

    # converts string into a list
    conversion_List=conversion_String.split()

    # restarts function if input is bad
    if len(conversion_List)!=4:
        return unit_conversion()

    # More input debacles
    if (conversion_List[1] and conversion_List[3]) not in (distances):
         if (conversion_List[1] and conversion_List[3]) not in (volume):
             if (conversion_List[1] and conversion_List[3]) not in (weights):
                 return unit_conversion()
    if conversion_List[2] != 'in':
        return unit_conversion()


    # assign metric and conversion factor lists
    if conversion_List[1] in distances:
        metric=distances
        conv_Factor=dist_conv

    if conversion_List[1] in weights:
        metric=weights
        conv_Factor=weight_conv

    if conversion_List[1] in volume:
        metric=volume
        conv_Factor=vol_conv


    #add something that returns the index of conversion necessary for source and dest analysis
    # establish source and destination conversion factors with respect to base
    conv1=conv_Factor[convert_index(conversion_List[1],metric)]
    conv2=conv_Factor[convert_index(conversion_List[3],metric)]

    #final calculation: B dest = A source * conv1/conv2
    try:
        number_dest=float(conversion_List[0]) * (conv1 / conv2)
    except ValueError:
        return unit_conversion()

    # final output after conversion
    final_output=[conversion_List[0], conversion_List[1],'=', str(number_dest), conversion_List[3]]
    delim=' '
    print(delim.join(final_output))

    return unit_conversion()


unit_conversion()