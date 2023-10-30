Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D526C650;
	Mon, 30 Oct 2023 01:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ou0arBov"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698629111; x=1730165111;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=c5D+LmKxbsno4hZi4VDihdJgWyyyDcMCgC2JLzd6smU=;
  b=Ou0arBov36SVRmHllZZazMlGeGjT8l7ctx7cGytGCbNJucWFQOCDIh2s
   aTpv/qLx8qeM8wTZ6oM5ZX/tZkqaiAyQEDNtFx3dMqbDahbhuLMM8Kx2J
   cvfrbucYaXYVT5RMDyO/7KtXRFLBAmvJo0zn7XhxhK8M+UDWQyG4uwV86
   KYVMeB08OmWBtwzH4fVjsB6ReNYJ2jZwcAFIHoUuATqhNiBFR2ro/BaE2
   uZo0O41x1WtF85tBAxIIwBeAy1PG5qEbCzmVDnxK+R7VYf9iaI+gUnnLt
   nQymPT4Jm4nJCaAmG9qOk4igUFWeIEbhjVGfmqUVLPRRmje7QNkrsI17q
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="368209223"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; 
   d="scan'208";a="368209223"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2023 18:25:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="1007274666"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; 
   d="scan'208";a="1007274666"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 29 Oct 2023 18:25:09 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qxH1f-000Cxr-0u;
	Mon, 30 Oct 2023 01:25:07 +0000
Date: Mon, 30 Oct 2023 09:24:24 +0800
From: kernel test robot <lkp@intel.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, gfs2@lists.linux.dev
Subject: [gfs2:alloc 65/70] fs/gfs2/bmap.c:1194:29: warning: variable 'bh'
 set but not used
