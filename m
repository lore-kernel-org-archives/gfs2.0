Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10hn2238.outbound.protection.outlook.com [52.100.156.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DEF1C6FE9
	for <gfs2@lists.linux.dev>; Mon,  2 Jun 2025 15:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.100.156.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748877746; cv=fail; b=SwBxcSSOJGmbFOoJe11Y0ToAKnxUqaokEMPm9pJnSholuyoLCdSGdw916cKPbixt80d2yPeZ2Zr7+QNPqfEQ+Ir8Jazg/Tid3Z7cp+JKSKV57XaHTR6jR4mrUnZ3GKtvCKHyMuEc02uEouAFmg+1iKt8pHqWQU0dhSfc/uRzphw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748877746; c=relaxed/simple;
	bh=+ybDULLznJAdKSSr8RGIUGw4/8D8FqU/+sVmcOaPo4c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A5Zj7i/wlqOku9KTWtfXO3FXyUxCMrqbPPn4pQjq0ywzknmb2bMmd46MMWv/IAPB9lw2tIjG+Cz2PMob3+ahCNsp+NCKg1uMN6Wbe5lsmHzXDVLA/5xolDuO/VgKfdMYZhn4M2oOkq2yGT6DZNWUgy+mkTrAZdl/3weBGzpjH9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=cloud.com; spf=pass smtp.mailfrom=citrix.onmicrosoft.com; dkim=pass (1024-bit key) header.d=citrix.onmicrosoft.com header.i=@citrix.onmicrosoft.com header.b=wfN2MQxr; arc=fail smtp.client-ip=52.100.156.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=cloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.onmicrosoft.com header.i=@citrix.onmicrosoft.com header.b="wfN2MQxr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fyx1HcLp9tPkKvVxp20iR1c3Gwac4I72FtPzJoihC3OTqMKS2Z5xDLynNsgbN3eGvjUQxKoVWmtnLjMYgw7/uYHTjER88bUp7QhgtvzafdqnLqOu/muwdocpMW6TGeufxBa8kt5Bj5ghc1pRlj4+KiL7fi/AUt11eQT/wcJ91xUZFhxnKoS3u8LSTxiKL2XAOIPMIh9t3h+XQTxOAVIix+K77BFe4gph/8opkoGbThiPyijLzBxv1DJk2dlr79qxS49IvnwcX2kVOBNKMpfaUyVvKzbltugrVvJFdxwK9iKFBByE3kK5+Okx1xcfcvR2SRahm8z0JvuhhyTB/UWdXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUkVcPPGyNnivUaaH7BcenbTk/ebe30qQYmKsm9MIOA=;
 b=sxmOxUOIQUBFAAj/jwGDb/IhgBIzsLc3O1qATqM6+70NIrAvXsjT7SgzXl7iAi1xYITkFK5TDAd5oFJiQHfaIazHAL2LHXS+W0ZrjevupxKkzllSpR+fjtdR8Rymi32dqaFDWVyQlf85GIgR8hBfGmcqcfO3QFTaAlIIjvYJXjW/VPUNKpX0YrvjkXK+OZSR9w2UYjU8zjrndZj17zLIxm7znXVUZka1FhKpt6KES45sPj9rQkB1sexh7mKH2AHWXmjS/wVh5PRABrweRHqtoUOgHDbQYWQ+sZd2xYtodtnB+/rwRFrgh8AIzhrPhWsvgvIQApubWUFXUOhETBn2bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 34.145.164.155) smtp.rcpttodomain=redhat.com smtp.mailfrom=cloud.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject header.from=cloud.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUkVcPPGyNnivUaaH7BcenbTk/ebe30qQYmKsm9MIOA=;
 b=wfN2MQxrvnedTrzz2pzPaUm6jUP8lX9WQG2OE0xdXIpGGGQKYBATeX2jtqzd76Joh9b0/iYbVTDuXzvc1K6qwHC72gy1f9l6iEb1iLjuU7MR6GUKsFjUVRQfUNOre+/WMIWvFmDHfSRrb8Q2njkLeVwA77q78eK5uJ0/w01MM4c=
