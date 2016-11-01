//
//  GlobalInfo.h
//  NewVipxox
//
//  Created by 黄佳峰 on 16/8/30.
//  Copyright © 2016年 黄蜂大魔王. All rights reserved.
//

#ifndef GlobalInfo_h
#define GlobalInfo_h

#define HTTP_ADDRESS        @"http://114.215.252.104"    //地址

#define HTTP_REGISTER       @"/api.php/Login/reg/" //注册账号
#define HTTP_REGISTER_CODE   @"/api.php/Login/getRegisterCode/" //注册验证码
#define HTTP_LOGION_CODE   @"/api.php/Login/getRegisterCode/" //快捷登录验证码
#define HTTP_RESET_CODE   @"/api.php/Login/getRegisterCode/" //重置密码验证码


#define HTTP_LOGIN          @"/api.php/Login/login/" //登入
#define HTTP_LOGIN_Quick      @"/api.php/Login/phoneLogin/" //快捷登录
#define HTTP_LOGIN_FORGET_TEL @"/api.php/Login/resetPassword/" //找回密码



#define HTTP_RB_HOME @"/api.php/Note/index/" //发现首页
#define HTTP_RB_DETAIL @"/api.php/Note/detail/" //笔记详情
#define HTTP_RB_RELATED @"/api.php/Note/getRelationNote/" //相关笔记
#define HTTP_RB_LIKE @"/api.php/Note/addLikes/" //添加点赞（喜欢）
#define HTTP_RB_LIKE_CANCEL @"/api.php/Note/delLikes/" //取消点赞（喜欢）
#define HTTP_RB_ALDUM @"/api.php/Note/getUserAlbumLists/" //获取用户专辑列表
#define HTTP_RB_CREATE_ALDUM @"/api.php/Note/addAlbum/" //创建专辑
#define HTTP_RB_COLLECTION_TO_ALDUM @"/api.php/Note/addToMyAlbum/" //添加收藏到我的专辑
#define HTTP_RB_COLLECTION_CANCEL @"/api.php/Note/delMyNoteAlbum/" //取消收藏
#define HTTP_RB_ATTENTION_ADD @"/api.php/User/addAttention/" //关注发布者
#define HTTP_RB_ATTENTION_CANCEL @"/api.php/User/delAttention/" //删除关注
#define HTTP_RB_COMMENT @"/api.php/Note/addNoteComment/" //评论发布
#define HTTP_RB_SEARCH_QUICK @"/api.php/Note/hotSearch/" //笔记热门搜索
#define HTTP_RB_SEARCH_KEY @"/api.php/Note/getRelationKeywords/" //搜索相关
#define HTTP_RB_SEARCH_RESULT @"/api.php/Note/searchResult/" //搜索结果
#define HTTP_RB_NODE_PUBLISH @"/api.php/Note/addNote/" //发布笔记
//#define HTTP_RB_ @"/api.php/Login/resetPassword/" //添加地点
//#define HTTP_RB_ @"/api.php/Login/resetPassword/" //搜索地点
#define HTTP_RB_ATTENTION @"/api.php/User/myAttention/" //我的关注

#define HTTP_IMG_UP @"/api.php/Index/uploadImg/" //上传图片














#pragma mark  -- 首页
#define HTTP_HOME_PAGE    @"/api.php/Index/index/"    //首页获取数据的接口
#define HTTP_HOME_UPDATECOORDINATE    @"/api.php/Index/updateCoordinate/"   //更新经纬度
#define HTTP_HOME_HOTSEARCH          @"/api.php/Index/hotSearch/"    //热门搜索
#define HTTP_HOME_SEARCH            @"/api.php/Index/searchResult/"     //搜索



#endif /* GlobalInfo_h */
