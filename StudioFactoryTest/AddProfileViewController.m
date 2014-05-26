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
    
// shouldn't add arry here should sent to json.
    [self.listTableVC.names addObject:self.accountName];
    NSLog(@"%i",[self.listTableVC.names count]);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"New Account"
                                                    message: @"Your Profile Add Success!"
                                                   delegate: nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
}

- (NSMutableDictionary *)fetchJsonResultFromURL
{
    NSData * jsonResult = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://dev.mystudiofactory.com/trombi/"]]];
    NSMutableDictionary * result = [NSJSONSerialization JSONObjectWithData:jsonResult
                                                  options:0
                                                    error:NULL];
    return result;
    
    NSDictionary * jsonDictionary = [NSDictionary dictionaryWithObject:self.accountName
                                                       forKey:@"name"];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:NULL];
    if (!jsonData) {
        //Deal with error
    } else {
        NSString * jsonRequest = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSLog(@"jsonRequest is %@", jsonRequest);
    
    NSURL *url = [NSURL URLWithString:@"https://xxxxxxx.com/questions"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    
    NSData *requestData = [jsonRequest dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    

}



@end
