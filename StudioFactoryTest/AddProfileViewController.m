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

@property (weak, nonatomic) IBOutlet UIImageView *chosenPhotoImageView;

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
    self.addAccountTextField.placeholder = @"Input Your Name";
    self.addDiscriptionTextView.editable = YES;
    [super viewDidLoad];
    [self.addDiscriptionTextView resignFirstResponder];

}


#pragma mark - 
#pragma mark UITextField

- (void)textFieldReturnEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}      




#pragma mark - 
#pragma mark UITextViewDelegate



#pragma mark -
#pragma mark UIImagePickerController Delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    self.chosenPhoto = image;
    [self displayChosenPhoto:self.chosenPhoto];

    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:
(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (IBAction)addProfilePhotoFromLibrary:(id)sender
{
    
    UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
    
    imagePicker.delegate = self;
    
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePicker
                       animated:YES completion:nil];
    
    
}

- (void)displayChosenPhoto:(UIImage *)image
{
    self.chosenPhotoImageView.image  = image;
}

@end
