Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F1019D;
	Fri, 20 Oct 2023 00:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WTJAd1FY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697761711; x=1729297711;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=w2OopOzoFLjV1EYsW5CM/EH98Ac+80y+yXFO6Zvja8s=;
  b=WTJAd1FYZNvSwD4oyPo27qvWZM24G20mbUvF2a+CEG4EZmJqJ0QYvzu+
   O+ipoe0irTkf2VzkzBT/Mzn3QMDFAZz5zki3B58o8dq+t9jBlp6tePAnS
   ms/UE9CSCzwO0dvPg0QkJ4PBBmj6lJONQ+aVf8hNFCZLtEl1yTutJI71x
   2M3KjeK1XCbJm3E2NMV4c9MkCjBrbPPU/bRJACIG575FcvV/7yn9aDQLL
   A6qaEyuCC9E5AWMW2pXqm7Q+CmGWfnZ39Tj2vjtCH4voJejmACtITw2mR
   QlOT3gc6bQfhK0KqA/h/KvzLDkQLwIRpgA1fJDQn3NLOIlCX6QmI9BCX4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="385278118"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="385278118"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 17:28:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="760854165"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="760854165"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Oct 2023 17:28:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 17:28:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 19 Oct 2023 17:28:29 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 19 Oct 2023 17:28:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GznwD1oVkGIgPI5VjJiZWfz6hfa+otRjL2MOxAc/KBnIZfk+TKv7g3ePInTCCIASpJ/+7/xzs+CxyQMlPhloIhjIy9Ar/F4elRAZWC5oo+yAmPUhbB8HUdC9N3W0BT7abugcVQ+zhBRHZQDkt0F0p5wAawPiKqVFbEgOpVJZIENaSBI7JrhELALoDtigY7BXwuPZsImvQzbPsMsUHU6uA/8RkwfyZ6eTvOqoAhpA6VXUtbt/P0hnRyAf56Y7YiV84M+81YT5Owgp4l+VftPITROO+xNziWJLyTv24uDK07mcVpQ0TxoGsGL0qmF8+fLsLK6EALGWJyeHgmdQDncnoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9cVm6v00jLPMAeyf7EfO3FRz9rp/QFJsLlRKOdbRfE=;
 b=ezY6IP0kq9dJIfcXXIfUif0ZLE6ivObs2XT4iloqfWC0KofPtlmzaxMeoYb6/m+JVYQG4FwhmrvtTg3Kd3ho4HldJil9S4FOaV3ib/snzdsRvJ0bm6G8G0Vi7oBSBvxK7lPi+9Cx5wbuLEuswWPMb+kWiHDSsKqrrS5CkidoJddExGe+wgSBPe9j382PtjeQ4eTUYAfVsGY1Uzg5P9z0RrF0iDV1E/apzPOi52sNztSySKQ+i5gNR4jk8U8wu0ODl8kNX3o0lMHgBknlGIxPVtm3Hmn5QzNVNOF3k28IuEeLqeFG+mytgCg+Zcm+SORoihZc1ToUgYC3AIHftb2b1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Fri, 20 Oct
 2023 00:28:27 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::f64:17c0:d3ab:196]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::f64:17c0:d3ab:196%7]) with mapi id 15.20.6907.022; Fri, 20 Oct 2023
 00:28:26 +0000
