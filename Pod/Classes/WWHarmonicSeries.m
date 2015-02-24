//
//  SAHarmonicSeries.m
//  SAHarmonics
//
//  Created by Wills Ward on 10/22/13.
//  Copyright (c) 2013 WillWorks. All rights reserved.
//

#import "WWHarmonicSeries.h"

@implementation WWHarmonicSeries

+(WWHarmonicSeries*)harmonicSeriesWithNote:(WWPitchedNote *)note
{
    WWHarmonicSeries* series = [[WWHarmonicSeries alloc] init];
    
    [series setBassNote:note];
    
    return series;
}

-(double)frequencyAtPartial:(NSInteger)partial
{
    return (double)partial*[[self bassNote] frequency];
}

@end
