USE [master]
GO
/****** Object:  Database [order_tracking_latest]    Script Date: 26-01-2016 03:53:02 ******/
CREATE DATABASE [order_tracking_latest]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'order_tracking_latest', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\order_tracking_latest.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'order_tracking_latest_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\order_tracking_latest_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [order_tracking_latest] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [order_tracking_latest].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [order_tracking_latest] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [order_tracking_latest] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [order_tracking_latest] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [order_tracking_latest] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [order_tracking_latest] SET ARITHABORT OFF 
GO
ALTER DATABASE [order_tracking_latest] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [order_tracking_latest] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [order_tracking_latest] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [order_tracking_latest] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [order_tracking_latest] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [order_tracking_latest] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [order_tracking_latest] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [order_tracking_latest] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [order_tracking_latest] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [order_tracking_latest] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [order_tracking_latest] SET  DISABLE_BROKER 
GO
ALTER DATABASE [order_tracking_latest] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [order_tracking_latest] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [order_tracking_latest] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [order_tracking_latest] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [order_tracking_latest] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [order_tracking_latest] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [order_tracking_latest] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [order_tracking_latest] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [order_tracking_latest] SET  MULTI_USER 
GO
ALTER DATABASE [order_tracking_latest] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [order_tracking_latest] SET DB_CHAINING OFF 
GO
ALTER DATABASE [order_tracking_latest] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [order_tracking_latest] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [order_tracking_latest]
GO
/****** Object:  StoredProcedure [dbo].[CreatePlayList]    Script Date: 26-01-2016 03:53:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CreatePlayList] 
AS
BEGIN
	DELETE FROM tbl_player;
	INSERT INTO tbl_player(song_id,order_number) 
		SELECT song_id,ROW_NUMBER() OVER(order by NEWID()) AS RNUM  FROM tbl_songs

	SELECT tbl_player.song_id,tbl_songs.song_name,tbl_songs.song_url,case is_playing when 1 then 'playing' else '' end as is_playing,
                case when is_requested =1 then 'display:none' else '' end as is_requested
                from tbl_player inner join tbl_songs on tbl_player.song_id = tbl_songs.song_id where is_played = 0 and is_played=0 order by order_number,requested_time
END


GO
/****** Object:  Table [dbo].[tbl_admin]    Script Date: 26-01-2016 03:53:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_admin](
	[admin_id] [int] IDENTITY(1,1) NOT NULL,
	[admin_name] [varchar](50) NULL,
	[admin_password] [varchar](50) NULL,
	[emailid] [varchar](50) NULL,
	[profile_pic] [varchar](150) NULL,
	[is_superadmin] [bit] NULL,
	[offers_combos] [bit] NULL,
	[inform_before_activate] [bit] NULL,
	[item_details] [bit] NULL,
	[created_by] [int] NULL,
	[is_active] [bit] NULL,
	[created_date] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_category]    Script Date: 26-01-2016 03:53:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_category](
	[category_id] [int] IDENTITY(1,1) NOT NULL,
	[category_name] [varchar](50) NULL,
	[category_image] [varchar](max) NULL,
	[description] [ntext] NULL,
	[added_by] [int] NULL,
	[is_active] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_combos]    Script Date: 26-01-2016 03:53:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_combos](
	[Combo_id] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](50) NULL,
	[description] [varchar](500) NULL,
	[price] [float] NULL,
	[combo_picture] [varchar](50) NULL,
 CONSTRAINT [PK_tbl_combos] PRIMARY KEY CLUSTERED 
(
	[Combo_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_eventpictures]    Script Date: 26-01-2016 03:53:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_eventpictures](
	[eventPictureId] [int] IDENTITY(1,1) NOT NULL,
	[event_id] [int] NULL,
	[picture_url] [varchar](500) NULL,
 CONSTRAINT [PK_tbl_eventpictures] PRIMARY KEY CLUSTERED 
(
	[eventPictureId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_events]    Script Date: 26-01-2016 03:53:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_events](
	[event_id] [int] IDENTITY(1,1) NOT NULL,
	[event_title] [varchar](50) NULL,
	[Message] [text] NULL,
	[event_date] [datetime] NULL,
	[is_displayed] [bit] NULL,
 CONSTRAINT [PK_tbl_events] PRIMARY KEY CLUSTERED 
(
	[event_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_hoteldetails]    Script Date: 26-01-2016 03:53:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_hoteldetails](
	[hotel_id] [int] IDENTITY(1,1) NOT NULL,
	[hotel_name] [varchar](50) NULL,
	[sub_title] [varchar](250) NULL,
	[logo] [varchar](max) NULL,
	[admin_emailid] [varchar](50) NULL,
	[password] [varchar](50) NULL,
	[hotel_address] [varchar](500) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_items]    Script Date: 26-01-2016 03:53:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_items](
	[item_id] [int] IDENTITY(1,1) NOT NULL,
	[item_name] [varchar](50) NULL,
	[category_id] [int] NULL,
	[price] [float] NULL,
	[item_image] [varchar](max) NULL,
	[item_desc] [ntext] NULL,
	[qty] [int] NULL,
	[added_by] [int] NULL,
	[is_active] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_order_details]    Script Date: 26-01-2016 03:53:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_order_details](
	[order_detailid] [int] IDENTITY(1,1) NOT NULL,
	[order_id] [int] NULL,
	[item_id] [int] NULL,
	[combo_id] [int] NULL,
	[price] [float] NULL,
	[qty] [float] NULL,
	[amount]  AS ([price]*[qty])
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_orders]    Script Date: 26-01-2016 03:53:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_orders](
	[order_id] [int] IDENTITY(1,1) NOT NULL,
	[start_date] [datetime] NULL,
	[isClosed] [bit] NULL,
	[tableNumber] [int] NULL,
	[amount] [float] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_player]    Script Date: 26-01-2016 03:53:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_player](
	[song_id] [int] NULL,
	[order_number] [int] NULL,
	[is_played] [bit] NULL,
	[is_requested] [bit] NULL,
	[requested_time] [datetime] NULL,
	[is_playing] [bit] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_songs]    Script Date: 26-01-2016 03:53:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_songs](
	[song_id] [int] IDENTITY(1,1) NOT NULL,
	[song_name] [varchar](500) NULL,
	[song_url] [varchar](150) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_themes]    Script Date: 26-01-2016 03:53:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_themes](
	[theme_id] [int] IDENTITY(1,1) NOT NULL,
	[theme_name] [varchar](250) NULL,
	[image_url] [varchar](500) NULL,
	[is_active] [bit] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_admin] ON 

INSERT [dbo].[tbl_admin] ([admin_id], [admin_name], [admin_password], [emailid], [profile_pic], [is_superadmin], [offers_combos], [inform_before_activate], [item_details], [created_by], [is_active], [created_date]) VALUES (2, N'Sushmit', N'123456', N'sushmit.patil@gmail.com', N'cropped_rlhiny01.gyz.jpg', 1, 1, 1, 1, 0, 1, CAST(0x0000A3B101529939 AS DateTime))
INSERT [dbo].[tbl_admin] ([admin_id], [admin_name], [admin_password], [emailid], [profile_pic], [is_superadmin], [offers_combos], [inform_before_activate], [item_details], [created_by], [is_active], [created_date]) VALUES (3, NULL, N'123456', N'sushmit.patil@gmail.com', NULL, 1, NULL, NULL, NULL, 0, 1, CAST(0x0000A3B400C825DE AS DateTime))
INSERT [dbo].[tbl_admin] ([admin_id], [admin_name], [admin_password], [emailid], [profile_pic], [is_superadmin], [offers_combos], [inform_before_activate], [item_details], [created_by], [is_active], [created_date]) VALUES (4, NULL, N'123456789', N'sushmit.patil@gmail.com', NULL, 1, 1, 1, 1, 0, 1, CAST(0x0000A58900C71EAE AS DateTime))
SET IDENTITY_INSERT [dbo].[tbl_admin] OFF
SET IDENTITY_INSERT [dbo].[tbl_category] ON 

INSERT [dbo].[tbl_category] ([category_id], [category_name], [category_image], [description], [added_by], [is_active]) VALUES (1, N'Rice Items', N'973a808a-ab42-42a4-b265-3985a70a9a8c.jpg', N'Deee', 2, 1)
INSERT [dbo].[tbl_category] ([category_id], [category_name], [category_image], [description], [added_by], [is_active]) VALUES (6, N'Cat 1', N'0989a59c-9db8-4474-8ef9-661d5d46ceb2.jpg', N'Demo', 2, 1)
SET IDENTITY_INSERT [dbo].[tbl_category] OFF
SET IDENTITY_INSERT [dbo].[tbl_combos] ON 

INSERT [dbo].[tbl_combos] ([Combo_id], [title], [description], [price], [combo_picture]) VALUES (2, N'Buy 2 Get 1 Free', N'This is demo pack for families of 4 members.', 450, N'bc5ae265-f51e-46f9-ab5c-66d7e9e0739a.jpg')
INSERT [dbo].[tbl_combos] ([Combo_id], [title], [description], [price], [combo_picture]) VALUES (1002, N'Demo Combo1', N'de', 1000, N'a13d85e4-317c-436d-b7af-19416f2ede77.jpg')
INSERT [dbo].[tbl_combos] ([Combo_id], [title], [description], [price], [combo_picture]) VALUES (1003, N'Buy 2 Get 1 Free', N'SDSA', 120, N'd79f1bce-56fb-4787-8788-d7b29d760158.jpg')
INSERT [dbo].[tbl_combos] ([Combo_id], [title], [description], [price], [combo_picture]) VALUES (1004, N'Buy 2 Get 2 Free', N'sads', 450, N'e6bd311b-a063-4ea4-8f2d-0e1bc154650b.jpg')
SET IDENTITY_INSERT [dbo].[tbl_combos] OFF
SET IDENTITY_INSERT [dbo].[tbl_eventpictures] ON 

INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (21, 4, N'https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-xaf1/t31.0-8/1795148_607235239376358_2923634548702667524_o.jpg')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (22, 4, N'https://scontent.xx.fbcdn.net/hphotos-xat1/t31.0-8/10847360_607235122709703_2370869082732998834_o.jpg')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (23, 4, N'https://fbcdn-sphotos-h-a.akamaihd.net/hphotos-ak-xtp1/t31.0-8/10560372_607235062709709_1820753219586245338_o.jpg')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (24, 4, N'https://scontent.xx.fbcdn.net/hphotos-xpf1/t31.0-8/10865868_607234799376402_5969333821938024904_o.jpg')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (25, 4, N'https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-xpt1/v/t1.0-9/11060851_864215716973269_1334613204549093874_n.jpg?oh=697e43f31099208bd4341c3f187fae90&oe=55D8B000&__gda__=1437297156_1e1ccab9d9c216163317a2c9cbff8d9e')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (26, 4, N'https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-xfp1/v/t1.0-9/11060046_864215076973333_6644411994504680239_n.jpg?oh=7612000c14e1681fba99acb54020de50&oe=55E4948C&__gda__=1440172037_bbfc0c7b873e07aca350a2e293bd51d9')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (27, 4, N'https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-xat1/v/t1.0-9/10906496_835358249859016_7020446227627512264_n.jpg?oh=c4999e02757d788606f1aabc2050974d&oe=559BE31E&__gda__=1440824513_ec6227280f146ca3ca929abda58a9c48')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (28, 4, N'https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-xpa1/v/t1.0-9/10175042_835358183192356_7846307678831921277_n.jpg?oh=6103912b1312e1be1d95f1a7c7b61c33&oe=5598B65A&__gda__=1440069346_9b28571a14c58c80069eb6d141ef890f')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (29, 4, N'https://scontent.xx.fbcdn.net/hphotos-xfa1/v/t1.0-9/1480523_835358119859029_9071514128538627202_n.jpg?oh=1d3e073aeea0d7fc0dcf0a56b5a8d1d3&oe=559C79FD')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (30, 4, N'https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-xfp1/v/t1.0-9/10403258_835357746525733_7489080481618196105_n.jpg?oh=de7953117d19ad3e8c594b718bb4cebd&oe=55A25021&__gda__=1436389544_345d5a5e9494126c11058e7066ba3b90')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (1011, 1003, N'https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-xaf1/t31.0-8/1795148_607235239376358_2923634548702667524_o.jpg')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (1012, 1003, N'https://scontent.xx.fbcdn.net/hphotos-xat1/t31.0-8/10847360_607235122709703_2370869082732998834_o.jpg')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (1013, 1003, N'https://fbcdn-sphotos-h-a.akamaihd.net/hphotos-ak-xtp1/t31.0-8/10560372_607235062709709_1820753219586245338_o.jpg')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (1014, 1003, N'https://scontent.xx.fbcdn.net/hphotos-xpf1/t31.0-8/10865868_607234799376402_5969333821938024904_o.jpg')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (1015, 1003, N'https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-xpt1/v/t1.0-9/11060851_864215716973269_1334613204549093874_n.jpg?oh=697e43f31099208bd4341c3f187fae90&oe=55D8B000&__gda__=1439889156_d4bfe19fdaa8f8d941bb9f75b8a16868')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (1016, 1003, N'https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-xfp1/v/t1.0-9/11060046_864215076973333_6644411994504680239_n.jpg?oh=7612000c14e1681fba99acb54020de50&oe=55E4948C&__gda__=1440172037_bbfc0c7b873e07aca350a2e293bd51d9')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (1017, 1003, N'https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-xat1/v/t1.0-9/10906496_835358249859016_7020446227627512264_n.jpg?oh=9c5f5e86d4b1bac8066c74389950d837&oe=55C3701E&__gda__=1440824513_2731377f54804d278836da25af409555')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (1018, 1003, N'https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-xpa1/v/t1.0-9/10175042_835358183192356_7846307678831921277_n.jpg?oh=6103912b1312e1be1d95f1a7c7b61c33&oe=5598B65A&__gda__=1440069346_9b28571a14c58c80069eb6d141ef890f')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (1019, 1003, N'https://scontent.xx.fbcdn.net/hphotos-xfa1/v/t1.0-9/1480523_835358119859029_9071514128538627202_n.jpg?oh=70cc1935f60f14d5c85692d7b4015502&oe=55C406FD')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (1020, 1003, N'https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-xfp1/v/t1.0-9/10403258_835357746525733_7489080481618196105_n.jpg?oh=56cdedab7f21e89d5f9ce30a3ff6d630&oe=55C9DD21&__gda__=1438981544_1b84380037193bd9549511f8cc223908')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (1021, 1004, N'https://z-1-scontent.xx.fbcdn.net/hphotos-xtp1/t31.0-8/12094810_679606832139198_1849627048383936906_o.jpg')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (1022, 1004, N'https://z-1-scontent.xx.fbcdn.net/hphotos-xtp1/t31.0-8/12113349_679603918806156_8445132776299644670_o.jpg')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (1023, 1004, N'https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-xta1/t31.0-8/12109778_679603915472823_5833387374005219963_o.jpg')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (1024, 1004, N'https://z-1-scontent.xx.fbcdn.net/hphotos-xat1/v/t1.0-9/11219344_1052523038091433_8621876432125004244_n.jpg?oh=19d65f8a120cab404aae8d6a0f26c0ff&oe=57421D89')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (1025, 1004, N'https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-xtf1/v/t1.0-9/10906496_835358249859016_7020446227627512264_n.jpg?oh=00dc3353b164c293c7798f12cde00405&oe=56FFD81E&__gda__=1459626565_a07fd5ffe5bb55be482760e11038a01a')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (1026, 1004, N'https://z-1-scontent.xx.fbcdn.net/hphotos-ash2/v/t1.0-9/10175042_835358183192356_7846307678831921277_n.jpg?oh=21400c15b748ca4bb983bd228d5fe946&oe=56FCAB5A')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (1027, 1004, N'https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-xap1/v/t1.0-9/1480523_835358119859029_9071514128538627202_n.jpg?oh=56887d127c35f6ecc5b71e55ccd37838&oe=57006EFD&__gda__=1459437748_02b819a385628ec9359fc002c8ef0aa3')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (1028, 1004, N'https://z-1-scontent.xx.fbcdn.net/hphotos-xlf1/v/t1.0-9/10403258_835357746525733_7489080481618196105_n.jpg?oh=bc579084e44e5a4aa6f6c18c1e8696a6&oe=57064521')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (1029, 1004, N'https://z-1-scontent.xx.fbcdn.net/hphotos-xpt1/v/t1.0-9/10933821_835357446525763_6960052107796132505_n.jpg?oh=49f72d34b40679285f6f9b7a5afd537d&oe=56FBDF4A')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (1030, 1005, N'https://z-1-scontent.xx.fbcdn.net/hphotos-xtp1/t31.0-8/12094810_679606832139198_1849627048383936906_o.jpg')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (1031, 1005, N'https://z-1-scontent.xx.fbcdn.net/hphotos-xtp1/t31.0-8/12113349_679603918806156_8445132776299644670_o.jpg')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (1032, 1005, N'https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-xta1/t31.0-8/12109778_679603915472823_5833387374005219963_o.jpg')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (1033, 1005, N'https://z-1-scontent.xx.fbcdn.net/hphotos-xat1/v/t1.0-9/11219344_1052523038091433_8621876432125004244_n.jpg?oh=19d65f8a120cab404aae8d6a0f26c0ff&oe=57421D89')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (1034, 1005, N'https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-xtf1/v/t1.0-9/10906496_835358249859016_7020446227627512264_n.jpg?oh=00dc3353b164c293c7798f12cde00405&oe=56FFD81E&__gda__=1459626565_a07fd5ffe5bb55be482760e11038a01a')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (1035, 1005, N'https://z-1-scontent.xx.fbcdn.net/hphotos-ash2/v/t1.0-9/10175042_835358183192356_7846307678831921277_n.jpg?oh=21400c15b748ca4bb983bd228d5fe946&oe=56FCAB5A')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (1036, 1005, N'https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-xap1/v/t1.0-9/1480523_835358119859029_9071514128538627202_n.jpg?oh=56887d127c35f6ecc5b71e55ccd37838&oe=57006EFD&__gda__=1459437748_02b819a385628ec9359fc002c8ef0aa3')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (1037, 1005, N'https://z-1-scontent.xx.fbcdn.net/hphotos-xlf1/v/t1.0-9/10403258_835357746525733_7489080481618196105_n.jpg?oh=bc579084e44e5a4aa6f6c18c1e8696a6&oe=57064521')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (1038, 1005, N'https://z-1-scontent.xx.fbcdn.net/hphotos-xpt1/v/t1.0-9/10933821_835357446525763_6960052107796132505_n.jpg?oh=49f72d34b40679285f6f9b7a5afd537d&oe=56FBDF4A')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (1039, 1006, N'https://z-1-scontent.xx.fbcdn.net/hphotos-xtp1/t31.0-8/12094810_679606832139198_1849627048383936906_o.jpg')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (1040, 1006, N'https://z-1-scontent.xx.fbcdn.net/hphotos-xtp1/t31.0-8/12113349_679603918806156_8445132776299644670_o.jpg')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (1041, 1006, N'https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-xta1/t31.0-8/12109778_679603915472823_5833387374005219963_o.jpg')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (1042, 1006, N'https://z-1-scontent.xx.fbcdn.net/hphotos-xat1/v/t1.0-9/11219344_1052523038091433_8621876432125004244_n.jpg?oh=19d65f8a120cab404aae8d6a0f26c0ff&oe=57421D89')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (1043, 1006, N'https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-xtf1/v/t1.0-9/10906496_835358249859016_7020446227627512264_n.jpg?oh=00dc3353b164c293c7798f12cde00405&oe=56FFD81E&__gda__=1459626565_a07fd5ffe5bb55be482760e11038a01a')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (1044, 1006, N'https://z-1-scontent.xx.fbcdn.net/hphotos-ash2/v/t1.0-9/10175042_835358183192356_7846307678831921277_n.jpg?oh=21400c15b748ca4bb983bd228d5fe946&oe=56FCAB5A')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (1045, 1006, N'https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-xap1/v/t1.0-9/1480523_835358119859029_9071514128538627202_n.jpg?oh=56887d127c35f6ecc5b71e55ccd37838&oe=57006EFD&__gda__=1459437748_02b819a385628ec9359fc002c8ef0aa3')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (1046, 1006, N'https://z-1-scontent.xx.fbcdn.net/hphotos-xlf1/v/t1.0-9/10403258_835357746525733_7489080481618196105_n.jpg?oh=bc579084e44e5a4aa6f6c18c1e8696a6&oe=57064521')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (1047, 1006, N'https://z-1-scontent.xx.fbcdn.net/hphotos-xpt1/v/t1.0-9/10933821_835357446525763_6960052107796132505_n.jpg?oh=49f72d34b40679285f6f9b7a5afd537d&oe=56FBDF4A')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (1048, 1007, N'https://z-1-scontent.xx.fbcdn.net/hphotos-xtp1/t31.0-8/12094810_679606832139198_1849627048383936906_o.jpg')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (1049, 1007, N'https://z-1-scontent.xx.fbcdn.net/hphotos-xtp1/t31.0-8/12113349_679603918806156_8445132776299644670_o.jpg')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (1050, 1007, N'https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-xta1/t31.0-8/12109778_679603915472823_5833387374005219963_o.jpg')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (1051, 1007, N'https://z-1-scontent.xx.fbcdn.net/hphotos-xat1/v/t1.0-9/11219344_1052523038091433_8621876432125004244_n.jpg?oh=19d65f8a120cab404aae8d6a0f26c0ff&oe=57421D89')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (1052, 1007, N'https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-xtf1/v/t1.0-9/10906496_835358249859016_7020446227627512264_n.jpg?oh=00dc3353b164c293c7798f12cde00405&oe=56FFD81E&__gda__=1459626565_a07fd5ffe5bb55be482760e11038a01a')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (1053, 1007, N'https://z-1-scontent.xx.fbcdn.net/hphotos-ash2/v/t1.0-9/10175042_835358183192356_7846307678831921277_n.jpg?oh=21400c15b748ca4bb983bd228d5fe946&oe=56FCAB5A')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (1054, 1007, N'https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-xap1/v/t1.0-9/1480523_835358119859029_9071514128538627202_n.jpg?oh=56887d127c35f6ecc5b71e55ccd37838&oe=57006EFD&__gda__=1459437748_02b819a385628ec9359fc002c8ef0aa3')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (1055, 1007, N'https://z-1-scontent.xx.fbcdn.net/hphotos-xlf1/v/t1.0-9/10403258_835357746525733_7489080481618196105_n.jpg?oh=bc579084e44e5a4aa6f6c18c1e8696a6&oe=57064521')
INSERT [dbo].[tbl_eventpictures] ([eventPictureId], [event_id], [picture_url]) VALUES (1056, 1007, N'https://z-1-scontent.xx.fbcdn.net/hphotos-xpt1/v/t1.0-9/10933821_835357446525763_6960052107796132505_n.jpg?oh=49f72d34b40679285f6f9b7a5afd537d&oe=56FBDF4A')
SET IDENTITY_INSERT [dbo].[tbl_eventpictures] OFF
SET IDENTITY_INSERT [dbo].[tbl_events] ON 

INSERT [dbo].[tbl_events] ([event_id], [event_title], [Message], [event_date], [is_displayed]) VALUES (4, N'Happy Birthday Moni', N'Demo text', CAST(0x0000A4890145A604 AS DateTime), 0)
INSERT [dbo].[tbl_events] ([event_id], [event_title], [Message], [event_date], [is_displayed]) VALUES (1003, N'Test event', N'Demo ', CAST(0x0000A48D00A896FC AS DateTime), 0)
INSERT [dbo].[tbl_events] ([event_id], [event_title], [Message], [event_date], [is_displayed]) VALUES (1004, N'Chetan', N'Happy Birthday', CAST(0x0000A58900DDC958 AS DateTime), 0)
INSERT [dbo].[tbl_events] ([event_id], [event_title], [Message], [event_date], [is_displayed]) VALUES (1005, N'Happy Birthday Chetan', N'Greeting text', CAST(0x0000A589011EFFE0 AS DateTime), 0)
INSERT [dbo].[tbl_events] ([event_id], [event_title], [Message], [event_date], [is_displayed]) VALUES (1006, N'Happy Birthday Chetan', N'Greeting text', CAST(0x0000A589011EF0A4 AS DateTime), 0)
INSERT [dbo].[tbl_events] ([event_id], [event_title], [Message], [event_date], [is_displayed]) VALUES (1007, N'Happy Birthday Chetan', N'Greeting text', CAST(0x0000A5890126E8E0 AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[tbl_events] OFF
SET IDENTITY_INSERT [dbo].[tbl_hoteldetails] ON 

INSERT [dbo].[tbl_hoteldetails] ([hotel_id], [hotel_name], [sub_title], [logo], [admin_emailid], [password], [hotel_address]) VALUES (5, N'Liberty', N'Demo Line', NULL, N'sushmit.patil@gmail.com', N'123456789', N'Hubli')
SET IDENTITY_INSERT [dbo].[tbl_hoteldetails] OFF
SET IDENTITY_INSERT [dbo].[tbl_items] ON 

INSERT [dbo].[tbl_items] ([item_id], [item_name], [category_id], [price], [item_image], [item_desc], [qty], [added_by], [is_active]) VALUES (1, N'Ghee Rice', 1, 75, N'e1dfb96c-922f-46e0-a4da-6586fdd86b55.jpg', N'dasd', 1, 2, 1)
INSERT [dbo].[tbl_items] ([item_id], [item_name], [category_id], [price], [item_image], [item_desc], [qty], [added_by], [is_active]) VALUES (2, N'Biryani', 1, 100, N'4f1f518f-47fa-44f8-aff5-7d306824bd43.jpg', N'dasd', 1, 2, 1)
INSERT [dbo].[tbl_items] ([item_id], [item_name], [category_id], [price], [item_image], [item_desc], [qty], [added_by], [is_active]) VALUES (3, N'Item1', 1, 100, N'ccb92b58-a123-4c4d-8b68-80ce4e7fb78f.png', N'test', 1, 2, 1)
SET IDENTITY_INSERT [dbo].[tbl_items] OFF
SET IDENTITY_INSERT [dbo].[tbl_order_details] ON 

INSERT [dbo].[tbl_order_details] ([order_detailid], [order_id], [item_id], [combo_id], [price], [qty]) VALUES (2002, 2002, NULL, 2, 450, 1)
INSERT [dbo].[tbl_order_details] ([order_detailid], [order_id], [item_id], [combo_id], [price], [qty]) VALUES (2003, 2002, 1, NULL, 75, 2)
INSERT [dbo].[tbl_order_details] ([order_detailid], [order_id], [item_id], [combo_id], [price], [qty]) VALUES (2004, 3003, NULL, 2, 450, 1)
INSERT [dbo].[tbl_order_details] ([order_detailid], [order_id], [item_id], [combo_id], [price], [qty]) VALUES (2005, 3003, NULL, 1002, 1000, 2)
INSERT [dbo].[tbl_order_details] ([order_detailid], [order_id], [item_id], [combo_id], [price], [qty]) VALUES (2006, 3008, NULL, 2, 450, 2)
SET IDENTITY_INSERT [dbo].[tbl_order_details] OFF
SET IDENTITY_INSERT [dbo].[tbl_orders] ON 

INSERT [dbo].[tbl_orders] ([order_id], [start_date], [isClosed], [tableNumber], [amount]) VALUES (2002, CAST(0x0000A47F01346219 AS DateTime), 1, 3, 600)
INSERT [dbo].[tbl_orders] ([order_id], [start_date], [isClosed], [tableNumber], [amount]) VALUES (3002, CAST(0x0000A49E00A44738 AS DateTime), 1, 3, 0)
INSERT [dbo].[tbl_orders] ([order_id], [start_date], [isClosed], [tableNumber], [amount]) VALUES (3003, CAST(0x0000A49E014E0422 AS DateTime), 1, 3, 2450)
INSERT [dbo].[tbl_orders] ([order_id], [start_date], [isClosed], [tableNumber], [amount]) VALUES (3004, CAST(0x0000A59900AE59B1 AS DateTime), 1, 1, 0)
INSERT [dbo].[tbl_orders] ([order_id], [start_date], [isClosed], [tableNumber], [amount]) VALUES (3005, CAST(0x0000A59900AEA54A AS DateTime), 1, 2, 0)
INSERT [dbo].[tbl_orders] ([order_id], [start_date], [isClosed], [tableNumber], [amount]) VALUES (3006, CAST(0x0000A59900AF202E AS DateTime), 1, 2, 0)
INSERT [dbo].[tbl_orders] ([order_id], [start_date], [isClosed], [tableNumber], [amount]) VALUES (3007, CAST(0x0000A59900BB12F3 AS DateTime), 1, 1, 0)
INSERT [dbo].[tbl_orders] ([order_id], [start_date], [isClosed], [tableNumber], [amount]) VALUES (3008, CAST(0x0000A59900BE598D AS DateTime), 1, 1, 900)
SET IDENTITY_INSERT [dbo].[tbl_orders] OFF
INSERT [dbo].[tbl_player] ([song_id], [order_number], [is_played], [is_requested], [requested_time], [is_playing]) VALUES (8, 1, 1, 0, CAST(0x0000A59900C670AC AS DateTime), 1)
INSERT [dbo].[tbl_player] ([song_id], [order_number], [is_played], [is_requested], [requested_time], [is_playing]) VALUES (1, 2, 1, 0, CAST(0x0000A59900C670AC AS DateTime), 1)
INSERT [dbo].[tbl_player] ([song_id], [order_number], [is_played], [is_requested], [requested_time], [is_playing]) VALUES (2, 3, 1, 0, CAST(0x0000A59900C670AC AS DateTime), 1)
INSERT [dbo].[tbl_player] ([song_id], [order_number], [is_played], [is_requested], [requested_time], [is_playing]) VALUES (5, 4, 1, 0, CAST(0x0000A59900C670AC AS DateTime), 1)
INSERT [dbo].[tbl_player] ([song_id], [order_number], [is_played], [is_requested], [requested_time], [is_playing]) VALUES (7, 5, 1, 0, CAST(0x0000A59900C670AC AS DateTime), 1)
INSERT [dbo].[tbl_player] ([song_id], [order_number], [is_played], [is_requested], [requested_time], [is_playing]) VALUES (3, 6, 0, 0, CAST(0x0000A59900C670AC AS DateTime), 1)
INSERT [dbo].[tbl_player] ([song_id], [order_number], [is_played], [is_requested], [requested_time], [is_playing]) VALUES (6, 7, 0, 0, CAST(0x0000A59900C670AC AS DateTime), 0)
INSERT [dbo].[tbl_player] ([song_id], [order_number], [is_played], [is_requested], [requested_time], [is_playing]) VALUES (4, 8, 0, 0, CAST(0x0000A59900C670AC AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[tbl_songs] ON 

INSERT [dbo].[tbl_songs] ([song_id], [song_name], [song_url]) VALUES (1, N'O Re Piya', N'a4423574-7065-4e25-9095-74510e377704.mp3')
INSERT [dbo].[tbl_songs] ([song_id], [song_name], [song_url]) VALUES (2, N'Lemongrass - Shankar Tucker', N'5a69ac62-e3a1-4b78-89f6-08b255207b1d.mp3')
INSERT [dbo].[tbl_songs] ([song_id], [song_name], [song_url]) VALUES (3, N'Ja Ja re', N'ed5078d9-a438-42df-a5ae-03f86fb2a828.mp3')
INSERT [dbo].[tbl_songs] ([song_id], [song_name], [song_url]) VALUES (4, N'Jane kaise', N'69d0c8c5-d133-4c33-8ea2-02aebb9340e3.mp3')
INSERT [dbo].[tbl_songs] ([song_id], [song_name], [song_url]) VALUES (5, N'Manmohini', N'f1bb9455-5504-4fbd-8f88-e02b8277709a.mp3')
INSERT [dbo].[tbl_songs] ([song_id], [song_name], [song_url]) VALUES (6, N'Meri saajan sun sun', N'ba1ea1fe-7cbf-43eb-93d1-649a4400151d.mp3')
INSERT [dbo].[tbl_songs] ([song_id], [song_name], [song_url]) VALUES (7, N'Mun be va', N'd861f0fc-d37c-43bd-84e0-6e2e92276f5a.mp3')
INSERT [dbo].[tbl_songs] ([song_id], [song_name], [song_url]) VALUES (8, N'Night Monsoon', N'335128ca-9eb3-40af-b491-6d8f0c22fdd9.mp3')
SET IDENTITY_INSERT [dbo].[tbl_songs] OFF
SET IDENTITY_INSERT [dbo].[tbl_themes] ON 

INSERT [dbo].[tbl_themes] ([theme_id], [theme_name], [image_url], [is_active]) VALUES (1, N'Sushmit', N'3329e406-d594-4ca0-8b1c-3485fa7586b0.jpg', 0)
INSERT [dbo].[tbl_themes] ([theme_id], [theme_name], [image_url], [is_active]) VALUES (2, N'New Year', N'e046e986-1107-434e-aec5-1f0075fc6698.jpg', 1)
SET IDENTITY_INSERT [dbo].[tbl_themes] OFF
ALTER TABLE [dbo].[tbl_admin] ADD  CONSTRAINT [DF_tbl_admin_is_superadmin]  DEFAULT ((1)) FOR [is_superadmin]
GO
ALTER TABLE [dbo].[tbl_admin] ADD  CONSTRAINT [DF_tbl_admin_offers_combos]  DEFAULT ((1)) FOR [offers_combos]
GO
ALTER TABLE [dbo].[tbl_admin] ADD  CONSTRAINT [DF_tbl_admin_inform_before_activate]  DEFAULT ((1)) FOR [inform_before_activate]
GO
ALTER TABLE [dbo].[tbl_admin] ADD  CONSTRAINT [DF_tbl_admin_item_details]  DEFAULT ((1)) FOR [item_details]
GO
ALTER TABLE [dbo].[tbl_admin] ADD  CONSTRAINT [DF_tbl_admin_created_date]  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[tbl_events] ADD  CONSTRAINT [DF_tbl_events_event_date]  DEFAULT (getdate()) FOR [event_date]
GO
ALTER TABLE [dbo].[tbl_events] ADD  CONSTRAINT [DF_tbl_events_is_displayed]  DEFAULT ((0)) FOR [is_displayed]
GO
ALTER TABLE [dbo].[tbl_orders] ADD  CONSTRAINT [DF_tbl_orders_start_date]  DEFAULT (getdate()) FOR [start_date]
GO
ALTER TABLE [dbo].[tbl_orders] ADD  CONSTRAINT [DF_tbl_orders_isClosed]  DEFAULT ((0)) FOR [isClosed]
GO
ALTER TABLE [dbo].[tbl_orders] ADD  CONSTRAINT [DF_tbl_orders_amount]  DEFAULT ((0)) FOR [amount]
GO
ALTER TABLE [dbo].[tbl_player] ADD  CONSTRAINT [DF_tbl_player_is_played]  DEFAULT ((0)) FOR [is_played]
GO
ALTER TABLE [dbo].[tbl_player] ADD  CONSTRAINT [DF_tbl_player_is_requested]  DEFAULT ((0)) FOR [is_requested]
GO
ALTER TABLE [dbo].[tbl_player] ADD  CONSTRAINT [DF_tbl_player_requested_time]  DEFAULT (getdate()) FOR [requested_time]
GO
ALTER TABLE [dbo].[tbl_player] ADD  CONSTRAINT [DF_tbl_player_is_playing]  DEFAULT ((0)) FOR [is_playing]
GO
ALTER TABLE [dbo].[tbl_themes] ADD  CONSTRAINT [DF_tbl_themes_is_active]  DEFAULT ((0)) FOR [is_active]
GO
ALTER TABLE [dbo].[tbl_eventpictures]  WITH CHECK ADD  CONSTRAINT [FK_tbl_eventpictures_tbl_events] FOREIGN KEY([event_id])
REFERENCES [dbo].[tbl_events] ([event_id])
GO
ALTER TABLE [dbo].[tbl_eventpictures] CHECK CONSTRAINT [FK_tbl_eventpictures_tbl_events]
GO
USE [master]
GO
ALTER DATABASE [order_tracking_latest] SET  READ_WRITE 
GO
