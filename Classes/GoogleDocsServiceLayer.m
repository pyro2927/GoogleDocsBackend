//
//  GoogleDocsShowServiceLayer.m
//  amp
//
//  Created by Joseph Pintozzi on 2/12/14.
//  Copyright (c) 2014 branberg. All rights reserved.
//

#import "GoogleDocsServiceLayer.h"
#import "GoogleDocsSpreadsheetAPIClient.h"
#import "Mantle.h"

@implementation GoogleDocsServiceLayer

+ (void)objectsForWorksheetKey:(NSString*)key sheetId:(NSString*)gid modelClass:(Class)modelClass callback:(GoogleDocsServiceLayerCompletionBlock)callback{
    [[GoogleDocsSpreadsheetAPIClient sharedClient] cellsForSpreadsheetKey:key sheetId:gid withCompletionBlock:^(BOOL success, NSDictionary *result, NSError *error) {
        if (success) {
            NSMutableArray *objects = [NSMutableArray array];
            NSMutableArray *entries = [result[@"feed"][@"entry"] mutableCopy];
            NSMutableArray *keys = [NSMutableArray array];
            //get section heads
            bool inHeader = true;
            int i = 0;
            NSDictionary *entry = entries[i];
            while (inHeader) {
                [keys addObject:entry[@"content"][@"$t"]];
                entry = entries[++i];
                NSString *cellNumber = entry[@"title"][@"$t"];
                //check to see if we are no longer in the header
                if ([[cellNumber substringFromIndex:1] isEqualToString:@"2"]) {
                    inHeader = false;
                }
            }
            
            //remove cell heads
            [entries removeObjectsInRange:NSMakeRange(0, [keys count])];
            
            //iterate and create shows
            NSMutableDictionary *nextObject = nil;
            for (NSDictionary *entry in entries) {
                //get the section header, which we will use as the key
                int column = [entries indexOfObject:entry] % keys.count;
                //every time we get to column 0, create a new show
                if (column == 0) {
                    if (nextObject) {
                        [objects addObject:[MTLJSONAdapter modelOfClass:modelClass fromJSONDictionary:nextObject error:nil]];
                    }
                    nextObject = [NSMutableDictionary dictionary];
                }
                NSString *key = keys[column];
                NSString *value = entry[@"content"][@"$t"];
                [nextObject setValue:value forKey:key];
            }
            [objects addObject:[MTLJSONAdapter modelOfClass:modelClass fromJSONDictionary:nextObject error:nil]];
            
            //sort before returning
            callback(objects, error);
        } else {
            callback(nil, error);
        }
        
    }];
}

@end