Received: from ROAP284CA0269.BRAP284.PROD.OUTLOOK.COM (2603:10d6:10:f1::11) by
 PH0PR03MB6574.namprd03.prod.outlook.com (2603:10b6:510:b9::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.33; Mon, 2 Jun 2025 15:22:19 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10d6:10:f1:cafe::a5) by ROAP284CA0269.outlook.office365.com
 (2603:10d6:10:f1::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.29 via Frontend Transport; Mon,
 2 Jun 2025 15:22:18 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 34.145.164.155) smtp.mailfrom=cloud.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=cloud.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cloud.com discourages use of 34.145.164.155 as permitted sender)
Received: from mail.citrix.com (34.145.164.155) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.29 via Frontend Transport; Mon, 2 Jun 2025 15:22:17 +0000
Received: from guepitiexch02.citrite.net (10.240.48.56) by
 guepitiexch02.citrite.net (10.240.48.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.32; Mon, 2 Jun 2025 15:22:11 +0000
Received: from mewpvdipd1010.corp.cloud.com (10.113.40.31) by
 smtprelay.citrix.com (10.240.48.56) with Microsoft SMTP Server id
 15.2.1258.32 via Frontend Transport; Mon, 2 Jun 2025 15:22:10 +0000
From: Mark Syms <mark.syms@cloud.com>
To: <agruenba@redhat.com>
CC: <gfs2@lists.linux.dev>, <ross.lagerwall@cloud.com>, Mark Syms
	<mark.syms@cloud.com>
Subject: [PATCH] CA-411820: add STATX_DIOALIGN support to GFS2
Date: Mon, 2 Jun 2025 16:22:01 +0100
Message-ID: <20250602152201.958425-1-mark.syms@cloud.com>
X-Mailer: git-send-email 2.49.0
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|PH0PR03MB6574:EE_
X-MS-Office365-Filtering-Correlation-Id: 0819602a-6377-446b-97fb-08dda1e942c5
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35950700016|82310400026|376014|61400799027|48200799018|38500700031;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?umC8rcayMGYDAIKNd4lC9xxb+X9RD2eVmxrcw6dYNwc2aHTdeOHP4Tc15f5J?=
 =?us-ascii?Q?Mft/JooZvx14aBkK0id2DL/OJS38zfm1ZOV8KAvxvAxjYWzmU4CY9XaK/098?=
 =?us-ascii?Q?e97EEkgeQasFbQmFxaEEzT7miYBpGxVa4hL0YtducO0JygD+QCn70y6jG5Y6?=
 =?us-ascii?Q?F5/7IDWRfHwRMpNqc4cY33nvxThjgPOSScN52sFz+bo36K06C7mYOjc63+1I?=
 =?us-ascii?Q?sEMOieROkCV6IxS0UJJGPbvW1L6HO9Id7CncwpYsF3bqUf8AMRC5heRtcemK?=
 =?us-ascii?Q?C6trmEM7VgM+qpDy530SAS39hF7yY7eQtrrtibYJjx34Nv3eT/Y4zEbErY46?=
 =?us-ascii?Q?k57uV3TBJhFRx0DzeUN3kI2jgJeOvrF5U8Q15Xtt6szLzCRknYqaf4/QcaXF?=
 =?us-ascii?Q?TRTPApqDK1brTjHUIiLYweCw6+qLYDOdqL94mkK1kVFWYoPbxr0rS8bTr0pX?=
 =?us-ascii?Q?5U2G1M6f2RVx8lsHWeF9PcMFeWgCtwgDZLDYu6WmM/PnIlnph6EM6dU+XRMe?=
 =?us-ascii?Q?Rpn2fgRycBvbgUiridGZhkmEsy82VhrTW7NMXANvWJLVJKJFVRrH1Zxguk8l?=
 =?us-ascii?Q?tsZ67MYrCDGy4WiHLljesuJlcwn3yvqqESN97990iqy8qEZNuqm/PG+vJtM8?=
 =?us-ascii?Q?TobSfYdGdxXfA1ve7Q1RTxRGjDFb/eYrkYM6q4mfT0tBL1oJpamm1/bdu61q?=
 =?us-ascii?Q?4cMe453T63tP9+BqmmUewKolQCkszqs2XQ5mvIZootiuRLqfXQjaLjydzd16?=
 =?us-ascii?Q?ymukDTz3M0Iaanot6HrnoqNHvwHhrpwRX7wxtKS7x7+QJY2f2vIDukx92Qzi?=
 =?us-ascii?Q?/yTWquHK+HcaW/qGqCJTVkn4Wk7T7pDdLNYglshB2FkAhtET7M9htMp2UPdg?=
 =?us-ascii?Q?DTooHYHn/p1YU0NNLiXUcN0jvzLThRGRz7Xiq+lKg8b7+mSHK8ZSELtoTVgG?=
 =?us-ascii?Q?vh1yxCOxSXLTu4pdRGyfaB+vSSxkEPJdEW+E7OmSQ6rek8URzp8KEEfy4Ipl?=
 =?us-ascii?Q?hyQ4InUevhWrS4yy0fTNZLK0tu3hE66tQsElY+lh2f36OSGGhORoeO7PmmS2?=
 =?us-ascii?Q?gNpEgiAmGuxrT2eRQitxXTqwltV4+ribtXgnst8HKgNP64xB6YpM/wEcB0+A?=
 =?us-ascii?Q?Cfzbfqiem745drEsuUdER2V+0eXy/Dhym2+nuPmWMBD3jp+s20F6jVUqgJ3o?=
 =?us-ascii?Q?ShIJhwVnaG1PnUguyN3tKHonhZOts81T4jk72CDA+BjHvd1pm412Fd+iId7z?=
 =?us-ascii?Q?Ci7wE1KVrZ6kmi4bz7dOUPerY7M9RVM8cnskr071FyGAzUMaVyxCLUd4hMcO?=
 =?us-ascii?Q?nZXXMVExnC6zaYJNYhjYvOcb9AF0BiMjzshpyKJspqP3G8AQneuzQSrZn53c?=
 =?us-ascii?Q?KyZIHvagkZLf43r7coheFE5vZ96BHKKBC0uFJ/3fDMIPP4ZNNP1NFKNbSz1+?=
 =?us-ascii?Q?o4BD6I3V+o4JOcv46pLPubDa1mYgsU+xTpkmPvjfVNzFUfJ6OdlK7g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:34.145.164.155;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.citrix.com;PTR:155.164.145.34.bc.googleusercontent.com;CAT:NONE;SFS:(13230040)(35950700016)(82310400026)(376014)(61400799027)(48200799018)(38500700031);DIR:OUT;SFP:1501;
X-OriginatorOrg: citrix.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 15:22:17.5924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0819602a-6377-446b-97fb-08dda1e942c5
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=335836de-42ef-43a2-b145-348c2ee9ca5b;Ip=[34.145.164.155];Helo=[mail.citrix.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6574

Inspiration taken from 8434ef1d8aa but in simplified form. 8434ef1d8aa
makes the response conditional on the result from `ext4_dio_alignment`.
It is not clear if similar discrimination needs to be performed for
GFS2 or if the iomap defaults will be generally suitable. In tests
performed with XenServer this does appear to be the case.

Signed-off-by: Mark Syms <mark.syms@cloud.com>
---
 fs/gfs2/inode.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 187d789a8f1e..9310ecfe1f15 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -2172,6 +2172,19 @@ static int gfs2_getattr(struct mnt_idmap *idmap,
 
 	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
 
+	/*
+	 * Return the DIO alignment restrictions if requested.  We only return
+	 * this information when requested.
+	 */
+	if ((request_mask & STATX_DIOALIGN) && S_ISREG(inode->i_mode)) {
+		struct block_device *bdev = inode->i_sb->s_bdev;
+
+		stat->result_mask |= STATX_DIOALIGN;
+		/* iomap defaults */
+		stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
+		stat->dio_offset_align = bdev_logical_block_size(bdev);
+	}
+
 	if (gfs2_holder_initialized(&gh))
 		gfs2_glock_dq_uninit(&gh);
 
-- 
2.49.0

