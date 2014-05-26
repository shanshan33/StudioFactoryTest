//
//  AddProfileViewController.h
//  StudioFactoryTest
//
//  Created by Shanshan ZHAO on 20/05/14.
//  Copyright (c) 2014 Shanshan ZHAO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListTableViewController.h"

@interface AddProfileViewController : UIViewController< UINavigationControllerDelegate,UIImagePickerControllerDelegate, UITextFieldDelegate,UITextViewDelegate,UIAlertViewDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate>

@property (nonatomic, strong) UIImage * chosenPhoto;
@property (nonatomic, strong) NSString * accountName;
@property (nonatomic, strong) NSString * discription;
@property (nonatomic, strong) ListTableViewController * listTableVC;
@property (nonatomic, strong) NSMutableArray * nameArray;

@property (nonatomic, strong) NSMutableData * receivedData;


@end
