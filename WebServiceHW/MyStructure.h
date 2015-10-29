//
//  MyStructure.h
//  WebServiceHW
//
//  Created by Hongjin Su on 10/19/15.
//  Copyright © 2015 Hongjin Su. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyStructure : NSObject

@property (strong, nonatomic) NSString *artistName;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *features;
@property (strong, nonatomic) NSString *releaseNotes;
@property (strong, nonatomic) NSString *trackViewUrl;
@property (strong, nonatomic) NSMutableArray *arrayScreenShots;

@end
