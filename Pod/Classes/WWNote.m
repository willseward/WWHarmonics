//
//  SANote.m
//  SAHarmonics
//
//  Created by Wills Ward on 10/21/13.
//  Copyright (c) 2013 WillWorks. All rights reserved.
//



#import "WWNote.h"

const WWInterval MINORSECOND = { 2, -1, 1 };
const WWInterval MAJORSECOND = { 2, 0, 1 };
const WWInterval AUGSECOND = { 2, 1, 1 };
const WWInterval MINORTHIRD = { 4, -1, 2 };
const WWInterval MAJORTHIRD = { 4, 0, 2 };
const WWInterval PERFECTFOURTH = { 5, 0, 3 };
const WWInterval TRITONE = { 7, -1, 4 };
const WWInterval PERFECTFIFTH = { 7, 0, 4 };
const WWInterval MINORSIXTH = { 9 , -1, 5 };
const WWInterval MAJORSIXTH = { 9, 0, 5 };
const WWInterval MINORSEVENTH = { 11, -1, 6 };
const WWInterval MAJORSEVENTH = { 11, 0, 6 };
const WWInterval OCTAVE = {12, 0, 7};

@interface WWNote ()

@end

@implementation WWNote

+(WWNote*)noteWithNote:(WWNote *)note
{
    WWNote* nNote = [[WWNote alloc] init];
    [nNote setNoteName:note.noteName];
    [nNote setAccidental:note.accidental];
    
    return nNote;
}

+(WWNote*)noteWithNote:(Note)note andAccidental:(Accidental)accidental
{
    WWNote* nNote = [[WWNote alloc] init];
    
    [nNote setNoteName:note];
    [nNote setAccidental:accidental];
    
    return nNote;
}

-(void)transposeUp:(WWInterval)interval
{
    if (interval.noteNameShift != OCTAVE.noteNameShift) {
        Note newNote = 0;
        Accidental newAccidental = 0;
        
        newNote = _noteName + interval.noteNameShift;
        
        if ((int)newNote > 6) newNote -= 7;
        if ((int)newNote < 0) newNote += 7;
        
        NSInteger difference = (interval.accidentalInterval+interval.naturalInterval) - ([self pitchNumberForNote:newNote] - [self pitchNumber]);
        
        if (difference > 2) difference -= 12;
        if (difference < -2) difference += 12;
        
        newAccidental = (int)difference;
        
        _noteName = newNote;
        _accidental = newAccidental;
    }
}

-(void)transposeDown:(WWInterval)interval
{
    if (interval.noteNameShift != OCTAVE.noteNameShift) {
        Note newNote = 0;
        Accidental newAccidental = 0;
        
        newNote = _noteName - interval.noteNameShift;
        
        if ((int)newNote > 6) {
            newNote -= 7;
        }
        if ((int)newNote < 0) newNote += 7;
        
        NSInteger difference = ([self pitchNumber] - [self pitchNumberForNote:newNote]) - (interval.accidentalInterval+interval.naturalInterval);
        
        if (difference > 2) difference -= 12;
        if (difference < -2) difference += 12;
        
        newAccidental = (int)difference;
        
        _noteName = newNote;
        _accidental = newAccidental;
    }
}

-(NSInteger)pitchNumberForNote:(Note)note
{
    switch (note) {
        case D:
            return 2;
        case E:
            return 4;
        case F:
            return 5;
        case G:
            return 7;
        case A:
            return 9;
        case B:
            return 11;
        default:
            return 0;
    }
}

-(NSInteger)noteForPitchNumber:(NSInteger)num
{
    Note n = -1;
    
    while (num >= 12)
        num -= 12;
    while (num < 0)
        num += 12;
    
    switch (num) {
        case 2:
            n = D;
            break;
        case 4:
            n = E;
            break;
        case 5:
            n = F;
            break;
        case 7:
            n = G;
            break;
        case 9:
            n = A;
            break;
        case 11:
            n = B;
            break;
        case 0:
            n = 0;
            break;
    }
    
    return n;
}

-(NSInteger)pitchNumber:(WWNote*)note
{
    int num = 0;
    
    switch (note.noteName) {
        case D:
            num = 2;
            break;
        case E:
            num = 4;
            break;
        case F:
            num = 5;
            break;
        case G:
            num = 7;
            break;
        case A:
            num = 9;
            break;
        case B:
            num = 11;
            break;
        default:
            break;
    }
    
    num += note.accidental;
    
    if (num < 0) {
        num += 12;
    }
    
    return num;
}

-(NSInteger)pitchNumber
{
    return [self pitchNumber:self];
}

-(NSString*)englishNotation
{
    NSString* retVal = @"";
    
    switch (_noteName) {
        case A:
            retVal = @"A";
            break;
        case B:
            retVal = @"B";
            break;
        case C:
            retVal = @"C";
            break;
        case D:
            retVal = @"D";
            break;
        case E:
            retVal = @"E";
            break;
        case F:
            retVal = @"F";
            break;
        case G:
            retVal = @"G";
            break;
        default:
            retVal = @"problem";
            break;
    }
    
    switch (_accidental) {
        case DOUBLEFLAT:
            retVal = [retVal stringByAppendingString:@"bb"];
            break;
        case FLAT:
            retVal = [retVal stringByAppendingString:@"b"];
            break;
        case SHARP:
            retVal = [retVal stringByAppendingString:@"#"];
            break;
        case DOUBLESHARP:
            retVal = [retVal stringByAppendingString:@"##"];
            break;
        default:
            break;
    }
    
    return retVal;
}

-(void)requestFlat
{
//    [self requestNatural];
    
    if (_accidental > 0) {
        
        int initial = (int)[self pitchNumber];
        
        _noteName += _accidental;
        _accidental = -_accidental;
        
        _accidental -= [self pitchNumber] - initial;
        
        if ((int)_noteName < 0) {
            _noteName += 7;
        } else if ((int)_noteName > 6) {
            _noteName -= 7;
        }
 
//        NSLog(@"%d", _accidental);
    }
}

-(void)requestSharp
{
//    [self requestNatural];
    
    if (_accidental < 0) {
        
        int initial = (int)[self pitchNumber];
        
        _noteName += _accidental;
        _accidental = -_accidental;
        
        _accidental -= [self pitchNumber] - initial;
        
        if ((int)_noteName < 0) {
            _noteName += 7;
        } else if ((int)_noteName > 6) {
            _noteName -= 7;
        }
    }
}

-(void)requestNatural
{
    if ([self noteForPitchNumber:[self pitchNumber]] != -1) {
        [self setNoteName:(int)[self noteForPitchNumber:[self pitchNumber]]];
        [self setAccidental:NATURAL];
    }
}

-(WWNote*)note
{
    return [WWNote noteWithNote:self.noteName andAccidental:self.accidental];
}

-(NSInteger)stepsASCToNote:(WWNote *)note
{
    int toNotePitch = (note.pitchNumber < self.pitchNumber) ? (int)note.pitchNumber+12 : (int)note.pitchNumber;
    int fromNotePitch = (int)self.pitchNumber;
    
    return toNotePitch-fromNotePitch;
}

-(NSInteger)stepsDESCToNote:(WWNote *)note
{
    int toNotePitch = (note.pitchNumber > self.pitchNumber) ? (int)note.pitchNumber-12 : (int)note.pitchNumber;
    int fromNotePitch = (int)self.pitchNumber;
    
    return fromNotePitch-toNotePitch;
}

-(NSString*)description
{
    return [self englishNotation];
}

@end
