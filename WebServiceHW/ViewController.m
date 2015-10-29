//
//  ViewController.m
//  WebServiceHW
//
//  Created by Hongjin Su on 10/19/15.
//  Copyright © 2015 Hongjin Su. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "MyStructure.h"
#import "DatabaseViewController.h"
#import <sqlite3.h>

@interface ViewController ()
// Display the list of app
@property (weak, nonatomic) IBOutlet UITableView *tableview_Detail;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *myActivityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *label_status;
@property (strong, nonatomic) NSMutableArray *appArray;

// Make the database
@property (strong, nonatomic) NSString * databasePath;
@property (nonatomic) sqlite3 *contactDB;
@property (strong, nonatomic) NSMutableArray *array_ObjInfo;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Table call
    [self DetailCall];
    
    _label_status.lineBreakMode = NSLineBreakByWordWrapping;
    _label_status.numberOfLines = 0;
    
    // Database call
    [self DatabaseCall];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma To display the JSON data
- (void)DetailCall {
    
    NSString *urlString = @"https://itunes.apple.com/search?term=apple&media=software";
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSession *session = [NSURLSession sharedSession]; // + class method
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        id object = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        if (error) {
            
            NSLog(@"Error: %@",error);
        }
        else {
            //NSLog(@"Arrived here");
            [self JSONData:object];
        }
    }];// return a dataTask
    [dataTask resume]; //resume is necessary
}

- (void)JSONData:(id)object {
    
    if ([object isKindOfClass:[NSDictionary class]]) { // In JSON data, if nothing before brackets, then check [object isKindOfClass:[NSArray Array]]
        NSDictionary *myDict = object;
        NSArray *resultArray = [myDict objectForKey:@"results"];
        
        _appArray = [NSMutableArray new];
        for (int i = 0; i < [resultArray count]; i++) {
            
            MyStructure *objStructure = [MyStructure new];
            NSDictionary *dict = resultArray[i];
            
            objStructure.artistName = [NSString stringWithFormat:@"%@", [dict objectForKey:@"artistName"]];
            objStructure.price = [NSString stringWithFormat:@"%@", [dict objectForKey:@"price"]];
            NSString *feature = [NSString stringWithFormat:@"%@", [dict objectForKey:@"features"]];
            NSString * newString = [feature stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            NSString * newString2 = [newString stringByReplacingOccurrencesOfString:@" " withString:@""];
            NSString * newString3 = [newString2 stringByReplacingOccurrencesOfString:@"(" withString:@""];
            NSString * newString4 = [newString3 stringByReplacingOccurrencesOfString:@")" withString:@""];
            objStructure.features = [NSString stringWithFormat:@"%@", newString4];
            objStructure.releaseNotes = [NSString stringWithFormat:@"%@", [dict objectForKey:@"releaseNotes"]];
            objStructure.trackViewUrl = [NSString stringWithFormat:@"%@", [dict objectForKey:@"trackViewUrl"]];
            objStructure.arrayScreenShots =[NSMutableArray new];
            NSArray *arrayScreenShots =[dict objectForKey:@"screenshotUrls"];
            for (int j = 0; j < [arrayScreenShots count]; j++) {
                
                NSString *strUrls = arrayScreenShots[j];
                [objStructure.arrayScreenShots addObject:strUrls];
            }
            
            [_appArray addObject:objStructure];
        }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [_tableview_Detail reloadData];
        _myActivityIndicator.hidden = YES;
    });
}

#pragma To make the database 
- (void)DatabaseCall {

    NSArray *dirPaths;
    NSString *docsDir;
    
    // Get the documents directory // Mandontary
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    
    // Build the path to the database file
    _databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"AppInfo.db"]];
    
    // To declare a file manager object to search the file
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    // To see if the AppInfo.db is there
    if ([filemgr fileExistsAtPath: _databasePath ] == NO) {// this is first time, u r installing the app.
        // If not
        const char *dbpath = [_databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK) {
            
            char *errMsg;
            const char *sql_stmt =
            "CREATE TABLE IF NOT EXISTS APPINFO (ID INTEGER PRIMARY KEY AUTOINCREMENT, ArtistName TEXT, Price TEXT, Feature TEXT)";
            
            if (sqlite3_exec(_contactDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) {
                
                _label_status.text = @"Failed to create table";
            }
            _label_status.text =@"Created database sucessfully";
            sqlite3_close(_contactDB);
        }
        else {
            
            _label_status.text = @"Failed to open/create database";
        }
    }
    else
        _label_status.text = @"Data base already created";
}

#pragma To make the table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _appArray.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *myCell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"DetailCell"];
    MyStructure *objStructure = [_appArray objectAtIndex:indexPath.row];
    myCell.textLabel.text = [NSString stringWithFormat:@"Artist Name: %@", objStructure.artistName];
    myCell.detailTextLabel.text = [NSString stringWithFormat:@"Price: $%@", objStructure.price];
    
    return myCell;
    
}

#pragma To display the database
- (IBAction)ButtonAction_DisplayDatabase:(id)sender {
    
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK) {
        
        NSString *querySQL = @"SELECT * FROM appinfo"; // * is to display all the data
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(_contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
            
            _array_ObjInfo =[NSMutableArray new];
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                MyStructure *obj_Structure = [MyStructure new];
                NSString *ArtistName = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                NSString *Price = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                NSString *Features = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                
                obj_Structure.artistName = ArtistName;
                obj_Structure.price = Price;
                obj_Structure.features = Features;
                
                [_array_ObjInfo addObject:obj_Structure];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_contactDB);
    }
}

#pragma To process to the next screen
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier]isEqualToString:@"DetailPush"]) {
        DetailViewController *objDVC = [segue destinationViewController];
        NSIndexPath *myIndexPath = [_tableview_Detail indexPathForSelectedRow];
        objDVC.objMyStructure = [_appArray objectAtIndex:myIndexPath.row];
        objDVC.DatabasePath = _databasePath;
        objDVC.ContactDB = _contactDB;
    }
    else if ([[segue identifier]isEqualToString:@"DisplayPush"]) {
    
        DatabaseViewController *objDBVC = [segue destinationViewController];
        NSIndexPath *myIndexPath = [_tableview_Detail indexPathForSelectedRow];
        objDBVC.objMyStructure = [_appArray objectAtIndex:myIndexPath.row];
        objDBVC.DatabasePath = _databasePath;
        objDBVC.ContactDB = _contactDB;
        objDBVC.array_Structure = _array_ObjInfo;
    }
}

@end
