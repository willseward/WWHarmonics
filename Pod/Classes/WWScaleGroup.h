//
//  SAScaleGroup.h
//  SAHarmonics
//
//  Created by Wills Ward on 10/21/13.
//  Copyright (c) 2013 WillWorks. All rights reserved.
//

#import "WWNoteGroup.h"
#import "WWNote.h"
#import "WWNoteRange.h"

typedef enum {ASC, DESC, ASCDESC, THIRDS, FORTHS, FIFTHS, SIXTHS, SEVENTHS} Order;
typedef enum {MAJOR, NATURALMINOR, HARMONICMINOR, MELODICMINOR} Quality;

typedef struct {
    Quality quality;
    WWInterval intervalsASC[8];
    WWInterval intervalsDESC[8];
} Scale;

extern const Scale MAJORSCALE;
extern const Scale NATURALMINORSCALE;
extern const Scale HARMONICMINORSCALE;
extern const Scale MELODICMINORSCALE;

@interface WWScaleGroup : WWNoteGroup

+(WWScaleGroup*)scaleGroupWithRootNote:(WWNote *)root andQuality:(Quality)quality inOrder:(Order)order withinRange:(WWNoteRange*)range inTuningKey:(WWNote*)key;

-(Quality)scaleQuality;
-(WWNote*)root;
-(Order)order;
-(WWNoteRange*)range;

@end
