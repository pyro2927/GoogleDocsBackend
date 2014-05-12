//
//  GoogleDocsShowServiceLayer.h
//  amp
//
//  Created by Joseph Pintozzi on 2/12/14.
//  Copyright (c) 2014 branberg. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^GoogleDocsServiceLayerCompletionBlock)(NSArray *objects, NSError *error);

@interface GoogleDocsServiceLayer : NSObject

+ (void)sheetsForWorksheetKey:(NSString*)key callback:(GoogleDocsServiceLayerCompletionBlock)callback;
+ (void)objectsForWorksheetKey:(NSString*)key sheetId:(NSString*)gid callback:(GoogleDocsServiceLayerCompletionBlock)callback;
+ (void)objectsForWorksheetKey:(NSString*)key sheetId:(NSString*)gid modelClass:(Class)modelClass callback:(GoogleDocsServiceLayerCompletionBlock)callback;

@end
