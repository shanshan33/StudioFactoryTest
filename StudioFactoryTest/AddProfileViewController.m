//
//  AddProfileViewController.m
//  StudioFactoryTest
//
//  Created by Shanshan ZHAO on 20/05/14.
//  Copyright (c) 2014 Shanshan ZHAO. All rights reserved.
//

#import "AddProfileViewController.h"

@interface AddProfileViewController ()

@property (weak, nonatomic) IBOutlet UITextField *addAccountTextField;

@property (weak, nonatomic) IBOutlet UITextView *addDiscriptionTextView;


@end

@implementation AddProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (IBAction)addProfilePhotoFromLibrary:(id)sender {
}

@end
