//
//  SAPitchedNote.m
//  SAHarmonics
//
//  Created by Wills Ward on 10/21/13.
//  Copyright (c) 2013 WillWorks. All rights reserved.
//

#import "WWPitchedNote.h"

@interface WWPitchedNote ()

@property Octave octave;
@property WWNote* tuningKey;

@end

@implementation WWPitchedNote

+(WWPitchedNote*)pitchedNoteWithNote:(WWNote *)note inOctave:(Octave)octave
{
    WWPitchedNote* pNote = [[WWPitchedNote alloc] init];
    
    [pNote setNoteName:note.noteName];
    [pNote setAccidental:note.accidental];
    [pNote setOctave:octave];
    [pNote setTuningKey:nil];
    
    return pNote;
}

+(WWPitchedNote*)pitchedNoteWithNote:(WWNote *)note inOctave:(Octave)octave andTuningKey:(WWNote *)key
{
    WWPitchedNote* pNote = [WWPitchedNote pitchedNoteWithNote:note inOctave:octave];
    [pNote setTuningKey:key];
    
    return pNote;
}

-(double)frequency
{
    if (_tuningKey) {
        return [self justIntonationFrequencyNote:self];
    } else {
        return [self equalTemperedFrequencyForNote:self];
    }
    
    return 0;
}

-(double)equalTemperedFrequencyForNote:(WWPitchedNote*)note
{
    NSInteger number = [note pitchNumber];
    
    double power = ((double)number - 69.0) / 12.0;
    double retVal = 440 * (pow(2, power));
    
    return retVal;
}

-(double)justIntonationFrequencyNote:(WWPitchedNote*)note
{
    WWPitchedNote* key = [WWPitchedNote pitchedNoteWithNote:_tuningKey inOctave:O0];
    
    while ([self compareTo:key] >= 12)
        [key transposeUp:OCTAVE];

    while ([self compareTo:key] <= -12)
        [key transposeDown:OCTAVE];
    
    double rootNoteFrequency = [self equalTemperedFrequencyForNote:key];
    
    NSInteger intervalDifference = [self pitchNumber] - [key pitchNumber];
        
    double retVal = 0.0;
    
    switch (intervalDifference) {
        case 0:
            retVal = rootNoteFrequency;
            break;
        case 1:
            retVal = rootNoteFrequency*MINORSECONDRATIO;
            break;
        case 2:
            retVal = rootNoteFrequency*MAJORSECONDRATIO;
            break;
        case 3:
            retVal = rootNoteFrequency*MINORTHIRDRATIO;
            break;
        case 4:
            retVal = rootNoteFrequency*MAJORTHIRDRATIO;
            break;
        case 5:
            retVal = rootNoteFrequency*FOURTHRATIO;
            break;
        case 6:
            retVal = rootNoteFrequency*TRITONRATIO;
            break;
        case 7:
            retVal = rootNoteFrequency*FIFTHRATIO;
            break;
        case 8:
            retVal = rootNoteFrequency*MINORSIXTHRATIO;
            break;
        case 9:
            retVal = rootNoteFrequency*MAJORSIXTHRATIO;
            break;
        case 10:
            retVal = rootNoteFrequency*MINORSEVENTHRATIO;
            break;
        case 11:
            retVal = rootNoteFrequency*MAJORSEVENTHRATIO;
            break;
        default:
            retVal = rootNoteFrequency;
            break;
    }
    
    return retVal;
    
}

-(void)transposeUp:(WWInterval)interval
{
    WWPitchedNote* initial = [self pitchedNote];
    
    Note newNote = 0;
    Accidental newAccidental = 0;
    
    newNote = self.noteName + interval.noteNameShift;
    
    if ((int)newNote > 6) newNote -= 7;
    if ((int)newNote < 0) newNote += 7;
    
    WWNote* n = [WWNote noteWithNote:newNote andAccidental:NATURAL];
    
    NSInteger difference = (interval.accidentalInterval+interval.naturalInterval) - (n.pitchNumber - [self.note pitchNumber]);
    
    if (difference > 2) difference -= 12;
    if (difference < -2) difference += 12;
    
    newAccidental = (int)difference;
    
    [self setNoteName:newNote];
    [self setAccidental:newAccidental];
    
    if (self.note.pitchNumber <= initial.note.pitchNumber) {
        _octave += 12;
    }
}

-(void)transposeDown:(WWInterval)interval
{
    WWPitchedNote* initial = [self pitchedNote];
    
    Note newNote = 0;
    Accidental newAccidental = 0;
    
    newNote = self.noteName - interval.noteNameShift;
    
    if ((int)newNote > 6) {
        newNote -= 7;
    }
    if ((int)newNote < 0) newNote += 7;
    
    WWNote* n = [WWNote noteWithNote:newNote andAccidental:NATURAL];
    
    NSInteger difference = ([self.note pitchNumber] - n.pitchNumber) - (interval.accidentalInterval+interval.naturalInterval);
    
    if (difference > 2) difference -= 12;
    if (difference < -2) difference += 12;
    
    newAccidental = (int)difference;
    
    [self setNoteName:newNote];
    [self setAccidental:newAccidental];
    
    if (self.note.pitchNumber >= initial.note.pitchNumber) {
        _octave -= 12;
    }
}

-(NSInteger)compareTo:(WWPitchedNote *)note
{
    return ([self pitchNumber] - [note pitchNumber]);
}

-(NSInteger)pitchNumber
{
    return [[self note] pitchNumber] + _octave;
}

-(NSString*)scientificNotation
{
    NSString* english = [super englishNotation];
    
    NSInteger displayNumber = (_octave / 12) - 1;
    
    return [english stringByAppendingString:[@(displayNumber) stringValue]];
    
}

-(WWPitchedNote*)pitchedNote
{
    WWNote* note = [self note];
    return [WWPitchedNote pitchedNoteWithNote:note inOctave:[self octave] andTuningKey:_tuningKey];
}

-(NSString*)description
{
    return [[self scientificNotation] stringByAppendingFormat:@" - %f", [self frequency]];
}

@end
