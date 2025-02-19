Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazhn15013061.outbound.protection.outlook.com [52.102.133.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79C285C5E
	for <gfs2@lists.linux.dev>; Wed, 19 Feb 2025 15:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.133.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739978523; cv=fail; b=gcApUOq1q8/9r/8cZz14DsuKh6BmjnLtn1AuXGTsGg8ngH3f1MjxFUaP1Dr+M/Ooyej49ztfUqPti8IaYPW/rOAzWn+jGh6aya9a3qw5QxwZ60jCXo45R4gwJ7AmavyZ/9C6mb5NIxWIXQ7TlXyLvAwoQU2WdnS6gR8mPEPngvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739978523; c=relaxed/simple;
	bh=yOkcMfFEo4WT55yYaLwOyZh97Bo7BykTkkKCGYHNzTM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZW6geiI4Us/pS8V0GYvOdX0GrhYUljLv2uVwPk16uqHd12DqAFMSwrrHfI5IaxjvdsEQB3Nj2jQpFaqtHW7/IgrdVUKqYpblgwjFUDrzznZs22M8p6EWq3iWflZTXmAHOjqwFNoLqM3k8l1Go2TGTOrMuvO12ZhwnfW3vy0Fsn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=cloud.com; spf=pass smtp.mailfrom=citrix.onmicrosoft.com; dkim=pass (1024-bit key) header.d=citrix.onmicrosoft.com header.i=@citrix.onmicrosoft.com header.b=HH5jgk+N; arc=fail smtp.client-ip=52.102.133.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=cloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.onmicrosoft.com header.i=@citrix.onmicrosoft.com header.b="HH5jgk+N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rNP4vstWXXITrUlouc30RW8UGPaXRWLGhFREV3tZFc6FMQP/PwBO3DIiZtxi6jKSQhkBYKjjb2hQzg7YwEtQTSAAXFLBLzcb5ZVYkxWwVYqSU2sXRL/MUZY5FcUW1j9a93gYo17OKAu4NQSfkDXGyBba0vUtkPd6OLHPyk4iVnRyx7U0By3vGrl+eF1k7xEZnJJjRq/qukvyAFa1cKjcVehoxqoCpls/vR1ENlDRt4c44cdSo0OYD7hi9aX6B8texsz/o1vYSqFs5AOm+h1TsK1enqM3n89A9ackCnLo6SVh/vkHBvTLGAYZ+pIgJzYqUtEneCOc6Gj9fAH8gFjshA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUnzs4sATVeIENknJp/2ssTBwZznsFgq3fejZPeiEWI=;
 b=yr7RfBgA8fNUEZrunhOArLTn0Ul2edHfpuhjRHH2q7kdZfj8UiNnWx3dHpkr9aE1jtbcgTQbrQaIod75IVs0zjTnSNCxzQKeZl314YLAzh89lPZvySQsf8vTE4LYo+2IiZzEkYLuSLjhdfVE/PYAFwBfjPG9ISG+lO6l2r/L4oAVNmie4VlWycfnXBiUDlLtflg2VfgyNXq/tnMm9NdKoSVtFEJZzCJcJC3FZ4h+/8Cp/MeEofWc3mAqhABKfKW3h2mfckQSnvErwNA/jlZ1LpffOjiasLWk79RSlTodmhg4ZEkk+gQvR3pzIPkykhRUaQNmYPrFrd2Q3IxM9iLqtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 34.150.242.106) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=cloud.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject header.from=cloud.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUnzs4sATVeIENknJp/2ssTBwZznsFgq3fejZPeiEWI=;
 b=HH5jgk+NvrKwGMcvLFCGJdHuTc9pBItLAN+shs13BuT7ECOyCJ2jNoOsn1XGnlTIQ3NCUFjPCDPQPlsKVbJuV9AogAAPb9B8ymY5e4oOC3ae92JFvORJv2zNvvxz4ysEv5xXOEDqiyH98WBAA8vVWYoVx9/9h/d0FI39YJbFt3Q=
Received: from SJ0PR05CA0008.namprd05.prod.outlook.com (2603:10b6:a03:33b::13)
 by SJ0PR03MB6440.namprd03.prod.outlook.com (2603:10b6:a03:397::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 15:21:55 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::d3) by SJ0PR05CA0008.outlook.office365.com
 (2603:10b6:a03:33b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.13 via Frontend Transport; Wed,
 19 Feb 2025 15:21:55 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 34.150.242.106) smtp.mailfrom=cloud.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=cloud.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cloud.com discourages use of 34.150.242.106 as permitted sender)
