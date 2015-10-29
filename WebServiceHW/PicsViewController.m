//
//  PicsViewController.m
//  WebServiceHW
//
//  Created by Hongjin Su on 10/19/15.
//  Copyright © 2015 Hongjin Su. All rights reserved.
//

#import "PicsViewController.h"

@interface PicsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableview_screenShots;
@property (weak, nonatomic) IBOutlet UIImageView *myImageview;
//@property NSInteger rowNo;
@end

@implementation PicsViewController

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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PicsCell"];
    cell.textLabel.text = [_objMyStructure.arrayScreenShots objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma To try to show the image 
- (void)tableView:(UITableView * _Nonnull)tableView didSelectRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath {

    NSString *path = [_objMyStructure.arrayScreenShots objectAtIndex:indexPath.row];
    NSURL *url = [NSURL URLWithString:path];
    NSData *data = [NSData dataWithContentsOfURL:url];
    _myImageview.image = [UIImage imageWithData:data];
}














//#pragma mark Rui Guo codes
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    _rowNo = indexPath.row;
//    
//        NSString *str=[_objMyStructure.arrayScreenShots objectAtIndex:_rowNo];
//        
//        NSLog(@"this is the %lu cell called download method",_rowNo);
//        [self webService_downloadImage:str];
//    
//}
//
//-(void)webService_downloadImage:(NSString *)str{
//    NSLog(@"this is the url :%@",str);
//    NSURLSessionConfiguration *url_config=[NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *session=[NSURLSession sessionWithConfiguration:url_config delegate:self delegateQueue:nil];
//    NSURLSessionDownloadTask *downloadTask=[session downloadTaskWithURL:[NSURL URLWithString:str]];
//    [downloadTask resume];
//    
//}
//
//
//- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
//didFinishDownloadingToURL:(NSURL *)location{
//    NSData *imagedata=[NSData dataWithContentsOfURL:location];
//    
//    
//    dispatch_async(dispatch_get_main_queue(), ^(void){
//        self.myImageview.image=[UIImage imageWithData:imagedata];
//        //NSLog(@"%@",[imagedata description]);
//        //self.progressbar.hidden=YES;
//    });
//}
//
//
//- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
//      didWriteData:(int64_t)bytesWritten
// totalBytesWritten:(int64_t)totalBytesWritten
//totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
//    
//    
//    float progress=(double)totalBytesWritten/(double)totalBytesExpectedToWrite;
//    dispatch_async(dispatch_get_main_queue(), ^{
//       // [self.progressbar setProgress:progress];
//    });
//}
@end
