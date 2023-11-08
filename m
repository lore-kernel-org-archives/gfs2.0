Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F2BD268;
	Wed,  8 Nov 2023 08:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D2uhBmly"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699433480; x=1730969480;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8Ij+nFTa4U40Oy32yL9PYlg6difawEGHdCHAnVEzKZ0=;
  b=D2uhBmlySIrX8xJ/wZO6QxCKW/7OfmKtSwpV5h6eKQys9QtcbFQ9exgb
   0ZcBq+4gaoRAKxrLndKw9TqlTDHOyTsRTTTNfDXhzVKLIp/rstLvcFYJ1
   HLBxxRYRpwOzPzoBlvj9phM1xG8u6PXKvbyzMt4+g0+SsyvLpvOWT0pDV
   Jtu0V5kKx30jccHbv0jfOGqIeuYwsy5zU1slapB6eAxexRxGilEPgAHp6
   FeZpROCgR2KZ+pNAQ0qgUiKPCgQvAEUMBxgPAr0Ht6yNabvjSnzWGzxmD
   kN5Goh2PS4QT3fO6+ShxWrIppB/lqbRgkxVztz5YM74dwC2lLKkd0dfml
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="2662981"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="2662981"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 00:51:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="828901170"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="828901170"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 08 Nov 2023 00:51:15 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r0eHJ-0007pZ-0D;
	Wed, 08 Nov 2023 08:51:13 +0000
