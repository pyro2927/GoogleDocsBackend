//
//  JPGoogleDocsSpreadsheetAPIClient.h
//  amp
//
//  Created by Joseph Pintozzi on 2/12/14.
//  Copyright (c) 2014 branberg. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

typedef void (^GoogleDocsAPICompletionBlock)(BOOL success, NSDictionary *result, NSError *error);

@interface GoogleDocsSpreadsheetAPIClient : AFHTTPRequestOperationManager

+ (GoogleDocsSpreadsheetAPIClient*)sharedClient;
- (void)cellsForSpreadsheetKey:(NSString*)key sheetId:(NSString*)gid withCompletionBlock:(GoogleDocsAPICompletionBlock)completionBlock;
- (void)sheetsForSpreadsheetKey:(NSString*)key withCompletionBlock:(GoogleDocsAPICompletionBlock)completionBlock;

@end