Message-ID: <202310300930.kaVdjHy8-lkp@intel.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git alloc
head:   f8dd6e4dd990a2524b3d76fd2459d027628420eb
commit: df17746aa1c0d73968d994423f3731192573059a [65/70] gfs2: Multiple indirect block support in gfs2_extent_lenth
config: loongarch-randconfig-002-20231030 (https://download.01.org/0day-ci/archive/20231030/202310300930.kaVdjHy8-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231030/202310300930.kaVdjHy8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310300930.kaVdjHy8-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/gfs2/bmap.c: In function '__gfs2_iomap_get':
>> fs/gfs2/bmap.c:1194:29: warning: variable 'bh' set but not used [-Wunused-but-set-variable]
    1194 |         struct buffer_head *bh;
         |                             ^~


vim +/bh +1194 fs/gfs2/bmap.c

7ee66c03e40a57 Christoph Hellwig   2018-06-01  1170  
3974320ca6aa68 Bob Peterson        2017-02-16  1171  /**
54992257fe4bb9 Andreas Gruenbacher 2021-03-27  1172   * __gfs2_iomap_get - Map blocks from an inode to disk blocks
3974320ca6aa68 Bob Peterson        2017-02-16  1173   * @inode: The inode
3974320ca6aa68 Bob Peterson        2017-02-16  1174   * @pos: Starting position in bytes
3974320ca6aa68 Bob Peterson        2017-02-16  1175   * @length: Length to map, in bytes
3974320ca6aa68 Bob Peterson        2017-02-16  1176   * @flags: iomap flags
3974320ca6aa68 Bob Peterson        2017-02-16  1177   * @iomap: The iomap structure
628e366df11c0a Andreas Gruenbacher 2018-06-04  1178   * @mp: The metapath
3974320ca6aa68 Bob Peterson        2017-02-16  1179   *
3974320ca6aa68 Bob Peterson        2017-02-16  1180   * Returns: errno
3974320ca6aa68 Bob Peterson        2017-02-16  1181   */
54992257fe4bb9 Andreas Gruenbacher 2021-03-27  1182  static int __gfs2_iomap_get(struct inode *inode, loff_t pos, loff_t length,
628e366df11c0a Andreas Gruenbacher 2018-06-04  1183  			    unsigned flags, struct iomap *iomap,
628e366df11c0a Andreas Gruenbacher 2018-06-04  1184  			    struct metapath *mp)
b3b94faa5fe596 David Teigland      2006-01-16  1185  {
feaa7bba026c18 Steven Whitehouse   2006-06-14  1186  	struct gfs2_inode *ip = GFS2_I(inode);
feaa7bba026c18 Steven Whitehouse   2006-06-14  1187  	struct gfs2_sbd *sdp = GFS2_SB(inode);
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  1188  	loff_t size = i_size_read(inode);
9b8c81d1de4994 Steven Whitehouse   2008-02-22  1189  	__be64 *ptr;
3974320ca6aa68 Bob Peterson        2017-02-16  1190  	sector_t lblock;
628e366df11c0a Andreas Gruenbacher 2018-06-04  1191  	sector_t lblock_stop;
81118680a9cf6b Andreas Gruenbacher 2023-10-20  1192  	int ret = 0;
628e366df11c0a Andreas Gruenbacher 2018-06-04  1193  	u64 len;
81118680a9cf6b Andreas Gruenbacher 2023-10-20 @1194  	struct buffer_head *bh;
9b8c81d1de4994 Steven Whitehouse   2008-02-22  1195  	u8 height;
7276b3b0c77101 Steven Whitehouse   2006-09-21  1196  
628e366df11c0a Andreas Gruenbacher 2018-06-04  1197  	if (!length)
628e366df11c0a Andreas Gruenbacher 2018-06-04  1198  		return -EINVAL;
b3b94faa5fe596 David Teigland      2006-01-16  1199  
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  1200  	down_read(&ip->i_rw_mutex);
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  1201  
49edd5bf429c40 Andreas Gruenbacher 2018-02-06  1202  	if (gfs2_is_stuffed(ip)) {
81118680a9cf6b Andreas Gruenbacher 2023-10-20  1203  		struct buffer_head *dibh = metapath_dibh(mp);
81118680a9cf6b Andreas Gruenbacher 2023-10-20  1204  
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  1205  		if (flags & IOMAP_WRITE) {
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  1206  			loff_t max_size = gfs2_max_stuffed_size(ip);
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  1207  
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  1208  			if (pos + length > max_size)
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  1209  				goto unstuff;
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  1210  			iomap->length = max_size;
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  1211  		} else {
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  1212  			if (pos >= size) {
49edd5bf429c40 Andreas Gruenbacher 2018-02-06  1213  				if (flags & IOMAP_REPORT) {
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  1214  					ret = -ENOENT;
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  1215  					goto unlock;
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  1216  				} else {
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  1217  					iomap->offset = pos;
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  1218  					iomap->length = length;
566a2ab3c9005f Andreas Gruenbacher 2020-04-20  1219  					goto hole_found;
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  1220  				}
3974320ca6aa68 Bob Peterson        2017-02-16  1221  			}
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  1222  			iomap->length = size;
49edd5bf429c40 Andreas Gruenbacher 2018-02-06  1223  		}
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  1224  		iomap->addr = (ip->i_no_addr << inode->i_blkbits) +
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  1225  			      sizeof(struct gfs2_dinode);
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  1226  		iomap->type = IOMAP_INLINE;
64bc06bb32ee9c Andreas Gruenbacher 2018-06-24  1227  		iomap->inline_data = dibh->b_data + sizeof(struct gfs2_dinode);
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  1228  		goto out;
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  1229  	}
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  1230  
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  1231  unstuff:
3974320ca6aa68 Bob Peterson        2017-02-16  1232  	lblock = pos >> inode->i_blkbits;
3974320ca6aa68 Bob Peterson        2017-02-16  1233  	iomap->offset = lblock << inode->i_blkbits;
628e366df11c0a Andreas Gruenbacher 2018-06-04  1234  	lblock_stop = (pos + length - 1) >> inode->i_blkbits;
628e366df11c0a Andreas Gruenbacher 2018-06-04  1235  	len = lblock_stop - lblock + 1;
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  1236  	iomap->length = len << inode->i_blkbits;
20cdc1931ee8e0 Andreas Gruenbacher 2017-09-22  1237  
9b8c81d1de4994 Steven Whitehouse   2008-02-22  1238  	height = ip->i_height;
69e6e734c0fb00 Andreas Gruenbacher 2023-10-18  1239  	while ((lblock_stop + 1) * sdp->sd_sb.sb_bsize > sdp->sd_heightsize[height])
ecc30c79157103 Steven Whitehouse   2008-01-28  1240  		height++;
628e366df11c0a Andreas Gruenbacher 2018-06-04  1241  	find_metapath(sdp, lblock, mp, height);
9b8c81d1de4994 Steven Whitehouse   2008-02-22  1242  	if (height > ip->i_height || gfs2_is_stuffed(ip))
9b8c81d1de4994 Steven Whitehouse   2008-02-22  1243  		goto do_alloc;
3974320ca6aa68 Bob Peterson        2017-02-16  1244  
628e366df11c0a Andreas Gruenbacher 2018-06-04  1245  	ret = lookup_metapath(ip, mp);
e8b43fe0c1e035 Andreas Gruenbacher 2017-12-08  1246  	if (ret)
628e366df11c0a Andreas Gruenbacher 2018-06-04  1247  		goto unlock;
3974320ca6aa68 Bob Peterson        2017-02-16  1248  
628e366df11c0a Andreas Gruenbacher 2018-06-04  1249  	if (mp->mp_aheight != ip->i_height)
9b8c81d1de4994 Steven Whitehouse   2008-02-22  1250  		goto do_alloc;
3974320ca6aa68 Bob Peterson        2017-02-16  1251  
628e366df11c0a Andreas Gruenbacher 2018-06-04  1252  	ptr = metapointer(ip->i_height - 1, mp);
9b8c81d1de4994 Steven Whitehouse   2008-02-22  1253  	if (*ptr == 0)
9b8c81d1de4994 Steven Whitehouse   2008-02-22  1254  		goto do_alloc;
3974320ca6aa68 Bob Peterson        2017-02-16  1255  
628e366df11c0a Andreas Gruenbacher 2018-06-04  1256  	bh = mp->mp_bh[ip->i_height - 1];
df17746aa1c0d7 Andreas Gruenbacher 2023-10-29  1257  	ret = gfs2_extent_length(inode, mp, len, &len);
df17746aa1c0d7 Andreas Gruenbacher 2023-10-29  1258  	if (ret)
df17746aa1c0d7 Andreas Gruenbacher 2023-10-29  1259  		goto unlock;
3974320ca6aa68 Bob Peterson        2017-02-16  1260  
628e366df11c0a Andreas Gruenbacher 2018-06-04  1261  	iomap->addr = be64_to_cpu(*ptr) << inode->i_blkbits;
628e366df11c0a Andreas Gruenbacher 2018-06-04  1262  	iomap->length = len << inode->i_blkbits;
628e366df11c0a Andreas Gruenbacher 2018-06-04  1263  	iomap->type = IOMAP_MAPPED;
0ed91eca1130e6 Andreas Gruenbacher 2018-07-25  1264  	iomap->flags |= IOMAP_F_MERGED;
3974320ca6aa68 Bob Peterson        2017-02-16  1265  
3974320ca6aa68 Bob Peterson        2017-02-16  1266  out:
628e366df11c0a Andreas Gruenbacher 2018-06-04  1267  	iomap->bdev = inode->i_sb->s_bdev;
628e366df11c0a Andreas Gruenbacher 2018-06-04  1268  unlock:
628e366df11c0a Andreas Gruenbacher 2018-06-04  1269  	up_read(&ip->i_rw_mutex);
9b8c81d1de4994 Steven Whitehouse   2008-02-22  1270  	return ret;
9b8c81d1de4994 Steven Whitehouse   2008-02-22  1271  
9b8c81d1de4994 Steven Whitehouse   2008-02-22  1272  do_alloc:
628e366df11c0a Andreas Gruenbacher 2018-06-04  1273  	if (flags & IOMAP_REPORT) {
49edd5bf429c40 Andreas Gruenbacher 2018-02-06  1274  		if (pos >= size)
3974320ca6aa68 Bob Peterson        2017-02-16  1275  			ret = -ENOENT;
02f9e18c81bda1 Andreas Gruenbacher 2023-10-29  1276  		else if (height == ip->i_height) {
02f9e18c81bda1 Andreas Gruenbacher 2023-10-29  1277  			ret = gfs2_hole_size(inode, lblock, len, mp, &len);
02f9e18c81bda1 Andreas Gruenbacher 2023-10-29  1278  			iomap->length = len << inode->i_blkbits;
02f9e18c81bda1 Andreas Gruenbacher 2023-10-29  1279  		} else
f3506eee81d1f7 Andreas Gruenbacher 2021-11-06  1280  			iomap->length = size - iomap->offset;
64bc06bb32ee9c Andreas Gruenbacher 2018-06-24  1281  	} else if (flags & IOMAP_WRITE) {
64bc06bb32ee9c Andreas Gruenbacher 2018-06-24  1282  		u64 alloc_size;
64bc06bb32ee9c Andreas Gruenbacher 2018-06-24  1283  
967bcc91b04493 Andreas Gruenbacher 2018-06-19  1284  		if (flags & IOMAP_DIRECT)
967bcc91b04493 Andreas Gruenbacher 2018-06-19  1285  			goto out;  /* (see gfs2_file_direct_write) */
967bcc91b04493 Andreas Gruenbacher 2018-06-19  1286  
64bc06bb32ee9c Andreas Gruenbacher 2018-06-24  1287  		len = gfs2_alloc_size(inode, mp, len);
64bc06bb32ee9c Andreas Gruenbacher 2018-06-24  1288  		alloc_size = len << inode->i_blkbits;
64bc06bb32ee9c Andreas Gruenbacher 2018-06-24  1289  		if (alloc_size < iomap->length)
64bc06bb32ee9c Andreas Gruenbacher 2018-06-24  1290  			iomap->length = alloc_size;
64bc06bb32ee9c Andreas Gruenbacher 2018-06-24  1291  	} else {
02f9e18c81bda1 Andreas Gruenbacher 2023-10-29  1292  		if (pos < size && height == ip->i_height) {
02f9e18c81bda1 Andreas Gruenbacher 2023-10-29  1293  			ret = gfs2_hole_size(inode, lblock, len, mp, &len);
02f9e18c81bda1 Andreas Gruenbacher 2023-10-29  1294  			iomap->length = len << inode->i_blkbits;
02f9e18c81bda1 Andreas Gruenbacher 2023-10-29  1295  		}
3974320ca6aa68 Bob Peterson        2017-02-16  1296  	}
566a2ab3c9005f Andreas Gruenbacher 2020-04-20  1297  hole_found:
566a2ab3c9005f Andreas Gruenbacher 2020-04-20  1298  	iomap->addr = IOMAP_NULL_ADDR;
566a2ab3c9005f Andreas Gruenbacher 2020-04-20  1299  	iomap->type = IOMAP_HOLE;
628e366df11c0a Andreas Gruenbacher 2018-06-04  1300  	goto out;
628e366df11c0a Andreas Gruenbacher 2018-06-04  1301  }
628e366df11c0a Andreas Gruenbacher 2018-06-04  1302  

:::::: The code at line 1194 was first introduced by commit
:::::: 81118680a9cf6b24ea7943e0a7b2a98bf8d2b676 gfs2: Initialize metapaths outside of __gfs2_iomap_get

:::::: TO: Andreas Gruenbacher <agruenba@redhat.com>
:::::: CC: Andreas Gruenbacher <agruenba@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
