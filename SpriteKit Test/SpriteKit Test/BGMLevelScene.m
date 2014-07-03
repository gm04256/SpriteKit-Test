//
//  BGMMyScene.m
//  SpriteKit Test
//
//  Created by 馬 岩 on 14-6-19.
//  Copyright (c) 2014年 馬 岩. All rights reserved.
//

#import "BGMLevelScene.h"
#import "BGMPlayerNode.h"
#import "BGMEnemyNode.h"
#import "BGMBulletNode.h"

#define ARC4RANDOM_MAX      0x100000000

@interface BGMLevelScene ()

@property (strong, nonatomic) BGMPlayerNode *playerNode;
@property (strong, nonatomic) SKNode *enemies;
@property (strong, nonatomic) SKNode *playerBullets;

@end

@implementation BGMLevelScene

#pragma mark - Construct Methods

+ (instancetype)sceneWithSize:(CGSize)size levelNumber:(NSUInteger)levelNumber
{
    return [[self alloc] initWithSize:size levelNumber:levelNumber];
}

- (instancetype)initWithSize:(CGSize)size
{
    return [self initWithSize:size levelNumber:1];
}

- (instancetype)initWithSize:(CGSize)size levelNumber:(NSUInteger)levelNumber
{
    if (self = [super initWithSize:size])
	{
        _levelNumber = levelNumber;
        _playerLives = 5;
        self.backgroundColor = [SKColor whiteColor];
        SKLabelNode *lives = [SKLabelNode labelNodeWithFontNamed:@"Courier"];
        lives.fontSize = 16;
        lives.fontColor = [SKColor blackColor];
        lives.name = @"LivesLabel";
        lives.text = [NSString stringWithFormat:@"Lives: %lu",
                      (unsigned long)_playerLives];
        lives.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
        lives.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        lives.position = CGPointMake(self.frame.size.width,
                                     self.frame.size.height);
		[self addChild:lives];
		
		SKLabelNode *level = [SKLabelNode labelNodeWithFontNamed:@"Courier"];
        level.fontSize = 16;
        level.fontColor = [SKColor blackColor];
        level.name = @"LevelLabel";
        level.text = [NSString stringWithFormat:@"Level: %lu",
                      (unsigned long)_levelNumber];
        level.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
        level.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        level.position = CGPointMake(0, self.frame.size.height);
        [self addChild:level];
		
		_playerNode = [BGMPlayerNode node];
        _playerNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetHeight(self.frame) * 0.1);
		[self addChild:_playerNode];
		
		_enemies = [SKNode node];
		[self addChild:_enemies];
		[self spawnEnemies];
		
		_playerBullets = [SKNode node];
		[self addChild:_playerBullets];
	}
    return self;
}

#pragma mark - Touch Event Method

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    /* Called when a touch begins */
    
    for (UITouch *touch in touches)
	{
        CGPoint location = [touch locationInNode:self];
        
        if (location.y < CGRectGetHeight(self.frame) * 0.2 )
		{
            CGPoint target = CGPointMake(location.x,
                                         self.playerNode.position.y);
            CGFloat duration = [self.playerNode moveToward:target];
        }
		else
		{
			BGMBulletNode *bullet = [BGMBulletNode
                                     bulletFrom:self.playerNode.position
                                     toward:location];
            if (bullet)
			{
                [self.playerBullets addChild:bullet];
			}
		}
    }
}

-(void)update:(CFTimeInterval)currentTime
{
    /* Called before each frame is rendered */
	if (self.finished) return;
    [self updateBullets];
    [self updateEnemies];
    [self checkForNextLevel];
}

- (void)updateBullets
{
    NSMutableArray *bulletsToRemove = [NSMutableArray array];
    for (BGMBulletNode *bullet in self.playerBullets.children)
	{
        // Remove any bullets that have moved off-screen
        if (!CGRectContainsPoint(self.frame, bullet.position))
		{
            // mark bullet for removal
            [bulletsToRemove addObject:bullet];
            continue;
        }
        // Apply thrust to remaining bullets
        [bullet applyRecurringForce];
	}
    [self.playerBullets removeChildrenInArray:bulletsToRemove];
}

- (void)updateEnemies {
    NSMutableArray *enemiesToRemove = [NSMutableArray array];
    for (SKNode *node in self.enemies.children) {
        // Remove any enemies that have moved off-screen
        if (!CGRectContainsPoint(self.frame, node.position)) {
            // mark enemy for removal
            [enemiesToRemove addObject:node];
            continue;
		}
	}
    if ([enemiesToRemove count] > 0) {
        [self.enemies removeChildrenInArray:enemiesToRemove];
	}
}

- (void)checkForNextLevel
{
    if ([self.enemies.children count] == 0)
	{
        [self goToNextLevel];
    }
}

- (void)goToNextLevel
{
    self.finished = YES;
    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Courier"];
    label.text = @"Level Complete!";
    label.fontColor = [SKColor blueColor];
    label.fontSize = 32;
    label.position = CGPointMake(self.frame.size.width * 0.5,
                                 self.frame.size.height * 0.5);
    [self addChild:label];
	
    BGMLevelScene *nextLevel = [[BGMLevelScene alloc]
                                initWithSize:self.frame.size
                                levelNumber:self.levelNumber + 1];
    nextLevel.playerLives = self.playerLives;
    [self.view presentScene:nextLevel
                 transition:[SKTransition flipHorizontalWithDuration:1.0]];
}

- (void)spawnEnemies
{
    NSUInteger count = log(self.levelNumber) + self.levelNumber;
    for (NSUInteger i = 0; i < count; i++)
	{
        BGMEnemyNode *enemy = [BGMEnemyNode node];
        CGSize size = self.frame.size;
        CGFloat x = (size.width * 0.8 * arc4random() / ARC4RANDOM_MAX) +
		(size.width * 0.1);
        CGFloat y = (size.height * 0.5 * arc4random() / ARC4RANDOM_MAX) +
		(size.height * 0.5);
        enemy.position = CGPointMake(x, y);
        [self.enemies addChild:enemy];
    }
}

@end
