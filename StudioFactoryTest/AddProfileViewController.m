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

    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"New Account"
                                                    message: @"Your Profile Add Success!"
                                                   delegate: nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    [self ConnectionToUrl];
    
//    [self performSegueWithIdentifier:@"back to list" sender:self];
    
}

- ( void)ConnectionToUrl
{
    NSURL *url = [NSURL URLWithString:@"http://dev.mystudiofactory.com/trombi/"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    NSDictionary * jsonDictionary = [NSDictionary dictionaryWithObject:self.accountName forKey:@"name"];
    NSError *error;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                                                       options:NSJSONWritingPrettyPrinted error:&error];
    
//    NSData *requestData = [self.accountName dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody: jsonData];
    
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    if (connection) {
        
        self.receivedData = [NSMutableData data];

        
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://dev.mystudiofactory.com/trombi/"]]];
        
        NSMutableDictionary * result = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:0
                                                                         error:NULL];
        self.nameArray = [result valueForKeyPath:@"list.name"];
        [self.nameArray addObject:self.accountName];

    }
}

#pragma mark -
#pragma mark NSUrlConnectionDelegate 

-(void)connection:(NSConnection*)conn didReceiveResponse:(NSURLResponse *)response
{
    if (self.receivedData == NULL) {
        self.receivedData = [[NSMutableData alloc] init];
    }
    [self.receivedData setLength:0];
    NSLog(@"didReceiveResponse: responseData length:(%d)", _receivedData.length);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.receivedData appendData:data];
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"Succeeded! Received %d bytes of data",[self.receivedData length]);
    
    NSString *responseText = [[NSString alloc] initWithData:self.receivedData encoding: NSASCIIStringEncoding];
    NSLog(@"Response: %@", responseText);
    
    NSString *newLineStr = @"\n";
    responseText = [responseText stringByReplacingOccurrencesOfString:@"<br />" withString:newLineStr];
    
}


@end