Date: Wed, 8 Nov 2023 16:50:27 +0800
From: kernel test robot <lkp@intel.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, gfs2@lists.linux.dev
Subject: [gfs2:alloc 69/77] fs/gfs2/bmap.c:1330:17: error: 'pos' undeclared
Message-ID: <202311081622.CtbSVfqQ-lkp@intel.com>
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
commit: 6842b3f344ecd8327cf936a619544e4cb1e5b02b [69/77] gfs2: Improve gfs2_iomap_write_alloc transaction size estimate
config: microblaze-randconfig-r122-20231107 (https://download.01.org/0day-ci/archive/20231108/202311081622.CtbSVfqQ-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231108/202311081622.CtbSVfqQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311081622.CtbSVfqQ-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/gfs2/bmap.c: In function 'gfs2_iomap_write_alloc':
>> fs/gfs2/bmap.c:1330:17: error: 'pos' undeclared (first use in this function)
    1330 |         start = pos >> inode->i_blkbits;
         |                 ^~~
   fs/gfs2/bmap.c:1330:17: note: each undeclared identifier is reported only once for each function it appears in
>> fs/gfs2/bmap.c:1331:44: error: 'length' undeclared (first use in this function)
    1331 |         data_blocks = ((pos & blockmask) + length + blockmask) >> inode->i_blkbits;
         |                                            ^~~~~~
   fs/gfs2/bmap.c: In function 'gfs2_iomap_begin':
   fs/gfs2/bmap.c:1487:58: warning: passing argument 3 of 'gfs2_iomap_write_alloc' makes pointer from integer without a cast [-Wint-conversion]
    1487 |                 ret = gfs2_iomap_write_alloc(inode, pos, length,
         |                                                          ^~~~~~
         |                                                          |
         |                                                          loff_t {aka long long int}
   fs/gfs2/bmap.c:1317:54: note: expected 'struct iomap *' but argument is of type 'loff_t' {aka 'long long int'}
    1317 |                        unsigned flags, struct iomap *iomap,
         |                                        ~~~~~~~~~~~~~~^~~~~
   fs/gfs2/bmap.c:1488:46: warning: passing argument 4 of 'gfs2_iomap_write_alloc' makes pointer from integer without a cast [-Wint-conversion]
    1488 |                                              flags, iomap, &mp);
         |                                              ^~~~~
         |                                              |
         |                                              unsigned int
   fs/gfs2/bmap.c:1318:41: note: expected 'struct metapath *' but argument is of type 'unsigned int'
    1318 |                        struct metapath *mp)
         |                        ~~~~~~~~~~~~~~~~~^~
   fs/gfs2/bmap.c:1487:23: error: too many arguments to function 'gfs2_iomap_write_alloc'
    1487 |                 ret = gfs2_iomap_write_alloc(inode, pos, length,
         |                       ^~~~~~~~~~~~~~~~~~~~~~
   fs/gfs2/bmap.c:1316:1: note: declared here
    1316 | gfs2_iomap_write_alloc(struct inode *inode,
         | ^~~~~~~~~~~~~~~~~~~~~~
   fs/gfs2/bmap.c: At top level:
   fs/gfs2/bmap.c:1278:1: warning: 'gfs2_grow_height' defined but not used [-Wunused-function]
    1278 | gfs2_grow_height(struct gfs2_inode *ip, struct metapath *mp,
         | ^~~~~~~~~~~~~~~~
   fs/gfs2/bmap.c:894:1: warning: 'gfs2_alloc_data_blocks' defined but not used [-Wunused-function]
     894 | gfs2_alloc_data_blocks(struct inode *inode, struct metapath *mp,
         | ^~~~~~~~~~~~~~~~~~~~~~
   fs/gfs2/bmap.c:827:1: warning: 'gfs2_alloc_indirect_blocks' defined but not used [-Wunused-function]
     827 | gfs2_alloc_indirect_blocks(struct inode *inode, struct metapath *mp,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/gfs2/bmap.c:735:1: warning: 'min_indirect_blocks' defined but not used [-Wunused-function]
     735 | min_indirect_blocks(struct inode *inode, struct metapath *mp,
         | ^~~~~~~~~~~~~~~~~~~


vim +/pos +1330 fs/gfs2/bmap.c

  1314	
  1315	static int
  1316	gfs2_iomap_write_alloc(struct inode *inode,
  1317			       unsigned flags, struct iomap *iomap,
  1318			       struct metapath *mp)
  1319	{
  1320		struct gfs2_inode *ip = GFS2_I(inode);
  1321		struct gfs2_sbd *sdp = GFS2_SB(inode);
  1322		unsigned int blockmask = i_blocksize(inode) - 1;
  1323		unsigned int unstuff_block, data_blocks, ind_blocks;
  1324		struct gfs2_alloc_parms ap = {};
  1325		unsigned int blocks, revokes;
  1326		struct gfs2_trans *tr;
  1327		u64 start;
  1328		int ret;
  1329	
> 1330		start = pos >> inode->i_blkbits;
> 1331		data_blocks = ((pos & blockmask) + length + blockmask) >> inode->i_blkbits;
  1332		ind_blocks = max_indirect_blocks(inode, mp->mp_fheight, start, data_blocks);
  1333		unstuff_block = gfs2_is_stuffed(ip) && i_size_read(inode) && start > 0;
  1334		ap.target = unstuff_block + data_blocks + ind_blocks;
  1335		ret = gfs2_quota_lock_check(ip, &ap);
  1336		if (ret)
  1337			return ret;
  1338	
  1339		ret = gfs2_inplace_reserve(ip, &ap);
  1340		if (ret)
  1341			goto out_qunlock;
  1342	
  1343		blocks = RES_DINODE + ind_blocks + RES_STATFS;
  1344		if (sdp->sd_args.ar_quota != GFS2_QUOTA_OFF)
  1345			blocks += RES_QUOTA;
  1346		if (gfs2_is_jdata(ip))
  1347			blocks += unstuff_block + data_blocks;
  1348		if (inode == sdp->sd_rindex)
  1349			blocks += 2 * RES_STATFS;
  1350		blocks += gfs2_rg_blocks(ip, unstuff_block + data_blocks + ind_blocks);
  1351	
  1352		revokes = unstuff_block + data_blocks;
  1353	
  1354		ret = gfs2_trans_begin(sdp, blocks, revokes);
  1355		if (ret)
  1356			goto out_trans_fail;
  1357	
  1358		if (gfs2_is_stuffed(ip)) {
  1359			ret = __gfs2_unstuff_inode(inode, &ap);
  1360			if (ret)
  1361				goto out_trans_end;
  1362			mp->mp_aheight = 1;
  1363			if (iomap->offset == 0 && inode->i_size != 0) {
  1364				__be64 *ptr = metapointer(0, mp);
  1365				u64 dblock = be64_to_cpu(*ptr);
  1366	
  1367				iomap->type = IOMAP_MAPPED;
  1368				iomap->addr = dblock << inode->i_blkbits;
  1369				iomap->flags |= IOMAP_F_MERGED;
  1370			}
  1371		}
  1372	
  1373		if (iomap->type == IOMAP_HOLE) {
  1374			ret = __gfs2_iomap_alloc(inode, iomap, mp);
  1375			if (ret) {
  1376				gfs2_trans_end(sdp);
  1377				gfs2_inplace_release(ip);
  1378				punch_hole(ip, iomap->offset, iomap->length);
  1379				goto out_qunlock;
  1380			}
  1381		}
  1382	
  1383		tr = current->journal_info;
  1384		if (tr->tr_num_buf_new)
  1385			__mark_inode_dirty(inode, I_DIRTY_DATASYNC);
  1386	
  1387		gfs2_trans_end(sdp);
  1388		return 0;
  1389	
  1390	out_trans_end:
  1391		gfs2_trans_end(sdp);
  1392	out_trans_fail:
  1393		gfs2_inplace_release(ip);
  1394	out_qunlock:
  1395		gfs2_quota_unlock(ip);
  1396		return ret;
  1397	}
  1398	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
