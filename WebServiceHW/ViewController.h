//
//  ViewController.h
//  WebServiceHW
//
//  Created by Hongjin Su on 10/19/15.
//  Copyright © 2015 Hongjin Su. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
@interface ViewController : UIViewController
@property (strong, nonatomic) NSString * DatabasePath;
@property (nonatomic) sqlite3 *ContactDB;

@end

