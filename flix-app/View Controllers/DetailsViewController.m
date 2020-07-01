//
//  DetailsViewController.m
//  flix-app
//
//  Created by gfloresv on 6/26/20.
//  Copyright © 2020 gfloresv. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backdropView;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *releaseDataLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    
    
    NSString *posterURLString = self.movie.posterUrl;
    NSString *fullPosterPathURLString = [baseURLString stringByAppendingFormat:@"%@", posterURLString];
    NSURL *posterURLPath = [NSURL URLWithString:fullPosterPathURLString];
    [self.posterView setImageWithURL:posterURLPath];
    
    NSString *backdropURLString = self.movie.backdropURL;
    NSString *fullBackdropPathURLString = [baseURLString stringByAppendingFormat:@"%@", backdropURLString];
    NSURL *backdropURLPath = [NSURL URLWithString:fullBackdropPathURLString];
    [self.backdropView setImageWithURL:backdropURLPath];
    
    self.titleLabel.text = self.movie.title;
    self.synopsisLabel.text = self.movie.descriptionLabel;
    self.releaseDataLabel.text = self.movie.releaseDate;
    
    [self.titleLabel sizeToFit];
    [self.synopsisLabel sizeToFit];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
