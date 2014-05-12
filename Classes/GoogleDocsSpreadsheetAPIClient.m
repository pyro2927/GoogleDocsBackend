//
//  JPGoogleDocsSpreadsheetAPIClient.m
//  amp
//
//  Created by Joseph Pintozzi on 2/12/14.
//  Copyright (c) 2014 branberg. All rights reserved.
//

#import "GoogleDocsSpreadsheetAPIClient.h"

@implementation GoogleDocsSpreadsheetAPIClient

+ (GoogleDocsSpreadsheetAPIClient*)sharedClient{
    static GoogleDocsSpreadsheetAPIClient *_sharedClient = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:@"https://spreadsheets.google.com/"]];
    });
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url{
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    // Set the default request class
    [self setResponseSerializer:[AFJSONResponseSerializer serializer]];
    return self;
}

//sample URL https://spreadsheets.google.com/feeds/cells/0Atoge9gLkMCTdENkUkVENElFczlmTDl1ODZWaTJmeFE/1/public/basic?alt=json

- (void)cellsForSpreadsheetKey:(NSString*)key sheetId:(NSString*)gid withCompletionBlock:(GoogleDocsAPICompletionBlock)completionBlock{
    [self GET:[NSString stringWithFormat:@"feeds/cells/%@/%@/public/basic?alt=json", key, gid] parameters:@{} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completionBlock(YES, responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completionBlock(NO, nil, error);
    }];
}

- (void)sheetsForSpreadsheetKey:(NSString*)key withCompletionBlock:(GoogleDocsAPICompletionBlock)completionBlock{
    [self GET:[NSString stringWithFormat:@"feeds/worksheets/%@/public/basic?alt=json", key] parameters:@{} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completionBlock(YES, responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completionBlock(NO, nil, error);
    }];
}

@end
