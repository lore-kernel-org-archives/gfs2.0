Received: from SJ2PR03CU002.outbound.protection.outlook.com (mail-westusazhn15013015.outbound.protection.outlook.com [52.102.128.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022DF1FDA9D
	for <gfs2@lists.linux.dev>; Wed, 19 Feb 2025 16:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.128.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739982209; cv=fail; b=P6WiHshsEEgtPkK8V3E6C/e1LqGu2H12iTowTUP9KtfKMSu2e8PggTrYT1ZVOcCQOT32FfHmp677JY5HcfgFblyDDuNn3QgwhrVvssjHn8nOq5gxWuOwIuBkkr5z+NUzQbV9NPp0CNVfazepNmQvRITFd8vvLeIBA3soLSLqdOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739982209; c=relaxed/simple;
	bh=mE8m6+0rAKazFNLGfWGsVpPACQA62UHTSNGuVsTjI/Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DGjvu7T2pm5R2FX7W5sdw3eDZuMdwttkXwIngNT5ev8KsK69lxTEyRQ+BWSvPv80gwEFpaZ3jrTg3MJNqPxKgeZN28pKse1DgLd4OifLNvQuCoeesgoysuP4hBarWfTdV93DEvQzZJa0p/46jG6SkDV0ubK5XB84hCV655jwRKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=cloud.com; spf=pass smtp.mailfrom=citrix.onmicrosoft.com; dkim=pass (1024-bit key) header.d=citrix.onmicrosoft.com header.i=@citrix.onmicrosoft.com header.b=pb3o4cs+; arc=fail smtp.client-ip=52.102.128.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=cloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.onmicrosoft.com header.i=@citrix.onmicrosoft.com header.b="pb3o4cs+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eaLLqW3qdLPlofjVlf/YyXa1gqpTY0BGFido9LkpM0a7WVRVW7THXIAh0EylFCWAMg41RclnjnNoCta8TX1p1X9JMHVrCdMhqKF0YVILWvO2EIyt1ul9uO4E599vn51kMf2TGWY/XzGNkhzXgLhpuf1Gr3EQl1C7GFlGHpb84CCL5EDng3GeVgPv2L6Daihf8wV9LpBX3f6H6qD3V++H/YDq2oPdju8m8z3fM0UaGO4KxNkPrsC/0DKg/k4NdiQu1EEASa0Cns3oAymgoVufbvmezDPRpBt7pnFoH+7PmPJyeZkmvQ1W+B9qNDiDW54de5f3dmYKwPqbVxoJqVpqrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=de/In33iiBRX7PL+UayubXz9B/cMiLuYrzmzyl2uMDY=;
 b=xk9zB++/YsZ4damYOfvn9jRLbzUg443bvCXrt88pcS3bTUAxsbnm6qZaK2OIhUTmLsqyQC7T2AUndmctaLpDy2LOHq7k0qbEvk08dlp5jzfK9SAgLaJo7K5FBA5+BgoWTjJuC5BzNuwNWSP0a+ofGXVtc+3wle5hGrGpM6ALC4xdsF4fGuCykVffbIwP8+ZXNpGJ/6iYtCIaL1rVyxwk4dlT0XUlLH828V0QUJvh5uPft0cUdqyt2WrkBFIrf0uN3HCI+8ohvGlwrwLj6FORsEGVWlih+hFwH2GQMLJgGz+TGAkvPVtx74ehsHxFLsNuTN/T7DSMBBUw1J0+QRCUag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 34.145.164.155) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=cloud.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject header.from=cloud.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=de/In33iiBRX7PL+UayubXz9B/cMiLuYrzmzyl2uMDY=;
 b=pb3o4cs+eZagVgbZWXEkfz0Cvz4TgSOKJqYnmPALhjVecUoZn5BWozYX43rpMEWom32NXk8ABGcv/XKxH+3npLRCJ59JZbjDkNoijXnCieZ0eS/CQayUFXA3GQGVz+AfBfq++gPPhnKON6Cn5soLA1apbBpUrngCgrKsN+74boU=
Received: from PH7PR17CA0008.namprd17.prod.outlook.com (2603:10b6:510:324::8)
 by CH4PR03MB7602.namprd03.prod.outlook.com (2603:10b6:610:236::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 16:23:24 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:510:324:cafe::5b) by PH7PR17CA0008.outlook.office365.com
 (2603:10b6:510:324::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Wed,
 19 Feb 2025 16:23:24 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 34.145.164.155) smtp.mailfrom=cloud.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=cloud.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cloud.com discourages use of 34.145.164.155 as permitted sender)
