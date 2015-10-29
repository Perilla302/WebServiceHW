//
//  DetailViewController.m
//  WebServiceHW
//
//  Created by Hongjin Su on 10/19/15.
//  Copyright © 2015 Hongjin Su. All rights reserved.
//

#import "DetailViewController.h"
#import "WebViewController.h"
#import "PicsViewController.h"
#import "Pics2ViewController.h"
#import "Web2ViewController.h"
#import <sqlite3.h>

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView_releaseNotes;
@property (weak, nonatomic) IBOutlet UILabel *label_features;
//@property (weak, nonatomic) IBOutlet UILabel *label_releaseNotes;
@property (weak, nonatomic) IBOutlet UIButton *button_trackViewUrl;
@property (weak, nonatomic) IBOutlet UILabel *label_saveStatus;

@end

@implementation DetailViewController

#pragma mark To display the details
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //NSString *releaseNotes = [NSString stringWithFormat:@"%@", _objMyStructure.releaseNotes];
    _label_features.text = [NSString stringWithFormat:@"Features: %@", _objMyStructure.features];
    //_label_releaseNotes.lineBreakMode = NSLineBreakByWordWrapping;
    //_label_releaseNotes.numberOfLines = 0;
    _textView_releaseNotes.text = [NSString stringWithFormat:@"Release Notes: \n%@", _objMyStructure.releaseNotes];
    NSString *buttonTitle = [NSString stringWithFormat:@"Go to: %@", _objMyStructure.trackViewUrl];
    [_button_trackViewUrl setTitle:buttonTitle forState:UIControlStateNormal];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark To save certain information in the database
- (IBAction)ButtonAction_SaveDatabase:(id)sender {
    sqlite3_stmt   *statement;
    const char *dbpath = [_DatabasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_ContactDB) == SQLITE_OK) {
        
        NSString *artistName = _objMyStructure.artistName;
        NSString *price = _objMyStructure.price;
        NSString *feature = _objMyStructure.features;
        
        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO APPINFO (ArtistName, Price, Feature) VALUES (\"%@\", \"%@\", \"%@\")", artistName, price, feature];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_ContactDB, insert_stmt,-1, &statement, NULL);
        //NSLog(@"Arrived here %@",[_DatabasePath description]);
        
        if (sqlite3_step(statement) == SQLITE_DONE) {
            
            _label_saveStatus.text = @"App Info added";
        }
        else {
            NSLog(@"%d",sqlite3_step(statement));
            _label_saveStatus.text = @"Failed to add App Info";
        }
        sqlite3_finalize(statement);
        sqlite3_close(_ContactDB);
    }
}

#pragma mark To process to the next screen
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier]isEqualToString:@"WebPush"]) {
        WebViewController *objWVC = [segue destinationViewController];
        objWVC.objMyStructure = _objMyStructure;
    }
    else if ([[segue identifier]isEqualToString:@"PicsPush"]) {
        PicsViewController *objPVC = [segue destinationViewController];
        objPVC.objMyStructure = _objMyStructure;
    }
    else if ([[segue identifier]isEqualToString:@"Pics2Push"]) {
        Pics2ViewController *objP2VC = [segue destinationViewController];
        objP2VC.objMyStructure = _objMyStructure;
    }
    else if ([[segue identifier]isEqualToString:@"Web2Push"]) {
        Web2ViewController *objW2VC = [segue destinationViewController];
        objW2VC.objMyStructure = _objMyStructure;
    }
}

@end
