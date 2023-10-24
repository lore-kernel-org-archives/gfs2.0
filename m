Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A1921378;
	Tue, 24 Oct 2023 13:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IIKiXeOy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698155066; x=1729691066;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=D+zq5i7oXV9GIgVjOh2+d3R+3GpyVVxZ8aarU5qe8bA=;
  b=IIKiXeOyPPCdmd8FH/qss7NCdN4QvEtd3vP3S2TX2jwWRXNO7nWdwSdc
   8slY4n/HZ2wgXjoVulKMsMd4Pk9NPofSFGIQNGvSuX7nSam9hefpK4iXm
   MxhN15nWIZIEWw4r1L/Nsus0/5uQ7T32gBx8DbgRGM8n/2VQscm8aWa4s
   k+g9tgshuFpuWflpaMJSMCstJCMcAYLrkwTvQGKswtNNsRM7dHNogP8Q/
   WumZgVIOhTcvhSdOnd0NGG/LdAiH3Hg2aid1Hhiwhmj51a8Vk6ZConT9h
   ExcrD0OwfkmY3y+xx+BD3TS7P4bn5K83soyIpdko19MmslQjkNU/1vjFC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="453524493"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="453524493"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 06:39:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="6176840"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 24 Oct 2023 06:37:43 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qvHcY-0007tx-2A;
	Tue, 24 Oct 2023 13:38:58 +0000
Date: Tue, 24 Oct 2023 21:38:02 +0800
From: kernel test robot <lkp@intel.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	gfs2@lists.linux.dev
Subject: [gfs2:for-next 14/21] fs/gfs2/bmap.c:893:9: warning: variable 'ret'
 is used uninitialized whenever 'if' condition is false
