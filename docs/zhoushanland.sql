USE [GTZY_TJFX]
GO
/****** Object:  Table [dbo].[area]    Script Date: 2020/5/21 19:57:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[area](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[ParentID] [int] NOT NULL,
 CONSTRAINT [PK_Area] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dossier]    Script Date: 2020/5/21 19:57:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dossier](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Year] [int] NOT NULL,
	[Quarter] [int] NOT NULL,
	[Remark] [varchar](1023) NULL,
	[UploadTime] [datetime] NOT NULL,
 CONSTRAINT [PK_dossier] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dossierfile]    Script Date: 2020/5/21 19:57:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dossierfile](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FileName] [varchar](255) NOT NULL,
	[FilePath] [varchar](1023) NOT NULL,
	[DossierID] [int] NOT NULL,
 CONSTRAINT [PK_dossierfile] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[form]    Script Date: 2020/5/21 19:57:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[form](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](255) NOT NULL,
	[ImportTemplate] [varchar](512) NULL,
	[ExportTemplate] [varchar](512) NULL,
	[ExcludeSubArea] [bit] NOT NULL,
	[Disabled] [bit] NOT NULL,
 CONSTRAINT [PK_form] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[node]    Script Date: 2020/5/21 19:57:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[node](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FormID] [int] NOT NULL,
	[ParentID] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Group] [varchar](50) NULL,
	[ValueTypes] [varchar](50) NOT NULL,
 CONSTRAINT [PK_node] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[node_value]    Script Date: 2020/5/21 19:57:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[node_value](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NodeID] [int] NOT NULL,
	[Value] [float] NOT NULL,
	[Raw_Value] [float] NOT NULL,
	[Quarter] [int] NOT NULL,
	[AreaID] [int] NOT NULL,
	[TypeID] [int] NOT NULL,
	[Year] [int] NOT NULL,
	[UpdateTime] [datetime] NOT NULL,
	[Period] [int] NOT NULL,
 CONSTRAINT [PK_node_value] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[season]    Script Date: 2020/5/21 19:57:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[season](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Quarter] [int] NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[Year] [int] NOT NULL,
	[EndTime] [datetime] NOT NULL,
	[SetTime] [datetime] NOT NULL,
	[Delete] [bit] NOT NULL,
 CONSTRAINT [PK_season] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[trend_template]    Script Date: 2020/5/21 19:57:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[trend_template](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[FilePath] [varchar](50) NOT NULL,
	[FormID] [int] NOT NULL,
 CONSTRAINT [PK_trend_template] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user]    Script Date: 2020/5/21 19:57:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[Role] [int] NOT NULL,
	[Name] [varchar](50) NULL,
	[Deleted] [bit] NOT NULL,
	[LastLoginTime] [datetime] NULL,
	[AreaIds] [varchar](50) NULL,
	[FormIds] [varchar](50) NULL,
 CONSTRAINT [PK_user] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[value_type]    Script Date: 2020/5/21 19:57:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[value_type](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Units] [varchar](255) NOT NULL,
	[Ratio] [int] NOT NULL,
 CONSTRAINT [PK_value_type] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[area] ON 
GO
INSERT [dbo].[area] ([ID], [Name], [ParentID]) VALUES (1, N'市本级', 0)
GO
INSERT [dbo].[area] ([ID], [Name], [ParentID]) VALUES (2, N'新城', 1)
GO
INSERT [dbo].[area] ([ID], [Name], [ParentID]) VALUES (3, N'定海区', 0)
GO
INSERT [dbo].[area] ([ID], [Name], [ParentID]) VALUES (4, N'岱山县', 0)
GO
INSERT [dbo].[area] ([ID], [Name], [ParentID]) VALUES (5, N'普陀区', 0)
GO
INSERT [dbo].[area] ([ID], [Name], [ParentID]) VALUES (6, N'嵊泗县', 0)
GO
INSERT [dbo].[area] ([ID], [Name], [ParentID]) VALUES (9, N'产业集聚区', 1)
GO
INSERT [dbo].[area] ([ID], [Name], [ParentID]) VALUES (10, N'金塘', 3)
GO
INSERT [dbo].[area] ([ID], [Name], [ParentID]) VALUES (11, N'六横', 5)
GO
INSERT [dbo].[area] ([ID], [Name], [ParentID]) VALUES (13, N'普陀山', 0)
GO
SET IDENTITY_INSERT [dbo].[area] OFF
GO
SET IDENTITY_INSERT [dbo].[dossier] ON 
GO
INSERT [dbo].[dossier] ([ID], [Year], [Quarter], [Remark], [UploadTime]) VALUES (2, 2016, 2, N'uploads/QL_20160725_0007.pdf', CAST(N'2016-07-27T11:22:58.000' AS DateTime))
GO
INSERT [dbo].[dossier] ([ID], [Year], [Quarter], [Remark], [UploadTime]) VALUES (3, 2016, 3, N'uploads/QL_20160725_0007.pdf', CAST(N'2016-07-27T11:27:07.000' AS DateTime))
GO
INSERT [dbo].[dossier] ([ID], [Year], [Quarter], [Remark], [UploadTime]) VALUES (4, 2015, 1, N'第一季度', CAST(N'2016-08-01T16:34:10.000' AS DateTime))
GO
INSERT [dbo].[dossier] ([ID], [Year], [Quarter], [Remark], [UploadTime]) VALUES (5, 2014, 1, N'年度统计册子', CAST(N'2016-08-01T16:33:33.000' AS DateTime))
GO
INSERT [dbo].[dossier] ([ID], [Year], [Quarter], [Remark], [UploadTime]) VALUES (6, 2015, 2, N'uploads/QL_20160725_0008636052294359612835.pdf', CAST(N'2016-07-27T15:17:17.000' AS DateTime))
GO
INSERT [dbo].[dossier] ([ID], [Year], [Quarter], [Remark], [UploadTime]) VALUES (7, 2016, 4, N'uploads/SKM_C364e16072710310_0001636052294514076858.pdf', CAST(N'2016-07-27T15:17:37.000' AS DateTime))
GO
INSERT [dbo].[dossier] ([ID], [Year], [Quarter], [Remark], [UploadTime]) VALUES (8, 2013, 1, NULL, CAST(N'2016-07-29T10:22:53.000' AS DateTime))
GO
INSERT [dbo].[dossier] ([ID], [Year], [Quarter], [Remark], [UploadTime]) VALUES (9, 2013, 2, N'123342', CAST(N'2016-07-29T10:44:02.000' AS DateTime))
GO
INSERT [dbo].[dossier] ([ID], [Year], [Quarter], [Remark], [UploadTime]) VALUES (10, 2012, 2, N'第二季度', CAST(N'2016-07-29T13:38:47.000' AS DateTime))
GO
INSERT [dbo].[dossier] ([ID], [Year], [Quarter], [Remark], [UploadTime]) VALUES (11, 2016, 1, NULL, CAST(N'2016-09-13T15:50:31.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[dossier] OFF
GO
SET IDENTITY_INSERT [dbo].[dossierfile] ON 
GO
INSERT [dbo].[dossierfile] ([ID], [FileName], [FilePath], [DossierID]) VALUES (1, N'QL_20160725_0007.pdf', N'uploads/QL_20160725_0007636053858312597793.pdf', 9)
GO
INSERT [dbo].[dossierfile] ([ID], [FileName], [FilePath], [DossierID]) VALUES (2, N'QL_20160725_0008.pdf', N'uploads/QL_20160725_0008636053858344267208.pdf', 9)
GO
INSERT [dbo].[dossierfile] ([ID], [FileName], [FilePath], [DossierID]) VALUES (3, N'SKM_C364e16072710310_0001.pdf', N'uploads/SKM_C364e16072710310_0001636053858373893285.pdf', 9)
GO
INSERT [dbo].[dossierfile] ([ID], [FileName], [FilePath], [DossierID]) VALUES (4, N'SKM_C364e16072710310_0003.pdf', N'uploads/SKM_C364e16072710310_0003636053858404059122.pdf', 9)
GO
INSERT [dbo].[dossierfile] ([ID], [FileName], [FilePath], [DossierID]) VALUES (6, N'SKM_C364e16072710310_0004.pdf', N'uploads/SKM_C364e16072710310_0004636053963259065437.pdf', 10)
GO
INSERT [dbo].[dossierfile] ([ID], [FileName], [FilePath], [DossierID]) VALUES (7, N'2014年度数据册子.doc', N'uploads/2014年度数据册子636056660126596791.doc', 5)
GO
INSERT [dbo].[dossierfile] ([ID], [FileName], [FilePath], [DossierID]) VALUES (8, N'2015年第一季度数据册子.doc', N'uploads/2015年第一季度数据册子636056660493232278.doc', 4)
GO
INSERT [dbo].[dossierfile] ([ID], [FileName], [FilePath], [DossierID]) VALUES (9, N'QL_20160725_0007.pdf', N'uploads/QL_20160725_0007636053962884252665.pdf', 1)
GO
INSERT [dbo].[dossierfile] ([ID], [FileName], [FilePath], [DossierID]) VALUES (11, N'2016年第一季度册子.pdf', N'uploads/2016年第一季度册子636093785716227670.pdf', 11)
GO
INSERT [dbo].[dossierfile] ([ID], [FileName], [FilePath], [DossierID]) VALUES (12, N'2016年上半年国土资源形式分析定稿.pdf', N'uploads/2016年上半年国土资源形式分析定稿636093786300915170.pdf', 11)
GO
SET IDENTITY_INSERT [dbo].[dossierfile] OFF
GO
SET IDENTITY_INSERT [dbo].[form] ON 
GO
INSERT [dbo].[form] ([ID], [Name], [ImportTemplate], [ExportTemplate], [ExcludeSubArea], [Disabled]) VALUES (1, N'建设用地审批', NULL, NULL, 1, 0)
GO
INSERT [dbo].[form] ([ID], [Name], [ImportTemplate], [ExportTemplate], [ExcludeSubArea], [Disabled]) VALUES (2, N'建设用地供应', NULL, NULL, 1, 0)
GO
INSERT [dbo].[form] ([ID], [Name], [ImportTemplate], [ExportTemplate], [ExcludeSubArea], [Disabled]) VALUES (3, N'土地储备', NULL, NULL, 0, 0)
GO
INSERT [dbo].[form] ([ID], [Name], [ImportTemplate], [ExportTemplate], [ExcludeSubArea], [Disabled]) VALUES (4, N'土地征收', NULL, NULL, 0, 0)
GO
INSERT [dbo].[form] ([ID], [Name], [ImportTemplate], [ExportTemplate], [ExcludeSubArea], [Disabled]) VALUES (6, N'矿业权市场', NULL, NULL, 0, 0)
GO
INSERT [dbo].[form] ([ID], [Name], [ImportTemplate], [ExportTemplate], [ExcludeSubArea], [Disabled]) VALUES (7, N'信访', NULL, NULL, 0, 0)
GO
INSERT [dbo].[form] ([ID], [Name], [ImportTemplate], [ExportTemplate], [ExcludeSubArea], [Disabled]) VALUES (8, N'建设用地预审', NULL, NULL, 1, 0)
GO
INSERT [dbo].[form] ([ID], [Name], [ImportTemplate], [ExportTemplate], [ExcludeSubArea], [Disabled]) VALUES (9, N'国土资源违法案件', NULL, NULL, 1, 0)
GO
INSERT [dbo].[form] ([ID], [Name], [ImportTemplate], [ExportTemplate], [ExcludeSubArea], [Disabled]) VALUES (10, N'不动产登记', NULL, NULL, 0, 0)
GO
INSERT [dbo].[form] ([ID], [Name], [ImportTemplate], [ExportTemplate], [ExcludeSubArea], [Disabled]) VALUES (12, N'不动产抵押登记', NULL, NULL, 0, 0)
GO
INSERT [dbo].[form] ([ID], [Name], [ImportTemplate], [ExportTemplate], [ExcludeSubArea], [Disabled]) VALUES (13, N'海域使用权审批', NULL, NULL, 0, 0)
GO
INSERT [dbo].[form] ([ID], [Name], [ImportTemplate], [ExportTemplate], [ExcludeSubArea], [Disabled]) VALUES (14, N'林业', NULL, NULL, 0, 0)
GO
INSERT [dbo].[form] ([ID], [Name], [ImportTemplate], [ExportTemplate], [ExcludeSubArea], [Disabled]) VALUES (15, N'规划审批', NULL, NULL, 0, 0)
GO
INSERT [dbo].[form] ([ID], [Name], [ImportTemplate], [ExportTemplate], [ExcludeSubArea], [Disabled]) VALUES (16, N'测绘审批', NULL, NULL, 0, 0)
GO
SET IDENTITY_INSERT [dbo].[form] OFF
GO
SET IDENTITY_INSERT [dbo].[node] ON 
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (1, 1, 0, N'批准建设用地面积', NULL, N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (3, 1, 1, N'新增建设用地', NULL, N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (4, 1, 3, N'农用地', NULL, N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (5, 1, 4, N'耕地', NULL, N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (6, 1, 3, N'未利用地', NULL, N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (7, 1, 1, N'城市分批次建设用地', N'类型', N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (8, 1, 1, N'单独选址建设用地', N'类型', N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (9, 1, 8, N'能源用地', NULL, N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (10, 1, 8, N'交通用地', NULL, N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (11, 1, 8, N'水利用地', NULL, N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (12, 1, 8, N'其他用地', NULL, N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (13, 2, 0, N'建设用地供应总量', NULL, N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (14, 2, 13, N'新增建设用地', N'新增建设用地', N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (15, 2, 13, N'房地产用地', N'用地类型', N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (16, 2, 13, N'工业仓储用地', N'用地类型', N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (17, 2, 15, N'商服用地', NULL, N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (18, 2, 15, N'普通商品房用地', NULL, N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (19, 3, 0, N'新增土地储备宗数', NULL, N'4')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (20, 3, 0, N'新增土地储备面积', NULL, N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (21, 3, 20, N'回收土地', NULL, N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (24, 3, 0, N'期内支出', NULL, N'5')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (25, 3, 24, N'补偿款', NULL, N'5')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (37, 4, 0, N'土地征收', NULL, N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (38, 4, 0, N'征收费用', NULL, N'5')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (43, 4, 0, N'安置农业人口', NULL, N'6')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (68, 4, 37, N'农用地', NULL, N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (72, 6, 0, N'采矿权许可证数', NULL, N'6')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (73, 6, 72, N'新立', NULL, N'6')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (74, 6, 72, N'撤销', NULL, N'6')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (75, 6, 0, N'采矿权出让', NULL, N'6')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (76, 6, 75, N'采矿权出让个数', NULL, N'6')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (77, 6, 75, N'缴纳采矿权出让价款', NULL, N'5')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (87, 2, 13, N'其他用地', N'用地类型', N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (88, 2, 13, N'划拨面积', N'供地方式', N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (89, 2, 13, N'出让面积', N'供地方式', N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (90, 2, 89, N'招拍挂出让面积', NULL, N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (91, 2, 0, N'出让金', NULL, N'5')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (92, 3, 20, N'收购土地', NULL, N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (93, 3, 20, N'其他', NULL, N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (94, 3, 24, N'开发费', NULL, N'5')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (95, 3, 0, N'结算土地收储成本', NULL, N'5')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (96, 3, 0, N'报告期末土地储备面积', NULL, N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (105, 8, 0, N'预审件数', NULL, N'3')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (106, 8, 0, N'预审面积', NULL, N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (107, 8, 106, N'耕地', NULL, N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (108, 8, 106, N'能源用地', NULL, N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (109, 8, 106, N'交通用地', NULL, N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (110, 8, 106, N'水利用地', NULL, N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (111, 8, 106, N'其他用地', NULL, N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (112, 9, 0, N'土地违法案件', N'土地违法案件', N'3')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (113, 9, 112, N'涉及土地面积', NULL, N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (114, 9, 113, N'耕地', NULL, N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (115, 9, 0, N'土地违法结案', N'土地违法案件', N'3')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (116, 9, 115, N'收回土地面积', NULL, N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (117, 9, 116, N'耕地', NULL, N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (118, 9, 115, N'拆除建筑面积', NULL, N'8')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (119, 9, 115, N'没收建筑面积', NULL, N'8')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (120, 9, 115, N'罚没款', NULL, N'5')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (121, 9, 0, N'矿产违法案件', N'土地违法案件', N'3')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (122, 9, 121, N'立案', NULL, N'3')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (123, 9, 121, N'结案', NULL, N'3')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (124, 9, 121, N'罚没款', NULL, N'5')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (131, 6, 0, N'采矿权出让', NULL, N'6')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (132, 6, 131, N'采矿权出让个数', NULL, N'6')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (133, 6, 131, N'采矿权出让价款', NULL, N'5')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (137, 6, 0, N'矿产三费收费情况', NULL, N'5')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (138, 6, 137, N'出让金', NULL, N'5')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (139, 6, 137, N'治理备用金', NULL, N'5')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (140, 6, 137, N'资源补偿费', NULL, N'5')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (141, 7, 0, N'本期来信', NULL, N'3')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (142, 7, 0, N'本期来访', NULL, N'7,9')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (145, 3, 0, N'期内新增面积', NULL, N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (146, 3, 0, N'期末面积', NULL, N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (147, 4, 68, N'耕地', NULL, N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (151, 4, 37, N'建设用地', NULL, N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (152, 4, 37, N'其他用地', NULL, N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (154, 4, 68, N'其他农用地', NULL, N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (155, 10, 0, N'国有建设用地使用权', NULL, N'4')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (156, 10, 0, N'国有建设用地使用权及房屋所有权', NULL, N'4')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (157, 10, 0, N'集体建设用地使用权及房屋所有权', NULL, N'4')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (158, 10, 0, N'宅基地使用权及房屋所有权', NULL, N'4')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (159, 12, 0, N'不动产抵押登记宗数', NULL, N'4')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (160, 12, 159, N'纯土地抵押宗数', NULL, N'4')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (161, 12, 0, N'不动产抵押建筑面积', NULL, N'8')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (162, 12, 0, N'不动产抵押土地面积', NULL, N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (163, 12, 162, N'纯土地抵押面积', NULL, N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (164, 12, 0, N'不动产抵押贷款金额', NULL, N'5')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (165, 12, 164, N'纯土地抵押贷款金额', NULL, N'5')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (166, 13, 0, N'宗海数', NULL, N'4')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (167, 13, 0, N'宗海面积', NULL, N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (168, 13, 167, N'出让宗数', NULL, N'4')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (169, 13, 167, N'出让面积', NULL, N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (170, 13, 167, N'出让金额', NULL, N'5')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (171, 14, 0, N'森林面积', NULL, N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (172, 14, 171, N'公益林', NULL, N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (174, 14, 0, N'森林蓄积', NULL, N'10')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (175, 14, 0, N'造林面积', NULL, N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (176, 14, 0, N'森林覆盖率', NULL, N'11')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (177, 14, 0, N'湿地面积', NULL, N'1')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (178, 14, 0, N'占用林地', NULL, N'4,8')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (179, 14, 0, N'林业产值', NULL, N'5')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (180, 15, 0, N'选址意见书', NULL, N'3')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (181, 15, 0, N'建设用地规划许可证', NULL, N'3')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (182, 15, 0, N'建设工程规划许可证', NULL, N'3')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (183, 15, 0, N'建设工程规划核实确认书', NULL, N'3')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (184, 16, 0, N'地图审批', NULL, N'3')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (185, 16, 0, N'测绘作业证核发', NULL, N'3')
GO
INSERT [dbo].[node] ([ID], [FormID], [ParentID], [Name], [Group], [ValueTypes]) VALUES (186, 16, 0, N'资质认定', NULL, N'3')
GO
SET IDENTITY_INSERT [dbo].[node] OFF
GO
SET IDENTITY_INSERT [dbo].[node_value] ON 
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (1, 1, 10130.15, 10130.15, 4, 0, 1, 2014, CAST(N'2016-08-26T15:18:23.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (2, 3, 7473.75, 7473.75, 4, 0, 1, 2014, CAST(N'2016-08-26T15:18:23.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (3, 4, 7151.6, 7151.6, 4, 0, 1, 2014, CAST(N'2016-08-26T15:18:23.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (4, 5, 4748.05, 4748.05, 4, 0, 1, 2014, CAST(N'2016-08-26T15:18:23.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (5, 6, 206.2, 206.2, 4, 0, 1, 2014, CAST(N'2016-08-26T15:18:24.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (6, 7, 5334.15, 5334.15, 4, 0, 1, 2014, CAST(N'2016-08-26T15:18:24.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (7, 8, 4796, 4796, 4, 0, 1, 2014, CAST(N'2016-08-26T15:18:24.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (8, 9, 0, 0, 4, 0, 1, 2014, CAST(N'2016-08-26T15:18:24.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (9, 10, 4290.1, 4290.1, 4, 0, 1, 2014, CAST(N'2016-08-26T15:18:24.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (10, 11, 0, 0, 4, 0, 1, 2014, CAST(N'2016-08-26T15:18:24.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (11, 12, 505.9, 505.9, 4, 0, 1, 2014, CAST(N'2016-08-26T15:18:24.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (12, 105, 62, 62, 4, 0, 3, 2014, CAST(N'2016-08-26T15:18:43.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (13, 106, 3818.81, 3818.81, 4, 0, 1, 2014, CAST(N'2016-08-26T15:18:43.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (14, 107, 756.47, 756.47, 4, 0, 1, 2014, CAST(N'2016-08-26T15:18:43.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (15, 108, 207, 207, 4, 0, 1, 2014, CAST(N'2016-08-26T15:18:43.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (16, 109, 1447.66, 1447.66, 4, 0, 1, 2014, CAST(N'2016-08-26T15:18:43.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (17, 110, 0, 0, 4, 0, 1, 2014, CAST(N'2016-08-26T15:18:43.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (18, 111, -1156.3, -1156.3, 4, 0, 1, 2014, CAST(N'2016-08-26T15:18:43.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (19, 112, 28, 28, 4, 0, 3, 2014, CAST(N'2016-08-26T15:18:51.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (20, 113, 375.83, 375.83, 4, 0, 1, 2014, CAST(N'2016-08-26T15:18:51.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (21, 114, 50.1, 50.1, 4, 0, 1, 2014, CAST(N'2016-08-26T15:18:51.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (22, 115, 77, 77, 4, 0, 3, 2014, CAST(N'2016-08-26T15:18:51.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (23, 116, 375.9, 375.9, 4, 0, 1, 2014, CAST(N'2016-08-26T15:18:51.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (24, 117, 50.1, 50.1, 4, 0, 1, 2014, CAST(N'2016-08-26T15:18:51.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (25, 118, 1771, 1771, 4, 0, 8, 2014, CAST(N'2016-08-26T15:18:51.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (26, 119, 154470, 154470, 4, 0, 8, 2014, CAST(N'2016-08-26T15:18:51.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (27, 120, 407.67, 407.67, 4, 0, 5, 2014, CAST(N'2016-08-26T15:18:51.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (28, 121, 1, 1, 4, 0, 3, 2014, CAST(N'2016-08-26T15:18:51.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (29, 122, 1, 1, 4, 0, 3, 2014, CAST(N'2016-08-26T15:18:51.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (30, 123, 2, 2, 4, 0, 3, 2014, CAST(N'2016-08-26T15:18:51.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (31, 124, 0.05, 0.05, 4, 0, 5, 2014, CAST(N'2016-08-26T15:18:51.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (32, 13, 4899.58, 4899.58, 4, 0, 1, 2014, CAST(N'2016-08-26T15:18:59.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (33, 14, 3069.75, 3069.75, 4, 0, 1, 2014, CAST(N'2016-08-26T15:18:59.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (34, 15, 602.78, 602.78, 4, 0, 1, 2014, CAST(N'2016-08-26T15:18:59.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (35, 17, 456.6, 456.6, 4, 0, 1, 2014, CAST(N'2016-08-26T15:18:59.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (36, 184, 146.17, 146.17, 4, 0, 1, 2014, CAST(N'2016-08-26T15:18:59.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (37, 16, 441.1, 441.1, 4, 0, 1, 2014, CAST(N'2016-08-26T15:18:59.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (38, 87, 3586.35, 3586.35, 4, 0, 1, 2014, CAST(N'2016-08-26T15:18:59.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (39, 88, 2647.72, 2647.72, 4, 0, 1, 2014, CAST(N'2016-08-26T15:18:59.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (40, 89, 2251.86, 2251.86, 4, 0, 1, 2014, CAST(N'2016-08-26T15:18:59.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (41, 90, 1069.41, 1069.41, 4, 0, 1, 2014, CAST(N'2016-08-26T15:18:59.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (42, 91, 160724, 160724, 4, 0, 5, 2014, CAST(N'2016-08-26T15:18:59.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (43, 72, 1, 1, 4, 0, 6, 2014, CAST(N'2016-08-26T15:19:07.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (44, 73, 3, 3, 4, 0, 6, 2014, CAST(N'2016-08-26T15:19:07.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (45, 74, 0, 0, 4, 0, 6, 2014, CAST(N'2016-08-26T15:19:08.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (46, 75, 0, 0, 4, 0, 6, 2014, CAST(N'2016-08-26T15:19:08.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (47, 76, 10, 10, 4, 0, 6, 2014, CAST(N'2016-08-26T15:19:08.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (48, 77, 38270.899999999994, 38270.899999999994, 4, 0, 5, 2014, CAST(N'2016-08-26T15:19:08.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (49, 131, 0, 0, 4, 0, 6, 2014, CAST(N'2016-08-26T15:19:08.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (50, 132, 0, 0, 4, 0, 6, 2014, CAST(N'2016-08-26T15:19:08.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (51, 133, 0, 0, 4, 0, 5, 2014, CAST(N'2016-08-26T15:19:08.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (52, 19, 47, 47, 4, 0, 3, 2014, CAST(N'2016-08-26T15:19:16.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (53, 20, 3692.92, 3692.92, 4, 0, 1, 2014, CAST(N'2016-08-26T15:19:16.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (54, 21, 2068.79, 2068.79, 4, 0, 1, 2014, CAST(N'2016-08-26T15:19:16.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (55, 92, 888.42, 888.42, 4, 0, 1, 2014, CAST(N'2016-08-26T15:19:16.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (56, 93, 1095.71, 1095.71, 4, 0, 1, 2014, CAST(N'2016-08-26T15:19:16.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (57, 24, 455494, 455494, 4, 0, 4, 2014, CAST(N'2016-08-26T15:19:16.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (58, 25, 378122.3, 378122.3, 4, 0, 4, 2014, CAST(N'2016-08-26T15:19:16.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (59, 94, 347, 347, 4, 0, 4, 2014, CAST(N'2016-08-26T15:19:16.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (60, 95, 40484.79, 40484.79, 4, 0, 4, 2014, CAST(N'2016-08-26T15:19:16.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (61, 96, 287.629999999999, 287.629999999999, 4, 0, 1, 2014, CAST(N'2016-08-26T15:19:16.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (62, 48, 19, 19, 4, 0, 4, 2014, CAST(N'2016-08-26T15:19:23.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (63, 48, -8244.83, -8244.83, 4, 0, 1, 2014, CAST(N'2016-08-26T15:19:23.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (64, 48, -1616200, -1616200, 4, 0, 5, 2014, CAST(N'2016-08-26T15:19:23.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (65, 49, 114, 114, 4, 0, 4, 2014, CAST(N'2016-08-26T15:19:23.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (66, 49, 4862.37, 4862.37, 4, 0, 1, 2014, CAST(N'2016-08-26T15:19:23.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (67, 49, 1263300, 1263300, 4, 0, 5, 2014, CAST(N'2016-08-26T15:19:23.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (68, 50, 95, 95, 4, 0, 4, 2014, CAST(N'2016-08-26T15:19:23.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (69, 50, 5560.68, 5560.68, 4, 0, 1, 2014, CAST(N'2016-08-26T15:19:23.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (70, 50, 584600, 584600, 4, 0, 5, 2014, CAST(N'2016-08-26T15:19:23.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (71, 58, 4954, 4954, 4, 0, 3, 2014, CAST(N'2016-08-26T15:19:23.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (72, 59, 0, 0, 4, 0, 3, 2014, CAST(N'2016-08-26T15:19:23.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (73, 103, 16, 16, 4, 0, 3, 2014, CAST(N'2016-08-26T15:19:23.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (74, 104, 1480, 1480, 4, 0, 3, 2014, CAST(N'2016-08-26T15:19:23.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (75, 141, 11, 11, 4, 0, 3, 2014, CAST(N'2016-08-26T15:19:36.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (76, 142, 7, 7, 4, 0, 9, 2014, CAST(N'2016-08-26T15:19:36.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (77, 142, 5, 5, 4, 0, 7, 2014, CAST(N'2016-08-26T15:19:36.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (157, 112, 7, 7, 3, 0, 3, 2015, CAST(N'2016-08-26T21:39:13.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (158, 113, 14.76, 14.76, 3, 0, 1, 2015, CAST(N'2016-08-26T21:39:13.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (159, 114, 13.13, 13.13, 3, 0, 1, 2015, CAST(N'2016-08-26T21:39:13.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (160, 115, 0, 0, 3, 0, 3, 2015, CAST(N'2016-08-26T21:39:13.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (161, 116, 32.91, 32.91, 3, 0, 1, 2015, CAST(N'2016-08-26T21:39:13.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (162, 117, 13.14, 13.14, 3, 0, 1, 2015, CAST(N'2016-08-26T21:39:13.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (163, 118, -18922.01, -18922.01, 3, 0, 8, 2015, CAST(N'2016-08-26T21:39:13.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (164, 119, 4.04, 4.04, 3, 0, 8, 2015, CAST(N'2016-08-26T21:39:13.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (165, 120, 686.67, 686.67, 3, 0, 5, 2015, CAST(N'2016-08-26T21:39:13.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (166, 121, 2, 2, 3, 0, 3, 2015, CAST(N'2016-08-26T21:39:13.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (167, 122, 2, 2, 3, 0, 3, 2015, CAST(N'2016-08-26T21:39:13.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (168, 123, 4, 4, 3, 0, 3, 2015, CAST(N'2016-08-26T21:39:13.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (169, 124, 52.31, 52.31, 3, 0, 5, 2015, CAST(N'2016-08-26T21:39:13.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (170, 13, 1403.25, 1403.25, 3, 0, 1, 2015, CAST(N'2016-08-26T21:39:20.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (171, 14, 1609.65, 1609.65, 3, 0, 1, 2015, CAST(N'2016-08-26T21:39:20.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (172, 15, 66.7800000000001, 66.7800000000001, 3, 0, 1, 2015, CAST(N'2016-08-26T21:39:20.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (173, 17, 66.76, 66.76, 3, 0, 1, 2015, CAST(N'2016-08-26T21:39:20.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (174, 184, 0.0200000000000031, 0.0200000000000031, 3, 0, 1, 2015, CAST(N'2016-08-26T21:39:20.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (175, 16, 711.77, 711.77, 3, 0, 1, 2015, CAST(N'2016-08-26T21:39:20.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (176, 87, 420.02, 420.02, 3, 0, 1, 2015, CAST(N'2016-08-26T21:39:20.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (177, 88, 429.81, 429.81, 3, 0, 1, 2015, CAST(N'2016-08-26T21:39:20.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (178, 89, 973.44, 973.44, 3, 0, 1, 2015, CAST(N'2016-08-26T21:39:20.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (179, 90, 461, 461, 3, 0, 1, 2015, CAST(N'2016-08-26T21:39:20.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (180, 91, 28536.43, 28536.43, 3, 0, 5, 2015, CAST(N'2016-08-26T21:39:20.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (181, 1, 235.39, 235.39, 3, 0, 1, 2015, CAST(N'2016-08-26T21:39:27.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (182, 3, 192.17, 192.17, 3, 0, 1, 2015, CAST(N'2016-08-26T21:39:27.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (183, 4, 189.7, 189.7, 3, 0, 1, 2015, CAST(N'2016-08-26T21:39:27.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (184, 5, 93.63, 93.63, 3, 0, 1, 2015, CAST(N'2016-08-26T21:39:27.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (185, 6, 2.48, 2.48, 3, 0, 1, 2015, CAST(N'2016-08-26T21:39:27.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (186, 7, 235.39, 235.39, 3, 0, 1, 2015, CAST(N'2016-08-26T21:39:27.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (187, 8, 0, 0, 3, 0, 1, 2015, CAST(N'2016-08-26T21:39:27.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (188, 9, 0, 0, 3, 0, 1, 2015, CAST(N'2016-08-26T21:39:27.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (189, 10, 0, 0, 3, 0, 1, 2015, CAST(N'2016-08-26T21:39:27.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (190, 11, 0, 0, 3, 0, 1, 2015, CAST(N'2016-08-26T21:39:27.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (191, 12, 0, 0, 3, 0, 1, 2015, CAST(N'2016-08-26T21:39:27.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (192, 105, 22, 22, 3, 0, 3, 2015, CAST(N'2016-08-26T21:39:34.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (193, 106, 346.42, 346.42, 3, 0, 1, 2015, CAST(N'2016-08-26T21:39:34.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (194, 107, 102.98, 102.98, 3, 0, 1, 2015, CAST(N'2016-08-26T21:39:34.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (195, 108, 0, 0, 3, 0, 1, 2015, CAST(N'2016-08-26T21:39:34.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (196, 109, 160.41, 160.41, 3, 0, 1, 2015, CAST(N'2016-08-26T21:39:34.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (197, 110, 0, 0, 3, 0, 1, 2015, CAST(N'2016-08-26T21:39:34.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (198, 111, 186.006, 186.006, 3, 0, 1, 2015, CAST(N'2016-08-26T21:39:34.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (199, 72, 1, 1, 3, 0, 6, 2015, CAST(N'2016-08-26T21:39:43.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (200, 73, 1, 1, 3, 0, 6, 2015, CAST(N'2016-08-26T21:39:43.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (201, 74, 0, 0, 3, 0, 6, 2015, CAST(N'2016-08-26T21:39:43.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (202, 75, 0, 0, 3, 0, 6, 2015, CAST(N'2016-08-26T21:39:44.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (203, 76, 1, 1, 3, 0, 6, 2015, CAST(N'2016-08-26T21:39:44.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (204, 77, 1634.03999999999, 1634.03999999999, 3, 0, 5, 2015, CAST(N'2016-08-26T21:39:44.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (205, 131, 0, 0, 3, 0, 6, 2015, CAST(N'2016-08-26T21:39:44.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (206, 132, 0, 0, 3, 0, 6, 2015, CAST(N'2016-08-26T21:39:44.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (207, 133, 0, 0, 3, 0, 5, 2015, CAST(N'2016-08-26T21:39:44.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (208, 19, 5, 5, 3, 0, 3, 2015, CAST(N'2016-08-26T21:39:51.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (209, 20, 16.7199999999993, 16.7199999999993, 3, 0, 1, 2015, CAST(N'2016-08-26T21:39:51.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (210, 21, 12.9399999999996, 12.9399999999996, 3, 0, 1, 2015, CAST(N'2016-08-26T21:39:51.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (211, 92, 6.78, 6.78, 3, 0, 1, 2015, CAST(N'2016-08-26T21:39:51.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (212, 93, 0, 0, 3, 0, 1, 2015, CAST(N'2016-08-26T21:39:51.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (213, 24, 12100.97, 12100.97, 3, 0, 4, 2015, CAST(N'2016-08-26T21:39:51.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (214, 25, 12100.97, 12100.97, 3, 0, 4, 2015, CAST(N'2016-08-26T21:39:51.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (215, 94, 0, 0, 3, 0, 4, 2015, CAST(N'2016-08-26T21:39:51.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (216, 95, 11498.03, 11498.03, 3, 0, 4, 2015, CAST(N'2016-08-26T21:39:51.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (217, 96, -2222.03, -2222.03, 3, 0, 1, 2015, CAST(N'2016-08-26T21:39:51.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (218, 48, -55, -55, 3, 0, 4, 2015, CAST(N'2016-08-26T21:39:58.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (219, 48, -2426.7, -2426.7, 3, 0, 1, 2015, CAST(N'2016-08-26T21:39:58.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (220, 48, -206700.00000000003, -206700.00000000003, 3, 0, 5, 2015, CAST(N'2016-08-26T21:39:58.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (221, 49, 41, 41, 3, 0, 4, 2015, CAST(N'2016-08-26T21:39:58.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (222, 49, 2637.15, 2637.15, 3, 0, 1, 2015, CAST(N'2016-08-26T21:39:58.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (223, 49, 270000, 270000, 3, 0, 5, 2015, CAST(N'2016-08-26T21:39:58.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (224, 50, 96, 96, 3, 0, 4, 2015, CAST(N'2016-08-26T21:39:58.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (225, 50, 5211.15, 5211.15, 3, 0, 1, 2015, CAST(N'2016-08-26T21:39:58.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (226, 50, 488700, 488700, 3, 0, 5, 2015, CAST(N'2016-08-26T21:39:58.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (227, 58, 6303, 6303, 3, 0, 3, 2015, CAST(N'2016-08-26T21:39:58.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (228, 59, 0, 0, 3, 0, 3, 2015, CAST(N'2016-08-26T21:39:58.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (229, 103, 5, 5, 3, 0, 3, 2015, CAST(N'2016-08-26T21:39:58.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (230, 104, 2513, 2513, 3, 0, 3, 2015, CAST(N'2016-08-26T21:39:58.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (231, 37, 988.42999999999893, 988.42999999999893, 3, 0, 1, 2015, CAST(N'2016-08-26T21:40:08.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (232, 68, 879.42, 879.42, 3, 0, 1, 2015, CAST(N'2016-08-26T21:40:08.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (233, 147, 647.52, 647.52, 3, 0, 1, 2015, CAST(N'2016-08-26T21:40:09.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (234, 38, 10723.39, 10723.39, 3, 0, 4, 2015, CAST(N'2016-08-26T21:40:09.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (235, 43, 1272, 1272, 3, 0, 6, 2015, CAST(N'2016-08-26T21:40:09.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (236, 112, 11, 11, 4, 0, 3, 2015, CAST(N'2016-08-26T21:40:17.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (237, 113, -331.14, -331.14, 4, 0, 1, 2015, CAST(N'2016-08-26T21:40:17.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (238, 114, -110.17, -110.17, 4, 0, 1, 2015, CAST(N'2016-08-26T21:40:17.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (239, 115, 107, 107, 4, 0, 3, 2015, CAST(N'2016-08-26T21:40:17.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (240, 116, -286.65, -286.65, 4, 0, 1, 2015, CAST(N'2016-08-26T21:40:17.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (241, 117, -102.61, -102.61, 4, 0, 1, 2015, CAST(N'2016-08-26T21:40:17.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (242, 118, 78176.01, 78176.01, 4, 0, 8, 2015, CAST(N'2016-08-26T21:40:17.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (243, 119, 29613.72, 29613.72, 4, 0, 8, 2015, CAST(N'2016-08-26T21:40:17.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (244, 120, -419.61, -419.61, 4, 0, 5, 2015, CAST(N'2016-08-26T21:40:17.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (245, 121, 8, 8, 4, 0, 3, 2015, CAST(N'2016-08-26T21:40:17.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (246, 122, 8, 8, 4, 0, 3, 2015, CAST(N'2016-08-26T21:40:17.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (247, 123, 3, 3, 4, 0, 3, 2015, CAST(N'2016-08-26T21:40:17.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (248, 124, 11.27, 11.27, 4, 0, 5, 2015, CAST(N'2016-08-26T21:40:17.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (249, 13, 4887.25, 4887.25, 4, 0, 1, 2015, CAST(N'2016-08-26T21:40:31.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (250, 14, 3224.09, 3224.09, 4, 0, 1, 2015, CAST(N'2016-08-26T21:40:31.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (251, 15, 141.14, 141.14, 4, 0, 1, 2015, CAST(N'2016-08-26T21:40:31.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (252, 17, 20.27, 20.27, 4, 0, 1, 2015, CAST(N'2016-08-26T21:40:31.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (253, 184, 120.87, 120.87, 4, 0, 1, 2015, CAST(N'2016-08-26T21:40:31.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (254, 16, 2127.65, 2127.65, 4, 0, 1, 2015, CAST(N'2016-08-26T21:40:31.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (255, 87, 2175.36, 2175.36, 4, 0, 1, 2015, CAST(N'2016-08-26T21:40:31.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (256, 88, 2322.27, 2322.27, 4, 0, 1, 2015, CAST(N'2016-08-26T21:40:31.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (257, 89, 2564.98, 2564.98, 4, 0, 1, 2015, CAST(N'2016-08-26T21:40:31.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (258, 90, 2502, 2502, 4, 0, 1, 2015, CAST(N'2016-08-26T21:40:31.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (259, 91, 115522.65, 115522.65, 4, 0, 5, 2015, CAST(N'2016-08-26T21:40:31.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (260, 1, 6732.47, 6732.47, 4, 0, 1, 2015, CAST(N'2016-08-26T21:40:37.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (261, 3, 6213.36, 6213.36, 4, 0, 1, 2015, CAST(N'2016-08-26T21:40:37.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (262, 4, 5895.56, 5895.56, 4, 0, 1, 2015, CAST(N'2016-08-26T21:40:37.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (263, 5, 3548.41, 3548.41, 4, 0, 1, 2015, CAST(N'2016-08-26T21:40:37.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (264, 6, 317.8, 317.8, 4, 0, 1, 2015, CAST(N'2016-08-26T21:40:37.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (265, 7, 5680.47, 5680.47, 4, 0, 1, 2015, CAST(N'2016-08-26T21:40:38.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (266, 8, 0, 0, 4, 0, 1, 2015, CAST(N'2016-08-26T21:40:38.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (267, 9, 0, 0, 4, 0, 1, 2015, CAST(N'2016-08-26T21:40:38.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (268, 10, 0, 0, 4, 0, 1, 2015, CAST(N'2016-08-26T21:40:38.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (269, 11, 0, 0, 4, 0, 1, 2015, CAST(N'2016-08-26T21:40:38.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (270, 12, 0, 0, 4, 0, 1, 2015, CAST(N'2016-08-26T21:40:38.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (271, 105, 38, 38, 4, 0, 3, 2015, CAST(N'2016-08-26T21:40:44.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (272, 106, 1245, 1245, 4, 0, 1, 2015, CAST(N'2016-08-26T21:40:44.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (273, 107, 350.71, 350.71, 4, 0, 1, 2015, CAST(N'2016-08-26T21:40:44.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (274, 108, 32.85, 32.85, 4, 0, 1, 2015, CAST(N'2016-08-26T21:40:44.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (275, 109, 332.29, 332.29, 4, 0, 1, 2015, CAST(N'2016-08-26T21:40:44.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (276, 110, 7.09, 7.09, 4, 0, 1, 2015, CAST(N'2016-08-26T21:40:44.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (277, 111, 873, 873, 4, 0, 1, 2015, CAST(N'2016-08-26T21:40:44.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (278, 72, -4, -4, 4, 0, 6, 2015, CAST(N'2016-08-26T21:40:52.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (279, 73, 8, 8, 4, 0, 6, 2015, CAST(N'2016-08-26T21:40:52.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (280, 74, 0, 0, 4, 0, 6, 2015, CAST(N'2016-08-26T21:40:52.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (281, 75, 0, 0, 4, 0, 6, 2015, CAST(N'2016-08-26T21:40:52.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (282, 76, 8, 8, 4, 0, 6, 2015, CAST(N'2016-08-26T21:40:52.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (283, 77, 5854, 5854, 4, 0, 5, 2015, CAST(N'2016-08-26T21:40:52.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (284, 131, 0, 0, 4, 0, 6, 2015, CAST(N'2016-08-26T21:40:52.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (285, 132, 0, 0, 4, 0, 6, 2015, CAST(N'2016-08-26T21:40:52.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (286, 133, 0, 0, 4, 0, 5, 2015, CAST(N'2016-08-26T21:40:52.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (287, 19, 16, 16, 4, 0, 3, 2015, CAST(N'2016-08-26T21:40:58.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (288, 20, 4683.79, 4683.79, 4, 0, 1, 2015, CAST(N'2016-08-26T21:40:58.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (289, 21, 1440.17, 1440.17, 4, 0, 1, 2015, CAST(N'2016-08-26T21:40:58.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (290, 92, 3240.62, 3240.62, 4, 0, 1, 2015, CAST(N'2016-08-26T21:40:58.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (291, 93, 0, 0, 4, 0, 1, 2015, CAST(N'2016-08-26T21:40:58.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (292, 24, 256058.65, 256058.65, 4, 0, 4, 2015, CAST(N'2016-08-26T21:40:58.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (293, 25, 255408.1, 255408.1, 4, 0, 4, 2015, CAST(N'2016-08-26T21:40:58.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (294, 94, 0, 0, 4, 0, 4, 2015, CAST(N'2016-08-26T21:40:58.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (295, 95, 8718.48, 8718.48, 4, 0, 4, 2015, CAST(N'2016-08-26T21:40:58.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (296, 96, 4859.19, 4859.19, 4, 0, 1, 2015, CAST(N'2016-08-26T21:40:59.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (297, 48, -27, -27, 4, 0, 4, 2015, CAST(N'2016-08-26T21:41:07.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (298, 48, -1880.2, -1880.2, 4, 0, 1, 2015, CAST(N'2016-08-26T21:41:07.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (299, 48, 73500.0000000002, 73500.0000000002, 4, 0, 5, 2015, CAST(N'2016-08-26T21:41:07.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (300, 49, 114, 114, 4, 0, 4, 2015, CAST(N'2016-08-26T21:41:07.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (301, 49, 10829.55, 10829.55, 4, 0, 1, 2015, CAST(N'2016-08-26T21:41:07.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (302, 49, 1012400, 1012400, 4, 0, 5, 2015, CAST(N'2016-08-26T21:41:07.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (303, 50, 141, 141, 4, 0, 4, 2015, CAST(N'2016-08-26T21:41:07.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (304, 50, 12560.57, 12560.57, 4, 0, 1, 2015, CAST(N'2016-08-26T21:41:07.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (305, 50, 927000, 927000, 4, 0, 5, 2015, CAST(N'2016-08-26T21:41:07.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (306, 58, 14171, 14171, 4, 0, 3, 2015, CAST(N'2016-08-26T21:41:07.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (307, 59, 0, 0, 4, 0, 3, 2015, CAST(N'2016-08-26T21:41:07.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (308, 103, 9, 9, 4, 0, 3, 2015, CAST(N'2016-08-26T21:41:07.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (309, 104, 786, 786, 4, 0, 3, 2015, CAST(N'2016-08-26T21:41:07.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (310, 37, 669.94000000000108, 669.94000000000108, 4, 0, 1, 2015, CAST(N'2016-08-26T21:41:13.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (311, 68, 1233.81, 1233.81, 4, 0, 1, 2015, CAST(N'2016-08-26T21:41:13.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (312, 147, 788.53, 788.53, 4, 0, 1, 2015, CAST(N'2016-08-26T21:41:13.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (313, 38, 8630.39, 8630.39, 4, 0, 4, 2015, CAST(N'2016-08-26T21:41:13.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (314, 43, 1260, 1260, 4, 0, 6, 2015, CAST(N'2016-08-26T21:41:13.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (397, 112, 38, 38, 1, 0, 3, 2016, CAST(N'2016-08-26T21:44:49.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (398, 113, 94.05, 94.05, 1, 0, 1, 2016, CAST(N'2016-08-26T21:44:49.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (399, 114, 29.7, 29.7, 1, 0, 1, 2016, CAST(N'2016-08-26T21:44:49.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (400, 115, 27, 27, 1, 0, 3, 2016, CAST(N'2016-08-26T21:44:49.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (401, 116, 48.75, 48.75, 1, 0, 1, 2016, CAST(N'2016-08-26T21:44:49.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (402, 117, 28.35, 28.35, 1, 0, 1, 2016, CAST(N'2016-08-26T21:44:49.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (403, 118, 23628, 23628, 1, 0, 8, 2016, CAST(N'2016-08-26T21:44:49.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (404, 119, 1492, 1492, 1, 0, 8, 2016, CAST(N'2016-08-26T21:44:49.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (405, 120, 200.67, 200.67, 1, 0, 5, 2016, CAST(N'2016-08-26T21:44:49.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (406, 121, 3, 3, 1, 0, 3, 2016, CAST(N'2016-08-26T21:44:50.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (407, 122, 3, 3, 1, 0, 3, 2016, CAST(N'2016-08-26T21:44:50.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (408, 123, 1, 1, 1, 0, 3, 2016, CAST(N'2016-08-26T21:44:50.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (409, 124, 0, 0, 1, 0, 5, 2016, CAST(N'2016-08-26T21:44:50.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (410, 13, 1114.44, 1114.44, 1, 0, 1, 2016, CAST(N'2016-08-26T21:45:11.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (411, 14, 629.22, 629.22, 1, 0, 1, 2016, CAST(N'2016-08-26T21:45:11.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (412, 15, 83.11, 83.11, 1, 0, 1, 2016, CAST(N'2016-08-26T21:45:11.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (413, 17, 80.81, 80.81, 1, 0, 1, 2016, CAST(N'2016-08-26T21:45:11.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (414, 184, 2.3, 2.3, 1, 0, 1, 2016, CAST(N'2016-08-26T21:45:12.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (415, 16, 374.11, 374.11, 1, 0, 1, 2016, CAST(N'2016-08-26T21:45:12.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (416, 87, 539.16, 539.16, 1, 0, 1, 2016, CAST(N'2016-08-26T21:45:12.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (417, 88, 629.92, 629.92, 1, 0, 1, 2016, CAST(N'2016-08-26T21:45:12.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (418, 89, 484.53, 484.53, 1, 0, 1, 2016, CAST(N'2016-08-26T21:45:12.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (419, 90, 483.58, 483.58, 1, 0, 1, 2016, CAST(N'2016-08-26T21:45:12.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (420, 91, 27145.97, 27145.97, 1, 0, 5, 2016, CAST(N'2016-08-26T21:45:12.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (421, 1, 0, 0, 1, 0, 1, 2016, CAST(N'2016-08-26T21:45:23.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (422, 3, 0, 0, 1, 0, 1, 2016, CAST(N'2016-08-26T21:45:23.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (423, 4, 0, 0, 1, 0, 1, 2016, CAST(N'2016-08-26T21:45:23.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (424, 5, 0, 0, 1, 0, 1, 2016, CAST(N'2016-08-26T21:45:23.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (425, 6, 0, 0, 1, 0, 1, 2016, CAST(N'2016-08-26T21:45:23.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (426, 7, 0, 0, 1, 0, 1, 2016, CAST(N'2016-08-26T21:45:23.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (427, 8, 0, 0, 1, 0, 1, 2016, CAST(N'2016-08-26T21:45:23.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (428, 9, 0, 0, 1, 0, 1, 2016, CAST(N'2016-08-26T21:45:23.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (429, 10, 0, 0, 1, 0, 1, 2016, CAST(N'2016-08-26T21:45:23.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (430, 11, 0, 0, 1, 0, 1, 2016, CAST(N'2016-08-26T21:45:23.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (431, 12, 0, 0, 1, 0, 1, 2016, CAST(N'2016-08-26T21:45:23.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (432, 72, 73, 73, 1, 0, 6, 2016, CAST(N'2016-08-26T21:45:31.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (433, 73, 1, 1, 1, 0, 6, 2016, CAST(N'2016-08-26T21:45:31.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (434, 74, 1, 1, 1, 0, 6, 2016, CAST(N'2016-08-26T21:45:31.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (435, 75, 0, 0, 1, 0, 6, 2016, CAST(N'2016-08-26T21:45:31.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (436, 76, 1, 1, 1, 0, 6, 2016, CAST(N'2016-08-26T21:45:31.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (437, 77, 14313.76, 14313.76, 1, 0, 5, 2016, CAST(N'2016-08-26T21:45:31.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (438, 131, 0, 0, 1, 0, 6, 2016, CAST(N'2016-08-26T21:45:31.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (439, 132, 0, 0, 1, 0, 6, 2016, CAST(N'2016-08-26T21:45:31.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (440, 133, 0, 0, 1, 0, 5, 2016, CAST(N'2016-08-26T21:45:31.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (441, 19, 9, 9, 1, 0, 3, 2016, CAST(N'2016-08-26T21:45:49.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (442, 20, 182.07, 182.07, 1, 0, 1, 2016, CAST(N'2016-08-26T21:45:49.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (443, 21, 13.78, 13.78, 1, 0, 1, 2016, CAST(N'2016-08-26T21:45:49.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (444, 92, 4.4, 4.4, 1, 0, 1, 2016, CAST(N'2016-08-26T21:45:49.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (445, 93, 163.89, 163.89, 1, 0, 1, 2016, CAST(N'2016-08-26T21:45:49.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (446, 24, 25927, 25927, 1, 0, 4, 2016, CAST(N'2016-08-26T21:45:49.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (447, 25, 25927, 25927, 1, 0, 4, 2016, CAST(N'2016-08-26T21:45:49.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (448, 94, 0, 0, 1, 0, 4, 2016, CAST(N'2016-08-26T21:45:49.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (449, 95, 0, 0, 1, 0, 4, 2016, CAST(N'2016-08-26T21:45:49.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (450, 96, 13227.17, 13227.17, 1, 0, 1, 2016, CAST(N'2016-08-26T21:45:49.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (451, 48, 906, 906, 1, 0, 4, 2016, CAST(N'2016-08-26T21:45:57.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (452, 48, 81215.49, 81215.49, 1, 0, 1, 2016, CAST(N'2016-08-26T21:45:57.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (453, 48, 7119000, 7119000, 1, 0, 5, 2016, CAST(N'2016-08-26T21:45:57.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (454, 49, 98, 98, 1, 0, 4, 2016, CAST(N'2016-08-26T21:45:57.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (455, 49, 4828.1, 4828.1, 1, 0, 1, 2016, CAST(N'2016-08-26T21:45:57.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (456, 49, 371800, 371800, 1, 0, 5, 2016, CAST(N'2016-08-26T21:45:57.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (457, 50, 100, 100, 1, 0, 4, 2016, CAST(N'2016-08-26T21:45:57.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (458, 50, 4410.57, 4410.57, 1, 0, 1, 2016, CAST(N'2016-08-26T21:45:57.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (459, 50, 489400.00000000006, 489400.00000000006, 1, 0, 5, 2016, CAST(N'2016-08-26T21:45:57.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (460, 58, 5161, 5161, 1, 0, 3, 2016, CAST(N'2016-08-26T21:45:57.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (461, 59, 0, 0, 1, 0, 3, 2016, CAST(N'2016-08-26T21:45:57.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (462, 103, 0, 0, 1, 0, 3, 2016, CAST(N'2016-08-26T21:45:57.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (463, 104, 873, 873, 1, 0, 3, 2016, CAST(N'2016-08-26T21:45:57.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (464, 37, 162.3, 162.3, 1, 0, 1, 2016, CAST(N'2016-08-26T21:46:04.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (465, 68, 90.45, 90.45, 1, 0, 1, 2016, CAST(N'2016-08-26T21:46:04.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (466, 147, 51.9, 51.9, 1, 0, 1, 2016, CAST(N'2016-08-26T21:46:04.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (467, 38, 831.56, 831.56, 1, 0, 4, 2016, CAST(N'2016-08-26T21:46:04.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (468, 43, 51, 51, 1, 0, 6, 2016, CAST(N'2016-08-26T21:46:04.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (469, 141, 25, 25, 1, 0, 3, 2016, CAST(N'2016-08-26T21:46:11.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (470, 142, 27, 27, 1, 0, 9, 2016, CAST(N'2016-08-26T21:46:11.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (471, 142, 225, 225, 1, 0, 7, 2016, CAST(N'2016-08-26T21:46:11.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (472, 141, 71, 71, 2, 0, 3, 2016, CAST(N'2016-08-26T21:46:19.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (473, 142, 27, 27, 2, 0, 9, 2016, CAST(N'2016-08-26T21:46:19.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (474, 142, 101, 101, 2, 0, 7, 2016, CAST(N'2016-08-26T21:46:19.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (475, 37, 5061.75, 5061.75, 2, 0, 1, 2016, CAST(N'2016-08-26T21:46:26.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (476, 68, 4567.05, 4567.05, 2, 0, 1, 2016, CAST(N'2016-08-26T21:46:26.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (477, 147, 2393.25, 2393.25, 2, 0, 1, 2016, CAST(N'2016-08-26T21:46:26.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (478, 38, 3183.89, 3183.89, 2, 0, 4, 2016, CAST(N'2016-08-26T21:46:26.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (479, 43, 80, 80, 2, 0, 6, 2016, CAST(N'2016-08-26T21:46:26.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (480, 48, -60, -60, 2, 0, 4, 2016, CAST(N'2016-08-26T21:46:33.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (481, 48, 363.149999999994, 363.149999999994, 2, 0, 1, 2016, CAST(N'2016-08-26T21:46:33.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (482, 48, -524000, -524000, 2, 0, 5, 2016, CAST(N'2016-08-26T21:46:33.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (483, 49, 74, 74, 2, 0, 4, 2016, CAST(N'2016-08-26T21:46:33.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (484, 49, 7100.25, 7100.25, 2, 0, 1, 2016, CAST(N'2016-08-26T21:46:33.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (485, 49, 436599.99999999994, 436599.99999999994, 2, 0, 5, 2016, CAST(N'2016-08-26T21:46:33.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (486, 50, 126, 126, 2, 0, 4, 2016, CAST(N'2016-08-26T21:46:33.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (487, 50, 6737.1, 6737.1, 2, 0, 1, 2016, CAST(N'2016-08-26T21:46:33.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (488, 50, 960600, 960600, 2, 0, 5, 2016, CAST(N'2016-08-26T21:46:33.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (489, 58, 7695, 7695, 2, 0, 3, 2016, CAST(N'2016-08-26T21:46:33.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (490, 59, 0, 0, 2, 0, 3, 2016, CAST(N'2016-08-26T21:46:33.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (491, 103, 1, 1, 2, 0, 3, 2016, CAST(N'2016-08-26T21:46:33.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (492, 104, 1061, 1061, 2, 0, 3, 2016, CAST(N'2016-08-26T21:46:33.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (493, 19, 4, 4, 2, 0, 3, 2016, CAST(N'2016-08-26T21:46:38.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (494, 20, 8.73000000000002, 8.73000000000002, 2, 0, 1, 2016, CAST(N'2016-08-26T21:46:38.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (495, 21, 8.73, 8.73, 2, 0, 1, 2016, CAST(N'2016-08-26T21:46:38.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (496, 92, 0, 0, 2, 0, 1, 2016, CAST(N'2016-08-26T21:46:38.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (497, 93, 0, 0, 2, 0, 1, 2016, CAST(N'2016-08-26T21:46:38.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (498, 24, 5797.91, 5797.91, 2, 0, 4, 2016, CAST(N'2016-08-26T21:46:38.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (499, 25, 5797.91, 5797.91, 2, 0, 4, 2016, CAST(N'2016-08-26T21:46:38.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (500, 94, 0, 0, 2, 0, 4, 2016, CAST(N'2016-08-26T21:46:38.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (501, 95, 4783.72, 4783.72, 2, 0, 4, 2016, CAST(N'2016-08-26T21:46:38.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (502, 96, 8.73999999999978, 8.73999999999978, 2, 0, 1, 2016, CAST(N'2016-08-26T21:46:38.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (503, 72, 2, 2, 2, 0, 6, 2016, CAST(N'2016-08-26T21:46:43.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (504, 73, 3, 3, 2, 0, 6, 2016, CAST(N'2016-08-26T21:46:43.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (505, 74, 1, 1, 2, 0, 6, 2016, CAST(N'2016-08-26T21:46:44.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (506, 75, 0, 0, 2, 0, 6, 2016, CAST(N'2016-08-26T21:46:44.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (507, 76, 3, 3, 2, 0, 6, 2016, CAST(N'2016-08-26T21:46:44.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (508, 77, 524.360000000001, 524.360000000001, 2, 0, 5, 2016, CAST(N'2016-08-26T21:46:44.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (509, 131, 0, 0, 2, 0, 6, 2016, CAST(N'2016-08-26T21:46:44.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (510, 132, 0, 0, 2, 0, 6, 2016, CAST(N'2016-08-26T21:46:44.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (511, 133, 0, 0, 2, 0, 5, 2016, CAST(N'2016-08-26T21:46:44.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (512, 1, 636.54, 636.54, 2, 0, 1, 2016, CAST(N'2016-08-26T21:46:53.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (513, 3, 312.91, 312.91, 2, 0, 1, 2016, CAST(N'2016-08-26T21:46:53.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (514, 4, 312.77, 312.77, 2, 0, 1, 2016, CAST(N'2016-08-26T21:46:53.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (515, 5, 102.39, 102.39, 2, 0, 1, 2016, CAST(N'2016-08-26T21:46:53.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (516, 6, 0.14, 0.14, 2, 0, 1, 2016, CAST(N'2016-08-26T21:46:53.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (517, 7, 637, 637, 2, 0, 1, 2016, CAST(N'2016-08-26T21:46:53.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (518, 8, 0, 0, 2, 0, 1, 2016, CAST(N'2016-08-26T21:46:53.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (519, 9, 0, 0, 2, 0, 1, 2016, CAST(N'2016-08-26T21:46:53.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (520, 10, 0, 0, 2, 0, 1, 2016, CAST(N'2016-08-26T21:46:53.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (521, 11, 0, 0, 2, 0, 1, 2016, CAST(N'2016-08-26T21:46:53.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (522, 12, 0, 0, 2, 0, 1, 2016, CAST(N'2016-08-26T21:46:53.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (523, 13, 2042.22, 2042.22, 2, 0, 1, 2016, CAST(N'2016-08-26T21:46:59.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (524, 14, 1061.14, 1061.14, 2, 0, 1, 2016, CAST(N'2016-08-26T21:46:59.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (525, 15, 145.33, 145.33, 2, 0, 1, 2016, CAST(N'2016-08-26T21:46:59.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (526, 17, 12.33, 12.33, 2, 0, 1, 2016, CAST(N'2016-08-26T21:46:59.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (527, 184, 133, 133, 2, 0, 1, 2016, CAST(N'2016-08-26T21:46:59.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (528, 16, 1609.96, 1609.96, 2, 0, 1, 2016, CAST(N'2016-08-26T21:46:59.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (529, 87, 273.56, 273.56, 2, 0, 1, 2016, CAST(N'2016-08-26T21:46:59.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (530, 88, 276.44, 276.44, 2, 0, 1, 2016, CAST(N'2016-08-26T21:46:59.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (531, 89, 1765.77, 1765.77, 2, 0, 1, 2016, CAST(N'2016-08-26T21:46:59.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (532, 90, 1763.18, 1763.18, 2, 0, 1, 2016, CAST(N'2016-08-26T21:46:59.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (533, 91, 100414.21, 100414.21, 2, 0, 5, 2016, CAST(N'2016-08-26T21:46:59.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (534, 112, 22, 22, 2, 0, 3, 2016, CAST(N'2016-08-26T21:47:06.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (535, 113, 62.55, 62.55, 2, 0, 1, 2016, CAST(N'2016-08-26T21:47:06.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (536, 114, 45.45, 45.45, 2, 0, 1, 2016, CAST(N'2016-08-26T21:47:06.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (537, 115, 3, 3, 2, 0, 3, 2016, CAST(N'2016-08-26T21:47:06.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (538, 116, 80.4, 80.4, 2, 0, 1, 2016, CAST(N'2016-08-26T21:47:06.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (539, 117, 44.4, 44.4, 2, 0, 1, 2016, CAST(N'2016-08-26T21:47:06.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (540, 118, 2669, 2669, 2, 0, 8, 2016, CAST(N'2016-08-26T21:47:06.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (541, 119, 25425, 25425, 2, 0, 8, 2016, CAST(N'2016-08-26T21:47:06.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (542, 120, 108.53, 108.53, 2, 0, 5, 2016, CAST(N'2016-08-26T21:47:06.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (543, 121, 0, 0, 2, 0, 3, 2016, CAST(N'2016-08-26T21:47:06.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (544, 122, 0, 0, 2, 0, 3, 2016, CAST(N'2016-08-26T21:47:06.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (545, 123, 1, 1, 2, 0, 3, 2016, CAST(N'2016-08-26T21:47:06.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (546, 124, 156.5, 156.5, 2, 0, 5, 2016, CAST(N'2016-08-26T21:47:06.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (547, 105, 30, 30, 2, 0, 3, 2016, CAST(N'2016-08-26T21:47:11.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (548, 106, 1194, 1194, 2, 0, 1, 2016, CAST(N'2016-08-26T21:47:11.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (549, 107, 142, 142, 2, 0, 1, 2016, CAST(N'2016-08-26T21:47:11.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (550, 108, 69, 69, 2, 0, 1, 2016, CAST(N'2016-08-26T21:47:11.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (551, 109, 431, 431, 2, 0, 1, 2016, CAST(N'2016-08-26T21:47:11.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (552, 110, 0, 0, 2, 0, 1, 2016, CAST(N'2016-08-26T21:47:11.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (553, 111, 694, 694, 2, 0, 1, 2016, CAST(N'2016-08-26T21:47:11.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (554, 105, 27, 27, 1, 0, 3, 2016, CAST(N'2016-08-26T21:47:17.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (555, 106, 2272, 2272, 1, 0, 1, 2016, CAST(N'2016-08-26T21:47:17.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (556, 107, 628, 628, 1, 0, 1, 2016, CAST(N'2016-08-26T21:47:17.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (557, 108, 4, 4, 1, 0, 1, 2016, CAST(N'2016-08-26T21:47:17.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (558, 109, 1935, 1935, 1, 0, 1, 2016, CAST(N'2016-08-26T21:47:17.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (559, 110, 8, 8, 1, 0, 1, 2016, CAST(N'2016-08-26T21:47:17.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (560, 111, 325, 325, 1, 0, 1, 2016, CAST(N'2016-08-26T21:47:17.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (561, 112, 83, 83, 1, 0, 3, 2015, CAST(N'2016-08-26T21:48:55.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (562, 113, 236.08, 236.08, 1, 0, 1, 2015, CAST(N'2016-08-26T21:48:55.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (563, 114, 70.67, 70.67, 1, 0, 1, 2015, CAST(N'2016-08-26T21:48:55.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (564, 115, 3, 3, 1, 0, 3, 2015, CAST(N'2016-08-26T21:48:55.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (565, 116, 177.89, 177.89, 1, 0, 1, 2015, CAST(N'2016-08-26T21:48:55.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (566, 117, 62.4, 62.4, 1, 0, 1, 2015, CAST(N'2016-08-26T21:48:55.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (567, 118, 8466, 8466, 1, 0, 8, 2015, CAST(N'2016-08-26T21:48:55.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (568, 119, 11639, 11639, 1, 0, 8, 2015, CAST(N'2016-08-26T21:48:55.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (569, 120, 556.91, 556.91, 1, 0, 5, 2015, CAST(N'2016-08-26T21:48:55.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (570, 121, 0, 0, 1, 0, 3, 2015, CAST(N'2016-08-26T21:48:55.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (571, 122, 0, 0, 1, 0, 3, 2015, CAST(N'2016-08-26T21:48:55.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (572, 123, 0, 0, 1, 0, 3, 2015, CAST(N'2016-08-26T21:48:55.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (573, 124, 0, 0, 1, 0, 5, 2015, CAST(N'2016-08-26T21:48:55.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (574, 13, 1456.41, 1456.41, 1, 0, 1, 2015, CAST(N'2016-08-26T21:49:01.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (575, 14, 641.44, 641.44, 1, 0, 1, 2015, CAST(N'2016-08-26T21:49:01.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (576, 15, 546.89, 546.89, 1, 0, 1, 2015, CAST(N'2016-08-26T21:49:01.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (577, 17, 484.35, 484.35, 1, 0, 1, 2015, CAST(N'2016-08-26T21:49:01.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (578, 184, 62.54, 62.54, 1, 0, 1, 2015, CAST(N'2016-08-26T21:49:01.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (579, 16, 435.72, 435.72, 1, 0, 1, 2015, CAST(N'2016-08-26T21:49:01.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (580, 87, 473.81, 473.81, 1, 0, 1, 2015, CAST(N'2016-08-26T21:49:01.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (581, 88, 338.69, 338.69, 1, 0, 1, 2015, CAST(N'2016-08-26T21:49:01.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (582, 89, 1117.72, 1117.72, 1, 0, 1, 2015, CAST(N'2016-08-26T21:49:01.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (583, 90, 1104.11, 1104.11, 1, 0, 1, 2015, CAST(N'2016-08-26T21:49:01.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (584, 91, 50753.2093, 50753.2093, 1, 0, 5, 2015, CAST(N'2016-08-26T21:49:01.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (585, 1, 522.69, 522.69, 1, 0, 1, 2015, CAST(N'2016-08-26T21:49:07.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (586, 3, 32.21, 32.21, 1, 0, 1, 2015, CAST(N'2016-08-26T21:49:07.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (587, 4, 31.72, 31.72, 1, 0, 1, 2015, CAST(N'2016-08-26T21:49:07.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (588, 5, 10.67, 10.67, 1, 0, 1, 2015, CAST(N'2016-08-26T21:49:07.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (589, 6, 0.49, 0.49, 1, 0, 1, 2015, CAST(N'2016-08-26T21:49:07.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (590, 7, 522.69, 522.69, 1, 0, 1, 2015, CAST(N'2016-08-26T21:49:07.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (591, 8, 0, 0, 1, 0, 1, 2015, CAST(N'2016-08-26T21:49:07.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (592, 9, 0, 0, 1, 0, 1, 2015, CAST(N'2016-08-26T21:49:07.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (593, 10, 0, 0, 1, 0, 1, 2015, CAST(N'2016-08-26T21:49:07.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (594, 11, 0, 0, 1, 0, 1, 2015, CAST(N'2016-08-26T21:49:07.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (595, 12, 0, 0, 1, 0, 1, 2015, CAST(N'2016-08-26T21:49:07.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (596, 105, 33, 33, 1, 0, 3, 2015, CAST(N'2016-08-26T21:49:13.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (597, 106, 1094, 1094, 1, 0, 1, 2015, CAST(N'2016-08-26T21:49:13.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (598, 107, 160, 160, 1, 0, 1, 2015, CAST(N'2016-08-26T21:49:13.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (599, 108, 0, 0, 1, 0, 1, 2015, CAST(N'2016-08-26T21:49:13.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (600, 109, 583, 583, 1, 0, 1, 2015, CAST(N'2016-08-26T21:49:13.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (601, 110, 11, 11, 1, 0, 1, 2015, CAST(N'2016-08-26T21:49:13.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (602, 111, 500, 500, 1, 0, 1, 2015, CAST(N'2016-08-26T21:49:13.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (603, 72, 67, 67, 1, 0, 6, 2015, CAST(N'2016-08-26T21:49:19.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (604, 73, 5, 5, 1, 0, 6, 2015, CAST(N'2016-08-26T21:49:19.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (605, 74, 3, 3, 1, 0, 6, 2015, CAST(N'2016-08-26T21:49:19.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (606, 75, 0, 0, 1, 0, 6, 2015, CAST(N'2016-08-26T21:49:19.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (607, 76, 5, 5, 1, 0, 6, 2015, CAST(N'2016-08-26T21:49:19.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (608, 77, 15270.64, 15270.64, 1, 0, 5, 2015, CAST(N'2016-08-26T21:49:19.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (609, 131, 0, 0, 1, 0, 6, 2015, CAST(N'2016-08-26T21:49:19.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (610, 132, 0, 0, 1, 0, 6, 2015, CAST(N'2016-08-26T21:49:19.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (611, 133, 0, 0, 1, 0, 5, 2015, CAST(N'2016-08-26T21:49:19.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (612, 19, 9, 9, 1, 0, 3, 2015, CAST(N'2016-08-26T21:49:27.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (613, 20, 2750.24, 2750.24, 1, 0, 1, 2015, CAST(N'2016-08-26T21:49:27.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (614, 21, 1319.25, 1319.25, 1, 0, 1, 2015, CAST(N'2016-08-26T21:49:27.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (615, 92, 1430.99, 1430.99, 1, 0, 1, 2015, CAST(N'2016-08-26T21:49:27.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (616, 93, 0, 0, 1, 0, 1, 2015, CAST(N'2016-08-26T21:49:27.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (617, 24, 6156.62, 6156.62, 1, 0, 4, 2015, CAST(N'2016-08-26T21:49:27.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (618, 25, 6156.62, 6156.62, 1, 0, 4, 2015, CAST(N'2016-08-26T21:49:27.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (619, 94, 0, 0, 1, 0, 4, 2015, CAST(N'2016-08-26T21:49:27.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (620, 95, 10003.06, 10003.06, 1, 0, 4, 2015, CAST(N'2016-08-26T21:49:27.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (621, 96, 8662.03, 8662.03, 1, 0, 1, 2015, CAST(N'2016-08-26T21:49:27.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (622, 48, 699, 699, 1, 0, 4, 2015, CAST(N'2016-08-26T21:49:35.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (623, 48, 58280.55, 58280.55, 1, 0, 1, 2015, CAST(N'2016-08-26T21:49:35.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (624, 48, 7207400, 7207400, 1, 0, 5, 2015, CAST(N'2016-08-26T21:49:35.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (625, 49, 77, 77, 1, 0, 4, 2015, CAST(N'2016-08-26T21:49:35.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (626, 49, 4683.9, 4683.9, 1, 0, 1, 2015, CAST(N'2016-08-26T21:49:35.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (627, 49, 2106427300, 2106427300, 1, 0, 5, 2015, CAST(N'2016-08-26T21:49:35.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (628, 50, 68, 68, 1, 0, 4, 2015, CAST(N'2016-08-26T21:49:35.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (629, 50, 1968.75, 1968.75, 1, 0, 1, 2015, CAST(N'2016-08-26T21:49:35.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (630, 50, 977536000, 977536000, 1, 0, 5, 2015, CAST(N'2016-08-26T21:49:35.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (631, 58, 4800, 4800, 1, 0, 3, 2015, CAST(N'2016-08-26T21:49:35.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (632, 59, 0, 0, 1, 0, 3, 2015, CAST(N'2016-08-26T21:49:35.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (633, 103, 0, 0, 1, 0, 3, 2015, CAST(N'2016-08-26T21:49:35.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (634, 104, 1097, 1097, 1, 0, 3, 2015, CAST(N'2016-08-26T21:49:35.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (635, 37, 125.61, 125.61, 1, 0, 1, 2015, CAST(N'2016-08-26T21:49:45.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (636, 68, 72.04, 72.04, 1, 0, 1, 2015, CAST(N'2016-08-26T21:49:45.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (637, 147, 42.24, 42.24, 1, 0, 1, 2015, CAST(N'2016-08-26T21:49:45.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (638, 38, 10950.76, 10950.76, 1, 0, 4, 2015, CAST(N'2016-08-26T21:49:45.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (639, 43, 1619, 1619, 1, 0, 6, 2015, CAST(N'2016-08-26T21:49:45.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (640, 37, 3305.94, 3305.94, 2, 0, 1, 2015, CAST(N'2016-08-26T21:49:51.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (641, 68, 1864.76, 1864.76, 2, 0, 1, 2015, CAST(N'2016-08-26T21:49:51.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (642, 147, 1340.01, 1340.01, 2, 0, 1, 2015, CAST(N'2016-08-26T21:49:52.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (643, 38, 8113.16, 8113.16, 2, 0, 4, 2015, CAST(N'2016-08-26T21:49:52.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (644, 43, 1013, 1013, 2, 0, 6, 2015, CAST(N'2016-08-26T21:49:52.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (645, 48, 187, 187, 2, 0, 4, 2015, CAST(N'2016-08-26T21:49:58.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (646, 48, 9173.55, 9173.55, 2, 0, 1, 2015, CAST(N'2016-08-26T21:49:58.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (647, 48, 617900, 617900, 2, 0, 5, 2015, CAST(N'2016-08-26T21:49:58.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (648, 49, 241, 241, 2, 0, 4, 2015, CAST(N'2016-08-26T21:49:58.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (649, 49, 13553.1, 13553.1, 2, 0, 1, 2015, CAST(N'2016-08-26T21:49:58.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (650, 49, -2102572200, -2102572200, 2, 0, 5, 2015, CAST(N'2016-08-26T21:49:58.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (651, 50, 49, 49, 2, 0, 4, 2015, CAST(N'2016-08-26T21:49:58.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (652, 50, 4379.55, 4379.55, 2, 0, 1, 2015, CAST(N'2016-08-26T21:49:58.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (653, 50, -976710300, -976710300, 2, 0, 5, 2015, CAST(N'2016-08-26T21:49:58.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (654, 58, 539, 539, 2, 0, 3, 2015, CAST(N'2016-08-26T21:49:58.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (655, 59, 0, 0, 2, 0, 3, 2015, CAST(N'2016-08-26T21:49:58.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (656, 103, 24, 24, 2, 0, 3, 2015, CAST(N'2016-08-26T21:49:58.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (657, 104, 281, 281, 2, 0, 3, 2015, CAST(N'2016-08-26T21:49:58.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (658, 19, 8, 8, 2, 0, 3, 2015, CAST(N'2016-08-26T21:50:09.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (659, 20, 3268.11, 3268.11, 2, 0, 1, 2015, CAST(N'2016-08-26T21:50:09.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (660, 21, 4687.05, 4687.05, 2, 0, 1, 2015, CAST(N'2016-08-26T21:50:09.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (661, 92, -1418.94, -1418.94, 2, 0, 1, 2015, CAST(N'2016-08-26T21:50:09.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (662, 93, 0, 0, 2, 0, 1, 2015, CAST(N'2016-08-26T21:50:09.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (663, 24, 10953.6, 10953.6, 2, 0, 4, 2015, CAST(N'2016-08-26T21:50:09.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (664, 25, 10953.6, 10953.6, 2, 0, 4, 2015, CAST(N'2016-08-26T21:50:09.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (665, 94, 0, 0, 2, 0, 4, 2015, CAST(N'2016-08-26T21:50:09.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (666, 95, 4569.79, 4569.79, 2, 0, 4, 2015, CAST(N'2016-08-26T21:50:09.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (667, 96, 1746.03, 1746.03, 2, 0, 1, 2015, CAST(N'2016-08-26T21:50:09.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (668, 72, 1, 1, 2, 0, 6, 2015, CAST(N'2016-08-26T21:50:15.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (669, 73, -1, -1, 2, 0, 6, 2015, CAST(N'2016-08-26T21:50:15.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (670, 74, 2, 2, 2, 0, 6, 2015, CAST(N'2016-08-26T21:50:15.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (671, 75, 0, 0, 2, 0, 6, 2015, CAST(N'2016-08-26T21:50:15.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (672, 76, -1, -1, 2, 0, 6, 2015, CAST(N'2016-08-26T21:50:15.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (673, 77, 113417.16, 113417.16, 2, 0, 5, 2015, CAST(N'2016-08-26T21:50:15.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (674, 131, 0, 0, 2, 0, 6, 2015, CAST(N'2016-08-26T21:50:15.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (675, 132, 0, 0, 2, 0, 6, 2015, CAST(N'2016-08-26T21:50:15.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (676, 133, 0, 0, 2, 0, 5, 2015, CAST(N'2016-08-26T21:50:15.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (677, 105, 52, 52, 2, 0, 3, 2015, CAST(N'2016-08-26T21:50:21.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (678, 106, 1631.36, 1631.36, 2, 0, 1, 2015, CAST(N'2016-08-26T21:50:21.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (679, 107, 146.31, 146.31, 2, 0, 1, 2015, CAST(N'2016-08-26T21:50:21.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (680, 108, 388.15, 388.15, 2, 0, 1, 2015, CAST(N'2016-08-26T21:50:21.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (681, 109, 394.3, 394.3, 2, 0, 1, 2015, CAST(N'2016-08-26T21:50:21.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (682, 110, 16.912, 16.912, 2, 0, 1, 2015, CAST(N'2016-08-26T21:50:21.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (683, 111, 831.994, 831.994, 2, 0, 1, 2015, CAST(N'2016-08-26T21:50:21.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (684, 1, 1248.45, 1248.45, 2, 0, 1, 2015, CAST(N'2016-08-26T21:50:25.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (685, 3, 1052.26, 1052.26, 2, 0, 1, 2015, CAST(N'2016-08-26T21:50:25.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (686, 4, 953.02, 953.02, 2, 0, 1, 2015, CAST(N'2016-08-26T21:50:25.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (687, 5, 679.29, 679.29, 2, 0, 1, 2015, CAST(N'2016-08-26T21:50:25.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (688, 6, 99.23, 99.23, 2, 0, 1, 2015, CAST(N'2016-08-26T21:50:25.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (689, 7, 1248.45, 1248.45, 2, 0, 1, 2015, CAST(N'2016-08-26T21:50:25.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (690, 8, 0, 0, 2, 0, 1, 2015, CAST(N'2016-08-26T21:50:25.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (691, 9, 0, 0, 2, 0, 1, 2015, CAST(N'2016-08-26T21:50:25.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (692, 10, 0, 0, 2, 0, 1, 2015, CAST(N'2016-08-26T21:50:25.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (693, 11, 0, 0, 2, 0, 1, 2015, CAST(N'2016-08-26T21:50:25.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (694, 12, 0, 0, 2, 0, 1, 2015, CAST(N'2016-08-26T21:50:25.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (695, 13, 2260.64, 2260.64, 2, 0, 1, 2015, CAST(N'2016-08-26T21:50:32.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (696, 14, 1441.02, 1441.02, 2, 0, 1, 2015, CAST(N'2016-08-26T21:50:32.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (697, 15, 13.41, 13.41, 2, 0, 1, 2015, CAST(N'2016-08-26T21:50:32.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (698, 17, 13.41, 13.41, 2, 0, 1, 2015, CAST(N'2016-08-26T21:50:32.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (699, 184, 0, 0, 2, 0, 1, 2015, CAST(N'2016-08-26T21:50:32.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (700, 16, 1143.86, 1143.86, 2, 0, 1, 2015, CAST(N'2016-08-26T21:50:32.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (701, 87, 1055.81, 1055.81, 2, 0, 1, 2015, CAST(N'2016-08-26T21:50:32.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (702, 88, 943.08, 943.08, 2, 0, 1, 2015, CAST(N'2016-08-26T21:50:32.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (703, 89, 1317.56, 1317.56, 2, 0, 1, 2015, CAST(N'2016-08-26T21:50:32.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (704, 90, 1162.59, 1162.59, 2, 0, 1, 2015, CAST(N'2016-08-26T21:50:32.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (705, 91, 35225.3407, 35225.3407, 2, 0, 5, 2015, CAST(N'2016-08-26T21:50:32.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (706, 112, 49, 49, 2, 0, 3, 2015, CAST(N'2016-08-26T21:50:39.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (707, 113, 109.97, 109.97, 2, 0, 1, 2015, CAST(N'2016-08-26T21:50:39.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (708, 114, 34.93, 34.93, 2, 0, 1, 2015, CAST(N'2016-08-26T21:50:39.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (709, 115, 4, 4, 2, 0, 3, 2015, CAST(N'2016-08-26T21:50:39.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (710, 116, 102.01, 102.01, 2, 0, 1, 2015, CAST(N'2016-08-26T21:50:39.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (711, 117, 35.1, 35.1, 2, 0, 1, 2015, CAST(N'2016-08-26T21:50:39.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (712, 118, 10781, 10781, 2, 0, 8, 2015, CAST(N'2016-08-26T21:50:39.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (713, 119, -11395.76, -11395.76, 2, 0, 8, 2015, CAST(N'2016-08-26T21:50:39.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (714, 120, 385.22, 385.22, 2, 0, 5, 2015, CAST(N'2016-08-26T21:50:39.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (715, 121, 6, 6, 2, 0, 3, 2015, CAST(N'2016-08-26T21:50:39.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (716, 122, 6, 6, 2, 0, 3, 2015, CAST(N'2016-08-26T21:50:39.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (717, 123, 0, 0, 2, 0, 3, 2015, CAST(N'2016-08-26T21:50:39.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (718, 124, 12711.37, 12711.37, 2, 0, 5, 2015, CAST(N'2016-08-26T21:50:39.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (719, 1, 1, 1, 4, 1, 1, 2016, CAST(N'2016-09-21T00:04:59.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (720, 3, 1, 1, 4, 1, 1, 2016, CAST(N'2016-09-21T00:04:59.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (721, 4, 1, 1, 4, 1, 1, 2016, CAST(N'2016-09-21T00:04:59.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (725, 155, 1, 5, 1, 0, 4, 2017, CAST(N'2017-03-13T19:58:58.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (726, 156, 1, 5, 1, 0, 4, 2017, CAST(N'2017-03-13T19:58:58.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (727, 157, 1, 5, 1, 0, 4, 2017, CAST(N'2017-03-13T19:58:58.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (728, 158, 1, 5, 1, 0, 4, 2017, CAST(N'2017-03-13T19:58:58.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (729, 155, 2, 2, 1, 0, 4, 2017, CAST(N'2017-03-13T19:59:04.000' AS DateTime), 1)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (730, 156, 2, 2, 1, 0, 4, 2017, CAST(N'2017-03-13T19:59:04.000' AS DateTime), 1)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (731, 157, 2, 2, 1, 0, 4, 2017, CAST(N'2017-03-13T19:59:04.000' AS DateTime), 1)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (732, 158, 2, 2, 1, 0, 4, 2017, CAST(N'2017-03-13T19:59:04.000' AS DateTime), 1)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (733, 155, 1, 1, 1, 1, 4, 2017, CAST(N'2017-03-13T20:00:03.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (734, 156, 1, 1, 1, 1, 4, 2017, CAST(N'2017-03-13T20:00:03.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (735, 157, 1, 1, 1, 1, 4, 2017, CAST(N'2017-03-13T20:00:03.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (736, 158, 1, 1, 1, 1, 4, 2017, CAST(N'2017-03-13T20:00:03.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (737, 155, 2, 2, 1, 1, 4, 2017, CAST(N'2017-03-13T20:00:09.000' AS DateTime), 1)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (738, 156, 2, 2, 1, 1, 4, 2017, CAST(N'2017-03-13T20:00:09.000' AS DateTime), 1)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (739, 157, 2, 2, 1, 1, 4, 2017, CAST(N'2017-03-13T20:00:09.000' AS DateTime), 1)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (740, 158, 2, 2, 1, 1, 4, 2017, CAST(N'2017-03-13T20:00:09.000' AS DateTime), 1)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (741, 155, 1, 1, 1, 3, 4, 2017, CAST(N'2017-03-13T20:00:17.000' AS DateTime), 1)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (742, 156, 1, 1, 1, 3, 4, 2017, CAST(N'2017-03-13T20:00:17.000' AS DateTime), 1)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (743, 157, 1, 1, 1, 3, 4, 2017, CAST(N'2017-03-13T20:00:17.000' AS DateTime), 1)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (744, 158, 1, 1, 1, 3, 4, 2017, CAST(N'2017-03-13T20:00:17.000' AS DateTime), 1)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (745, 155, 1, 1, 1, 3, 4, 2017, CAST(N'2017-03-13T20:00:22.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (746, 156, 1, 1, 1, 3, 4, 2017, CAST(N'2017-03-13T20:00:22.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (747, 157, 1, 1, 1, 3, 4, 2017, CAST(N'2017-03-13T20:00:22.000' AS DateTime), 0)
GO
INSERT [dbo].[node_value] ([ID], [NodeID], [Value], [Raw_Value], [Quarter], [AreaID], [TypeID], [Year], [UpdateTime], [Period]) VALUES (748, 158, 1, 1, 1, 3, 4, 2017, CAST(N'2017-03-13T20:00:22.000' AS DateTime), 0)
GO
SET IDENTITY_INSERT [dbo].[node_value] OFF
GO
SET IDENTITY_INSERT [dbo].[season] ON 
GO
INSERT [dbo].[season] ([ID], [Quarter], [StartTime], [Year], [EndTime], [SetTime], [Delete]) VALUES (1, 1, CAST(N'2016-01-01T00:00:00.000' AS DateTime), 0, CAST(N'2016-03-01T00:00:00.000' AS DateTime), CAST(N'2016-07-30T21:14:23.000' AS DateTime), 1)
GO
INSERT [dbo].[season] ([ID], [Quarter], [StartTime], [Year], [EndTime], [SetTime], [Delete]) VALUES (2, 2, CAST(N'2016-03-01T00:00:00.000' AS DateTime), 2016, CAST(N'2016-04-29T00:00:00.000' AS DateTime), CAST(N'2016-08-01T15:34:41.000' AS DateTime), 0)
GO
INSERT [dbo].[season] ([ID], [Quarter], [StartTime], [Year], [EndTime], [SetTime], [Delete]) VALUES (3, 3, CAST(N'2016-06-01T00:00:00.000' AS DateTime), 2016, CAST(N'2016-08-30T00:00:00.000' AS DateTime), CAST(N'2016-08-01T15:34:47.000' AS DateTime), 0)
GO
INSERT [dbo].[season] ([ID], [Quarter], [StartTime], [Year], [EndTime], [SetTime], [Delete]) VALUES (4, 4, CAST(N'2016-09-01T00:00:00.000' AS DateTime), 2016, CAST(N'2016-12-30T00:00:00.000' AS DateTime), CAST(N'2016-09-18T11:16:54.000' AS DateTime), 0)
GO
SET IDENTITY_INSERT [dbo].[season] OFF
GO
SET IDENTITY_INSERT [dbo].[trend_template] ON 
GO
INSERT [dbo].[trend_template] ([ID], [Name], [FilePath], [FormID]) VALUES (1, N'建设用地预审.xls', N'建设用地预审.xls', 8)
GO
INSERT [dbo].[trend_template] ([ID], [Name], [FilePath], [FormID]) VALUES (2, N'各土地应用变化.xls', N'各土地应用变化.xls', 2)
GO
INSERT [dbo].[trend_template] ([ID], [Name], [FilePath], [FormID]) VALUES (3, N'信访情况.xls', N'信访情况.xls', 7)
GO
INSERT [dbo].[trend_template] ([ID], [Name], [FilePath], [FormID]) VALUES (4, N'土地储备.xls', N'土地储备.xls', 3)
GO
INSERT [dbo].[trend_template] ([ID], [Name], [FilePath], [FormID]) VALUES (5, N'矿产收费情况.xls', N'矿产收费情况.xls', 6)
GO
INSERT [dbo].[trend_template] ([ID], [Name], [FilePath], [FormID]) VALUES (6, N'国土资源违法案件.xls', N'国土资源违法案件.xls', 9)
GO
INSERT [dbo].[trend_template] ([ID], [Name], [FilePath], [FormID]) VALUES (7, N'土地登记和抵押.xls', N'土地登记和抵押.xls', 5)
GO
INSERT [dbo].[trend_template] ([ID], [Name], [FilePath], [FormID]) VALUES (8, N'土地征收.xls', N'土地征收.xls', 4)
GO
SET IDENTITY_INSERT [dbo].[trend_template] OFF
GO
SET IDENTITY_INSERT [dbo].[user] ON 
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (1, N'admin', N'202cb962ac59075b964b07152d234b70', 5, N'admin', 0, CAST(N'2020-05-16T11:54:11.843' AS DateTime), NULL, N'')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (3, N'loowootech', N'202cb962ac59075b964b07152d234b70', 5, N'loowootech', 0, NULL, NULL, N'')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (4, N'ty', N'202cb962ac59075b964b07152d234b70', 3, N'唐尧', 0, CAST(N'2016-09-18T12:17:46.000' AS DateTime), NULL, N'')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (5, N'zq', N'202cb962ac59075b964b07152d234b70', 2, N'赵泉', 0, CAST(N'2016-09-18T12:15:51.000' AS DateTime), N'1', N'')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (6, N'zwj', N'202cb962ac59075b964b07152d234b70', 1, N'周威俊', 0, NULL, N'6', N'')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (8, N'sjgh', N'202cb962ac59075b964b07152d234b70', 3, N'市局规划', 0, CAST(N'2016-09-18T11:17:02.000' AS DateTime), N'1', N'1,8')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (9, N'sjly', N'202cb962ac59075b964b07152d234b70', 3, N'市局利用', 0, CAST(N'2016-10-14T15:25:19.000' AS DateTime), N'1', N'2')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (10, N'cbzx', N'202cb962ac59075b964b07152d234b70', 3, N'储备中心', 0, NULL, N'1', N'3')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (11, N'zds', N'202cb962ac59075b964b07152d234b70', 3, N'征地所', 0, CAST(N'2016-09-22T08:19:46.000' AS DateTime), N'1', N'4')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (12, N'sjkg', N'202cb962ac59075b964b07152d234b70', 3, N'市局矿管', 0, CAST(N'2016-09-14T10:46:29.000' AS DateTime), N'1', N'6')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (13, N'jczd', N'202cb962ac59075b964b07152d234b70', 3, N'监察支队', 0, CAST(N'2016-09-13T14:51:51.000' AS DateTime), N'1', N'9')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (14, N'sjxf', N'202cb962ac59075b964b07152d234b70', 3, N'市局信访', 0, CAST(N'2016-09-13T14:15:44.000' AS DateTime), N'1', N'7')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (15, N'bdc', N'202cb962ac59075b964b07152d234b70', 3, N'不动产中心', 0, CAST(N'2016-10-10T09:12:00.000' AS DateTime), N'1', N'5')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (16, N'sjdj', N'202cb962ac59075b964b07152d234b70', 3, N'地籍处', 0, NULL, N'1', N'5')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (17, N'dhgh', N'202cb962ac59075b964b07152d234b70', 1, N'定海规划', 0, CAST(N'2016-09-21T15:40:52.000' AS DateTime), N'3', N'1,8')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (18, N'dhly', N'202cb962ac59075b964b07152d234b70', 1, N'定海利用储备', 0, NULL, N'3', N'2,3')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (19, N'dhzd', N'202cb962ac59075b964b07152d234b70', 1, N'定海土地征收', 0, NULL, N'3', N'4')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (20, N'dhkg', N'202cb962ac59075b964b07152d234b70', 1, N'定海矿产管理', 0, NULL, N'3', N'6')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (21, N'dhbdc', N'202cb962ac59075b964b07152d234b70', 1, N'定海不动产', 0, NULL, N'3', N'5')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (22, N'dhzf', N'202cb962ac59075b964b07152d234b70', 1, N'定海执法监察', 0, NULL, N'3', N'9')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (23, N'dhxf', N'202cb962ac59075b964b07152d234b70', 1, N'定海信访', 0, NULL, N'3', N'7')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (24, N'ptgh', N'202cb962ac59075b964b07152d234b70', 1, N'普陀规划、征收', 0, NULL, N'5', N'1,4,8')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (25, N'ptly', N'202cb962ac59075b964b07152d234b70', 1, N'普陀利用', 0, NULL, N'5', N'2')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (26, N'ptkg', N'202cb962ac59075b964b07152d234b70', 1, N'普陀矿产管理', 0, NULL, N'5', N'6')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (27, N'ptbdc', N'202cb962ac59075b964b07152d234b70', 1, N'普陀不动产', 0, CAST(N'2016-09-22T11:19:14.000' AS DateTime), N'5', N'5')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (28, N'ptcb', N'202cb962ac59075b964b07152d234b70', 1, N'普陀土地储备', 0, NULL, N'5', N'3')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (29, N'ptzf', N'202cb962ac59075b964b07152d234b70', 1, N'普陀执法监察', 0, NULL, N'5', N'9')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (30, N'ptxf', N'202cb962ac59075b964b07152d234b70', 1, N'普陀信访', 0, CAST(N'2016-09-22T09:12:13.000' AS DateTime), N'5', N'7')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (31, N'dsgh', N'202cb962ac59075b964b07152d234b70', 1, N'岱山规划', 0, NULL, N'4', N'1,8')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (32, N'dsly', N'202cb962ac59075b964b07152d234b70', 1, N'岱山利用', 0, NULL, N'4', N'2')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (33, N'dszd', N'202cb962ac59075b964b07152d234b70', 1, N'岱山土地征收、土地储备', 0, NULL, N'4', N'3,4')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (34, N'dskg', N'202cb962ac59075b964b07152d234b70', 1, N'岱山矿产管理', 0, NULL, N'4', N'6')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (35, N'dsbdc', N'202cb962ac59075b964b07152d234b70', 1, N'岱山不动产', 0, NULL, N'4', N'5')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (36, N'dszf', N'202cb962ac59075b964b07152d234b70', 1, N'岱山执法监察', 0, NULL, N'4', N'9')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (37, N'dsxf', N'202cb962ac59075b964b07152d234b70', 1, N'岱山信访', 0, NULL, N'4', N'7')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (38, N'ssgh', N'202cb962ac59075b964b07152d234b70', 1, N'嵊泗规划', 0, CAST(N'2016-09-21T11:47:47.000' AS DateTime), N'6', N'1,8')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (39, N'ssly', N'202cb962ac59075b964b07152d234b70', 1, N'嵊泗土地利用', 0, NULL, N'6', N'2')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (40, N'sszd', N'202cb962ac59075b964b07152d234b70', 1, N'嵊泗征地', 0, NULL, N'6', N'4')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (41, N'sskg', N'202cb962ac59075b964b07152d234b70', 1, N'嵊泗矿管', 0, CAST(N'2016-09-23T09:36:01.000' AS DateTime), N'6', N'6')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (42, N'ssbdc', N'202cb962ac59075b964b07152d234b70', 1, N'嵊泗不动产', 0, NULL, N'6', N'5')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (43, N'sscb', N'202cb962ac59075b964b07152d234b70', 1, N'嵊泗储备', 0, NULL, N'6', N'3')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (44, N'sszf', N'202cb962ac59075b964b07152d234b70', 1, N'嵊泗执法监察信访', 0, NULL, N'6', N'7,9')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (45, N'xcgh', N'202cb962ac59075b964b07152d234b70', 1, N'新城土地规划', 0, NULL, N'2', N'1,8')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (46, N'xcly', N'202cb962ac59075b964b07152d234b70', 1, N'新城土地利用、土地储备', 0, NULL, N'2', N'2')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (47, N'xczd', N'202cb962ac59075b964b07152d234b70', 1, N'新城土地征收', 0, NULL, N'2', N'4')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (48, N'xckg', N'202cb962ac59075b964b07152d234b70', 1, N'新城矿管', 0, NULL, N'2', N'6')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (49, N'xczf', N'202cb962ac59075b964b07152d234b70', 1, N'新城执法监察', 0, NULL, N'2', N'9')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (50, N'xcxf', N'202cb962ac59075b964b07152d234b70', 1, N'新城信访', 0, NULL, N'2', N'7')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (51, N'jjqgh', N'202cb962ac59075b964b07152d234b70', 1, N'集聚区分局土地规划、土地征收、执法监察、信访', 0, NULL, N'9', N'1,4,7,8,9')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (52, N'jjqly', N'202cb962ac59075b964b07152d234b70', 1, N'集聚区土地利用', 0, NULL, N'9', N'2')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (53, N'jjqkg', N'202cb962ac59075b964b07152d234b70', 1, N'集聚区矿产管理、不动产', 0, NULL, N'9', N'5,6')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (54, N'ptsgh', N'202cb962ac59075b964b07152d234b70', 1, N'普陀山分局账号1', 0, NULL, N'13', N'1,2,3,4,6,8')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (55, N'ptszf', N'202cb962ac59075b964b07152d234b70', 1, N'普陀山分局执法监察、信访', 0, NULL, N'13', N'7,9')
GO
INSERT [dbo].[user] ([ID], [Username], [Password], [Role], [Name], [Deleted], [LastLoginTime], [AreaIds], [FormIds]) VALUES (56, N'ptsbdc', N'202cb962ac59075b964b07152d234b70', 1, N'普陀山分局不动产', 0, NULL, N'13', N'5')
GO
SET IDENTITY_INSERT [dbo].[user] OFF
GO
SET IDENTITY_INSERT [dbo].[value_type] ON 
GO
INSERT [dbo].[value_type] ([ID], [Name], [Units], [Ratio]) VALUES (1, N'面积', N'亩,公顷', 1000)
GO
INSERT [dbo].[value_type] ([ID], [Name], [Units], [Ratio]) VALUES (3, N'件数', N'件', 0)
GO
INSERT [dbo].[value_type] ([ID], [Name], [Units], [Ratio]) VALUES (4, N'宗数', N'宗', 0)
GO
INSERT [dbo].[value_type] ([ID], [Name], [Units], [Ratio]) VALUES (5, N'费用', N'万元,亿元', 10000)
GO
INSERT [dbo].[value_type] ([ID], [Name], [Units], [Ratio]) VALUES (6, N'个数', N'个', 0)
GO
INSERT [dbo].[value_type] ([ID], [Name], [Units], [Ratio]) VALUES (7, N'人数', N'人', 0)
GO
INSERT [dbo].[value_type] ([ID], [Name], [Units], [Ratio]) VALUES (8, N'面积', N'㎡,万㎡', 10000)
GO
INSERT [dbo].[value_type] ([ID], [Name], [Units], [Ratio]) VALUES (9, N'批次', N'次', 0)
GO
INSERT [dbo].[value_type] ([ID], [Name], [Units], [Ratio]) VALUES (10, N'体积', N'立方米', 1000)
GO
INSERT [dbo].[value_type] ([ID], [Name], [Units], [Ratio]) VALUES (11, N'百分比', N'%', 0)
GO
SET IDENTITY_INSERT [dbo].[value_type] OFF
GO
ALTER TABLE [dbo].[dossier] ADD  CONSTRAINT [DF__dossier__Remark__00551192]  DEFAULT (NULL) FOR [Remark]
GO
ALTER TABLE [dbo].[form] ADD  CONSTRAINT [DF__form__ImportTemp__0519C6AF]  DEFAULT (NULL) FOR [ImportTemplate]
GO
ALTER TABLE [dbo].[form] ADD  CONSTRAINT [DF__form__ExportTemp__060DEAE8]  DEFAULT (NULL) FOR [ExportTemplate]
GO
ALTER TABLE [dbo].[form] ADD  DEFAULT ((0)) FOR [Disabled]
GO
ALTER TABLE [dbo].[node] ADD  CONSTRAINT [DF__node__Group__07F6335A]  DEFAULT (NULL) FOR [Group]
GO
ALTER TABLE [dbo].[user] ADD  CONSTRAINT [DF__user__Name__0EA330E9]  DEFAULT (NULL) FOR [Name]
GO
ALTER TABLE [dbo].[user] ADD  CONSTRAINT [DF__user__LastLoginT__0F975522]  DEFAULT (NULL) FOR [LastLoginTime]
GO
ALTER TABLE [dbo].[user] ADD  CONSTRAINT [DF__user__AreaIds__108B795B]  DEFAULT (NULL) FOR [AreaIds]
GO
ALTER TABLE [dbo].[user] ADD  CONSTRAINT [DF__user__FormIds__117F9D94]  DEFAULT (NULL) FOR [FormIds]
GO