Received: from mail.citrix.com (34.145.164.155) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Wed, 19 Feb 2025 16:23:24 +0000
Received: from guepitiexch02.citrite.net (10.240.48.56) by
 guepitiexch02.citrite.net (10.240.48.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 19 Feb 2025 16:23:22 +0000
Received: from mewpvdipd1010.corp.cloud.com (10.113.40.31) by
 smtprelay.citrix.com (10.240.48.56) with Microsoft SMTP Server id
 15.2.1258.12 via Frontend Transport; Wed, 19 Feb 2025 16:23:21 +0000
From: Mark Syms <mark.syms@cloud.com>
To: <gfs2@lists.linux.dev>
CC: Mark Syms <mark.syms@cloud.com>
Subject: [PATCH v3] gfs2_grow: Optionally allow not issuing discard requests
Date: Wed, 19 Feb 2025 16:23:15 +0000
Message-ID: <20250219162315.377253-1-mark.syms@cloud.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|CH4PR03MB7602:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fcc8287-8301-4149-0aac-08dd5101bbb9
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|82310400026|48200799018|35950700016|376014|38500700025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eMpGS590OjLXfG3J0wxUNAqBHvY9XfuBcT4Q9M2ioKpTPGGKkItFjyyT5OMS?=
 =?us-ascii?Q?wbem4OFg2wpzL/YUlr5O4Z8S0rlXV3OI82Bn+qY1z323+5IzXEDxjqt/m2bn?=
 =?us-ascii?Q?m4kWMSrAgrrCGdkmJCCufE7LMxX9zfYpQtUEAohxFY+SrZ6P+AGDS7ayYSxX?=
 =?us-ascii?Q?l2yQSwYCJjH5kkqtUNaU2RuUYkNX9qV26jXGWRTzllOirV7hnETFFqSSo1F6?=
 =?us-ascii?Q?ehDj4XY5YyDo2ydhFMWYm9ULr3aVJ02v3SEe6gVWmmXGCeHo30Hxg61AAeNt?=
 =?us-ascii?Q?U/bdC1oxFMxt05f5Wznz11G4bG9Ur17E2vZZ5mZG7N10Ckkw9Fm/5nDDHtQ9?=
 =?us-ascii?Q?lXvF4ktgG/wA+EdK4O3fULVLPtc6dfhAt5sR7yahiUL3w8ZSwzZJ9/7OqKtT?=
 =?us-ascii?Q?WrdkGuBMGbC01QI5QlMfFzkCP2EzvjOQ55VTLMOtrywdUpmW7rVpbIXsjAFr?=
 =?us-ascii?Q?QJFqBk+w/gtL9hnEJhd0RQRQsj2NA1E6CNFj2jHgM5se0vk2kCSpFXgh7zgA?=
 =?us-ascii?Q?eQ85YVAh/grtDG3LZmjIugvFSEeJtA5VHXzsmJtmMV3mhPQIPqwpVcymQFIp?=
 =?us-ascii?Q?uFrJ0Q5hMKU1FxW37+WWGb9MQMr8IIyWvtTWCFRN0oP0jsrmgbH1hjgqSMb6?=
 =?us-ascii?Q?fpN3YIHdAMORjXveMXV2E1jtJnJ9ztiuzjeSM4OOq8Iicu+7Ibb90/ZYAgYk?=
 =?us-ascii?Q?Ed+yRwVO4SPIU1drNfHOoGh8gMf3dTpdWfdIFGQYqwt+ckdyqp5F6Nqatzrp?=
 =?us-ascii?Q?Pof5RyDJxd0noRGbUyDa11Y8F1EoEeypvMww0UYtY9npFpSk0LKnXZxk2eU5?=
 =?us-ascii?Q?+sAYjNm3uqEhzXyv2bVo9sSQ7xfanPmwpzLl4xMceIkK5ith5cp7xw1KCycF?=
 =?us-ascii?Q?SpVC7Q4uI7dhZdTcSbuwtm2uP8wz1lSScgOFtDmAMFSue5J+qsPcQHxiFp+Z?=
 =?us-ascii?Q?wj/+BSxrbjM/NRUEwrGtqIq6ZRustsHPqVgkdq6iRkEaD6wRrkdogvobVoIZ?=
 =?us-ascii?Q?07XVwqSLscg04yEmJhCExsJ4gNEtrHFgCopN+cB2HLZW0PaRKYcTlLimZ/pk?=
 =?us-ascii?Q?1QRd38eJ/1ufCvrxZzCBoJaWtrD4wRV5KpZAFwzCCDi/jwLUR7vAT4grZFKn?=
 =?us-ascii?Q?kgegffBshgBO+lL9Y+/tZ3REklccN8jCJ7ZNj7LjrD/OZOWhjkFTv87GcAeI?=
 =?us-ascii?Q?AXM/ksKk0bcTITNcIe8NOaVLISftuvMj8hw+/uyeWdoSYi7DnlT6ECIa4tiT?=
 =?us-ascii?Q?qy0chiz65wMRt95b2JCynLnYrl9r83HT/+MIanhAV56C9+XpYLgUWoE4z8PX?=
 =?us-ascii?Q?viPS6Mnp4xIWeciyMjbjKIP+/SpRsOPuHzmw3rUiBJ3rRc+VGjtZR4T9e6Ul?=
 =?us-ascii?Q?u6QtIUXNZceu0819Af1uotWIOIx/qVCHqd6ITGjBfXPjzLqnzJF6PYqyVBbV?=
 =?us-ascii?Q?rXtv23470Ys=3D?=
X-Forefront-Antispam-Report:
	CIP:34.145.164.155;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.citrix.com;PTR:155.164.145.34.bc.googleusercontent.com;CAT:NONE;SFS:(13230040)(61400799027)(82310400026)(48200799018)(35950700016)(376014)(38500700025);DIR:OUT;SFP:1501;
X-OriginatorOrg: citrix.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 16:23:24.1824
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fcc8287-8301-4149-0aac-08dd5101bbb9
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=335836de-42ef-43a2-b145-348c2ee9ca5b;Ip=[34.145.164.155];Helo=[mail.citrix.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB7602

mkfs.gfs2 supports a -K option which disables issuing discard requests
for unused blocks on the LUN. gfs2_grow does not have an equivalent
option so even if the filesystem was originally created with the -K
option a subsequent grow operation will incur the, potentially high,
cost of performing the discard.

Signed-off-by: Mark Syms <mark.syms@cloud.com>

---
v2:
 * Fix indentation of break statement
v3:
 * Update man page with the new option
---
 gfs2/man/gfs2_grow.8  |  6 ++++++
 gfs2/mkfs/main_grow.c | 11 +++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/gfs2/man/gfs2_grow.8 b/gfs2/man/gfs2_grow.8
index f1ba5e4e..ed962dca 100644
--- a/gfs2/man/gfs2_grow.8
+++ b/gfs2/man/gfs2_grow.8
@@ -38,6 +38,12 @@ Prints out a short usage message and exits.
 \fB-q\fP
 Be quiet.  Don't print anything.
 .TP
+\fB-K\fP
+Do not attempt to discard the block device contents. Issuing discards to the
+device allows some solid state devices and sparse or thin-provisioned storage
+devices to optimise free space. Other devices may emulate this behaviour by
+zeroing the device contents, which can be a slow process.
+.TP
 \fB-T\fP
 Test. Do all calculations, but do not write any data to the disk and do not
 expand the filesystem. This is used to discover what the tool would have done
diff --git a/gfs2/mkfs/main_grow.c b/gfs2/mkfs/main_grow.c
index e378a668..2d74c3fa 100644
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
+			break;
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

