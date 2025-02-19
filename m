Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazhn15012042.outbound.protection.outlook.com [52.102.146.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4301FBEB4
	for <gfs2@lists.linux.dev>; Wed, 19 Feb 2025 15:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.146.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739979425; cv=fail; b=XiZcjEaKjzDp54gceR85uIgw3Ckw4AzZfSbSI9+GY5GgN6EDBulR7+B1vNa1Yl6cS5JdIA0IEdZECgjHlyJyWDdl5lJFhajWsYUAcTdTYqQWEY1LmQFttL4EM5cXIa0kK77+jfNMTqAtFJxSjsks4R0T8DB2viZwvIgbYxPOBp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739979425; c=relaxed/simple;
	bh=vcxQiQrnOKzSKDnt6ZkzKUm82Ym2eQYkoMuo+eZbPPk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ej8y5iazw6Z2RnX/cWfrztKTfDJhEXTLG9Y30qjO4NPrfqaGx17Dk52mxYsESHBDM7j8EtMVHLcwMbIKOG24n4YoDR6whwE+Jj4Y8Men7sFI9EqibXZ4WytlKYPtu7yCag454Lno23NgpIPvnejsyqOrozpErY+J+OHGaYyV9PA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=cloud.com; spf=pass smtp.mailfrom=citrix.onmicrosoft.com; dkim=pass (1024-bit key) header.d=citrix.onmicrosoft.com header.i=@citrix.onmicrosoft.com header.b=vhM7vg6e; arc=fail smtp.client-ip=52.102.146.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=cloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.onmicrosoft.com header.i=@citrix.onmicrosoft.com header.b="vhM7vg6e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PnYICoWbfMRS0p0xP+AIItQB8LWP5ukBv3kNCDN3NVBhqO9CEQcHD6ahqbzcbRv+AJliz3Co2ljAb9G+h7MO2vF/nYC2Q30rzda6yqIswzR3438Oass5eT00eqekrbo/T8zfAmcm5DdljHzi87OXMQpReA+mRS3NfLwkEBdhFDM1WILjSnjAwHITfGFLcqcCuqFlJ7CP030olF9NZ/PVRak18g1czc9dX3764DJvCwNa4my6OFyBN9bUZR94mBcxpVrEr2LKIJE5MhFHsCHZmKMrSiT5gFyrhDhRZTZM/ByZe6AJjL/UCwwSa2wXMbfxW4xr1hssJ96W/LSQxlynAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGcsocXbGd5sMEyB7pFG73xLQTYs6sdvsMvM6KdlhYQ=;
 b=CFvhM71MmEWlx96TF1er2ScMIM2dliqBOXzwJgIdeGUTDVTZAy/nyHZoY0djyWfo2H3P13J25fQPe90gwTxFm72slU4T/xEdXvctTIWlqJUo+eKQzoFymi2QMKrx0tmXQ7LY6MomCj21t18f/KEYUQMRgY2nv43a6Jw4U8rr5KYPQR6fmIB7iydDkhesq1kcJhvH5VyoWPadIz0Aji625yXTFkhXJKTrBkTIPDCjIKMFKDe9fl4hPdJWbr4cCH12HPl9gRCc4rH5Ohf5y/vBZP8OP5KC3s6Hz4ylPNMT+16pupNcFd2vuTB2+TND7MSZ0vzU64qjvFAyLHiqwT30hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 34.150.242.106) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=cloud.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject header.from=cloud.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGcsocXbGd5sMEyB7pFG73xLQTYs6sdvsMvM6KdlhYQ=;
 b=vhM7vg6e2Vt23VEBbKrCfSWmL36Gk1Vrqy8qYAakasuocEkib3f0cZUs18FwIUkfX5BMyxE11rqJYcK5STePN5as/8MSGWHZdvwknZ03oeqM4Xq6kS0mJHC1UpmmOQLHPE4DrXV5ykfiwDw9MGm7BND1oA3YXBLnuVlac2yrvAU=
Received: from BN8PR07CA0016.namprd07.prod.outlook.com (2603:10b6:408:ac::29)
 by BY5PR03MB5268.namprd03.prod.outlook.com (2603:10b6:a03:219::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Wed, 19 Feb
 2025 15:36:59 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:408:ac:cafe::2a) by BN8PR07CA0016.outlook.office365.com
 (2603:10b6:408:ac::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Wed,
 19 Feb 2025 15:36:58 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 34.150.242.106) smtp.mailfrom=cloud.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=cloud.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cloud.com discourages use of 34.150.242.106 as permitted sender)
