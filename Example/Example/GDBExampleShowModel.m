//
//  GDBExampleShowModel.m
//  Example
//
//  Created by Joseph Pintozzi on 2/13/14.
//  Copyright (c) 2014 Pintozzi. All rights reserved.
//

#import "GDBExampleShowModel.h"

@implementation GDBExampleShowModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"cityName": @"Location",
             @"venueName": @"Venue",
             @"eventDate": @"Date",
             @"ticketUrl": @"Link"
             };
}

+ (NSValueTransformer *)eventDateJSONTransformer {
    return [self googleDocsDateJSONTransformer];
}

@end
