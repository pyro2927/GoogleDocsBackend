//
//  GDBSheet.m
//  Pods
//
//  Created by Joseph Pintozzi on 5/12/14.
//
//

#import "GDBSheet.h"

@implementation GDBSheet

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"sheetUrl": @"id.$t",
             @"name": @"title.$t"
             };
}

- (NSString*)sheetId{
    return [[self.sheetUrl componentsSeparatedByString:@"/"] lastObject];
}

- (NSString*)worksheetId{
    NSArray *components = [self.sheetUrl componentsSeparatedByString:@"/"];
    return components[components.count - 4];
}

@end