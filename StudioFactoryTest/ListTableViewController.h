//
//  ListTableViewController.h
//  StudioFactoryTest
//
//  Created by Shanshan ZHAO on 16/05/14.
//  Copyright (c) 2014 Shanshan ZHAO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListTableViewController : UITableViewController


@property (nonatomic,strong) NSMutableDictionary * result;
@property (nonatomic,strong) NSArray  * names;
@property (nonatomic,strong) UIImage * photo;


- (NSDictionary *)getResultDictionary;

@end
