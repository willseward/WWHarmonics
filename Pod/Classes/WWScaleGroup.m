//
//  SAScaleGroup.m
//  SAHarmonics
//
//  Created by Wills Ward on 10/21/13.
//  Copyright (c) 2013 WillWorks. All rights reserved.
//

#import "WWScaleGroup.h"
#import "WWNote.h"

@interface WWScaleGroup ()

@property (nonatomic) WWNote* root;
@property (nonatomic) Scale quality;
@property (nonatomic) WWNoteRange* range;
@property (nonatomic) Order order;
@property (nonatomic) WWNote* tuningKey;

@end

@implementation WWScaleGroup

-(id)init
{
    if (self = [super init]) {
        
        
        
    }
    
    return self;
}

+(WWScaleGroup*)scaleGroupWithRootNote:(WWNote *)root andQuality:(Quality)quality inOrder:(Order)order withinRange:(WWNoteRange*)range inTuningKey:(WWNote*)key
{
    const Scale MAJORSCALE = {
        
        MAJOR,
        
        {MAJORSECOND, MAJORSECOND, MINORSECOND, MAJORSECOND, MAJORSECOND, MAJORSECOND, MINORSECOND},
        
        {MAJORSEVENTH, MINORSEVENTH, MINORSEVENTH, MINORSEVENTH, MAJORSEVENTH, MINORSEVENTH, MINORSEVENTH},
        
    };
    
    
    
    const Scale NATURALMINORSCALE = {
        
        NATURALMINOR,
        
        {MAJORSECOND, MINORSECOND, MAJORSECOND, MAJORSECOND, MINORSECOND, MAJORSECOND, MAJORSECOND},
        
        {MINORSEVENTH, MINORSEVENTH, MAJORSEVENTH, MINORSEVENTH, MINORSEVENTH, MAJORSEVENTH, MINORSEVENTH},
        
    };
    
    
    
    const Scale HARMONICMINORSCALE = {
        
        HARMONICMINOR,
        
        {MAJORSECOND, MINORSECOND, MAJORSECOND, MAJORSECOND, MINORSECOND, AUGSECOND, MINORSECOND},
        
        {MAJORSEVENTH, MAJORSIXTH, MAJORSEVENTH, MINORSEVENTH, MINORSEVENTH, MAJORSEVENTH, MINORSEVENTH},
        
    };
    
    
    
    const Scale MELODICMINORSCALE = {
        
        MELODICMINOR,
        
        {MAJORSECOND, MINORSECOND, MAJORSECOND, MAJORSECOND, MAJORSECOND, MAJORSECOND, MINORSECOND},
        
        {MINORSEVENTH, MINORSEVENTH, MAJORSEVENTH, MINORSEVENTH, MINORSEVENTH, MAJORSEVENTH, MINORSEVENTH},
        
    };
    
    
    WWScaleGroup* group = [[WWScaleGroup alloc] init];
    
    [group setRoot:root];
    
    if (quality == MAJORSCALE.quality) {
        [group setQuality:MAJORSCALE];
    } else if (quality == NATURALMINORSCALE.quality) {
        [group setQuality:NATURALMINORSCALE];
    } else if (quality == HARMONICMINORSCALE.quality) {
        [group setQuality:HARMONICMINORSCALE];
    } else if (quality == MELODICMINORSCALE.quality) {
        [group setQuality:MELODICMINORSCALE];
    }
    
    [group setOrder:order];
    [group setRange:range];
    [group setTuningKey:key];
    
    switch (order) {
        case ASC:
            [group setNotes:[[group generateASCNoteArray] mutableCopy]];
            break;
        case DESC:
            [group setNotes:[[group generateDESCNoteArray] mutableCopy]];
            break;
        case ASCDESC:
            [group setNotes:[[group generateASCDESCNoteArray] mutableCopy]];
            break;
        default:
            [group setNotes:[[group generateASCDESCNoteArray] mutableCopy]];
            break;
    }
    
    return group;
}

-(Quality)scaleQuality
{
    return _quality.quality;
}

-(WWNote*)root
{
    return _root;
}

-(Order)order
{
    return _order;
}

-(WWNoteRange*)range
{
    return _range;
}

-(NSMutableArray*)ascScale
{
    NSMutableArray* fullScale = [[NSMutableArray alloc] init];
    
    WWNote* currentNote = [WWNote noteWithNote:_root];
    
    for (int i = 0; i < 7; i++) {
        [fullScale addObject:[currentNote note]];
        [currentNote transposeUp:_quality.intervalsASC[i]];
    }

    return fullScale;
}

