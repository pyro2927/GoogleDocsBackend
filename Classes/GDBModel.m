//
//  GDBModel.m
//  Pods
//
//  Created by Joseph Pintozzi on 2/13/14.
//
//

#import "GDBModel.h"

@implementation GDBModel

+ (NSDateFormatter *)googleDocsDateFormatter {
    static NSDateFormatter *googleDocsDateFormatter = nil;
    if (!googleDocsDateFormatter) {
        googleDocsDateFormatter = [[NSDateFormatter alloc] init];
        googleDocsDateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        googleDocsDateFormatter.dateFormat = @"M/d/yyyy";
    }
    return googleDocsDateFormatter;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{};
}

+ (NSValueTransformer *)googleDocsDateJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [self.googleDocsDateFormatter dateFromString:str];
    } reverseBlock:^(NSDate *date) {
        return [self.googleDocsDateFormatter stringFromDate:date];
    }];
}

@end
