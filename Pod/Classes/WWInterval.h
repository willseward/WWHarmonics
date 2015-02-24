//
//  SAInterval.h
//  SAHarmonics
//
//  Created by Wills Ward on 10/21/13.
//  Copyright (c) 2013 WillWorks. All rights reserved.
//

typedef struct {
    int naturalInterval;
    int accidentalInterval;
    int noteNameShift;
} WWInterval;

extern const WWInterval MINORSECOND;
extern const WWInterval MAJORSECOND;
extern const WWInterval AUGSECOND;
extern const WWInterval MINORTHIRD;
extern const WWInterval MAJORTHIRD;
extern const WWInterval PERFECTFOURTH;
extern const WWInterval TRITONE;
extern const WWInterval PERFECTFIFTH;
extern const WWInterval MINORSIXTH;
extern const WWInterval MAJORSIXTH;
extern const WWInterval MINORSEVENTH;
extern const WWInterval MAJORSEVENTH;
extern const WWInterval OCTAVE;

#define UNISONRATION ((double)1)
#define MINORSECONDRATIO ((double)(16.0/15.0))
#define MAJORSECONDRATIO ((double)(9.0/8.0))
#define MINORTHIRDRATIO ((double)(6.0/5.0))
#define MAJORTHIRDRATIO ((double)(5.0/4.0))
#define FOURTHRATIO ((double)(4.0/3.0))
#define TRITONRATIO ((double)(45.0/32.0))
#define FIFTHRATIO ((double)(3.0/2.0))
#define MINORSIXTHRATIO ((double)(8.0/5.0))
#define MAJORSIXTHRATIO ((double)(5.0/3.0))
#define MINORSEVENTHRATIO ((double)(9.0/5.0))
#define MAJORSEVENTHRATIO ((double)(15.0/8.0))