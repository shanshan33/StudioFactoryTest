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
    self.addDiscriptionTextView.delegate = self;
    [super viewDidLoad];

}


#pragma mark - 
#pragma mark UITextField

- (IBAction)textFieldDidEndOnExit:(id)sender
{
    [sender resignFirstResponder];
//    self.addAccountTextField.text = self.accountName;
}


#pragma mark - 
#pragma mark UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

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


#pragma mark -
#pragma mark Actions 

- (IBAction)commitNewAccount:(id)sender {
    
    self.accountName = self.addAccountTextField.text;
    self.discription = self.addDiscriptionTextView.text;
    
    [self.listTableVC.names addObject:self.accountName]; 
    
}

@end
