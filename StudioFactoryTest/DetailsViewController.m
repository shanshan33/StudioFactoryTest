//
//  DetailsViewController.m
//  StudioFactoryTest
//
//  Created by Shanshan ZHAO on 18/05/14.
//  Copyright (c) 2014 Shanshan ZHAO. All rights reserved.
//

#import "DetailsViewController.h"
#import "ListTableViewController.h"

@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *DescriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *devPhotoImageView;

@end

@implementation DetailsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.devPhotoImageView.image = self.photo;
    self.nameLabel.text = [NSString stringWithFormat:@"Dev's Name : %@",self.name];
    self.DescriptionLabel.text = [NSString stringWithFormat:@"More About Him: %@", self.description];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
