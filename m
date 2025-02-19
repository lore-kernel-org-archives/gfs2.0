Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azhn15011022.outbound.protection.outlook.com [52.102.138.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F340385C5E
	for <gfs2@lists.linux.dev>; Wed, 19 Feb 2025 15:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.138.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739978481; cv=fail; b=obedqRaDEu2uRS8qsnhksw0YDjdKyLwB0h+eDsUdeLwULZN9zLbIKNgVfWeGjobQ22Ov94a8F6jrKpnOf3ajL0nVxiGA4WcdAsGavfo+bJUklQoPRSEs3pN2GOe87/EP8IHHYb4PKemZjlvvbdauKz8aR9ZEoFSHmdIlkJE9m3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739978481; c=relaxed/simple;
	bh=yOkcMfFEo4WT55yYaLwOyZh97Bo7BykTkkKCGYHNzTM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BatR3JpQex7P0W/hSpk9t/edXDUW0Qtpv+zhz6qYkzUhBAloQkCzj/5AdOaH714iCVrq6fkuDhQ9SXEWdzKxAzgAysTxcYjlWY00WMZMjtxT7IK7SPDiHn1bNHHFhNf9wCiDTv7+1D2qzu9ggQrB7RvfizH/reZNSrvUEDTXiYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=cloud.com; spf=pass smtp.mailfrom=citrix.onmicrosoft.com; dkim=pass (1024-bit key) header.d=citrix.onmicrosoft.com header.i=@citrix.onmicrosoft.com header.b=GpMWrvxL; arc=fail smtp.client-ip=52.102.138.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=cloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.onmicrosoft.com header.i=@citrix.onmicrosoft.com header.b="GpMWrvxL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vaY+b/AUtiI7D7eZAipthJsQ6Mwh5tnh2RWCM/75pjx4d6HK5MG3NXKbtUq2hN+11dUUp3kBzlJeZVjOkek+aH0ytYYT/dGCGvgA5m+0o/7pCq6pBdbnbqb0i5u7hCJxFclHUgj9AzPWeoXaZpJzX2UiLUGyNa88mqhGaGp626pvXzsJQal+iWMb179Ei6G+fpPxh2g5BgNkpNGhJqTmS0h/SdBKvN41ufrL3w4V9snE6jr0+uQzLWwnY1eADD8RQKZcmn+dwGDGpoZQ+Sue5/IdA7iiL9JZWTQAHmmBzBTIURdhm7rb4Maqx2Z0RcwSGhWQZjCcVAN9Wr8faRwCng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUnzs4sATVeIENknJp/2ssTBwZznsFgq3fejZPeiEWI=;
 b=RLHtl+etndISqDn9CFKZQIcpiiP0OrD39rLHUN8MvCZZTUwnqF3T7hVO+cGCAdqZqsHDMn2uV7efg1yy8sWp219Afo4j7u3FIUYxKAl4RtHaNEdx9LUx8CK7iv5D0guiaYO9L4faIuzImobhUV7+tLQNmCFil5zgsZsLvaDNwaIxT3kRx7IF5k6j+dPI65hV4CUcGWhZBJm86eh2qeMFN8cdVzv0TMW3BxSfN787Qp3+mcqKDI34mK3UG40YU4j9hwwH1eV/EdGh5DCk212tNEvF9UBr/qI4jKbwkp4itVbpVcNgpB/Hhp94iVvlo7JSbDJE016X1eYyCr8qgFIJLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 34.145.164.155) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=cloud.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject header.from=cloud.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUnzs4sATVeIENknJp/2ssTBwZznsFgq3fejZPeiEWI=;
 b=GpMWrvxL94zb2xkV1tFO14Omk4MZIN4Tdwaaxxb7pqcPe6pzKuARWWix4Yt+JvKckKtrrxRPHTGg0Za8ZoWCwoDUirtyssUskkyQtpWRtTVOS1wIFCWh1Xd9w9WM7hN7LPbPbvNo4YV2b7wQKEc437dp2Krxt3sLEDu4XPT689Y=
Received: from MW4PR04CA0387.namprd04.prod.outlook.com (2603:10b6:303:81::32)
 by DS0PR03MB7202.namprd03.prod.outlook.com (2603:10b6:8:121::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 15:21:07 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::fc) by MW4PR04CA0387.outlook.office365.com
 (2603:10b6:303:81::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.16 via Frontend Transport; Wed,
 19 Feb 2025 15:21:07 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 34.145.164.155) smtp.mailfrom=cloud.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=cloud.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cloud.com discourages use of 34.145.164.155 as permitted sender)
