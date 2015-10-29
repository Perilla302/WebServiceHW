//
//  Pics2ViewController.m
//  WebServiceHW
//
//  Created by Hongjin Su on 10/20/15.
//  Copyright © 2015 Hongjin Su. All rights reserved.
//

#import "Pics2ViewController.h"

@interface Pics2ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableview_pics2;
@property (weak, nonatomic) IBOutlet UIImageView *imageview_2;

@end

@implementation Pics2ViewController

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

#pragma mark UITABLE View DataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _objMyStructure.arrayScreenShots.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Pics2Cell"];
    cell.textLabel.text = [_objMyStructure.arrayScreenShots objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma To try to show the image
- (void)tableView:(UITableView * _Nonnull)tableView didSelectRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath {
    
    NSString *path = [_objMyStructure.arrayScreenShots objectAtIndex:indexPath.row];
    NSURL *url = [NSURL URLWithString:path];
    NSData *data = [NSData dataWithContentsOfURL:url];
    _imageview_2.image = [UIImage imageWithData:data];
}


@end
