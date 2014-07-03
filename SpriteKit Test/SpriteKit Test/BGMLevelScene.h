//
//  BGMMyScene.h
//  SpriteKit Test
//

//  Copyright (c) 2014年 馬 岩. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface BGMLevelScene : SKScene

@property (assign, nonatomic) NSUInteger levelNumber;
@property (assign, nonatomic) NSUInteger playerLives;
@property (assign, nonatomic) BOOL finished;

+ (instancetype)sceneWithSize:(CGSize)size levelNumber:(NSUInteger)levelNumber;
- (instancetype)initWithSize:(CGSize)size levelNumber:(NSUInteger)levelNumber;

@end
