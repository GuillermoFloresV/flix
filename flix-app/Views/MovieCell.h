//
//  MovieCell.h
//  flix-app
//
//  Created by gfloresv on 6/26/20.
//  Copyright © 2020 gfloresv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
NS_ASSUME_NONNULL_BEGIN

@interface MovieCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (nonatomic, strong) Movie *movie;

@end

NS_ASSUME_NONNULL_END
