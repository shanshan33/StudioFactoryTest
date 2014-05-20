//
//  ListTableViewController.m
//  StudioFactoryTest
//
//  Created by Shanshan ZHAO on 16/05/14.
//  Copyright (c) 2014 Shanshan ZHAO. All rights reserved.
//

#import "ListTableViewController.h"
#import "DetailsViewController.h"

@interface ListTableViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;

@end

@implementation ListTableViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getResultDictionary];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSDictionary *)getResultDictionary
{
    
    NSData * jsonResult = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://dev.mystudiofactory.com/trombi/"]]];
    self.result = [NSJSONSerialization JSONObjectWithData:jsonResult
                                                  options:0
                                                    error:NULL];
    return self.result;
}

#pragma mark - 
#pragma mark TableView data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.result valueForKeyPath:@"list.name"] count];
}

#pragma mark-
#pragma mark TableView delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"developer Cell"
                                                            forIndexPath:indexPath];
    self.names = [self.result valueForKeyPath:@"list.name"];

    NSString * name = [self.names objectAtIndex:indexPath.row];

    cell.textLabel.text = name;

    return cell;
}



#pragma mark -
#pragma mark Tableview Navigation 

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:sender];
    if (indexPath) {
        
        if ([segue.identifier isEqualToString:@"Show Details"]) {
            if ([segue.destinationViewController isKindOfClass:[DetailsViewController class]]) {
                DetailsViewController * detailvc = (DetailsViewController *)segue.destinationViewController;
                NSArray * photoURLs = [self.result valueForKeyPath:@"list.picture"];
                NSString * imageURL = [photoURLs objectAtIndex:indexPath.row];
                detailvc.photo = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]]];;
                
                detailvc.name = [self.names objectAtIndex:indexPath.row];
                
                NSArray * descriptionArray = [self.result valueForKeyPath:@"list.description"];
                detailvc.description = [descriptionArray objectAtIndex:indexPath.row];

            }
        }
    }
}

#pragma mark -
#pragma mark Actions

- (IBAction)AddNewAccount:(id)sender {
    
    [self performSegueWithIdentifier:@"Add New Account" sender:nil];

    
}


@end
