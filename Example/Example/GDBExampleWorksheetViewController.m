//
//  GDBExampleWorksheet.m
//  Example
//
//  Created by Joseph Pintozzi on 5/12/14.
//  Copyright (c) 2014 Pintozzi. All rights reserved.
//

#import "GDBExampleWorksheetViewController.h"
#import "GoogleDocsServiceLayer.h"
#import "GDBSheet.h"
#import "GDBExampleViewController.h"

@interface GDBExampleWorksheetViewController (){
    NSArray *worksheets;
}

@end

@implementation GDBExampleWorksheetViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    //request all objects from worksheet with key 0Atoge9gLkMCTdENkUkVENElFczlmTDl1ODZWaTJmeFE
    [GoogleDocsServiceLayer sheetsForWorksheetKey:@"0Atoge9gLkMCTdENkUkVENElFczlmTDl1ODZWaTJmeFE"  callback:^(NSArray *objects, NSError *error) {
        if (error) {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        } else {
            //choosing to sort returned values by an NSDate attribute
            worksheets = objects;
            [self.tableView reloadData];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return worksheets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    GDBSheet *sheet = worksheets[indexPath.row];
    cell.textLabel.text = sheet.name;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GDBSheet *sheet = worksheets[indexPath.row];
    GDBExampleViewController *sheetViewController = [[GDBExampleViewController alloc] initWithSheet:sheet];
    [self.navigationController pushViewController:sheetViewController animated:YES];
}

@end
