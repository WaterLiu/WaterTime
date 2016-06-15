//
//  GIFDownloader.h
//  TheJoysOfCode
//
//  Created by Bob on 29/10/12.
//  Copyright (c) 2012 Tall Developments. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXTERN NSString * const kGIF2MP4ConversionErrorDomain;
typedef enum {
    kGIF2MP4ConversionErrorInvalidGIFImage = 0,
    kGIF2MP4ConversionErrorAlreadyProcessing,
    kGIF2MP4ConversionErrorBufferingFailed,
    kGIF2MP4ConversionErrorInvalidResolution,
    kGIF2MP4ConversionErrorTimedOut,
} kGIF2MP4ConversionError;


typedef void (^kGIF2MP4ConversionCompleted) (NSString* outputFilePath, NSError* error);

@interface GIFDownloader : NSObject

+ (void) sendAsynchronousRequest: (NSString*) srcPath
                downloadFilePath: (NSString*) filePath
               thumbnailFilePath: (NSString*) thumbFilePath
                       completed: (kGIF2MP4ConversionCompleted) handler;


@end
