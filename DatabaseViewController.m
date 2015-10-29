//
//  DatabaseViewController.m
//  WebServiceHW
//
//  Created by Hongjin Su on 10/19/15.
//  Copyright © 2015 Hongjin Su. All rights reserved.
//

#import "MyStructure.h"
#import "DatabaseViewController.h"

@interface DatabaseViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableview_Database;

@end

@implementation DatabaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array_Structure.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =(UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"DatabaseCell"];
    MyStructure *objStr = [_array_Structure objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"Artist Name: %@; Price: $%@", objStr.artistName, objStr.price];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Features: %@", objStr.features];
    
    return cell;
}

@end
