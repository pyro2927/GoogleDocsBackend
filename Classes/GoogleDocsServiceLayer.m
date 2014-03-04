//
//  GoogleDocsShowServiceLayer.m
//  amp
//
//  Created by Joseph Pintozzi on 2/12/14.
//  Copyright (c) 2014 branberg. All rights reserved.
//

#import "GoogleDocsServiceLayer.h"
#import "GoogleDocsSpreadsheetAPIClient.h"
#import "GDBModel.h"

@implementation GoogleDocsServiceLayer

+ (void)objectsForWorksheetKey:(NSString*)key sheetId:(NSString*)gid callback:(GoogleDocsServiceLayerCompletionBlock)callback{
    [[self class] objectsForWorksheetKey:key sheetId:gid modelClass:[GDBModel class] callback:callback];
}

+ (void)objectsForWorksheetKey:(NSString*)key sheetId:(NSString*)gid modelClass:(Class)modelClass callback:(GoogleDocsServiceLayerCompletionBlock)callback{
    [[GoogleDocsSpreadsheetAPIClient sharedClient] cellsForSpreadsheetKey:key sheetId:gid withCompletionBlock:^(BOOL success, NSDictionary *result, NSError *error) {
        if (success) {
            NSMutableArray *objects = [NSMutableArray array];
            NSMutableArray *entries = [result[@"feed"][@"entry"] mutableCopy];
            NSMutableDictionary *keys = [NSMutableDictionary dictionary]; // Store keys according to column letter, ex: @{@"A": @"Show", @"B": @"Time"}
            
            //get section heads
            int i = 0;
            NSDictionary *entry = entries[i];
            NSString *cellNumber = entry[@"title"][@"$t"];
            int row = [[self class] rowForCellTitle:cellNumber];
            while (row == 1) {
                [keys setValue:entry[@"content"][@"$t"] forKey:[[self class] columnForCellTitle:cellNumber]];
                entry = entries[++i];
                cellNumber = entry[@"title"][@"$t"];
                
                //check row of next entry
                row = [[self class] rowForCellTitle:cellNumber];
            }
            
            //remove cell heads
            [entries removeObjectsInRange:NSMakeRange(0, [keys count])];
            
            //iterate and create shows
            NSMutableDictionary *nextObject = [NSMutableDictionary dictionary];
            //headers are row 1, first object is row 2
            int nextRow = 2;
            for (NSDictionary *entry in entries) {
                //get the section header, which we will use as the key
                cellNumber = entry[@"title"][@"$t"];
                nextRow = [[self class] rowForCellTitle:cellNumber];
                //if we are on a new row, add the object and start on the next one
                if (nextRow != row) {
                    if (nextObject) {
                        [objects addObject:[MTLJSONAdapter modelOfClass:modelClass fromJSONDictionary:nextObject error:nil]];
                    }
                    row = nextRow;
                    nextObject = [NSMutableDictionary dictionary];
                }
                NSString *key = [keys objectForKey:[[self class] columnForCellTitle:cellNumber]];
                //only add this to our new object if we have a matching key from before
                if (key) {
                    NSString *value = entry[@"content"][@"$t"];
                    [nextObject setValue:value forKey:key];
                }
            }
            [objects addObject:[MTLJSONAdapter modelOfClass:modelClass fromJSONDictionary:nextObject error:nil]];
            
            //sort before returning
            callback(objects, error);
        } else {
            callback(nil, error);
        }
        
    }];
}

# pragma mark Cell regex stuff

+ (NSRegularExpression*)cellTitleRegularExpression{
    //regex used to get column letter
    static NSRegularExpression *cellRegex = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        cellRegex = [NSRegularExpression regularExpressionWithPattern:@"^(\\D{1,})(\\d{1,})$" options:NSRegularExpressionUseUnicodeWordBoundaries error:nil];
    });
    return cellRegex;
}

+ (NSArray*)matchesInCellTitle:(NSString*)cellTitle{
    return [[[self class] cellTitleRegularExpression] matchesInString:cellTitle options:NSMatchingReportCompletion range:NSMakeRange(0, cellTitle.length)];
}

+ (int)rowForCellTitle:(NSString*)cellTitle{
    NSTextCheckingResult *rowMatch = [[[self class] matchesInCellTitle:cellTitle] firstObject];
    NSRange rowRange = [rowMatch rangeAtIndex:2];
    return [[cellTitle substringWithRange:rowRange] intValue];  //row is the last part of the matches
}

+ (NSString*)columnForCellTitle:(NSString*)cellTitle{
    NSTextCheckingResult *columnMatch = [[[self class] matchesInCellTitle:cellTitle] firstObject];
    NSRange columnRange = [columnMatch rangeAtIndex:1]; //match zero is whole match, column is match 1, row is match 2
    return [cellTitle substringWithRange:columnRange];
}

@end
