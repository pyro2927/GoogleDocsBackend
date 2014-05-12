//
//  GDBSheet.h
//  Pods
//
//  Created by Joseph Pintozzi on 5/12/14.
//
//

#import "Mantle.h"

@interface GDBSheet : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sheetUrl;
@property (readonly) NSString *sheetId;
@property (readonly) NSString *worksheetId;

@end