Date: Fri, 20 Oct 2023 08:28:18 +0800
From: Philip Li <philip.li@intel.com>
To: Andrew Price <anprice@redhat.com>
CC: Julia Lawall <julia.lawall@inria.fr>, <oe-kbuild-all@lists.linux.dev>,
	<gfs2@lists.linux.dev>, Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [Cluster-devel] [gfs2:extents 14/14]
 fs/gfs2/extents.c:123:23-27: WARNING use flexible-array member instead
 (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
 (fwd)
Message-ID: <ZTHJolgTz238L41d@rli9-mobl>
References: <a8791f89-ed7b-1649-3b53-72349899c5d@inria.fr>
 <be0ce0c5-5278-4d29-94d2-e5ce26e8e3b5@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <be0ce0c5-5278-4d29-94d2-e5ce26e8e3b5@redhat.com>
X-ClientProxiedBy: SG2PR04CA0156.apcprd04.prod.outlook.com (2603:1096:4::18)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|CY8PR11MB7290:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fdbe750-f1c6-4d6b-b57f-08dbd103799f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QylxW3Wb9RIwHmVN10jH820UeUmV7ufzbtqneVD8Q+3I/Y527o+0nf0iMu4yTXhyRh/B319cwWXxiOBDxfLJMWG+BlaA4eYj4KGptC9BheK1HLQb5y5E07pFOZhLMksbb6HS/8QW4BT+9azD6s1b5e1lsVpKNfxOrt53f9ZiGO2G848VXeViemIH50/ixf9S96v0IxryqOU7YpqbtxdtVuoPd4MT3nAVwn2uA3PZSZTp0KVmtd/l393tRR/TggvTUZKRavsGXjC+z5715IqO6pPDC3XHeY8kIsx3nF4/9yQreMEuOM2vyVtO0oV6CXJFVclDjAaQxm5UiQGca3mstsNkF8EZSiK4MlXmy3ODIzwKWXVko9ikyPvVH4L0ZoYDxDONKRwI2ac5KcyXzYoSE1KJVoPQCGuIdjvwyIbDxqFBiiTpdnYjGDY5CxB3TKbxKDeMJyK2VE7KEVz3SHMTHvPW0dzippMC3NdttT8GULkwYUnxIQKRB9wD1jq0/VNPEvJcVNwdpzXj2EZCsCF2yH4cAtPA624ktysYATO16Q6vTif0mMEVS7jmkufNUznGD4vs3GQwyr7Cu5aIxOPvwD0tSh6AB7HG7gpSnEOHUPLsgIN1v9WFxMrFtldP416eidAG9LTH+KXKH58Azd9P1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(396003)(39860400002)(366004)(376002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(6506007)(26005)(83380400001)(6666004)(8936002)(966005)(6916009)(9686003)(53546011)(4326008)(5660300002)(478600001)(41300700001)(2906002)(6486002)(8676002)(33716001)(44832011)(66556008)(54906003)(316002)(82960400001)(38100700002)(66476007)(66946007)(6512007)(86362001)(163123001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+iW8O4Q51f4E8N+MCTNliLuBTrU3QD9TWZyrL+4yO4CJye4H1UshuG3Hz9vK?=
 =?us-ascii?Q?2JZjRr50fzlMoB/iuaIY1ptnY9Z5xjveds6km82qWQtcrky577N9YHe5mLxm?=
 =?us-ascii?Q?HoDFO40374lNIb24ztsFc1N/QyVpuN2kDZgA6jg9QtCbSKjk1SObsBJMcqKd?=
 =?us-ascii?Q?HvHm0L4tjl98KnCQGfgbq3eIKopOioFJ0kDZLVz1oj9z/g/hwJC/DTpaXud3?=
 =?us-ascii?Q?0KHA1Wtt2dlBozhsOrXD5C7lpjjX4MrFB9wPFkQWOyfjqx5mDdcMkeg7pzMN?=
 =?us-ascii?Q?fLRsjF0wrlJPaG1BDvfQDctO0sU8NCrEwqn1FLwGmle0gHH0OSRtbKSLJEgu?=
 =?us-ascii?Q?oiFiDxTlAysaeyjs3kZEBGmIO1IByzBB2hF1Ipszdza9i/tDaxLKPvjpTWHC?=
 =?us-ascii?Q?vk28TNkh8r+L737Sane6ofeYJU+G14W8KL+NWBZ0ZSMvaqDr+EuQLP3gGvLR?=
 =?us-ascii?Q?PsVzXk1cwqYe6NlWx+y3LMsyHY509pSYVP1TA+0INuj28FFYKpdcVTgp50FZ?=
 =?us-ascii?Q?/QksKDv5XaWFxNSZVChoestStb2LioHBgE8Tc62HozvGM+lgyzJc2VK76Bfj?=
 =?us-ascii?Q?1k6MnwihL8Vl7M5pXNdeWbyZT8IpCdlr78N4OPXqCPsY937XC4WaWNqvCKub?=
 =?us-ascii?Q?j65E19SPXCUjl3oS5AN88DfpsoFE/swoWqKb6vPaXRwGLMmQ3/fays17c0Yq?=
 =?us-ascii?Q?p/XDSFssGxYWDQWnDGJd1vJ2WfyEj7uMpJF/PwZIAIADGCm3t7Yeg4lOHzRY?=
 =?us-ascii?Q?uh9YVhQkiUVTUvS2xFywtUrw3xULSUggXxi52i5asf7UyKelN2Wb+8/sX8RT?=
 =?us-ascii?Q?LyhM8UF3n/SPYV5aC+5hBDPNiCZkl3Z0yURwAbWumNmsAGF9MbD1qm4G5Vz4?=
 =?us-ascii?Q?vj0KFpfildmiwBpC9kXyccDb9OTyGUDLGVe1uETdie28FQtLl4NlhXrS+Emc?=
 =?us-ascii?Q?GY2j7WoURLctG9TWOQ3BAVd5Gsm+WsS3+Bg6p/yC1GsZ065heRNpQBD4GYJQ?=
 =?us-ascii?Q?BgBWsXiIpmEWFzJuxBeSobdSizkQSvABL499jWRbHaPbfsuZAp0L2bX7xF5E?=
 =?us-ascii?Q?mWu+1iXV9G2VSB/OxXqddHeJ+g34yyKVF1y8YYHV5BgQH+9QqlRFIqrsnWo8?=
 =?us-ascii?Q?zvR9TPdCKClCxbG6tVldeaT56EVdh1ucuZjt6sRVJQ2xX+JYJ+XeN8KZw/F6?=
 =?us-ascii?Q?COT7xS9SOnSRpL9XSYmFiG0nU/j641RDkyZyTT4Fe+ysYlx+9pCh6Y4Udw6g?=
 =?us-ascii?Q?cAghyBvvnL+CtF9t+MGlZz9IyqYsu9h/7ZvvpRp/10O2hwnXukAioYlfjHtW?=
 =?us-ascii?Q?IUjmnNJZA9T8JvTBUeNwwMJA6gXqdZRgmRAk+R0mtB2EvmA4Bynpl6dNBC5+?=
 =?us-ascii?Q?evadv4pB/nA+EgdsMGk1ZXCVNSHBP8L/HNtdyA+2UpnlsNKjNAmMnBGiLCnC?=
 =?us-ascii?Q?7s31drLTRX5aVZrae75ih3rP/jqxKzWIwQmUKj8FxubM/eb/7g+ZecNH2o/d?=
 =?us-ascii?Q?buplAnzI1sdFBOUR34DpXcs6jT4UjvnFaU5NwFOGm8E2+tvrvUuDhnFSVkvJ?=
 =?us-ascii?Q?YZQ6BliPmaVA3ajYKD9ITcHa+8HWQ7aPDOopfUOl?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fdbe750-f1c6-4d6b-b57f-08dbd103799f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 00:28:26.3065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 26BQAQ7t5+nZbQvF1RTaeW09Dv6ECaywjEalq6qhAP+7PPVjdYTybrMnXOpbkyHG9Dmo4L4FL8HGP3S+Nyb51g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7290
X-OriginatorOrg: intel.com

On Thu, Oct 19, 2023 at 01:28:13PM +0100, Andrew Price wrote:
> On 19/10/2023 06:27, Julia Lawall wrote:
> > 
> > 
> > ---------- Forwarded message ----------
> > Date: Thu, 19 Oct 2023 05:56:44 +0800
> > From: kernel test robot <lkp@intel.com>
> > To: oe-kbuild@lists.linux.dev
> > Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
> > Subject: [gfs2:extents 14/14] fs/gfs2/extents.c:123:23-27: WARNING use
> >      flexible-array member instead
> >      (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-
> >      and-one-element-arrays)
> > 
> > BCC: lkp@intel.com
> > CC: oe-kbuild-all@lists.linux.dev
> > CC: cluster-devel@redhat.com
> 
> The lkp-tests contact info is out of date. I've opened a PR to fix it at

Hi Andy, we now use lkp@intel.com, sorry for any outdated info.

> https://github.com/intel/lkp-tests/pull/319 but it should probably use the

The pr has been merged, thanks

> latest MAINTAINERS file always. CCing the new gfs2 list.
> 
> Thanks,
> Andy
> 
> > TO: Andreas Gruenbacher <agruenba@redhat.com>
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git extents
> > head:   86474c69cac46872bd311318c02fb8e9e25abd10
> > commit: 86474c69cac46872bd311318c02fb8e9e25abd10 [14/14] gfs2: Add some initial extents-based inode code
> > :::::: branch date: 9 days ago
> > :::::: commit date: 9 days ago
> > config: x86_64-randconfig-101-20231018 (https://download.01.org/0day-ci/archive/20231019/202310190541.0impmnL4-lkp@intel.com/config)
> > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> > reproduce: (https://download.01.org/0day-ci/archive/20231019/202310190541.0impmnL4-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Reported-by: Julia Lawall <julia.lawall@inria.fr>
> > | Closes: https://lore.kernel.org/r/202310190541.0impmnL4-lkp@intel.com/
> > 
> > cocci warnings: (new ones prefixed by >>)
> > > > fs/gfs2/extents.c:123:23-27: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > 
> > vim +123 fs/gfs2/extents.c
> > 
> > 86474c69cac468 Andreas Gruenbacher 2021-03-25  115
> > 86474c69cac468 Andreas Gruenbacher 2021-03-25  116  /*
> > 86474c69cac468 Andreas Gruenbacher 2021-03-25  117   * The path components in struct gfs2_extent_path are stored in "reverse"
> > 86474c69cac468 Andreas Gruenbacher 2021-03-25  118   * order: the leaf is stored first, and when the tree grows at the root,
> > 86474c69cac468 Andreas Gruenbacher 2021-03-25  119   * this happens at the end of the array.
> > 86474c69cac468 Andreas Gruenbacher 2021-03-25  120   */
> > 86474c69cac468 Andreas Gruenbacher 2021-03-25  121  struct gfs2_extent_path {
> > 86474c69cac468 Andreas Gruenbacher 2021-03-25  122  	unsigned int p_height;
> > 86474c69cac468 Andreas Gruenbacher 2021-03-25 @123  	struct gfs2_extent_pc p_pc[1];
> > 86474c69cac468 Andreas Gruenbacher 2021-03-25  124  };
> > 86474c69cac468 Andreas Gruenbacher 2021-03-25  125
> > 
> 
> 
