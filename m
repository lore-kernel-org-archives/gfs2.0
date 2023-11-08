Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A53DCA78;
	Wed,  8 Nov 2023 06:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i1+0IcwR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699424484; x=1730960484;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bLCJxXwyRPz4Lr5cLa/jjlq50UQUMbSbXnLnR/TwEEs=;
  b=i1+0IcwRoleyZu4YobJjC5HNTxEYqm3DwqADnnTs9QFc4/YrsUAUB2GL
   WmtbjvrLoDFYwopL12NP0v1ZLFMhXH08QZNP0ZlNYNosfbB7rnGqcmxZV
   iybMRhS6JRayTKzTEGFjqE7oC8r5zH8OrCqIsWWixF18S/D2+OxRCKmkz
   wq3wCxLmIczS0WamgUGUKEc/NV+EW73YomWyn/nFpwkY/qeV56rK2HYIp
   6y4q+RGNNSTrnm58+S5bi7pdLBSsvhjcH08jZLI6eRe9Ok0svYPT01BRl
   nKav5RkEcVEtHDnVc0f8fShqTn2uPLRZdlPZiKQGCbKwjLdQedHejnpzQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="393617503"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="393617503"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 22:21:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="880104111"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="880104111"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 07 Nov 2023 22:21:21 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r0bwE-0007jP-2d;
	Wed, 08 Nov 2023 06:21:18 +0000
Date: Wed, 8 Nov 2023 14:21:03 +0800
From: kernel test robot <lkp@intel.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, gfs2@lists.linux.dev
Subject: [gfs2:alloc 57/77] fs/gfs2/bmap.c:1176:23: error: too many arguments
 to function 'gfs2_iomap_write_alloc'
Message-ID: <202311081452.oh0jMQkN-lkp@intel.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git alloc
head:   04e5d5785cde5d9320a6352e7cc01cfdb394d042
commit: 2e721b03a8a2877ac116affe082d0f9a18964e99 [57/77] gfs2: Add gfs2_iomap_write_alloc helper
config: microblaze-randconfig-r122-20231107 (https://download.01.org/0day-ci/archive/20231108/202311081452.oh0jMQkN-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231108/202311081452.oh0jMQkN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311081452.oh0jMQkN-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   fs/gfs2/bmap.c: In function 'gfs2_iomap_begin':
>> fs/gfs2/bmap.c:1176:58: warning: passing argument 3 of 'gfs2_iomap_write_alloc' makes pointer from integer without a cast [-Wint-conversion]
    1176 |                 ret = gfs2_iomap_write_alloc(inode, pos, length,
         |                                                          ^~~~~~
         |                                                          |
         |                                                          loff_t {aka long long int}
   fs/gfs2/bmap.c:1011:54: note: expected 'struct iomap *' but argument is of type 'loff_t' {aka 'long long int'}
    1011 |                        unsigned flags, struct iomap *iomap,
         |                                        ~~~~~~~~~~~~~~^~~~~
   fs/gfs2/bmap.c:1177:46: warning: passing argument 4 of 'gfs2_iomap_write_alloc' makes pointer from integer without a cast [-Wint-conversion]
    1177 |                                              flags, iomap, &mp);
         |                                              ^~~~~
         |                                              |
         |                                              unsigned int
   fs/gfs2/bmap.c:1012:41: note: expected 'struct metapath *' but argument is of type 'unsigned int'
    1012 |                        struct metapath *mp)
         |                        ~~~~~~~~~~~~~~~~~^~
>> fs/gfs2/bmap.c:1176:23: error: too many arguments to function 'gfs2_iomap_write_alloc'
    1176 |                 ret = gfs2_iomap_write_alloc(inode, pos, length,
         |                       ^~~~~~~~~~~~~~~~~~~~~~
   fs/gfs2/bmap.c:1010:1: note: declared here
    1010 | gfs2_iomap_write_alloc(struct inode *inode,
         | ^~~~~~~~~~~~~~~~~~~~~~


vim +/gfs2_iomap_write_alloc +1176 fs/gfs2/bmap.c

  1133	
  1134	static int gfs2_iomap_begin(struct inode *inode, loff_t pos, loff_t length,
  1135				    unsigned flags, struct iomap *iomap,
  1136				    struct iomap *srcmap)
  1137	{
  1138		struct gfs2_inode *ip = GFS2_I(inode);
  1139		struct metapath mp;
  1140		int ret;
  1141	
  1142		if (gfs2_is_jdata(ip))
  1143			iomap->flags |= IOMAP_F_BUFFER_HEAD;
  1144	
  1145		trace_gfs2_iomap_start(ip, pos, length, flags);
  1146		ret = init_metapath(&mp, inode);
  1147		if (ret)
  1148			goto out_unlock;
  1149		ret = __gfs2_iomap_get(inode, pos, length, flags, iomap, &mp);
  1150		if (ret)
  1151			goto out_unlock;
  1152	
  1153		switch(flags & (IOMAP_WRITE | IOMAP_ZERO)) {
  1154		case IOMAP_WRITE:
  1155			if (flags & IOMAP_DIRECT) {
  1156				/*
  1157				 * Silently fall back to buffered I/O for stuffed files
  1158				 * or if we've got a hole (see gfs2_file_direct_write).
  1159				 */
  1160				if (iomap->type != IOMAP_MAPPED)
  1161					ret = -ENOTBLK;
  1162				goto out_unlock;
  1163			}
  1164			break;
  1165		case IOMAP_ZERO:
  1166			if (iomap->type == IOMAP_HOLE)
  1167				goto out_unlock;
  1168			break;
  1169		default:
  1170			goto out_unlock;
  1171		}
  1172	
  1173		if ((gfs2_is_stuffed(ip) &&
  1174		     pos + length > gfs2_max_stuffed_size(ip)) ||
  1175		    iomap->type == IOMAP_HOLE) {
> 1176			ret = gfs2_iomap_write_alloc(inode, pos, length,
  1177						     flags, iomap, &mp);
  1178			if (ret)
  1179				goto out_unlock;
  1180		}
  1181	
  1182		if (gfs2_is_stuffed(ip) || gfs2_is_jdata(ip))
  1183			iomap->folio_ops = &gfs2_iomap_folio_ops;
  1184	
  1185	out_unlock:
  1186		release_metapath(&mp);
  1187		trace_gfs2_iomap_end(ip, iomap, ret);
  1188		return ret;
  1189	}
  1190	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
