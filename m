Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182B31DD894;
	Sun,  9 Mar 2025 15:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741534207; cv=none; b=CLEHOLG8lLIAzMlO3yaVRlL6LrGr3kQSkSx6hdzGVIfKVX0QAg94qBBWRdbScvkqG7kflV7SwyjYihI6em8eq6kbhCrxvnQlwlHSuDPSVwmAaqxpQi5JoRTHXxTHG+Me+tjMKsaqnwqjE6JLqPgdxXMZKWzG2e8i9YsZ3yL4FAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741534207; c=relaxed/simple;
	bh=4v1GgBz35Z9e0JoFA1VNxsESVjblRjyeVbOcAGA2yV4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Jm2PxF34fgsQ18d6FihUL0IGwPEPD62qA0lhHwVGl/5KP3w8yUYZZNWCwvJBjQhBrEXpnZGjx+b7y6Ql0gfhu9XK1kRKLwX3IhuXTvtN3duK7gn4FneXWAByhfYSud4d67VAwGUqn3+TtGviMHoeQyq19GlOjcUt0+xoJU7k2ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DjsALOwg; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DjsALOwg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741534205; x=1773070205;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4v1GgBz35Z9e0JoFA1VNxsESVjblRjyeVbOcAGA2yV4=;
  b=DjsALOwgKbWTlt6LJDnCD2OweNnIGzbjS13rdu/4CFN5eDEtjtzYT1dG
   9uruN+XCAR7S1gV+U6BrNmgDft6ToP9Imkv+lSb9z2DW22hLcMnTbB3pB
   nQhV7VcbhS0jZH8kNee9pbJjxA5umieGFA81fVFoVT5JYqw2om2brslas
   XRJhaXW0lrDJUWa7xhtuRcjsymlLH7Hw8b5YJpnPGT6U2JeoiNwEP4NV4
   W6yogUR/7SVAVpaGOdWZlrKoOquJtYmorhF25vzGY4AeBQQOoZ9TNTamI
   OGC+kG6oAEiSWA+nB9g7ag9Nf95CrvDhvrRdsKf7JydFEstn5t+/lKtvo
   g==;
X-CSE-ConnectionGUID: FuIS/TNsS2i5rU00DrNL5A==
X-CSE-MsgGUID: 7QkL3x3NTISIwfzkcB/IfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="30109078"
X-IronPort-AV: E=Sophos;i="6.14,234,1736841600"; 
   d="scan'208";a="30109078"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 08:30:04 -0700
X-CSE-ConnectionGUID: 0WXFuuBLQYKnQs4tVT5bnQ==
X-CSE-MsgGUID: 3FN0cR+6TSqha1DnFKnw7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,234,1736841600"; 
   d="scan'208";a="120488433"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 09 Mar 2025 08:30:03 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1trIbI-0003Dy-1X;
	Sun, 09 Mar 2025 15:30:00 +0000
Date: Sun, 9 Mar 2025 23:29:46 +0800
From: kernel test robot <lkp@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	gfs2@lists.linux.dev, Andreas Gruenbacher <agruenba@redhat.com>
Subject: [gfs2:for-next 19/20] fs/ocfs2/aops.c:878:7: error: call to
 undeclared function 'page_has_buffers'; ISO C99 and later do not support
 implicit function declarations