Message-ID: <202310242105.0fHmealv-lkp@intel.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git for-next
head:   ec6e8472a6a78f4c630fb45a07a354bbfbeb5660
commit: 2cd225820b919acde16729f05f9f8841de682eef [14/21] gfs2: Initialize metapaths outside of __gfs2_iomap_get
config: hexagon-randconfig-r033-20220828 (https://download.01.org/0day-ci/archive/20231024/202310242105.0fHmealv-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231024/202310242105.0fHmealv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310242105.0fHmealv-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from fs/gfs2/bmap.c:9:
   In file included from include/linux/buffer_head.h:12:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from fs/gfs2/bmap.c:9:
   In file included from include/linux/buffer_head.h:12:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from fs/gfs2/bmap.c:9:
   In file included from include/linux/buffer_head.h:12:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
>> fs/gfs2/bmap.c:893:9: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
                                   if (flags & IOMAP_REPORT) {
                                       ^~~~~~~~~~~~~~~~~~~~
   fs/gfs2/bmap.c:950:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   fs/gfs2/bmap.c:893:5: note: remove the 'if' if its condition is always true
                                   if (flags & IOMAP_REPORT) {
                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/gfs2/bmap.c:892:8: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
                           if (pos >= size) {
                               ^~~~~~~~~~~
   fs/gfs2/bmap.c:950:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   fs/gfs2/bmap.c:892:4: note: remove the 'if' if its condition is always true
                           if (pos >= size) {
                           ^~~~~~~~~~~~~~~~~
   fs/gfs2/bmap.c:888:8: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
                           if (pos + length > max_size)
                               ^~~~~~~~~~~~~~~~~~~~~~~
   fs/gfs2/bmap.c:950:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   fs/gfs2/bmap.c:888:4: note: remove the 'if' if its condition is always true
                           if (pos + length > max_size)
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/gfs2/bmap.c:871:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   9 warnings generated.


vim +893 fs/gfs2/bmap.c

7ee66c03e40a57 Christoph Hellwig   2018-06-01  849  
3974320ca6aa68 Bob Peterson        2017-02-16  850  /**
54992257fe4bb9 Andreas Gruenbacher 2021-03-27  851   * __gfs2_iomap_get - Map blocks from an inode to disk blocks
3974320ca6aa68 Bob Peterson        2017-02-16  852   * @inode: The inode
3974320ca6aa68 Bob Peterson        2017-02-16  853   * @pos: Starting position in bytes
3974320ca6aa68 Bob Peterson        2017-02-16  854   * @length: Length to map, in bytes
3974320ca6aa68 Bob Peterson        2017-02-16  855   * @flags: iomap flags
3974320ca6aa68 Bob Peterson        2017-02-16  856   * @iomap: The iomap structure
628e366df11c0a Andreas Gruenbacher 2018-06-04  857   * @mp: The metapath
3974320ca6aa68 Bob Peterson        2017-02-16  858   *
3974320ca6aa68 Bob Peterson        2017-02-16  859   * Returns: errno
3974320ca6aa68 Bob Peterson        2017-02-16  860   */
54992257fe4bb9 Andreas Gruenbacher 2021-03-27  861  static int __gfs2_iomap_get(struct inode *inode, loff_t pos, loff_t length,
628e366df11c0a Andreas Gruenbacher 2018-06-04  862  			    unsigned flags, struct iomap *iomap,
628e366df11c0a Andreas Gruenbacher 2018-06-04  863  			    struct metapath *mp)
b3b94faa5fe596 David Teigland      2006-01-16  864  {
feaa7bba026c18 Steven Whitehouse   2006-06-14  865  	struct gfs2_inode *ip = GFS2_I(inode);
feaa7bba026c18 Steven Whitehouse   2006-06-14  866  	struct gfs2_sbd *sdp = GFS2_SB(inode);
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  867  	loff_t size = i_size_read(inode);
9b8c81d1de4994 Steven Whitehouse   2008-02-22  868  	__be64 *ptr;
3974320ca6aa68 Bob Peterson        2017-02-16  869  	sector_t lblock;
628e366df11c0a Andreas Gruenbacher 2018-06-04  870  	sector_t lblock_stop;
628e366df11c0a Andreas Gruenbacher 2018-06-04  871  	int ret;
9b8c81d1de4994 Steven Whitehouse   2008-02-22  872  	int eob;
628e366df11c0a Andreas Gruenbacher 2018-06-04  873  	u64 len;
2cd225820b919a Andreas Gruenbacher 2023-10-20  874  	struct buffer_head *bh;
9b8c81d1de4994 Steven Whitehouse   2008-02-22  875  	u8 height;
7276b3b0c77101 Steven Whitehouse   2006-09-21  876  
628e366df11c0a Andreas Gruenbacher 2018-06-04  877  	if (!length)
628e366df11c0a Andreas Gruenbacher 2018-06-04  878  		return -EINVAL;
b3b94faa5fe596 David Teigland      2006-01-16  879  
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  880  	down_read(&ip->i_rw_mutex);
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  881  
49edd5bf429c40 Andreas Gruenbacher 2018-02-06  882  	if (gfs2_is_stuffed(ip)) {
2cd225820b919a Andreas Gruenbacher 2023-10-20  883  		struct buffer_head *dibh = metapath_dibh(mp);
2cd225820b919a Andreas Gruenbacher 2023-10-20  884  
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  885  		if (flags & IOMAP_WRITE) {
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  886  			loff_t max_size = gfs2_max_stuffed_size(ip);
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  887  
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  888  			if (pos + length > max_size)
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  889  				goto unstuff;
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  890  			iomap->length = max_size;
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  891  		} else {
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  892  			if (pos >= size) {
49edd5bf429c40 Andreas Gruenbacher 2018-02-06 @893  				if (flags & IOMAP_REPORT) {
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  894  					ret = -ENOENT;
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  895  					goto unlock;
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  896  				} else {
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  897  					iomap->offset = pos;
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  898  					iomap->length = length;
566a2ab3c9005f Andreas Gruenbacher 2020-04-20  899  					goto hole_found;
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  900  				}
3974320ca6aa68 Bob Peterson        2017-02-16  901  			}
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  902  			iomap->length = size;
49edd5bf429c40 Andreas Gruenbacher 2018-02-06  903  		}
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  904  		iomap->addr = (ip->i_no_addr << inode->i_blkbits) +
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  905  			      sizeof(struct gfs2_dinode);
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  906  		iomap->type = IOMAP_INLINE;
64bc06bb32ee9c Andreas Gruenbacher 2018-06-24  907  		iomap->inline_data = dibh->b_data + sizeof(struct gfs2_dinode);
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  908  		goto out;
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  909  	}
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  910  
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  911  unstuff:
3974320ca6aa68 Bob Peterson        2017-02-16  912  	lblock = pos >> inode->i_blkbits;
3974320ca6aa68 Bob Peterson        2017-02-16  913  	iomap->offset = lblock << inode->i_blkbits;
628e366df11c0a Andreas Gruenbacher 2018-06-04  914  	lblock_stop = (pos + length - 1) >> inode->i_blkbits;
628e366df11c0a Andreas Gruenbacher 2018-06-04  915  	len = lblock_stop - lblock + 1;
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  916  	iomap->length = len << inode->i_blkbits;
20cdc1931ee8e0 Andreas Gruenbacher 2017-09-22  917  
9b8c81d1de4994 Steven Whitehouse   2008-02-22  918  	height = ip->i_height;
9a38662ba4e268 Andreas Gruenbacher 2018-04-16  919  	while ((lblock + 1) * sdp->sd_sb.sb_bsize > sdp->sd_heightsize[height])
ecc30c79157103 Steven Whitehouse   2008-01-28  920  		height++;
628e366df11c0a Andreas Gruenbacher 2018-06-04  921  	find_metapath(sdp, lblock, mp, height);
9b8c81d1de4994 Steven Whitehouse   2008-02-22  922  	if (height > ip->i_height || gfs2_is_stuffed(ip))
9b8c81d1de4994 Steven Whitehouse   2008-02-22  923  		goto do_alloc;
3974320ca6aa68 Bob Peterson        2017-02-16  924  
628e366df11c0a Andreas Gruenbacher 2018-06-04  925  	ret = lookup_metapath(ip, mp);
e8b43fe0c1e035 Andreas Gruenbacher 2017-12-08  926  	if (ret)
628e366df11c0a Andreas Gruenbacher 2018-06-04  927  		goto unlock;
3974320ca6aa68 Bob Peterson        2017-02-16  928  
628e366df11c0a Andreas Gruenbacher 2018-06-04  929  	if (mp->mp_aheight != ip->i_height)
9b8c81d1de4994 Steven Whitehouse   2008-02-22  930  		goto do_alloc;
3974320ca6aa68 Bob Peterson        2017-02-16  931  
628e366df11c0a Andreas Gruenbacher 2018-06-04  932  	ptr = metapointer(ip->i_height - 1, mp);
9b8c81d1de4994 Steven Whitehouse   2008-02-22  933  	if (*ptr == 0)
9b8c81d1de4994 Steven Whitehouse   2008-02-22  934  		goto do_alloc;
3974320ca6aa68 Bob Peterson        2017-02-16  935  
628e366df11c0a Andreas Gruenbacher 2018-06-04  936  	bh = mp->mp_bh[ip->i_height - 1];
b4bf3d5c37d404 Andreas Gruenbacher 2023-09-14  937  	len = gfs2_extent_length(bh, ptr, &eob);
3974320ca6aa68 Bob Peterson        2017-02-16  938  
628e366df11c0a Andreas Gruenbacher 2018-06-04  939  	iomap->addr = be64_to_cpu(*ptr) << inode->i_blkbits;
628e366df11c0a Andreas Gruenbacher 2018-06-04  940  	iomap->length = len << inode->i_blkbits;
628e366df11c0a Andreas Gruenbacher 2018-06-04  941  	iomap->type = IOMAP_MAPPED;
0ed91eca1130e6 Andreas Gruenbacher 2018-07-25  942  	iomap->flags |= IOMAP_F_MERGED;
9b8c81d1de4994 Steven Whitehouse   2008-02-22  943  	if (eob)
7ee66c03e40a57 Christoph Hellwig   2018-06-01  944  		iomap->flags |= IOMAP_F_GFS2_BOUNDARY;
3974320ca6aa68 Bob Peterson        2017-02-16  945  
3974320ca6aa68 Bob Peterson        2017-02-16  946  out:
628e366df11c0a Andreas Gruenbacher 2018-06-04  947  	iomap->bdev = inode->i_sb->s_bdev;
628e366df11c0a Andreas Gruenbacher 2018-06-04  948  unlock:
628e366df11c0a Andreas Gruenbacher 2018-06-04  949  	up_read(&ip->i_rw_mutex);
9b8c81d1de4994 Steven Whitehouse   2008-02-22  950  	return ret;
9b8c81d1de4994 Steven Whitehouse   2008-02-22  951  
9b8c81d1de4994 Steven Whitehouse   2008-02-22  952  do_alloc:
628e366df11c0a Andreas Gruenbacher 2018-06-04  953  	if (flags & IOMAP_REPORT) {
49edd5bf429c40 Andreas Gruenbacher 2018-02-06  954  		if (pos >= size)
3974320ca6aa68 Bob Peterson        2017-02-16  955  			ret = -ENOENT;
628e366df11c0a Andreas Gruenbacher 2018-06-04  956  		else if (height == ip->i_height)
628e366df11c0a Andreas Gruenbacher 2018-06-04  957  			ret = gfs2_hole_size(inode, lblock, len, mp, iomap);
49edd5bf429c40 Andreas Gruenbacher 2018-02-06  958  		else
f3506eee81d1f7 Andreas Gruenbacher 2021-11-06  959  			iomap->length = size - iomap->offset;
64bc06bb32ee9c Andreas Gruenbacher 2018-06-24  960  	} else if (flags & IOMAP_WRITE) {
64bc06bb32ee9c Andreas Gruenbacher 2018-06-24  961  		u64 alloc_size;
64bc06bb32ee9c Andreas Gruenbacher 2018-06-24  962  
967bcc91b04493 Andreas Gruenbacher 2018-06-19  963  		if (flags & IOMAP_DIRECT)
967bcc91b04493 Andreas Gruenbacher 2018-06-19  964  			goto out;  /* (see gfs2_file_direct_write) */
967bcc91b04493 Andreas Gruenbacher 2018-06-19  965  
64bc06bb32ee9c Andreas Gruenbacher 2018-06-24  966  		len = gfs2_alloc_size(inode, mp, len);
64bc06bb32ee9c Andreas Gruenbacher 2018-06-24  967  		alloc_size = len << inode->i_blkbits;
64bc06bb32ee9c Andreas Gruenbacher 2018-06-24  968  		if (alloc_size < iomap->length)
64bc06bb32ee9c Andreas Gruenbacher 2018-06-24  969  			iomap->length = alloc_size;
64bc06bb32ee9c Andreas Gruenbacher 2018-06-24  970  	} else {
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  971  		if (pos < size && height == ip->i_height)
d505a96a3b16f4 Andreas Gruenbacher 2018-06-24  972  			ret = gfs2_hole_size(inode, lblock, len, mp, iomap);
3974320ca6aa68 Bob Peterson        2017-02-16  973  	}
566a2ab3c9005f Andreas Gruenbacher 2020-04-20  974  hole_found:
566a2ab3c9005f Andreas Gruenbacher 2020-04-20  975  	iomap->addr = IOMAP_NULL_ADDR;
566a2ab3c9005f Andreas Gruenbacher 2020-04-20  976  	iomap->type = IOMAP_HOLE;
628e366df11c0a Andreas Gruenbacher 2018-06-04  977  	goto out;
628e366df11c0a Andreas Gruenbacher 2018-06-04  978  }
628e366df11c0a Andreas Gruenbacher 2018-06-04  979  

:::::: The code at line 893 was first introduced by commit
:::::: 49edd5bf429c405b3a7f75503845d9f66a47dd4b gfs2: Fixes to "Implement iomap for block_map"

:::::: TO: Andreas Gruenbacher <agruenba@redhat.com>
:::::: CC: Bob Peterson <rpeterso@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