-(NSMutableArray*)descScale
{
    NSMutableArray* fullScale = [[NSMutableArray alloc] init];
    
    WWNote* currentNote = [WWNote noteWithNote:_root];
    
    for (int i = 0; i < 7; i++) {
        [fullScale addObject:[currentNote note]];
        [currentNote transposeUp:_quality.intervalsDESC[i]];
    }
    
    return fullScale;
}

-(NSInteger)ascScaleDegreeForNote:(WWNote*)note
{
    NSMutableArray* fullScale = [self ascScale];

    int i = 1;
    
    int closestDistance = 12;
    int closestNote;
    
    for (WWNote* n in fullScale) {
        if ([n pitchNumber] == [note pitchNumber]) {
            return i;
        } else {
            int temp = (int)([note stepsASCToNote:n]);
            
            if (temp >= 0) {
                if (temp < closestDistance) {
                    closestDistance = temp;
                    closestNote = i;
                }
            }
        }
        
        i++;
    }
    
    return closestNote;
}

-(NSInteger)descScaleDegreeForNote:(WWNote*)note
{
    NSMutableArray* fullScale = [self descScale];
    
    int i = 0;
    
    int closestDistance = 12;
    int closestNote;
    
    for (WWNote* n in fullScale) {
        if ([n pitchNumber] == [note pitchNumber]) {
            return i;
        } else {
            int temp = (int)([note stepsDESCToNote:n]);
            
            if (temp >= 0) {
                if (temp < closestDistance) {
                    closestDistance = temp;
                    closestNote = i;
                }
            }
        }
        
        i++;
    }
    
    return closestNote;

}


-(NSArray*)generateASCNoteArray
{
    NSMutableArray* scale = [self ascScale];
    
    NSMutableArray* ascScale = [[NSMutableArray alloc] init];
    
    NSInteger startingDegree = [self ascScaleDegreeForNote:_range.bottomNote.note];
    WWNote* startingNote = [scale objectAtIndex:startingDegree-1];
    Octave startingOctave = _range.bottomNote.octave;
    if (_range.bottomNote.note.pitchNumber > startingNote.pitchNumber) startingOctave += 12;
    WWPitchedNote* currentNote = [WWPitchedNote pitchedNoteWithNote:[startingNote note] inOctave:startingOctave andTuningKey:_tuningKey];
    NSInteger currentIndex = [scale indexOfObject:startingNote];
    
    while ([_range rangeContainsNote:currentNote]) {
        [ascScale addObject:[currentNote pitchedNote]];
        [currentNote transposeUp:_quality.intervalsASC[currentIndex]];
        
        if (++currentIndex > 6) currentIndex = 0;
    }
    
    return [ascScale copy];
}

-(NSArray*)generateDESCNoteArray
{
    NSMutableArray* scale = [self descScale];
    
    NSMutableArray* descScale = [[NSMutableArray alloc] init];
    
    NSInteger startingDegree = [self descScaleDegreeForNote:_range.topNote.note];
    WWNote* startingNote = [scale objectAtIndex:startingDegree];
    Octave startingOctave = _range.topNote.octave;
    if (_range.topNote.note.pitchNumber < startingNote.pitchNumber) startingOctave -= 12;
    WWPitchedNote* currentNote = [WWPitchedNote pitchedNoteWithNote:[startingNote note] inOctave:startingOctave andTuningKey:_tuningKey];
    NSInteger currentIndex = [scale indexOfObject:startingNote];
    
    while ([_range rangeContainsNote:currentNote]) {
        [descScale addObject:[currentNote pitchedNote]];
        [currentNote transposeDown:OCTAVE];
        [currentNote transposeUp:_quality.intervalsDESC[currentIndex]];
        
        if (++currentIndex > 6) currentIndex = 0;
    }
    
    return [descScale copy];
}

-(NSArray*)generateASCDESCNoteArray
{
    NSMutableArray* ASC = [[self generateASCNoteArray] mutableCopy];
    NSMutableArray* DESC = [[self generateDESCNoteArray] mutableCopy];
    
    [DESC removeObjectAtIndex:0];
    
    NSArray* ret = [ASC arrayByAddingObjectsFromArray:DESC];
    
    return ret;
}

@end