Message-ID: <202503092338.i0AkxoMV-lkp@intel.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git for-next
head:   16abce10ad13ab3ee23754a81164aa8d0506d552
commit: b3cbb48767a2c7a9348b13852b75ea01ed52017b [19/20] gfs2: Convert gfs2_end_log_write_bh() to work on a folio
config: arm-randconfig-003-20250309 (https://download.01.org/0day-ci/archive/20250309/202503092338.i0AkxoMV-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project e15545cad8297ec7555f26e5ae74a9f0511203e7)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250309/202503092338.i0AkxoMV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503092338.i0AkxoMV-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/ocfs2/aops.c:878:7: error: call to undeclared function 'page_has_buffers'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     878 |         if (!page_has_buffers(page))
         |              ^
   fs/ocfs2/aops.c:878:7: note: did you mean 'inode_has_buffers'?
   include/linux/buffer_head.h:511:5: note: 'inode_has_buffers' declared here
     511 | int inode_has_buffers(struct inode *inode);
         |     ^
   fs/ocfs2/aops.c:927:18: error: call to undeclared function 'page_has_buffers'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     927 |                 if (tmppage && page_has_buffers(tmppage)) {
         |                                ^
   fs/ocfs2/aops.c:2025:7: error: call to undeclared function 'page_has_buffers'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2025 |                 if (page_has_buffers(tmppage)) {
         |                     ^
   3 errors generated.
--
>> fs/ocfs2/refcounttree.c:2969:7: error: call to undeclared function 'page_has_buffers'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2969 |                 if (page_has_buffers(page)) {
         |                     ^
   fs/ocfs2/refcounttree.c:2969:7: note: did you mean 'inode_has_buffers'?
   include/linux/buffer_head.h:511:5: note: 'inode_has_buffers' declared here
     511 | int inode_has_buffers(struct inode *inode);
         |     ^
   1 error generated.


vim +/page_has_buffers +878 fs/ocfs2/aops.c

6af67d8205cf65 Mark Fasheh       2007-03-06  866  
9517bac6cc7a7a Mark Fasheh       2007-02-09  867  /*
3a307ffc2730bf Mark Fasheh       2007-05-08  868   * If a page has any new buffers, zero them out here, and mark them uptodate
3a307ffc2730bf Mark Fasheh       2007-05-08  869   * and dirty so they'll be written out (in order to prevent uninitialised
3a307ffc2730bf Mark Fasheh       2007-05-08  870   * block data from leaking). And clear the new bit.
9517bac6cc7a7a Mark Fasheh       2007-02-09  871   */
3a307ffc2730bf Mark Fasheh       2007-05-08  872  static void ocfs2_zero_new_buffers(struct page *page, unsigned from, unsigned to)
9517bac6cc7a7a Mark Fasheh       2007-02-09  873  {
3a307ffc2730bf Mark Fasheh       2007-05-08  874  	unsigned int block_start, block_end;
3a307ffc2730bf Mark Fasheh       2007-05-08  875  	struct buffer_head *head, *bh;
9517bac6cc7a7a Mark Fasheh       2007-02-09  876  
3a307ffc2730bf Mark Fasheh       2007-05-08  877  	BUG_ON(!PageLocked(page));
3a307ffc2730bf Mark Fasheh       2007-05-08 @878  	if (!page_has_buffers(page))
3a307ffc2730bf Mark Fasheh       2007-05-08  879  		return;
9517bac6cc7a7a Mark Fasheh       2007-02-09  880  
3a307ffc2730bf Mark Fasheh       2007-05-08  881  	bh = head = page_buffers(page);
3a307ffc2730bf Mark Fasheh       2007-05-08  882  	block_start = 0;
3a307ffc2730bf Mark Fasheh       2007-05-08  883  	do {
3a307ffc2730bf Mark Fasheh       2007-05-08  884  		block_end = block_start + bh->b_size;
9517bac6cc7a7a Mark Fasheh       2007-02-09  885  
3a307ffc2730bf Mark Fasheh       2007-05-08  886  		if (buffer_new(bh)) {
3a307ffc2730bf Mark Fasheh       2007-05-08  887  			if (block_end > from && block_start < to) {
3a307ffc2730bf Mark Fasheh       2007-05-08  888  				if (!PageUptodate(page)) {
3a307ffc2730bf Mark Fasheh       2007-05-08  889  					unsigned start, end;
9517bac6cc7a7a Mark Fasheh       2007-02-09  890  
3a307ffc2730bf Mark Fasheh       2007-05-08  891  					start = max(from, block_start);
3a307ffc2730bf Mark Fasheh       2007-05-08  892  					end = min(to, block_end);
9517bac6cc7a7a Mark Fasheh       2007-02-09  893  
eebd2aa355692a Christoph Lameter 2008-02-04  894  					zero_user_segment(page, start, end);
3a307ffc2730bf Mark Fasheh       2007-05-08  895  					set_buffer_uptodate(bh);
3a307ffc2730bf Mark Fasheh       2007-05-08  896  				}
eeb47d1234af1a Mark Fasheh       2007-06-06  897  
3a307ffc2730bf Mark Fasheh       2007-05-08  898  				clear_buffer_new(bh);
3a307ffc2730bf Mark Fasheh       2007-05-08  899  				mark_buffer_dirty(bh);
3a307ffc2730bf Mark Fasheh       2007-05-08  900  			}
9517bac6cc7a7a Mark Fasheh       2007-02-09  901  		}
9517bac6cc7a7a Mark Fasheh       2007-02-09  902  
3a307ffc2730bf Mark Fasheh       2007-05-08  903  		block_start = block_end;
3a307ffc2730bf Mark Fasheh       2007-05-08  904  		bh = bh->b_this_page;
3a307ffc2730bf Mark Fasheh       2007-05-08  905  	} while (bh != head);
3a307ffc2730bf Mark Fasheh       2007-05-08  906  }
9517bac6cc7a7a Mark Fasheh       2007-02-09  907  

:::::: The code at line 878 was first introduced by commit
:::::: 3a307ffc2730bfa1a4dfa94537be9d412338aad2 ocfs2: rework ocfs2_buffered_write_cluster()

:::::: TO: Mark Fasheh <mark.fasheh@oracle.com>
:::::: CC: Mark Fasheh <mark.fasheh@oracle.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
