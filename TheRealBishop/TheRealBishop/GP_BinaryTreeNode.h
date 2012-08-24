//
//  GP_BinaryTreeNode.h
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-8.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GP_BinaryTreeNode : NSObject
{
//    public var left:BinaryTreeNode;
//    
//    public var right:BinaryTreeNode;
//    
//    public var parent:BinaryTreeNode;
//    
//    public var data:*;
    @public
        GP_BinaryTreeNode *left,*right,*parent;
        id data;
}
//

//public static function preorder(node:BinaryTreeNode, process:Function):void
+(void)preorder:(GP_BinaryTreeNode *)node func:(id *)process;
//public static function inorder(node:BinaryTreeNode, process:Function):void
+(void)inorder:(GP_BinaryTreeNode *)node func:(id *)process;
//public static function postorder(node:BinaryTreeNode, process:Function):void
+(void)postorder:(GP_BinaryTreeNode *)node func:(id *)process;
//public function BinaryTreeNode(obj:*)
-(void)BinaryTreeNode:(id)obj;
//public function setLeft(obj:*):void
-(void)setLeft:(id)obj;
//public function setRight(obj:*):void
-(void)setRight:(id)obj;
//public function isLeft():Boolean
-(BOOL)isLeft;
//public function isRight():Boolean
-(BOOL)isRight;
//public function getDepth(node:BinaryTreeNode = null):int
-(int)getDepth:(GP_BinaryTreeNode *)node;
//public function count():int
-(int)count;
//public function destroy():void
-(void)destroy;
//public function toString():String
-(NSString *)toString;
//
@end
