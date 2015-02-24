//
//  SANoteGroup.m
//  SAHarmonics
//
//  Created by Wills Ward on 10/21/13.
//  Copyright (c) 2013 WillWorks. All rights reserved.
//

#import "WWNoteGroup.h"

@interface WWNoteGroup ()

@property (nonatomic)  NSMutableArray* notes;
@property NSInteger currentIndex;

@end

@implementation WWNoteGroup

-(id)init
{
    if (self = [super init]) {
        _notes = [[NSMutableArray alloc] init];
        _currentIndex = 0;
    }
    
    return self;
}

+(WWNoteGroup*)noteGroup
{
    return [[WWNoteGroup alloc] init];
}

-(void)setNotes:(NSMutableArray *)array
{
    _notes = array;
}

-(WWPitchedNote*)previousNote
{
    return [_notes objectAtIndex:_currentIndex-1];
}

-(WWPitchedNote*)nextNote
{
    if (_currentIndex == _notes.count-1) {
        _currentIndex = 0;
    }
    return [_notes objectAtIndex:++_currentIndex];
}

-(WWPitchedNote*)noteAtIndex:(NSInteger)index
{
    return [_notes objectAtIndex:index];
}

-(WWPitchedNote*)randomNote
{
    WWNote* note = [WWNote noteWithNote:(int)arc4random_uniform(7) andAccidental:(int)(arc4random_uniform(6)-2)];
    WWPitchedNote* randNote = [WWPitchedNote pitchedNoteWithNote:note inOctave:(int)(arc4random_uniform(6)*12)];
    
    [_notes addObject:randNote];
    
    return randNote;
}

-(NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(__unsafe_unretained id [])buffer count:(NSUInteger)len
{
    return [_notes countByEnumeratingWithState:state objects:buffer count:len];
}

@end
