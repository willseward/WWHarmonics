//
//  SATenorTrombone.m
//  SAHarmonics
//
//  Created by Wills Ward on 10/22/13.
//  Copyright (c) 2013 WillWorks. All rights reserved.
//

#import "WWTenorTrombone.h"
#import "WWTrombone.h"
#import "WWHarmonicSeries.h"

@implementation WWTenorTrombone

@synthesize harmonicSeries = _harmonicSeries;

-(id)init
{
    if (self = [super init]) {
        
        WWPitchedNote* bFlatTwo = [WWPitchedNote pitchedNoteWithNote:[WWNote noteWithNote:B andAccidental:FLAT] inOctave:O1];
        WWPitchedNote* fTwo = [WWPitchedNote pitchedNoteWithNote:[WWNote noteWithNote:F andAccidental:NATURAL] inOctave:O1];

        NSArray* h = [NSArray arrayWithObjects:bFlatTwo, fTwo, nil];
        [self setHarmonicSeries:[h copy]];
    }
    
    return self;
}

-(NSArray*)slidePositionsGivenNote:(WWPitchedNote *)note inSimpleNotation:(BOOL)simple
{
    NSMutableArray* validSlidePositions = [[NSMutableArray alloc] init];
    
    int valve = -1;
    for (WWPitchedNote* h in [self harmonicSeries]) {
        valve++;
        
        WWPitchedNote* currentNote = [h pitchedNote];
        [currentNote transposeUp:MINORSECOND];
        
        NSMutableArray* harmonicSeriesInValveSetting = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < 9; i++) {
            WWHarmonicSeries *currentSeries = [WWHarmonicSeries harmonicSeriesWithNote:[currentNote pitchedNote]];
            
            [harmonicSeriesInValveSetting addObject:currentSeries];
            
            [currentNote transposeDown:MINORSECOND];
            
            [currentNote requestFlat];
//            [currentNote requestNatural];
        }
        
        //Iterate through partials
        for (int i = 1; i <= 15; i++)
        {
            //check if freqency is between sp0 and sp8
            if ((note.frequency < (double)[(WWHarmonicSeries *)([harmonicSeriesInValveSetting objectAtIndex:0]) frequencyAtPartial:i])
                && (note.frequency > (double)[(WWHarmonicSeries *)([harmonicSeriesInValveSetting objectAtIndex:8]) frequencyAtPartial:i])) {
                
                //iterate through all slide positions
                for (int sp = 0; sp < 8; sp++) {
                    
                    //check if frequency is between sp(sp) and sp(sp+1)
                    if ((note.frequency < (double)[(WWHarmonicSeries *)([harmonicSeriesInValveSetting objectAtIndex:sp]) frequencyAtPartial:i])
                        && (note.frequency >= (double)[(WWHarmonicSeries *)([harmonicSeriesInValveSetting objectAtIndex:sp+1]) frequencyAtPartial:i])) {
                        
                        double frequencyForHighPosition = (double)[(WWHarmonicSeries *)([harmonicSeriesInValveSetting objectAtIndex:sp]) frequencyAtPartial:i];
                        double frequencyForLowPosition = (double)[(WWHarmonicSeries *)([harmonicSeriesInValveSetting objectAtIndex:sp+1]) frequencyAtPartial:i];
                        
                        double deviation = (note.frequency - frequencyForLowPosition) / (frequencyForHighPosition - frequencyForLowPosition);
                        
                        WWSlidePosition* position;
                        
                        if (deviation > .50) {
                            //the frequency is closer to the higher sp
                            if (sp != 0 && sp != 8) {
                                //check is the freqency is off the slide
                                if ((sp != 7) || (deviation > .97)) {
                                    position = [WWSlidePosition slidePositionWithPartial:i slidePosition:sp withDeviation:-(1.0-deviation) onValve:valve];
                                    [validSlidePositions addObject:position];
                                }
                            }
                        } else {
                            //otherwise
                            if (sp+1 != 8) {
                                if ((sp+1 != 1) || (deviation < .15)) {
                                    position = [WWSlidePosition slidePositionWithPartial:i slidePosition:sp+1 withDeviation:deviation onValve:valve];
                                    [validSlidePositions addObject:position];
                                }
                            }
                        }
                        
                        //add valid position to the array
                    }
                }
            }
        }
    }
    
    return [validSlidePositions copy];
}

@end
