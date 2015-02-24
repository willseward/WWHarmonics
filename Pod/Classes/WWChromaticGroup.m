//
//  SAChromaticGroup.m
//  SAHarmonics
//
//  Created by Wills Ward on 10/21/13.
//  Copyright (c) 2013 WillWorks. All rights reserved.
//

#import "WWChromaticGroup.h"

@interface WWChromaticGroup ()

@property Order order;
@property WWNoteRange* range;

@end

@implementation WWChromaticGroup

-(id)init
{
    if (self = [super init]) {
        
        
        
    }
    
    return self;
}

+(WWChromaticGroup*)chromaticGroupForRange:(WWNoteRange *)range inOrder:(Order)order
{
    WWChromaticGroup* chrom = [[WWChromaticGroup alloc] init];
    
    [chrom setRange:range];
    [chrom setOrder:order];
    
    switch (order) {
        case ASC:
            [chrom setNotes:[[chrom generateASCNoteArray] mutableCopy]];
            break;
        case DESC:
            [chrom setNotes:[[chrom generateDESCNoteArray] mutableCopy]];
            break;
        case ASCDESC:
            [chrom setNotes:[[chrom generateASCDESCNoteArray] mutableCopy]];
            break;
            
        default:
            break;
    }
    
    return chrom;
}

-(NSArray*)generateASCNoteArray
{
    NSMutableArray* notes = [[NSMutableArray alloc] init];
    WWPitchedNote* currentNote = [_range.bottomNote pitchedNote];
    [currentNote requestSharp];
    
    while ([_range rangeContainsNote:currentNote]) {
        [notes addObject:[currentNote pitchedNote]];
        [currentNote transposeUp:MINORSECOND];
        [currentNote requestSharp];
    }
    
    return [notes copy];
}

-(NSArray*)generateDESCNoteArray
{
    NSMutableArray* notes = [[NSMutableArray alloc] init];
    WWPitchedNote* currentNote = [_range.topNote pitchedNote];
    [currentNote requestFlat];
    
    while ([_range rangeContainsNote:currentNote]) {
        [notes addObject:[currentNote pitchedNote]];
        [currentNote transposeDown:MINORSECOND];
        [currentNote requestFlat];
    }
    
    return [notes copy];
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