Received: from mail.citrix.com (34.150.242.106) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Wed, 19 Feb 2025 15:21:55 +0000
Received: from guepitiexch02.citrite.net (10.240.48.56) by
 guepitiexch02.citrite.net (10.240.48.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 19 Feb 2025 15:21:53 +0000
Received: from mewpvdipd1010.corp.cloud.com (10.113.40.31) by
 smtprelay.citrix.com (10.240.48.56) with Microsoft SMTP Server id
 15.2.1258.12 via Frontend Transport; Wed, 19 Feb 2025 15:21:53 +0000
From: Mark Syms <mark.syms@cloud.com>
To: <gfs2@lists.linux.dev>
CC: Mark Syms <mark.syms@cloud.com>
Subject: [PATCH] gfs2_grow: Optionally allow not issuing discard requests
Date: Wed, 19 Feb 2025 15:21:49 +0000
Message-ID: <20250219152149.350838-1-mark.syms@cloud.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|SJ0PR03MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: 92f97d4b-c5ef-4b17-78ba-08dd50f924f7
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|35950700016|61400799027|82310400026|48200799018|38500700025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5qeGiY8ljkspWJT+5BHU+7L7HoMwRPyHv/xyXTXkzR1mWPMBTcKMXVz6MDEv?=
 =?us-ascii?Q?Z3sTFrrZKvaHastcIdekCxHJcPnZAhali3mgSAGDKj6UMF7cZUjymepNYuzU?=
 =?us-ascii?Q?RL/mYp4kWmIy1QV4k8MTQ9E4at/I+P9RqZOcYiXMm3yHBmtHA0CuxqljgJ0c?=
 =?us-ascii?Q?06+DDy3/O/ChLZKp/VH3vlVwvPEdM9pnAzauu5PuA6JQs1M6VN386NeuyJ1Y?=
 =?us-ascii?Q?3kLTPurPiwCdtFT8BwKHyLMPX8OiWedhDuDZGR3+I/s5tNqtxM0IWlm8QJ5q?=
 =?us-ascii?Q?TIrbG2Y2OJIjEB+yz15OxT5B7ncn9F+3hsmBC2UbH4PWh3WPayotsal+ssgQ?=
 =?us-ascii?Q?+Q8QkxnDzunu7MamWCe+k//fStUcYN1fOP1VUdYRZmeXUnWRx2l407E7fIr7?=
 =?us-ascii?Q?x5TqlrChJKcQluaFk0/c1s31mPn2fnxTE5yD/Rey2oV0sVPHVR8+XZgEBcZ7?=
 =?us-ascii?Q?1oDkX+6rmCI+D16hYQ++b67HanvbYvVob3eLr54z1x3/8iYrFmDmro8Ow4Z7?=
 =?us-ascii?Q?hVuGscQffPChe+wQmmsqxmZOc9tSGGyRVfs72DKzNnCXsOkj0OTPFsRwYKwX?=
 =?us-ascii?Q?Fdj4Xqvt23FQv1xGYAQ0EvdPdq8IPWfB3eFMkxi0x2rANwimTEvZl5WIFm98?=
 =?us-ascii?Q?XG7klCVkI6qFv6/04fL8smCnpcF0wDWRM3UrX+5/CjJ9KNSupEYxdJv8a5+8?=
 =?us-ascii?Q?DgDh8oZQNESQhRcrJQsQDrVu0HfpAHU1nzSVH+2SZIdReikrCOAiR3NM3L9c?=
 =?us-ascii?Q?rbCd+MkqEUnaoV2/0nikYiHP6G6THhx0YhCt1xjId2UMTsYnjlUp36/auoip?=
 =?us-ascii?Q?moh2BbDUK6Nug2tGrYo1NpL3YJxH/jkD+8qGU7R+qk5nuSGo0AWZ1yg1TLn1?=
 =?us-ascii?Q?ljiEdlMCYq0937LxvlhW3pNTOym8P9r/CL3mW0yZfa664fvONfAyUFO9VkPP?=
 =?us-ascii?Q?+nV7NlFwjtQwYXzj6dYbVyGAZ39DzrzeBV0l6jDgj+iBx6NF99BmDgQaUUg2?=
 =?us-ascii?Q?wuQPJIxMHDVmHk4XucSmGyC06YGX/bTDZVehrmtG1gJ+A8RRiZpTnZQYYjyp?=
 =?us-ascii?Q?4VMGZwFTdQtUShXFJW7aDCGVm/bzeOc/p6PVRCjzq3wfMUwHscKruIRViDAa?=
 =?us-ascii?Q?7FOIhAr7IZGm2ExTQ8ilT/rHGwGBoKn65hcaoKubfxF21MRQqDJd0U1JEjWM?=
 =?us-ascii?Q?VJZZgutHQnVhY8JeHiCDZcvzP0OoFDBvaDPhY2udcmNGOdFw5KKmlapUgLo1?=
 =?us-ascii?Q?ZqvB/mF9R+F6IJUSA4q6D3VmScXDBZw/QFdTG3P+DpFzoeTTBoI1ap2xV62K?=
 =?us-ascii?Q?HtiNzUa4QpdvZgH9KcBSBFLGRK3ZiwAFqv7yqwVMeqjhXlPc2pbaHKbHDzkB?=
 =?us-ascii?Q?g+Nd8nL+qzbVsWkdErzvIJAxH1wcr3IIiF7hNWnY0rj293t8tcJ9c5aubG91?=
 =?us-ascii?Q?BGYf7y02o10=3D?=
X-Forefront-Antispam-Report:
	CIP:34.150.242.106;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.citrix.com;PTR:106.242.150.34.bc.googleusercontent.com;CAT:NONE;SFS:(13230040)(376014)(35950700016)(61400799027)(82310400026)(48200799018)(38500700025);DIR:OUT;SFP:1501;
X-OriginatorOrg: citrix.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 15:21:55.2192
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f97d4b-c5ef-4b17-78ba-08dd50f924f7
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=335836de-42ef-43a2-b145-348c2ee9ca5b;Ip=[34.150.242.106];Helo=[mail.citrix.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6440

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