Received: from mail.citrix.com (34.145.164.155) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Wed, 19 Feb 2025 15:21:07 +0000
Received: from guepitiexch02.citrite.net (10.240.48.56) by
 guepitiexch02.citrite.net (10.240.48.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 19 Feb 2025 15:21:05 +0000
Received: from mewpvdipd1010.corp.cloud.com (10.113.40.31) by
 smtprelay.citrix.com (10.240.48.56) with Microsoft SMTP Server id
 15.2.1258.12 via Frontend Transport; Wed, 19 Feb 2025 15:21:04 +0000
From: Mark Syms <mark.syms@cloud.com>
To: <gfs2@lists.linux.dev>
CC: Mark Syms <mark.syms@cloud.com>
Subject: [PATCH] gfs2_grow: Optionally allow not issuing discard requests
Date: Wed, 19 Feb 2025 15:20:46 +0000
Message-ID: <20250219152046.350786-1-mark.syms@cloud.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|DS0PR03MB7202:EE_
X-MS-Office365-Filtering-Correlation-Id: b481953b-a6f6-4aec-8f05-08dd50f90875
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35950700016|376014|61400799027|82310400026|48200799018|38500700025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ApAlE2Riv9DO5muo5odKUiS8d3Rxr/nd776mDJva+mXsH24RQqqZQcULL7f6?=
 =?us-ascii?Q?LhL02o8AwxQtc4eg0fCQOZ2scnfcGCtgbDnmb82rUiFWsjmlfQ0Zga0BVHDY?=
 =?us-ascii?Q?wxpgqN+C36DXFVjFQlC08kl/ZoHSZrnDnXDAIBjgvSo8r+fcwt0s9imMuPx9?=
 =?us-ascii?Q?I+8LURBUlPeW0mGWEWorWnCl7qxHi9ydBOwZGKGZUXiTZERCTtmlgl7kt5VY?=
 =?us-ascii?Q?uE+Dxf/LIBhrFW2ytXZ9Bfzr6pontMn+WZoI06lNUh/4lsTIF4dt78IcCR5V?=
 =?us-ascii?Q?/2eBfEnt/7wBoaTmAMNRRcJbw16lI/BDUobc5dvOn7ZJ7HxsOIsRlufX1kO5?=
 =?us-ascii?Q?7VSPnI4y549a0UPB1HJLD1fuRxD+UMsiJhWNcNFI9fZvQalACUiwtetyyv+R?=
 =?us-ascii?Q?jmCc2ANp5POkOB3xDeaE3DCROR/OQomayr3hbz9craV2ZCVxdh6T743QiYBk?=
 =?us-ascii?Q?kq7iMjs1XanNk+LPjFK5sawezM81W2wC+fhwSEoP+K6Jacy2ChX5uCoTAF28?=
 =?us-ascii?Q?eNSoSobA4T7BL36YSGqL2l/d0Wr8dwJxmG4m7rcv4m1iHMxBY+pz8y1MwhTp?=
 =?us-ascii?Q?zMsWgJYy/pPVcMN4xhVkZty+eZoqFWeFJDX4K6kU6BsNnrmOt4UDiLJ+zqDA?=
 =?us-ascii?Q?a1rjXgelgc4Km1ALXYWdPhmCkVSdR+6GzGLhQqiU3edcCoqUrAyKTDPSoLR0?=
 =?us-ascii?Q?TBEKyTy+5wQTRZYnfpZmTTaS1ps3bIY9igQdTZpNrDVnF7dHj7N2pvHXRN0v?=
 =?us-ascii?Q?sg2cX2q5ufeJyo0Dh2fi2Q4nLd5+hd/IXF74KMJsMimJ9kJSoZves6RcEPxu?=
 =?us-ascii?Q?ngafn64eihQ7C/08jftGp/yA9y9PsqG4ReyG4g6rsdw+0MmL2BUWCUN/8o97?=
 =?us-ascii?Q?soCyI7oVzvz2GDGuQUgic7gqhjF5wcyU1cI139rlJnT8jPPPKFmZiTSif8Yl?=
 =?us-ascii?Q?zHhyZI59ixzrEaqJ8DxNiebJs+GbRqlH50bUwzg2rSkvbxZaZDrMIX3GJBK3?=
 =?us-ascii?Q?3ztCQKuaKqmn7sjrgsU7xzvEOgaxNBLcqjTEOZftwgYbklSw61jtHbbUcfKb?=
 =?us-ascii?Q?qXeL7ieg2YCYBlNTYNPrLW7gc9iVgCEuTltk0xMdMSvrjUQO0xd5iYtaxUkG?=
 =?us-ascii?Q?t/qOa0B9KBbcdisD6t6c4m8fQTKM/iJWXrSYspMEWpwuOBHApZl/huKEPdUF?=
 =?us-ascii?Q?mORDnUAd3tp1P0lHtw4xl/eBlVqpon57eDAOPe8OAvjiPDuDgRgoUyfqsEMv?=
 =?us-ascii?Q?kdrdvfl6/fTE6sVm8TseRBs7dWzoMrGjiSUp1wFcRJVIkX435umhjTcsQGiG?=
 =?us-ascii?Q?h2VzwB5abi87FWpd7+spzOL2JucOJge9VWuv/Boyx8acTt+Ad5Jnb4p5fg7A?=
 =?us-ascii?Q?spHQRFYawvIRI4tK+bf3wFBuBxV+HuK3NnryDV+cDYepkVSDcXwo08uZv2WQ?=
 =?us-ascii?Q?/v+AzNZ9gG0=3D?=
X-Forefront-Antispam-Report:
	CIP:34.145.164.155;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.citrix.com;PTR:155.164.145.34.bc.googleusercontent.com;CAT:NONE;SFS:(13230040)(35950700016)(376014)(61400799027)(82310400026)(48200799018)(38500700025);DIR:OUT;SFP:1501;
X-OriginatorOrg: citrix.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 15:21:07.4073
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b481953b-a6f6-4aec-8f05-08dd50f90875
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=335836de-42ef-43a2-b145-348c2ee9ca5b;Ip=[34.145.164.155];Helo=[mail.citrix.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7202

mkfs.gfs2 supports a -K option which disables issuing discard requests
for unused blocks on the LUN. gfs2_grow does not have an equivalent
option so even if the filesystem was originally created with the -K
option a subsequent grow operation will incur the, potentially high,
cost of performing the discard.

Signed-off-by: Mark Syms <mark.syms@cloud.com>
---
 gfs2/mkfs/main_grow.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/gfs2/mkfs/main_grow.c b/gfs2/mkfs/main_grow.c
index e378a668..d2052604 100644
--- a/gfs2/mkfs/main_grow.c
+++ b/gfs2/mkfs/main_grow.c
@@ -31,6 +31,7 @@
 static uint64_t override_device_size = 0;
 static int test = 0;
 static uint64_t fssize = 0, fsgrowth;
+static int skip_discard = 0;
 int print_level = MSG_NOTICE;
 
 extern int create_new_inode(struct lgfs2_sbd *sdp);
@@ -72,6 +73,7 @@ static void usage(void)
 		"-T", NULL, _("Do everything except update file system"),
 		"-V", NULL, _("Display version information"),
 		"-v", NULL, _("Increase verbosity"),
+		"-K", NULL, _("Don't try to discard unused blocks"),
 		NULL, NULL, NULL /* Must be kept at the end */
 	};
 
@@ -92,7 +94,7 @@ static void decode_arguments(int argc, char *argv[], struct lgfs2_sbd *sdp)
 {
 	int opt;
 
-	while ((opt = getopt(argc, argv, "VD:hqTv?")) != EOF) {
+	while ((opt = getopt(argc, argv, "VD:hqTv?K")) != EOF) {
 		switch (opt) {
 		case 'D':	/* This option is for testing only */
 			override_device_size = atoi(optarg);
@@ -116,6 +118,9 @@ static void decode_arguments(int argc, char *argv[], struct lgfs2_sbd *sdp)
 		case 'v':
 			increase_verbosity();
 			break;
+		case 'K':
+			skip_discard = 1;
+            break;
 		case ':':
 		case '?':
 			/* Unknown flag */
@@ -207,7 +212,9 @@ static unsigned initialize_new_portion(struct lgfs2_sbd *sdp, lgfs2_rgrps_t rgs)
 	unsigned rgcount = 0;
 	uint64_t rgaddr = fssize;
 
-	discard_blocks(sdp->device_fd, rgaddr * sdp->sd_bsize, fsgrowth * sdp->sd_bsize);
+	if (skip_discard == 0)
+		discard_blocks(sdp->device_fd, rgaddr * sdp->sd_bsize, fsgrowth * sdp->sd_bsize);
+
 	/* Build the remaining resource groups */
 	while (1) {
 		int err = 0;
-- 
2.48.1

