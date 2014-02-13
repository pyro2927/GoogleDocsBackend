//
//  GDBExampleShowModel.h
//  Example
//
//  Created by Joseph Pintozzi on 2/13/14.
//  Copyright (c) 2014 Pintozzi. All rights reserved.
//

#import "GDBModel.h"

@interface GDBExampleShowModel : GDBModel

@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, copy) NSString *venueName;
@property (nonatomic, copy) NSDate *eventDate;
@property (nonatomic, copy) NSString *ticketUrl;

@end
