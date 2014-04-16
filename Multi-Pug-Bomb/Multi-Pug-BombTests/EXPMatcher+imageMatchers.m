//
//  EXPMatcher+imageMatchers.m
//  NSOperationQueue
//
//  Created by Joe Burgess on 4/13/14.
//  Copyright (c) 2014 al-tyus.com. All rights reserved.
//

#import "EXPMatcher+imageMatchers.h"

@implementation UIImage (imageMatchers)

- (BOOL)isEqual:(id)object
{
    UIImage *imageB = object;
    NSData *imageAData = UIImagePNGRepresentation(self);
    NSData *imageBData = UIImagePNGRepresentation(imageB);
    return [imageAData isEqual:imageBData];
}
@end

EXPMatcherImplementationBegin(containImageData, (void)) {
    BOOL actualIsNil = (actual==nil);
    NSData *actualData = UIImagePNGRepresentation(actual);
    prerequisite(^BOOL  {
        return !actualIsNil;
    });

    match(^BOOL {
        return [actualData length]>0;
    });

    failureMessageForTo(^NSString *{
        if(actualIsNil)
        {
            return @"The actual value is nil/null";
        }

        return [NSString
                stringWithFormat:@"expected actual to contain data, got an empty object"];
    });

    failureMessageForNotTo(^NSString * {
        if(actualIsNil)
        {
            return @"The actual value is nil/null";
        }

        return [NSString stringWithFormat:@"Expected actual to contain no data, got an object with %lu bytes",(unsigned long)[actualData length]];
    });
}
EXPMatcherImplementationEnd
