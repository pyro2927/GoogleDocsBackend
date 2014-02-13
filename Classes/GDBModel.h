//
//  GDBModel.h
//  Pods
//
//  Created by Joseph Pintozzi on 2/13/14.
//
//

#import "Mantle.h"

@interface GDBModel : MTLModel <MTLJSONSerializing>

+ (NSDateFormatter *)googleDocsDateFormatter;
+ (NSValueTransformer *)googleDocsDateJSONTransformer;

@end
