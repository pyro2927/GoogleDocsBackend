//
//  GDBExampleViewController.m
//  Example
//
//  Created by Joseph Pintozzi on 2/13/14.
//  Copyright (c) 2014 Pintozzi. All rights reserved.
//

#import "GDBExampleViewController.h"
#import "GDBExampleCell.h"
#import "GoogleDocsServiceLayer.h"
#import "GDBExampleShowModel.h"

@interface GDBExampleViewController (){
    NSArray *googleDocObjects;
    GDBSheet *sheet;
}

@end

@implementation GDBExampleViewController

- (id)initWithSheet:(GDBSheet*)gdbSheet
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        // Custom initialization
        sheet = gdbSheet;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = sheet.name;
    [self.tableView registerClass:[GDBExampleCell class] forCellReuseIdentifier:@"Cell"];
    //request all objects from worksheet with key 0Atoge9gLkMCTdENkUkVENElFczlmTDl1ODZWaTJmeFE
    [GoogleDocsServiceLayer objectsForWorksheetKey:sheet.worksheetId sheetId:sheet.sheetId modelClass:[GDBExampleShowModel class] callback:^(NSArray *objects, NSError *error) {
        if (error) {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        } else {
            //choosing to sort returned values by an NSDate attribute
            googleDocObjects = [objects sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"eventDate" ascending:YES]]];
            [self.tableView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    return googleDocObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    GDBExampleCell *cell = (GDBExampleCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    GDBExampleShowModel *show = googleDocObjects[indexPath.row];
    cell.textLabel.text = show.venueName;
    cell.detailTextLabel.text = show.cityName;
    return cell;
}

@end
