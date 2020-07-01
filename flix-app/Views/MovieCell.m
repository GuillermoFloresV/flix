//
//  MovieCell.m
//  flix-app
//
//  Created by gfloresv on 6/26/20.
//  Copyright © 2020 gfloresv. All rights reserved.
//

#import "MovieCell.h"
#import "Movie.h"
#import "UIImageView+AFNetworking.h"
@implementation MovieCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setMovie:(Movie *)movie {
    // Since we're replacing the default setter, we have to set the underlying private storage _movie ourselves.
    // _movie was an automatically declared variable with the @propery declaration.
    // You need to do this any time you create a custom setter.
    _movie = movie;

    self.titleLabel.text = self.movie.title;
    self.descriptionLabel.text = self.movie.description;

    self.posterView.image = nil;
    if (self.movie.posterUrl != nil) {
        [self.posterView setImageWithURL:self.movie.posterURLPath];
    }
}

@end
