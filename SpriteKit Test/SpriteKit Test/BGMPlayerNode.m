//
//  BGMPlayerNode.m
//  SpriteKit Test
//
//  Created by 馬 岩 on 14-7-2.
//  Copyright (c) 2014年 馬 岩. All rights reserved.
//

#import "BGMPlayerNode.h"

#import "BGMGeometry.h"

#import "BGMPhysicsCategories.h"

@implementation BGMPlayerNode

- (instancetype)init
{
    if (self = [super init])
	{
        self.name = [NSString stringWithFormat:@"Player %p", self];
        [self initNodeGraph];
		[self initPhysicsBody];
    }
	return self;
}

- (void)initNodeGraph
{
    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Courier"];
    label.fontColor = [SKColor darkGrayColor];
    label.fontSize = 40;
    label.text = @"v";
	
	// some test code
//	label.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
//	label.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
	
    label.zRotation = M_PI;
    label.name = @"label";
	
    [self addChild:label];
}

- (void)initPhysicsBody
{
    SKPhysicsBody *body = [SKPhysicsBody bodyWithRectangleOfSize:
                           CGSizeMake(20, 20)];
    body.affectedByGravity = NO;
    body.categoryBitMask = PlayerCategory;
	body.contactTestBitMask = EnemyCategory;
	
    body.collisionBitMask = 0;
    self.physicsBody = body;
}

- (CGFloat)moveToward:(CGPoint)location
{
    [self removeActionForKey:@"movement"];
	[self removeActionForKey:@"wobbling"];
	
	self.xScale = 1.0;
	
    CGFloat distance = BGMPointDistance(self.position, location);
    CGFloat pixels = [UIScreen mainScreen].bounds.size.width;
    CGFloat duration = 2.0 * distance / pixels;
    [self runAction:[SKAction moveTo:location duration:duration]
            withKey:@"movement"];
	
	CGFloat wobbleTime = 0.3;
    CGFloat halfWobbleTime = wobbleTime * 0.5;
    SKAction *wobbling = [SKAction
                          sequence:@[[SKAction scaleXTo:0.2
                                               duration:halfWobbleTime],
                                     [SKAction scaleXTo:1.0
                                               duration:halfWobbleTime]
                                     ]];
    NSUInteger wobbleCount = duration / wobbleTime;
    [self runAction:[SKAction repeatAction:wobbling count:wobbleCount]
            withKey:@"wobbling"];
	
    return duration;
}

@end