Received: from mail.citrix.com (34.150.242.106) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Wed, 19 Feb 2025 15:36:58 +0000
Received: from guepitiexch02.citrite.net (10.240.48.56) by
 guepitiexch02.citrite.net (10.240.48.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 19 Feb 2025 15:36:57 +0000
Received: from mewpvdipd1010.corp.cloud.com (10.113.40.31) by
 smtprelay.citrix.com (10.240.48.56) with Microsoft SMTP Server id
 15.2.1258.12 via Frontend Transport; Wed, 19 Feb 2025 15:36:57 +0000
From: Mark Syms <mark.syms@cloud.com>
To: <gfs2@lists.linux.dev>
CC: Mark Syms <mark.syms@cloud.com>
Subject: [PATCH v2] gfs2_grow: Optionally allow not issuing discard requests
Date: Wed, 19 Feb 2025 15:36:54 +0000
Message-ID: <20250219153654.351944-1-mark.syms@cloud.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|BY5PR03MB5268:EE_
X-MS-Office365-Filtering-Correlation-Id: c4007027-5588-462a-9595-08dd50fb3f80
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35950700016|376014|82310400026|48200799018|61400799027|38500700025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m/UjfXa2JTC/xVveLKRDh+Wv/+pHPWJMraw8PUKA82zNSDloz3kumvdzuovo?=
 =?us-ascii?Q?83QlO5OSYY64WB65TfRhou/7XyJW65PEkJqeyX0ACuwqmoDjtDEVov6PWoWZ?=
 =?us-ascii?Q?eBhXvO6EO69E1jjDmP2JK7eMIczUNoywehCy4+m2g9H7/WNEVtMOPn305gpr?=
 =?us-ascii?Q?RTMkUS8kePPzu/37kvsuHmpug6bUgfqOyYRLRvEO8WWE38v/DyCwa/n27rAz?=
 =?us-ascii?Q?YKeRWLKjDLLfEOz98BpWMmXYme0+f6ZXaqJD0SBbpvCoFnh+k8X+7Izy/g7d?=
 =?us-ascii?Q?W+AFwPmaltrBQeFkMp9XsmjqmRhvQnizj+HeXRWxuwvTgzIMyEeQF0WTRGsh?=
 =?us-ascii?Q?K/Y44sXDhLaDHb5+KM7KjCjuY6WVx41EbQ3h6m64q3Vj3ICcYBrFyQkOqkCO?=
 =?us-ascii?Q?VA/453RgpFGBHghP0feY19pXWuIW8MA7XRUZln9vqoYtv/Q6ij1lsfS32gUo?=
 =?us-ascii?Q?mfm/mRQKykiikFiVigfKIIujW5nLaVVzqTTjE9VMD8sivBCjKW8K/OzRpkac?=
 =?us-ascii?Q?AA3SP+s/eezhsQCTDFc8pKdfX7ucyQFSN4dL6efM+zJznTE45RUeTibHeyfC?=
 =?us-ascii?Q?/2rTWBIn/q9/ej8gnuFI/8tF+fzPrGttDIuK5Zx6UgRoV6qKjfGpIn/nw5iV?=
 =?us-ascii?Q?a/WwHwIXleHyIdOTvE46FvE4wzrJPpZQmYAXI2MtUXLsDoISUT8PFzwbj+7U?=
 =?us-ascii?Q?QAtSsMOpN2do+/s1CtuQDghOy9QYA/2t9zFk4/EnMGMWuZccW27BIet3k6ab?=
 =?us-ascii?Q?e4lm/IKbah9Q/gvScbJFszGecgbPyOnxD7GMDttsSAcAPKxtDQp5P543y5N5?=
 =?us-ascii?Q?WIJpmDyYk0ikY1WT+Re6f3D+MS8q3M6cmP5DEXucmCOXm+CofwaCfVGL0Dfn?=
 =?us-ascii?Q?WZSF18JzAXd1qvIopE9yFtW7R0J+UdJa6iaJ1VvL3APsSeMolbfnGPHq2kkQ?=
 =?us-ascii?Q?+BKj/fbQAAB3yVHn0p0HDy2FrTsLWzcAWQfdEXfH4RbFQSAE7QmsBxPG9DGD?=
 =?us-ascii?Q?WpF0edYgujNzlSD+g0HVQBZU92kvqHkO3HDT2HG5pyWeelCSA+8LroJsGSfe?=
 =?us-ascii?Q?Wajn7qBMIkJnmGRJBqjWYski3NbSuWnlcmR0s2KMS0g0jkH4xEGcYHVtgKwp?=
 =?us-ascii?Q?eMRTXtDRj9/VnF/OUXmkLOznLAeSmX37u9Ca2+sDOQM4i9gv1FbHvvH9SN9h?=
 =?us-ascii?Q?Mb56GGlDDEVGGTS/Nw9X0Rra6EfrrSVwuzG9cEqx5ml2easbR++DYxBFzWtn?=
 =?us-ascii?Q?2qEa5GxrSbqSQoAV50+o4QYOwn/2eOezdI6PD+xProvvYIGm0BmYPqPU4cEd?=
 =?us-ascii?Q?rDxh74jurYJBdUVlZTsFYarPeCyzUlak94RJUfaFL8hHfxnHbEjcOPJXDpV8?=
 =?us-ascii?Q?AKpgUu2PJiSByBwq4wSAAZ1nChPgAPbIoXCdI36aX4bjyiMTbORJaayKRAV2?=
 =?us-ascii?Q?+fMQP5AkNgM=3D?=
X-Forefront-Antispam-Report:
	CIP:34.150.242.106;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.citrix.com;PTR:106.242.150.34.bc.googleusercontent.com;CAT:NONE;SFS:(13230040)(35950700016)(376014)(82310400026)(48200799018)(61400799027)(38500700025);DIR:OUT;SFP:1501;
X-OriginatorOrg: citrix.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 15:36:58.8727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4007027-5588-462a-9595-08dd50fb3f80
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=335836de-42ef-43a2-b145-348c2ee9ca5b;Ip=[34.150.242.106];Helo=[mail.citrix.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5268

mkfs.gfs2 supports a -K option which disables issuing discard requests
for unused blocks on the LUN. gfs2_grow does not have an equivalent
option so even if the filesystem was originally created with the -K
option a subsequent grow operation will incur the, potentially high,
cost of performing the discard.

Signed-off-by: Mark Syms <mark.syms@cloud.com>

---
v2:
 * Fix indentation of break statement
---
 gfs2/mkfs/main_grow.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

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

